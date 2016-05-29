package rastrograo.rastreamento

import org.springframework.dao.DataIntegrityViolationException
import grails.util.Environment
import rastrograo.customizacao.RastroProduto

class LoteController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService
    
    // Converte de byte para imagem
    def showQrCodeImage (Long id) {
        def loteInstance = Lote.get(id)
        byte[] qrCodeImage = loteInstance.qrCodeImage
        response.outputStream << qrCodeImage
    }
    
    private saveQrCode(loteInstance) {
        URL toDownload = new URL("http://rastro.jelasticlw.com.br/rastro/qrcode/text?s=120&text=www.rastro.jelasticlw.com.br/rastro/lote/cliente/${loteInstance?.id}")
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream()

        try {
            byte[] chunk = new byte[2024]
            int bytesRead;
            InputStream stream = toDownload.openStream()

            while ((bytesRead = stream.read(chunk)) > 0) {
                outputStream.write(chunk, 0, bytesRead)
            }

        } catch (IOException e) {
            e.printStackTrace()
            return null;
        }

        loteInstance.qrCodeImage = outputStream.toByteArray()
        loteInstance.save(flush: true)
    }
    
    def getAcessoInstance = {
        def acessoInstance
        //verificar permissão do usuário para visualizar ou editar o registro
        if (springSecurityService.isLoggedIn()) {
            acessoInstance = rastrograo.seguranca.Acesso.get(springSecurityService?.principal?.id)
        }
        return acessoInstance
    }    
    
    def getPermissao (empresaInstance, propriedadeInstance) {
        /*
         * Mensagem erro permissão visualização/edição
         * Se não é administrador e acesso não está vinculado à empresa
         */
        if (acessoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }) {
            def acessoInstanceList = rastrograo.seguranca.Acesso.createCriteria().list(){
                empresas{
                    eq('id', empresaInstance?.id)
                }
                propriedades{
                    eq('id', propriedadeInstance?.id)
                }
                eq('id', acessoInstance?.id)
            }
            if (!acessoInstanceList){
                redirect(action: "denied", controller: 'login')
                return
            }
        }
    }

    def getRastroProdutoInstanceList = {
        def rastroProdutoInstanceList = RastroProduto.createCriteria().list(){
            and{
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id ?: (0).toLong())
                }
                empresa{
                    'in'('id', acessoInstance?.empresas?.id ?: (0).toLong())
                }
            }
        }
        return rastroProdutoInstanceList
    }
    
    /* 
     * Utilizado na visualziação do formulário de gerenciamento de lotes, onde, 
     * ativo exibe o campo obrigatório nrLoteManual e inativo oculta o campo e torna opcional o preenchimento
     */
    def showNrLoteManual (boolean nrLoteSequencial){
        def loteInstance = new Lote(params)
        loteInstance.nrLoteSequencial = nrLoteSequencial
        render(template: '/lote/fieldNrLoteManual', model: [loteInstance: loteInstance])
        return  
    }
    
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'dataLote'
        params.order = params?.order?:'desc'
        
        def consultaInstance = new Lote(params)
        consultaInstance.rastroProduto = RastroProduto.get(params?.rastroProduto?.id ? params?.rastroProduto?.id?.toLong() : 0)
        consultaInstance.nrLoteManual = params?.nrLoteManual ? params?.nrLoteManual?.trim() : null
        
        def loteInstanceList
        def loteInstanceTotal 
        
        loteInstanceList = Lote.createCriteria().list(params){
            and{
                rastroProduto{
                    propriedade{
                        'in'('id', acessoInstance?.propriedades?.id ?: (0).toLong())
                    }
                    empresa{
                        'in'('id', acessoInstance?.empresas?.id ?: (0).toLong())
                    }
                }
                if(consultaInstance.rastroProduto) eq('rastroProduto', consultaInstance.rastroProduto)
                if(consultaInstance?.nrLoteManual?.isInteger() && consultaInstance?.nrLoteManual){
                    or{
                        eq('id', consultaInstance?.nrLoteManual?.toLong())
                        ilike('nrLoteManual', "%" + consultaInstance?.nrLoteManual + "%")
                    }
                }else if(consultaInstance?.nrLoteManual){
                    ilike('nrLoteManual', "%" + consultaInstance?.nrLoteManual + "%")
                }
            }
        }
        
        //retorno
        [loteInstanceList: loteInstanceList, 
            loteInstanceTotal: loteInstanceList.totalCount,   
            consultaInstance: consultaInstance,
            rastroProdutoInstanceList: rastroProdutoInstanceList]
    }

    def create() {
        [loteInstance: new Lote(params),
            rastroProdutoInstanceList: rastroProdutoInstanceList]
    }

    def save() {
        def loteInstance = new Lote(params)
        
        /*
         * altera a situação do rastreamento bloqueando a edição da customização, 
         * apenas o campo qr-code consumidor permace ativo para edição
         */
        if(loteInstance.rastroProduto.situacao.equals("Em andamento")){
            loteInstance.rastroProduto.situacao = "Encerrado"
        }
        
        if (!loteInstance.save(flush: true)) {
            render(view: "create", model: [loteInstance: loteInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }        
        saveQrCode(loteInstance)
        flash.message = message(code: 'default.created.message', args: [message(code: 'lote.label', default: 'Lote'), loteInstance.id])
        redirect(action: "show", id: loteInstance.id)
    }

    def show(Long id) {
        def loteInstance = Lote.get(id)
        if (!loteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'lote.label', default: 'Lote'), id])
            redirect(action: "list")
            return
        }

        getPermissao(loteInstance?.rastroProduto?.empresa, loteInstance?.rastroProduto?.propriedade)
        
        def SUBREPORT_DIR = servletContext.getRealPath('reports') + "/"
        
        [loteInstance: loteInstance,
            SUBREPORT_DIR: SUBREPORT_DIR]
    }

    def edit(Long id) {
        def loteInstance = Lote.get(id)
        if (!loteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'lote.label', default: 'Lote'), id])
            redirect(action: "list")
            return
        }

        getPermissao(loteInstance?.rastroProduto?.empresa, loteInstance?.rastroProduto?.propriedade)
        
        [loteInstance: loteInstance,
            rastroProdutoInstanceList: rastroProdutoInstanceList]
    }

    def update(Long id, Long version) {
        def loteInstance = Lote.get(id)
        if (!loteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'lote.label', default: 'Lote'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (loteInstance.version > version) {
                loteInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'lote.label', default: 'Lote')] as Object[],
                          "Another user has updated this Lote while you were editing")
                render(view: "edit", model: [loteInstance: loteInstance,
                        rastroProdutoInstanceList: rastroProdutoInstanceList])
                return
            }
        }

        loteInstance.properties = params

        /*
         * altera a situação do rastreamento bloqueando a edição da customização, 
         * apenas o campo qr-code consumidor permace ativo para edição
         */
        if(loteInstance.rastroProduto.situacao.equals("Em andamento")){
            loteInstance.rastroProduto.situacao = "Encerrado"
        }
        
        if (!loteInstance.save(flush: true)) {
            render(view: "edit", model: [loteInstance: loteInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }
        
        saveQrCode(loteInstance)
        
        flash.message = message(code: 'default.updated.message', args: [message(code: 'lote.label', default: 'Lote'), loteInstance.id])
        redirect(action: "show", id: loteInstance.id)
    }

    def delete(Long id) {
        def loteInstance = Lote.get(id)
        if (!loteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'lote.label', default: 'Lote'), id])
            redirect(action: "list")
            return
        }
        
        try {
            /*
             * armazena o valor de rastreamento para atualizar a situação para "Em andamento" 
             * caso exclusão bem sucedida
             */
            def rastroProdutoInstance = loteInstance?.rastroProduto
            
            loteInstance.delete(flush: true)
            
            /*
             * altera a situação do rastreamento desbloqueando a edição da customização, 
             * todos os campos serão reabertos para edição
             */
            if(rastroProdutoInstance.situacao.equals("Encerrado")){
                rastroProdutoInstance.situacao = "Em andamento"
            }
            /*
             * persiste a alteração da situação para "Em andamento"
             */
            rastroProdutoInstance.save(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'lote.label', default: 'Lote'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'lote.label', default: 'Lote'), id])
            redirect(action: "show", id: id)
        }
    }
}
