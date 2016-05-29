package rastrograo.propriedade

import org.springframework.dao.DataIntegrityViolationException

import rastrograo.tabela.TipoResponsavel

class ResponsavelPropriedadeController {

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

    def list(Integer max, Long tipoResponsavelId, Long propriedadeId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'nomeResponsavelPropriedade'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new ResponsavelPropriedade(params)
        consultaInstance?.tipoResponsavel = TipoResponsavel.get(tipoResponsavelId)
        consultaInstance?.propriedade = Propriedade.get(propriedadeId)
        consultaInstance?.nomeResponsavelPropriedade = params?.nomeResponsavelPropriedade?.trim()
        consultaInstance?.dddResponsavelPropriedade = params?.dddResponsavelPropriedade?.trim()
        consultaInstance?.numeroTelefoneResponsavelPropriedade = params?.numeroTelefoneResponsavelPropriedade?.trim()
        def responsavelPropriedadeInstanceList
        def responsavelPropriedadeInstanceTotal  
         
        //regra de negócio de consulta    
        if((consultaInstance?.nomeResponsavelPropriedade?.length() <= 1 && consultaInstance?.nomeResponsavelPropriedade) ||
            (consultaInstance?.dddResponsavelPropriedade?.length() <= 1 && consultaInstance?.dddResponsavelPropriedade)||
            (consultaInstance?.numeroTelefoneResponsavelPropriedade?.length() <= 1 && consultaInstance?.numeroTelefoneResponsavelPropriedade)){
            if (consultaInstance?.nomeResponsavelPropriedade?.length() <= 1 && consultaInstance?.nomeResponsavelPropriedade) {
                consultaInstance.errors.rejectValue("nomeResponsavelPropriedade", "default.minSize.message",
                    [message(code: 'responsavelPropriedade.label', default: 'Responsavel Propriedade'), message(code: 'responsavelPropriedade.nomeResponsavelPropriedade.label', default: 'Nome Responsavel Propriedade')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.dddResponsavelPropriedade?.length() <= 1 && consultaInstance?.dddResponsavelPropriedade) {
                consultaInstance.errors.rejectValue("dddResponsavelPropriedade", "default.minSize.message",
                    [message(code: 'responsavelPropriedade.label', default: 'Responsavel Propriedade'), message(code: 'responsavelPropriedade.dddResponsavelPropriedade.label', default: 'Ddd Responsavel Propriedade')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.numeroTelefoneResponsavelPropriedade?.length() <= 1 && consultaInstance?.numeroTelefoneResponsavelPropriedade) {
                consultaInstance.errors.rejectValue("numeroTelefoneResponsavelPropriedade", "default.minSize.message",
                    [message(code: 'responsavelPropriedade.label', default: 'Responsavel Propriedade'), message(code: 'responsavelPropriedade.numeroTelefoneResponsavelPropriedade.label', default: 'Ddd Responsavel Propriedade')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    responsavelPropriedadeInstanceList: responsavelPropriedadeInstanceList, 
                    responsavelPropriedadeInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        responsavelPropriedadeInstanceList = ResponsavelPropriedade.createCriteria().list(params){
            and{
                tipoResponsavel{
                    if(consultaInstance?.tipoResponsavel) eq('id', consultaInstance?.tipoResponsavel?.id)
                    if(params?.sort.contains('tipoResponsavel')) order('descricaoTipoResponsavel',params.order)
                }
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id)
                    if(consultaInstance?.propriedade) eq('id', consultaInstance?.propriedade?.id)
                    if(params?.sort.contains('propriedade')) order('nomePropriedade',params.order)
                }
                if(consultaInstance?.nomeResponsavelPropriedade?.length() > 1) ilike('nomeResponsavelPropriedade', "%" + consultaInstance?.nomeResponsavelPropriedade + "%")
                if(consultaInstance?.dddResponsavelPropriedade?.length() > 1) ilike('dddResponsavelPropriedade', "%" + consultaInstance?.dddResponsavelPropriedade + "%")
                if(consultaInstance?.numeroTelefoneResponsavelPropriedade?.length() > 1) ilike('numeroTelefoneResponsavelPropriedade', "%" + consultaInstance?.numeroTelefoneResponsavelPropriedade + "%")
            }
            if(params?.sort.equals('nomeResponsavelPropriedade')) order(params.sort,params.order)
            if(params?.sort.equals('dddResponsavelPropriedade')) order(params.sort,params.order)
            if(params?.sort.equals('numeroTelefoneResponsavelPropriedade')) order(params.sort,params.order)
        }
        
        //retorno
        [responsavelPropriedadeInstanceList: responsavelPropriedadeInstanceList, 
            responsavelPropriedadeInstanceTotal: responsavelPropriedadeInstanceList.totalCount,
            consultaInstance: consultaInstance,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def create() {
        [responsavelPropriedadeInstance: new ResponsavelPropriedade(params),
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def save() {
        def responsavelPropriedadeInstance = new ResponsavelPropriedade(params)
        if (!responsavelPropriedadeInstance.save(flush: true)) {
            render(view: "create", model: [responsavelPropriedadeInstance: responsavelPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade'), responsavelPropriedadeInstance.id])
        redirect(action: "show", id: responsavelPropriedadeInstance.id)
    }

    def show(Long id) {
        def responsavelPropriedadeInstance = ResponsavelPropriedade.get(id)
        if (!responsavelPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(responsavelPropriedadeInstance?.propriedade)
        
        [responsavelPropriedadeInstance: responsavelPropriedadeInstance]
    }

    def edit(Long id) {
        def responsavelPropriedadeInstance = ResponsavelPropriedade.get(id)
        if (!responsavelPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(responsavelPropriedadeInstance?.propriedade)
        
        [responsavelPropriedadeInstance: responsavelPropriedadeInstance,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def update(Long id, Long version) {
        def responsavelPropriedadeInstance = ResponsavelPropriedade.get(id)
        if (!responsavelPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (responsavelPropriedadeInstance.version > version) {
                responsavelPropriedadeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade')] as Object[],
                          "Another user has updated this ResponsavelPropriedade while you were editing")
                render(view: "edit", model: [responsavelPropriedadeInstance: responsavelPropriedadeInstance,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }
        }

        responsavelPropriedadeInstance.properties = params

        if (!responsavelPropriedadeInstance.save(flush: true)) {
            render(view: "edit", model: [responsavelPropriedadeInstance: responsavelPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade'), responsavelPropriedadeInstance.id])
        redirect(action: "show", id: responsavelPropriedadeInstance.id)
    }

    def delete(Long id) {
        def responsavelPropriedadeInstance = ResponsavelPropriedade.get(id)
        if (!responsavelPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade'), id])
            redirect(action: "list")
            return
        }

        try {
            responsavelPropriedadeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade'), id])
            redirect(action: "show", id: id)
        }
    }
}
