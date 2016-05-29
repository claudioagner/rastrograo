package rastrograo.customizacao

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import rastrograo.empresa.Empresa
import rastrograo.estrutura.Atributo
import rastrograo.estrutura.ListaAtributo
import rastrograo.estrutura.Cultivar
import rastrograo.estrutura.Produto
import rastrograo.propriedade.Propriedade
import rastrograo.propriedade.TalhaoPropriedade

class RastroProdutoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService
    
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
    
    def sumario(){
        def rastroProdutoInstanceList = RastroProduto.createCriteria().list(params){
            and{
                empresa{
                    'in'('id', acessoInstance?.empresas?.id ?: (0).toLong())
                }
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id ?: (0).toLong())
                }
                eq('situacao', 'Em andamento')
            }
        }
        render(template: '/rastroProduto/listRastrosProduto', model: [rastroProdutoInstanceList: rastroProdutoInstanceList])
    }
    
    def saveCheck() {
        def rastroAtributoInstance = RastroAtributo.get(params?.rastroAtributoId?.toLong())
        if(params?.campo.equals('registrarDados')){
            rastroAtributoInstance?.registrarDados = params?.valorBoolean?.equals('true') ? true : false 
        }else if(params?.campo.equals('exibirQRConsumidor')){
            rastroAtributoInstance?.exibirQRConsumidor = params?.valorBoolean?.equals('true') ? true : false 
        }
        rastroAtributoInstance.save(flush: true)
    }
    
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'anoSafra'
        params.order = params?.order?:'asc'
        
        def consultaInstance = new RastroProduto(params)
        consultaInstance.empresa = Empresa.get(params?.empresaId ? params?.empresaId?.toLong() : 0)
        consultaInstance.propriedade = Propriedade.get(params?.propriedadeId ? params?.propriedadeId?.toLong() : 0)
        consultaInstance.talhaoPropriedade = TalhaoPropriedade.get(params?.talhaoPropriedadeId ? params?.talhaoPropriedadeId?.toLong() : 0)
        consultaInstance.produto = Produto.get(params?.produtoId ? params?.produtoId?.toLong() : 0)
        consultaInstance.cultivar = Cultivar.get(params?.cultivarId ? params?.cultivarId?.toLong() : 0)
        consultaInstance.anoSafra = params?.anoSafra?.trim()
        
        def rastroProdutoInstanceList
        def rastroProdutoInstanceTotal  
        
        rastroProdutoInstanceList = RastroProduto.createCriteria().list(params){
            and{
                empresa{
                    'in'('id', acessoInstance?.empresas?.id)
                }
                if(consultaInstance.empresa) eq('empresa', consultaInstance?.empresa)
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id)
                }
                if(consultaInstance.propriedade) eq('propriedade', consultaInstance?.propriedade)
                if(consultaInstance.talhaoPropriedade) eq('talhaoPropriedade', consultaInstance?.talhaoPropriedade)
                if(consultaInstance.produto) eq('produto', consultaInstance?.produto)
                if(consultaInstance.cultivar) eq('cultivar', consultaInstance?.cultivar)
                if(consultaInstance.anoSafra) eq('anoSafra', consultaInstance?.anoSafra)
            }
        }
        
        def SUBREPORT_DIR = servletContext.getRealPath('reports') + "/"
        
        //retorno
        [rastroProdutoInstanceList: rastroProdutoInstanceList, 
            rastroProdutoInstanceTotal: rastroProdutoInstanceList.totalCount,
            consultaInstance: consultaInstance,
            empresaInstanceList: acessoInstance?.empresas,
            propriedadeInstanceList: acessoInstance?.propriedades,
            SUBREPORT_DIR: SUBREPORT_DIR]
    }

    def create() {
        [rastroProdutoInstance: new RastroProduto(params),
            empresaInstanceList: acessoInstance?.empresas,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def save() {
        def rastroProdutoInstance = new RastroProduto(params)
        if (!rastroProdutoInstance.save(flush: true)) {
            render(view: "create", model: [rastroProdutoInstance: rastroProdutoInstance,
                    empresaInstanceList: acessoInstance?.empresas,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }else{
            addToRastrosFase(rastroProdutoInstance)
            addToRastrosAtributo(rastroProdutoInstance)
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), rastroProdutoInstance.id])
        redirect(action: "show", id: rastroProdutoInstance.id)
    }

    def show(Long id) {
        def rastroProdutoInstance = RastroProduto.get(id)
        if (!rastroProdutoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), id])
            redirect(action: "list")
            return
        }
        
        getPermissao(rastroProdutoInstance?.empresa, rastroProdutoInstance?.propriedade)
        
        [rastroProdutoInstance: rastroProdutoInstance]
    }

    def edit(Long id) {
        def rastroProdutoInstance = RastroProduto.get(id)
        if (!rastroProdutoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), id])
            redirect(action: "list")
            return
        }
        
        getPermissao(rastroProdutoInstance?.empresa, rastroProdutoInstance?.propriedade)
        
        [rastroProdutoInstance: rastroProdutoInstance]
    }

    def update(Long id, Long version) {
        def rastroProdutoInstance = RastroProduto.get(id)
        
        if (!rastroProdutoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (rastroProdutoInstance.version > version) {
                rastroProdutoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'rastroProduto.label', default: 'RastroProduto')] as Object[],
                          "Another user has updated this RastroProduto while you were editing")
                render(view: "edit", model: [rastroProdutoInstance: rastroProdutoInstance,
                        empresaInstanceList: acessoInstance?.empresas,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }
        }

        rastroProdutoInstance.properties = params
        rastroProdutoInstance.dataAlterado = new Date()
        
        if (!rastroProdutoInstance.save(flush: true)) {
            render(view: "edit", model: [rastroProdutoInstance: rastroProdutoInstance,
                    empresaInstanceList: acessoInstance?.empresas,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }else{
            addToRastrosFase(rastroProdutoInstance)
            addToRastrosAtributo(rastroProdutoInstance)
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), rastroProdutoInstance.id])
        redirect(action: "show", id: rastroProdutoInstance.id)
    }
    
    def addToRastrosFase(rastroProdutoInstance){
        def agora = new Date()
        for(faseInstance in rastroProdutoInstance.produto.fases){
            if(!RastroFase.findByRastroProdutoAndFase(rastroProdutoInstance, faseInstance)) 
            rastroProdutoInstance.addToRastrosFase(fase: faseInstance).save(flush: true)
        }
    }
    
    def addToRastrosAtributo(rastroProdutoInstance){
        def agora = new Date()
        for(rastroFaseInstance in rastroProdutoInstance.rastrosFase){
            for(atributoInstance in rastroFaseInstance.fase.atributos){
                if(!RastroAtributo.findByRastroFaseAndAtributo(rastroFaseInstance, atributoInstance)) 
                rastroFaseInstance.addToRastrosAtributo(atributo: atributoInstance).save(flush: true)
            }
        }
    }
    
    def delete(Long id) {
        def rastroProdutoInstance = RastroProduto.get(id)
        if (!rastroProdutoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), id])
            redirect(action: "list")
            return
        }

        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params registros
         * @return caso verdadeiro tela de visualização do registro
         * 10/5/2016 12:16
         */
        if(rastroProdutoInstance.registros){
            flash.message = message(code: 'rastroProduto.not.deleted.dados', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), id])
            redirect(action: "show", id: id)
            return
        }else if(rastroProdutoInstance.lote){
            flash.message = message(code: 'rastroProduto.not.deleted.lote', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            rastroProdutoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'rastroProduto.label', default: 'RastroProduto'), id])
            redirect(action: "show", id: id)
        }
    }
}
