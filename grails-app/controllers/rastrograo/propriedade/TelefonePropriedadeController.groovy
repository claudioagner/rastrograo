package rastrograo.propriedade

import org.springframework.dao.DataIntegrityViolationException

class TelefonePropriedadeController {

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

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long propriedadeId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'numeroTelefonePropriedade'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new TelefonePropriedade(params)
        consultaInstance?.propriedade = Propriedade.get(propriedadeId)
        consultaInstance?.dddPropriedade = params?.dddPropriedade?.trim()
        consultaInstance?.numeroTelefonePropriedade = params?.numeroTelefonePropriedade?.trim()
        def telefonePropriedadeInstanceList
        def telefonePropriedadeInstanceTotal  
        
        //regra de negócio de consulta    
        if((consultaInstance?.dddPropriedade?.length() <= 1 && consultaInstance?.dddPropriedade)||
            (consultaInstance?.numeroTelefonePropriedade?.length() <= 1 && consultaInstance?.numeroTelefonePropriedade)){
            if (consultaInstance?.dddPropriedade?.length() <= 1 && consultaInstance?.dddPropriedade) {
                consultaInstance.errors.rejectValue("dddPropriedade", "default.minSize.message",
                    [message(code: 'telefonePropriedade.label', default: 'Telefone Propriedade'), message(code: 'telefonePropriedade.dddPropriedade.label', default: 'Ddd Propriedade')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.numeroTelefonePropriedade?.length() <= 1 && consultaInstance?.numeroTelefonePropriedade) {
                consultaInstance.errors.rejectValue("numeroTelefonePropriedade", "default.minSize.message",
                    [message(code: 'responsavelPropriedade.label', default: 'Responsavel Propriedade'), message(code: 'responsavelPropriedade.numeroTelefonePropriedade.label', default: 'Numero Telefone Propriedade')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    telefonePropriedadeInstanceList: telefonePropriedadeInstanceList, 
                    telefonePropriedadeInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        telefonePropriedadeInstanceList = TelefonePropriedade.createCriteria().list(params){
            and{
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id)
                    if(consultaInstance?.propriedade) eq('id', consultaInstance?.propriedade?.id)
                    if(params?.sort.contains('propriedade')) order('nomePropriedade',params.order)
                }
                if(consultaInstance?.dddPropriedade?.length() > 1) ilike('dddPropriedade', "%" + consultaInstance?.dddPropriedade + "%")
                if(consultaInstance?.numeroTelefonePropriedade?.length() > 1) ilike('numeroTelefonePropriedade', "%" + consultaInstance?.numeroTelefonePropriedade + "%")
            }
            if(params?.sort.equals('dddPropriedade')) order(params.sort,params.order)
            if(params?.sort.equals('numeroTelefonePropriedade')) order(params.sort,params.order)
        }
        
        //retorno
        [telefonePropriedadeInstanceList: telefonePropriedadeInstanceList, 
            telefonePropriedadeInstanceTotal: telefonePropriedadeInstanceList.totalCount,
            consultaInstance: consultaInstance,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def create() {
        [telefonePropriedadeInstance: new TelefonePropriedade(params),
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def save() {
        def telefonePropriedadeInstance = new TelefonePropriedade(params)
        if (!telefonePropriedadeInstance.save(flush: true)) {
            render(view: "create", model: [telefonePropriedadeInstance: telefonePropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade'), telefonePropriedadeInstance.id])
        redirect(action: "show", id: telefonePropriedadeInstance.id)
    }

    def show(Long id) {
        def telefonePropriedadeInstance = TelefonePropriedade.get(id)
        if (!telefonePropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(telefonePropriedadeInstance?.propriedade)
        
        [telefonePropriedadeInstance: telefonePropriedadeInstance]
    }

    def edit(Long id) {
        def telefonePropriedadeInstance = TelefonePropriedade.get(id)
        if (!telefonePropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(telefonePropriedadeInstance?.propriedade)
        
        [telefonePropriedadeInstance: telefonePropriedadeInstance]
    }

    def update(Long id, Long version) {
        def telefonePropriedadeInstance = TelefonePropriedade.get(id)
        if (!telefonePropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (telefonePropriedadeInstance.version > version) {
                telefonePropriedadeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade')] as Object[],
                          "Another user has updated this TelefonePropriedade while you were editing")
                render(view: "edit", model: [telefonePropriedadeInstance: telefonePropriedadeInstance,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }
        }

        telefonePropriedadeInstance.properties = params

        if (!telefonePropriedadeInstance.save(flush: true)) {
            render(view: "edit", model: [telefonePropriedadeInstance: telefonePropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade'), telefonePropriedadeInstance.id])
        redirect(action: "show", id: telefonePropriedadeInstance.id)
    }

    def delete(Long id) {
        def telefonePropriedadeInstance = TelefonePropriedade.get(id)
        if (!telefonePropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade'), id])
            redirect(action: "list")
            return
        }

        try {
            telefonePropriedadeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade'), id])
            redirect(action: "show", id: id)
        }
    }
}
