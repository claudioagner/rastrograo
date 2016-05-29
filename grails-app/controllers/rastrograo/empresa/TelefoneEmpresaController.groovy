package rastrograo.empresa

import org.springframework.dao.DataIntegrityViolationException

class TelefoneEmpresaController {

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

    def list(Integer max, Long empresaId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'numeroTelefoneEmpresa'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new TelefoneEmpresa(params)
        consultaInstance?.empresa = Empresa.get(empresaId)
        consultaInstance?.dddEmpresa = params?.dddEmpresa?.trim()
        consultaInstance?.numeroTelefoneEmpresa = params?.numeroTelefoneEmpresa?.trim()
        def telefoneEmpresaInstanceList
        def telefoneEmpresaInstanceTotal   
         
        //regra de negócio de consulta    
        if((consultaInstance?.dddEmpresa?.length() <= 1 && consultaInstance?.dddEmpresa)||
            (consultaInstance?.numeroTelefoneEmpresa?.length() <= 1 && consultaInstance?.numeroTelefoneEmpresa)){
            if (consultaInstance?.dddEmpresa?.length() <= 1 && consultaInstance?.dddEmpresa) {
                consultaInstance.errors.rejectValue("dddEmpresa", "default.minSize.message",
                    [message(code: 'telefoneEmpresa.label', default: 'Telefone Empresa'), message(code: 'telefoneEmpresa.dddEmpresa.label', default: 'Ddd Empresa')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.numeroTelefoneEmpresa?.length() <= 1 && consultaInstance?.numeroTelefoneEmpresa) {
                consultaInstance.errors.rejectValue("numeroTelefoneEmpresa", "default.minSize.message",
                    [message(code: 'responsavelEmpresa.label', default: 'Responsavel Empresa'), message(code: 'responsavelEmpresa.numeroTelefoneEmpresa.label', default: 'Numero Telefone Empresa')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    telefoneEmpresaInstanceList: telefoneEmpresaInstanceList, 
                    telefoneEmpresaInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        telefoneEmpresaInstanceList = TelefoneEmpresa.createCriteria().list(params){
            and{
                empresa{
                    'in'('id', acessoInstance?.empresas?.id)
                    if(consultaInstance?.empresa) eq('id', consultaInstance?.empresa?.id)
                    if(params?.sort.contains('empresa')) order('nomeEmpresa',params.order)
                }
                if(consultaInstance?.dddEmpresa?.length() > 1) ilike('dddEmpresa', "%" + consultaInstance?.dddEmpresa + "%")
                if(consultaInstance?.numeroTelefoneEmpresa?.length() > 1) ilike('numeroTelefoneEmpresa', "%" + consultaInstance?.numeroTelefoneEmpresa + "%")
            }
            if(params?.sort.equals('dddEmpresa')) order(params.sort,params.order)
            if(params?.sort.equals('numeroTelefoneEmpresa')) order(params.sort,params.order)
        }
        
        //retorno
        [telefoneEmpresaInstanceList: telefoneEmpresaInstanceList, 
            telefoneEmpresaInstanceTotal: telefoneEmpresaInstanceList.totalCount,
            consultaInstance: consultaInstance,
            empresaInstanceList: acessoInstance?.empresas]
    }

    def create() {
        [telefoneEmpresaInstance: new TelefoneEmpresa(params),
            empresaInstanceList: acessoInstance?.empresas]
    }

    def save() {
        def telefoneEmpresaInstance = new TelefoneEmpresa(params)
        if (!telefoneEmpresaInstance.save(flush: true)) {
            render(view: "create", model: [telefoneEmpresaInstance: telefoneEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa'), telefoneEmpresaInstance.id])
        redirect(action: "show", id: telefoneEmpresaInstance.id)
    }

    def show(Long id) {
        def telefoneEmpresaInstance = TelefoneEmpresa.get(id)
        if (!telefoneEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa'), id])
            redirect(action: "list")
            return
        }

        getPermissao(telefoneEmpresaInstance?.empresa)
        
        [telefoneEmpresaInstance: telefoneEmpresaInstance]
    }

    def edit(Long id) {
        def telefoneEmpresaInstance = TelefoneEmpresa.get(id)
        if (!telefoneEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa'), id])
            redirect(action: "list")
            return
        }

        getPermissao(telefoneEmpresaInstance?.empresa)
        
        [telefoneEmpresaInstance: telefoneEmpresaInstance,
            empresaInstanceList: acessoInstance?.empresas]
    }

    def update(Long id, Long version) {
        def telefoneEmpresaInstance = TelefoneEmpresa.get(id)
        if (!telefoneEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (telefoneEmpresaInstance.version > version) {
                telefoneEmpresaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa')] as Object[],
                          "Another user has updated this TelefoneEmpresa while you were editing")
                render(view: "edit", model: [telefoneEmpresaInstance: telefoneEmpresaInstance,
                        empresaInstanceList: acessoInstance?.empresas])
                return
            }
        }

        telefoneEmpresaInstance.properties = params

        if (!telefoneEmpresaInstance.save(flush: true)) {
            render(view: "edit", model: [telefoneEmpresaInstance: telefoneEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa'), telefoneEmpresaInstance.id])
        redirect(action: "show", id: telefoneEmpresaInstance.id)
    }

    def delete(Long id) {
        def telefoneEmpresaInstance = TelefoneEmpresa.get(id)
        if (!telefoneEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa'), id])
            redirect(action: "list")
            return
        }

        try {
            telefoneEmpresaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa'), id])
            redirect(action: "show", id: id)
        }
    }
}
