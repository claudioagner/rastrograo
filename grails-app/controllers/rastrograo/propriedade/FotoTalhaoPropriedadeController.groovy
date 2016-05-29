package rastrograo.propriedade

import org.springframework.dao.DataIntegrityViolationException

class FotoTalhaoPropriedadeController {

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
    
    def getPermissao (propriedadeInstance) {
        /*
         * Mensagem erro permissão visualização/edição
         * Se não é administrador e acesso não está vinculado à empresa
         */
        if (acessoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }) {
            def acessoInstanceList = rastrograo.seguranca.Acesso.createCriteria().list(){
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
    
    // Converte de byte para imagem
    def showFoto (Long id) {
        def fotoTalhaoPropriedadeInstance = FotoTalhaoPropriedade.get(id)
        byte[] foto = fotoTalhaoPropriedadeInstance.foto
        response.outputStream << foto
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long propriedadeId, Long talhaoPropriedadeId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'tituloFoto'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new FotoTalhaoPropriedade(params)
        consultaInstance?.talhaoPropriedade = TalhaoPropriedade.get(talhaoPropriedadeId)
        consultaInstance?.talhaoPropriedade?.propriedade = Propriedade.get(propriedadeId)
        consultaInstance?.tituloFoto = params?.tituloFoto?.trim()
        
        def fotoTalhaoPropriedadeInstanceList
        def fotoTalhaoPropriedadeInstanceTotal          
            
        //regra de negócio de consulta    
        if(consultaInstance?.tituloFoto?.length() <= 1 && consultaInstance?.tituloFoto){
            consultaInstance.errors.rejectValue("tituloFoto", "default.minSize.message",
                [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), message(code: 'fotoPropriedade.tituloFoto.label', default: 'Url')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            
            render(view: "list", model: [consultaInstance: consultaInstance,
                    fotoTalhaoPropriedadeInstanceList: fotoTalhaoPropriedadeInstanceList, 
                    fotoTalhaoPropriedadeInstanceTotal: 0])
            return
        } 
        
        //aplicação dos parâmetros à consulta
        fotoTalhaoPropriedadeInstanceList = FotoTalhaoPropriedade.createCriteria().list(params){
            and{
                talhaoPropriedade{
                    propriedade{
                        'in'('id', acessoInstance?.propriedades?.id)
                        if(consultaInstance?.talhaoPropriedade?.propriedade) eq('id', consultaInstance?.talhaoPropriedade?.propriedade?.id)
                        if(params?.sort.contains('propriedade')) order('nomePropriedade',params.order)
                    }
                    if(consultaInstance?.talhaoPropriedade) eq('id', consultaInstance?.talhaoPropriedade?.id)
                    if(params?.sort.contains('talhaoPropriedade')) order('descricaoTalhao',params.order)
                }
                if(consultaInstance?.tituloFoto?.length() > 1) ilike('tituloFoto', "%" + consultaInstance?.tituloFoto + "%")
            }
            if(params?.sort.equals('tituloFoto')) order(params.sort,params.order)
        }
        
        //retorno
        [fotoTalhaoPropriedadeInstanceList: fotoTalhaoPropriedadeInstanceList, 
            fotoTalhaoPropriedadeInstanceTotal: fotoTalhaoPropriedadeInstanceList.totalCount,
            consultaInstance: consultaInstance,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }
    
    def create() {
        [fotoTalhaoPropriedadeInstance: new FotoTalhaoPropriedade(params),
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def save() {
        def fotoTalhaoPropriedadeInstance = new FotoTalhaoPropriedade(params)
        
        if(!fotoTalhaoPropriedadeInstance.foto){
            fotoTalhaoPropriedadeInstance.errors.rejectValue("foto", "default.null.failure",
                [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoPropriedade')] as Object[],
                          "O campo [Foto] da classe [Talhão Propriedade] não pode ser vazia")
            render(view: "edit", model: [fotoTalhaoPropriedadeInstance: fotoTalhaoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }
        
        if (!fotoTalhaoPropriedadeInstance.save(flush: true)) {
            render(view: "create", model: [fotoTalhaoPropriedadeInstance: fotoTalhaoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade'), fotoTalhaoPropriedadeInstance.id])
        redirect(action: "show", id: fotoTalhaoPropriedadeInstance.id)
    }

    def show(Long id) {
        def fotoTalhaoPropriedadeInstance = FotoTalhaoPropriedade.get(id)
        if (!fotoTalhaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade)
        
        [fotoTalhaoPropriedadeInstance: fotoTalhaoPropriedadeInstance]
    }

    def edit(Long id) {
        def fotoTalhaoPropriedadeInstance = FotoTalhaoPropriedade.get(id)
        if (!fotoTalhaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade)
        
        [fotoTalhaoPropriedadeInstance: fotoTalhaoPropriedadeInstance]
    }

    def update(Long id, Long version) {
        def fotoTalhaoPropriedadeInstance = FotoTalhaoPropriedade.get(id)
        if (!fotoTalhaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (fotoTalhaoPropriedadeInstance.version > version) {
                fotoTalhaoPropriedadeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade')] as Object[],
                          "Another user has updated this FotoTalhaoPropriedade while you were editing")
                render(view: "edit", model: [fotoTalhaoPropriedadeInstance: fotoTalhaoPropriedadeInstance,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }
        }

        def imagemSalva
        if(params.foto.isEmpty()){
            if(!fotoTalhaoPropriedadeInstance.foto){
                fotoTalhaoPropriedadeInstance.errors.rejectValue("foto", "default.null.failure",
                    [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoEmpresa')] as Object[],
                          "O campo [Foto] da classe [Talhão Propriedade] não pode ser vazia")
                render(view: "edit", model: [fotoTalhaoPropriedadeInstance: fotoTalhaoPropriedadeInstance,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }else{
                imagemSalva = fotoTalhaoPropriedadeInstance.foto
            }
        }
        
        fotoTalhaoPropriedadeInstance.properties = params
        
        if(!fotoTalhaoPropriedadeInstance.foto){
            fotoTalhaoPropriedadeInstance.foto = imagemSalva
        }
        
        if (!fotoTalhaoPropriedadeInstance.save(flush: true)) {
            render(view: "edit", model: [fotoTalhaoPropriedadeInstance: fotoTalhaoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade'), fotoTalhaoPropriedadeInstance.id])
        redirect(action: "show", id: fotoTalhaoPropriedadeInstance.id)
    }

    def delete(Long id) {
        def fotoTalhaoPropriedadeInstance = FotoTalhaoPropriedade.get(id)
        if (!fotoTalhaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        try {
            fotoTalhaoPropriedadeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade'), id])
            redirect(action: "show", id: id)
        }
    }
}
