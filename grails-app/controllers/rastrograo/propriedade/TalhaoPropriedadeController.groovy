package rastrograo.propriedade

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class TalhaoPropriedadeController {

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

    //método ajax para popular dinamicamente os talhoes de acordo com a propriedade selecionado
    def ajaxGetTalhaoPropriedade (Long id) {
        def propriedadeInstance = Propriedade.get(id)
        def talhaoPropriedadeInstanceList = TalhaoPropriedade.withCriteria {
            if(propriedadeInstance){
                propriedade{
                    eq('id', propriedadeInstance?.id)
                }
            }
            order('descricaoTalhao', 'asc')
        }                
        def resposta = []
        resposta = talhaoPropriedadeInstanceList
        render resposta as JSON
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long propriedadeId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'descricaoTalhao'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new TalhaoPropriedade(params)
        consultaInstance?.propriedade = Propriedade.get(propriedadeId)
        consultaInstance?.descricaoTalhao = params?.descricaoTalhao?.trim()
        def talhaoPropriedadeInstanceList
        def talhaoPropriedadeInstanceTotal    
        
        //regra de negócio de consulta    
        if(consultaInstance?.descricaoTalhao?.length() <= 1 && consultaInstance?.descricaoTalhao){
            consultaInstance.errors.rejectValue("descricaoTalhao", "default.minSize.message",
                [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), message(code: 'talhaoPropriedade.descricaoTalhao.label', default: 'Descricao Talhao')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    talhaoPropriedadeInstanceList: talhaoPropriedadeInstanceList, 
                    talhaoPropriedadeInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        talhaoPropriedadeInstanceList = TalhaoPropriedade.createCriteria().list(params){
            and{
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id)
                    if(consultaInstance?.propriedade) eq('id', consultaInstance?.propriedade?.id)
                    if(params?.sort.contains('propriedade')) order('nomePropriedade',params.order)
                }
                if(consultaInstance?.descricaoTalhao?.length() > 1) ilike('descricaoTalhao', "%" + consultaInstance?.descricaoTalhao + "%")
            }
            if(params?.sort.equals('descricaoTalhao')) order(params.sort,params.order)
        }
        
        //retorno
        [talhaoPropriedadeInstanceList: talhaoPropriedadeInstanceList, 
            talhaoPropriedadeInstanceTotal: talhaoPropriedadeInstanceList.totalCount,
            consultaInstance: consultaInstance,
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def create() {
        [talhaoPropriedadeInstance: new TalhaoPropriedade(params),
            propriedadeInstanceList: acessoInstance?.propriedades]
    }

    def save() {
        def talhaoPropriedadeInstance = new TalhaoPropriedade(params)
        if (!talhaoPropriedadeInstance.save(flush: true)) {
            render(view: "create", model: [talhaoPropriedadeInstance: talhaoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), talhaoPropriedadeInstance.id])
        redirect(action: "show", id: talhaoPropriedadeInstance.id)
    }

    def show(Long id) {
        def talhaoPropriedadeInstance = TalhaoPropriedade.get(id)
        if (!talhaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(talhaoPropriedadeInstance?.propriedade)
        
        [talhaoPropriedadeInstance: talhaoPropriedadeInstance]
    }

    def edit(Long id) {
        def talhaoPropriedadeInstance = TalhaoPropriedade.get(id)
        if (!talhaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(talhaoPropriedadeInstance?.propriedade)
        
        [talhaoPropriedadeInstance: talhaoPropriedadeInstance]
    }

    def update(Long id, Long version) {
        def talhaoPropriedadeInstance = TalhaoPropriedade.get(id)
        if (!talhaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (talhaoPropriedadeInstance.version > version) {
                talhaoPropriedadeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade')] as Object[],
                          "Another user has updated this TalhaoPropriedade while you were editing")
                render(view: "edit", model: [talhaoPropriedadeInstance: talhaoPropriedadeInstance,
                        propriedadeInstanceList: acessoInstance?.propriedades])
                return
            }
        }

        talhaoPropriedadeInstance.properties = params

        if (!talhaoPropriedadeInstance.save(flush: true)) {
            render(view: "edit", model: [talhaoPropriedadeInstance: talhaoPropriedadeInstance,
                    propriedadeInstanceList: acessoInstance?.propriedades])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), talhaoPropriedadeInstance.id])
        redirect(action: "show", id: talhaoPropriedadeInstance.id)
    }

    def delete(Long id) {
        def talhaoPropriedadeInstance = TalhaoPropriedade.get(id)
        if (!talhaoPropriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), id])
            redirect(action: "list")
            return
        }

        try {
            talhaoPropriedadeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade'), id])
            redirect(action: "show", id: id)
        }
    }
}
