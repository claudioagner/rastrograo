package rastrograo.empresa

import org.springframework.dao.DataIntegrityViolationException

import rastrograo.tabela.TipoCertificacao

class CertificacaoEmpresaController {

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

    def list(Integer max, Long tipoCertificacaoId, Long empresaId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'empresa.nomeEmpresa'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new CertificacaoEmpresa(params)
        consultaInstance?.tipoCertificacao = TipoCertificacao.get(tipoCertificacaoId)
        consultaInstance?.empresa = Empresa.get(empresaId)
        def certificacaoEmpresaInstanceList
        def certificacaoEmpresaInstanceTotal  
        
        //aplicação dos parâmetros à consulta
        certificacaoEmpresaInstanceList = CertificacaoEmpresa.createCriteria().list(params){
            and{
                tipoCertificacao{
                    if(consultaInstance?.tipoCertificacao) eq('id', consultaInstance?.tipoCertificacao?.id)
                    if(params?.sort.contains('tipoCertificacao')) order('descricaoTipoCertificacao',params.order)
                }
                empresa{
                    'in'('id', acessoInstance?.empresas?.id)
                    if(consultaInstance?.empresa) eq('id', consultaInstance?.empresa?.id)
                    if(params?.sort.contains('empresa')) order('nomeEmpresa',params.order)
                }
            }
        }
        
        //retorno
        [certificacaoEmpresaInstanceList: certificacaoEmpresaInstanceList, 
            certificacaoEmpresaInstanceTotal: certificacaoEmpresaInstanceList.totalCount,
            consultaInstance: consultaInstance,
            empresaInstanceList: acessoInstance?.empresas]
    }

    def create() {
        [certificacaoEmpresaInstance: new CertificacaoEmpresa(params),
            empresaInstanceList: acessoInstance?.empresas]
    }

    def save() {
        def certificacaoEmpresaInstance = new CertificacaoEmpresa(params)
        if (!certificacaoEmpresaInstance.save(flush: true)) {
            render(view: "create", model: [certificacaoEmpresaInstance: certificacaoEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa'), certificacaoEmpresaInstance.id])
        redirect(action: "show", id: certificacaoEmpresaInstance.id)
    }

    def show(Long id) {
        def certificacaoEmpresaInstance = CertificacaoEmpresa.get(id)
        if (!certificacaoEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa'), id])
            redirect(action: "list")
            return
        }
        
        getPermissao(certificacaoEmpresaInstance?.empresa)
        
        [certificacaoEmpresaInstance: certificacaoEmpresaInstance]
    }

    def edit(Long id) {
        def certificacaoEmpresaInstance = CertificacaoEmpresa.get(id)
        if (!certificacaoEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa'), id])
            redirect(action: "list")
            return
        }

        getPermissao(certificacaoEmpresaInstance?.empresa)
        
        [certificacaoEmpresaInstance: certificacaoEmpresaInstance]
    }

    def update(Long id, Long version) {
        def certificacaoEmpresaInstance = CertificacaoEmpresa.get(id)
        if (!certificacaoEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (certificacaoEmpresaInstance.version > version) {
                certificacaoEmpresaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa')] as Object[],
                          "Another user has updated this CertificacaoEmpresa while you were editing")
                render(view: "edit", model: [certificacaoEmpresaInstance: certificacaoEmpresaInstance,
                        empresaInstanceList: acessoInstance?.empresas])
                return
            }
        }

        certificacaoEmpresaInstance.properties = params

        if (!certificacaoEmpresaInstance.save(flush: true)) {
            render(view: "edit", model: [certificacaoEmpresaInstance: certificacaoEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa'), certificacaoEmpresaInstance.id])
        redirect(action: "show", id: certificacaoEmpresaInstance.id)
    }

    def delete(Long id) {
        def certificacaoEmpresaInstance = CertificacaoEmpresa.get(id)
        if (!certificacaoEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa'), id])
            redirect(action: "list")
            return
        }

        try {
            certificacaoEmpresaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa'), id])
            redirect(action: "show", id: id)
        }
    }
}
