package rastrograo.rastreamento

import org.springframework.dao.DataIntegrityViolationException

import rastrograo.empresa.Empresa
import rastrograo.propriedade.Propriedade

class ConsolidacaoController {

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
    
    def getEmpresaInstanceList = {
        def empresaInstanceList = Empresa.createCriteria().list(){
            'in'('id', acessoInstance?.empresas?.id ?: (0).toLong())
        }
        return empresaInstanceList
    }
    
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'dataConsolidacao'
        params.order = params?.order?:'desc'
        
        def consultaInstance = new Consolidacao(params)
        consultaInstance.empresa = Empresa.get(params?.empresaId ? params?.empresaId?.toLong() : 0)
        consultaInstance.empresaOrigem = Empresa.get(params?.empresaOrigemId ? params?.empresaOrigemId?.toLong() : 0)
        consultaInstance.propriedadeOrigem = Propriedade.get(params?.propriedadeOrigemId ? params?.propriedadeOrigemId?.toLong() : 0)
        consultaInstance.nrLoteConsolidado = params?.nrLoteConsolidado ? params?.nrLoteConsolidado?.trim() : null
        
        def consolidacaoInstanceList
        def consolidacaoInstanceTotal 
        
        consolidacaoInstanceList = Consolidacao.createCriteria().list(params){
            and{
                empresa{
                    'in'('id', acessoInstance?.empresas?.id ?: (0).toLong())
                }
                if(consultaInstance.empresa) eq('empresa', consultaInstance.empresa)
                if(consultaInstance.empresaOrigem) eq('empresaOrigem', consultaInstance.empresaOrigem)
                if(consultaInstance.propriedadeOrigem) eq('propriedadeOrigem', consultaInstance.propriedadeOrigem)
                if(consultaInstance?.nrLoteConsolidado) ilike('nrLoteConsolidado', "%" + consultaInstance?.nrLoteConsolidado + "%")
            }
        }
        
        //retorno
        [consolidacaoInstanceList: consolidacaoInstanceList, 
            consolidacaoInstanceTotal: consolidacaoInstanceList.totalCount,   
            consultaInstance: consultaInstance,
            empresaInstanceList: empresaInstanceList]
    }

    def create() {
        [consolidacaoInstance: new Consolidacao(params), empresaInstanceList: empresaInstanceList]
    }

    def save() {
        def consolidacaoInstance = new Consolidacao(params)
        if (!consolidacaoInstance.save(flush: true)) {
            render(view: "create", model: [consolidacaoInstance: consolidacaoInstance, 
                    empresaInstanceList: empresaInstanceList])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'consolidacao.label', default: 'Consolidacao'), consolidacaoInstance.id])
        redirect(action: "show", id: consolidacaoInstance.id)
    }

    def show(Long id) {
        def consolidacaoInstance = Consolidacao.get(id)
        if (!consolidacaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'consolidacao.label', default: 'Consolidacao'), id])
            redirect(action: "list")
            return
        }

        getPermissao(consolidacaoInstance?.empresa)
        
        [consolidacaoInstance: consolidacaoInstance, 
            empresaInstanceList: empresaInstanceList]
    }

    def edit(Long id) {
        def consolidacaoInstance = Consolidacao.get(id)
        if (!consolidacaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'consolidacao.label', default: 'Consolidacao'), id])
            redirect(action: "list")
            return
        }

        getPermissao(consolidacaoInstance?.empresa)
        
        [consolidacaoInstance: consolidacaoInstance,
            empresaInstanceList: empresaInstanceList]
    }

    def update(Long id, Long version) {
        def consolidacaoInstance = Consolidacao.get(id)
        if (!consolidacaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'consolidacao.label', default: 'Consolidacao'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (consolidacaoInstance.version > version) {
                consolidacaoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'consolidacao.label', default: 'Consolidacao')] as Object[],
                          "Another user has updated this Consolidacao while you were editing")
                render(view: "edit", model: [consolidacaoInstance: consolidacaoInstance,
                        empresaInstanceList: empresaInstanceList])
                return
            }
        }

        consolidacaoInstance.properties = params

        if (!consolidacaoInstance.save(flush: true)) {
            render(view: "edit", model: [consolidacaoInstance: consolidacaoInstance,
                    empresaInstanceList: empresaInstanceList])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'consolidacao.label', default: 'Consolidacao'), consolidacaoInstance.id])
        redirect(action: "show", id: consolidacaoInstance.id)
    }

    def delete(Long id) {
        def consolidacaoInstance = Consolidacao.get(id)
        if (!consolidacaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'consolidacao.label', default: 'Consolidacao'), id])
            redirect(action: "list")
            return
        }

        try {
            consolidacaoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'consolidacao.label', default: 'Consolidacao'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'consolidacao.label', default: 'Consolidacao'), id])
            redirect(action: "show", id: id)
        }
    }
}
