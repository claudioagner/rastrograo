package rastrograo.empresa

import org.springframework.dao.DataIntegrityViolationException

import rastrograo.tabela.TipoResponsavel

class ResponsavelEmpresaController {

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
    
    def getPermissao (empresaInstance) {
        /*
         * Mensagem erro permissão visualização/edição
         * Se não é administrador e acesso não está vinculado à empresa
         */
        if (acessoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }) {
            def acessoInstanceList = rastrograo.seguranca.Acesso.createCriteria().list(){
                empresas{
                    eq('id', empresaInstance?.id)
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

    def list(Integer max, Long tipoResponsavelId, Long empresaId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'nomeResponsavelEmpresa'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new ResponsavelEmpresa(params)
        consultaInstance?.tipoResponsavel = TipoResponsavel.get(tipoResponsavelId)
        consultaInstance?.empresa = Empresa.get(empresaId)
        consultaInstance?.nomeResponsavelEmpresa = params?.nomeResponsavelEmpresa?.trim()
        consultaInstance?.dddResponsavelEmpresa = params?.dddResponsavelEmpresa?.trim()
        consultaInstance?.numeroTelefoneResponsavelEmpresa = params?.numeroTelefoneResponsavelEmpresa?.trim()
        def responsavelEmpresaInstanceList
        def responsavelEmpresaInstanceTotal  
         
        //regra de negócio de consulta    
        if((consultaInstance?.nomeResponsavelEmpresa?.length() <= 1 && consultaInstance?.nomeResponsavelEmpresa) ||
            (consultaInstance?.dddResponsavelEmpresa?.length() <= 1 && consultaInstance?.dddResponsavelEmpresa)||
            (consultaInstance?.numeroTelefoneResponsavelEmpresa?.length() <= 1 && consultaInstance?.numeroTelefoneResponsavelEmpresa)){
            if (consultaInstance?.nomeResponsavelEmpresa?.length() <= 1 && consultaInstance?.nomeResponsavelEmpresa) {
                consultaInstance.errors.rejectValue("nomeResponsavelEmpresa", "default.minSize.message",
                    [message(code: 'responsavelEmpresa.label', default: 'Responsavel Empresa'), message(code: 'responsavelEmpresa.nomeResponsavelEmpresa.label', default: 'Nome Responsavel Empresa')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.dddResponsavelEmpresa?.length() <= 1 && consultaInstance?.dddResponsavelEmpresa) {
                consultaInstance.errors.rejectValue("dddResponsavelEmpresa", "default.minSize.message",
                    [message(code: 'responsavelEmpresa.label', default: 'Responsavel Empresa'), message(code: 'responsavelEmpresa.dddResponsavelEmpresa.label', default: 'Ddd Responsavel Empresa')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.numeroTelefoneResponsavelEmpresa?.length() <= 1 && consultaInstance?.numeroTelefoneResponsavelEmpresa) {
                consultaInstance.errors.rejectValue("numeroTelefoneResponsavelEmpresa", "default.minSize.message",
                    [message(code: 'responsavelEmpresa.label', default: 'Responsavel Empresa'), message(code: 'responsavelEmpresa.numeroTelefoneResponsavelEmpresa.label', default: 'Ddd Responsavel Empresa')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    responsavelEmpresaInstanceList: responsavelEmpresaInstanceList, 
                    responsavelEmpresaInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        responsavelEmpresaInstanceList = ResponsavelEmpresa.createCriteria().list(params){
            and{
                tipoResponsavel{
                    if(consultaInstance?.tipoResponsavel) eq('id', consultaInstance?.tipoResponsavel?.id)
                    if(params?.sort.contains('tipoResponsavel')) order('descricaoTipoResponsavel',params.order)
                }
                empresa{
                    'in'('id', acessoInstance?.empresas?.id)
                    if(consultaInstance?.empresa) eq('id', consultaInstance?.empresa?.id)
                    if(params?.sort.contains('empresa')) order('nomeEmpresa',params.order)
                }
                if(consultaInstance?.nomeResponsavelEmpresa?.length() > 1) ilike('nomeResponsavelEmpresa', "%" + consultaInstance?.nomeResponsavelEmpresa + "%")
                if(consultaInstance?.dddResponsavelEmpresa?.length() > 1) ilike('dddResponsavelEmpresa', "%" + consultaInstance?.dddResponsavelEmpresa + "%")
                if(consultaInstance?.numeroTelefoneResponsavelEmpresa?.length() > 1) ilike('numeroTelefoneResponsavelEmpresa', "%" + consultaInstance?.numeroTelefoneResponsavelEmpresa + "%")
            }
            if(params?.sort.equals('nomeResponsavelEmpresa')) order(params.sort,params.order)
            if(params?.sort.equals('dddResponsavelEmpresa')) order(params.sort,params.order)
            if(params?.sort.equals('numeroTelefoneResponsavelEmpresa')) order(params.sort,params.order)
        }
        
        //retorno
        [responsavelEmpresaInstanceList: responsavelEmpresaInstanceList, 
            responsavelEmpresaInstanceTotal: responsavelEmpresaInstanceList.totalCount,
            consultaInstance: consultaInstance,
            empresaInstanceList: acessoInstance?.empresas]
    }

    def create() {
        [responsavelEmpresaInstance: new ResponsavelEmpresa(params),
            empresaInstanceList: acessoInstance?.empresas]
    }

    def save() {
        def responsavelEmpresaInstance = new ResponsavelEmpresa(params)
        if (!responsavelEmpresaInstance.save(flush: true)) {
            render(view: "create", model: [responsavelEmpresaInstance: responsavelEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa'), responsavelEmpresaInstance.id])
        redirect(action: "show", id: responsavelEmpresaInstance.id)
    }

    def show(Long id) {
        def responsavelEmpresaInstance = ResponsavelEmpresa.get(id)
        if (!responsavelEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa'), id])
            redirect(action: "list")
            return
        }

        getPermissao(responsavelEmpresaInstance?.empresa)
        
        [responsavelEmpresaInstance: responsavelEmpresaInstance]
    }

    def edit(Long id) {
        def responsavelEmpresaInstance = ResponsavelEmpresa.get(id)
        if (!responsavelEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa'), id])
            redirect(action: "list")
            return
        }

        getPermissao(responsavelEmpresaInstance?.empresa)
        
        [responsavelEmpresaInstance: responsavelEmpresaInstance,
            empresaInstanceList: acessoInstance?.empresas]
    }

    def update(Long id, Long version) {
        def responsavelEmpresaInstance = ResponsavelEmpresa.get(id)
        if (!responsavelEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (responsavelEmpresaInstance.version > version) {
                responsavelEmpresaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa')] as Object[],
                          "Another user has updated this ResponsavelEmpresa while you were editing")
                render(view: "edit", model: [responsavelEmpresaInstance: responsavelEmpresaInstance,
                        empresaInstanceList: acessoInstance?.empresas])
                return
            }
        }

        responsavelEmpresaInstance.properties = params

        if (!responsavelEmpresaInstance.save(flush: true)) {
            render(view: "edit", model: [responsavelEmpresaInstance: responsavelEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa'), responsavelEmpresaInstance.id])
        redirect(action: "show", id: responsavelEmpresaInstance.id)
    }

    def delete(Long id) {
        def responsavelEmpresaInstance = ResponsavelEmpresa.get(id)
        if (!responsavelEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa'), id])
            redirect(action: "list")
            return
        }

        try {
            responsavelEmpresaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa'), id])
            redirect(action: "show", id: id)
        }
    }
}
