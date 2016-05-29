package rastrograo.propriedade

import org.springframework.dao.DataIntegrityViolationException

import rastrograo.tabela.TipoCertificacao

class CertificacaoPropriedadeController {

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

    def list(Integer max, Long tipoCertificacaoId, Long propriedadeId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'propriedade.nomePropriedade'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new CertificacaoPropriedade(params)
        consultaInstance?.tipoCertificacao = TipoCertificacao.get(tipoCertificacaoId)
        consultaInstance?.propriedade = Propriedade.get(propriedadeId)
        def certificacaoPropriedadeInstanceList
        def certificacaoPropriedadeInstanceTotal  
        
        //aplicação dos parâmetros à consulta
        certificacaoPropriedadeInstanceList = CertificacaoPropriedade.createCriteria().list(params){
            and{
                tipoCertificacao{
                    if(consultaInstance?.tipoCertificacao) eq('id', consultaInstance?.tipoCertificacao?.id)
                    if(params?.sort.contains('tipoCertificacao')) order('descricaoTipoCertificacao',params.order)
                }
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id)
                    if(consultaInstance?.propriedade) eq('id', consultaInstance?.propriedade?.id)
                    if(params?.sort.contains('propriedade')) order('nomePropriedade',params.order)
                }
            }
        }
        
        //retorno
        [certificacaoPropriedadeInstanceList: certificacaoPropriedadeInstanceList, 
            certificacaoPropriedadeInstanceTotal: certificacaoPropriedadeInstanceList.totalCount,
            consultaInstance: consultaInstance,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def create() {
        [certificacaoPropriedadeInstance: new CertificacaoPropriedade(params),
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def save() {
        def certificacaoPropriedadeInstance = new CertificacaoPropriedade(params)
        if (!certificacaoPropriedadeInstance.save(flush: true)) {
            render(view: "create", model: [certificacaoPropriedadeInstance: certificacaoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade'), certificacaoPropriedadeInstance.id])
        redirect(action: "show", id: certificacaoPropriedadeInstance.id)
    }

    def show(Long id) {
        def certificacaoPropriedadeInstance = CertificacaoPropriedade.get(id)
        if (!certificacaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(certificacaoPropriedadeInstance?.propriedade)
        
        [certificacaoPropriedadeInstance: certificacaoPropriedadeInstance]
    }

    def edit(Long id) {
        def certificacaoPropriedadeInstance = CertificacaoPropriedade.get(id)
        if (!certificacaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(certificacaoPropriedadeInstance?.propriedade)
        
        [certificacaoPropriedadeInstance: certificacaoPropriedadeInstance,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def update(Long id, Long version) {
        def certificacaoPropriedadeInstance = CertificacaoPropriedade.get(id)
        if (!certificacaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (certificacaoPropriedadeInstance.version > version) {
                certificacaoPropriedadeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade')] as Object[],
                          "Another user has updated this CertificacaoPropriedade while you were editing")
                render(view: "edit", model: [certificacaoPropriedadeInstance: certificacaoPropriedadeInstance,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }
        }

        certificacaoPropriedadeInstance.properties = params

        if (!certificacaoPropriedadeInstance.save(flush: true)) {
            render(view: "edit", model: [certificacaoPropriedadeInstance: certificacaoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade'), certificacaoPropriedadeInstance.id])
        redirect(action: "show", id: certificacaoPropriedadeInstance.id)
    }

    def delete(Long id) {
        def certificacaoPropriedadeInstance = CertificacaoPropriedade.get(id)
        if (!certificacaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        try {
            certificacaoPropriedadeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade'), id])
            redirect(action: "show", id: id)
        }
    }
}
