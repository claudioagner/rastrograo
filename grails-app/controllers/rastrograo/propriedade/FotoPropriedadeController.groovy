package rastrograo.propriedade

import org.springframework.dao.DataIntegrityViolationException

class FotoPropriedadeController {

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
        def fotoPropriedadeInstance = FotoPropriedade.get(id)
        byte[] foto = fotoPropriedadeInstance.foto
        response.outputStream << foto
    }

    def index() {
        redirect(action: "list", params: params)
    }  

    def list(Integer max, Long propriedadeId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'tituloFoto'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new FotoPropriedade(params)
        consultaInstance?.propriedade = Propriedade.get(propriedadeId)
        consultaInstance?.tituloFoto = params?.tituloFoto?.trim()
        
        def fotoPropriedadeInstanceList
        def fotoPropriedadeInstanceTotal          
            
        //regra de negócio de consulta    
        if(consultaInstance?.tituloFoto?.length() <= 1 && consultaInstance?.tituloFoto){
            consultaInstance.errors.rejectValue("tituloFoto", "default.minSize.message",
                [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), message(code: 'fotoPropriedade.tituloFoto.label', default: 'Url')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            
            render(view: "list", model: [consultaInstance: consultaInstance,
                    fotoPropriedadeInstanceList: fotoPropriedadeInstanceList, 
                    fotoPropriedadeInstanceTotal: 0])
            return
        } 
        
        //aplicação dos parâmetros à consulta
        fotoPropriedadeInstanceList = FotoPropriedade.createCriteria().list(params){
            and{
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id)
                    if(consultaInstance?.propriedade) eq('id', consultaInstance?.propriedade?.id)
                    if(params?.sort.contains('propriedade')) order('nomePropriedade',params.order)
                }
                if(consultaInstance?.tituloFoto?.length() > 1) ilike('tituloFoto', "%" + consultaInstance?.tituloFoto + "%")
            }
            if(params?.sort.equals('tituloFoto')) order(params.sort,params.order)
        }
        
        //retorno
        [fotoPropriedadeInstanceList: fotoPropriedadeInstanceList, 
            fotoPropriedadeInstanceTotal: fotoPropriedadeInstanceList.totalCount,
            consultaInstance: consultaInstance,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def create() {
        [fotoPropriedadeInstance: new FotoPropriedade(params),
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def save() {
        def fotoPropriedadeInstance = new FotoPropriedade(params)
        
        if(!fotoPropriedadeInstance.foto){
            fotoPropriedadeInstance.errors.rejectValue("foto", "default.null.failure",
                [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade')] as Object[],
                          "O campo [Foto] da classe [Propriedade] não pode ser vazia")
            render(view: "edit", model: [fotoPropriedadeInstance: fotoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }
        
        if (!fotoPropriedadeInstance.save(flush: true)) {
            render(view: "create", model: [fotoPropriedadeInstance: fotoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), fotoPropriedadeInstance.id])
        redirect(action: "show", id: fotoPropriedadeInstance.id)
    }

    def show(Long id) {
        def fotoPropriedadeInstance = FotoPropriedade.get(id)
        if (!fotoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(fotoPropriedadeInstance?.propriedade)
        
        [fotoPropriedadeInstance: fotoPropriedadeInstance]
    }

    def edit(Long id) {
        def fotoPropriedadeInstance = FotoPropriedade.get(id)
        if (!fotoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(fotoPropriedadeInstance?.propriedade)
        
        [fotoPropriedadeInstance: fotoPropriedadeInstance]
    }

    def update(Long id, Long version) {
        def fotoPropriedadeInstance = FotoPropriedade.get(id)
        if (!fotoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (fotoPropriedadeInstance.version > version) {
                fotoPropriedadeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade')] as Object[],
                          "Another user has updated this FotoPropriedade while you were editing")
                render(view: "edit", model: [fotoPropriedadeInstance: fotoPropriedadeInstance,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }
        }

        def imagemSalva
        if(params.foto.isEmpty()){
            if(!fotoPropriedadeInstance.foto){
                fotoPropriedadeInstance.errors.rejectValue("foto", "default.null.failure",
                    [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade')] as Object[],
                          "O campo [Foto] da classe [Propriedade] não pode ser vazia")
                render(view: "edit", model: [fotoPropriedadeInstance: fotoPropriedadeInstance,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }else{
                imagemSalva = fotoPropriedadeInstance.foto
            }
        }
        
        fotoPropriedadeInstance.properties = params
        
        if(!fotoPropriedadeInstance.foto){
            fotoPropriedadeInstance.foto = imagemSalva
        }
        
        if (!fotoPropriedadeInstance.save(flush: true)) {
            render(view: "edit", model: [fotoPropriedadeInstance: fotoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), fotoPropriedadeInstance.id])
        redirect(action: "show", id: fotoPropriedadeInstance.id)
    }

    def delete(Long id) {
        def fotoPropriedadeInstance = FotoPropriedade.get(id)
        if (!fotoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), id])
            redirect(action: "list")
            return
        }

        try {
            fotoPropriedadeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'fotoPropriedade.label', default: 'FotoPropriedade'), id])
            redirect(action: "show", id: id)
        }
    }
}
