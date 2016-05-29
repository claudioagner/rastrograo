package rastrograo.seguranca

import org.springframework.dao.DataIntegrityViolationException

class PermissaoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'url'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Permissao(params)
        consultaInstance?.url = params?.url?.trim()
        consultaInstance?.configAttribute = params?.configAttribute?.trim()
        def permissaoInstanceList
        def permissaoInstanceTotal      
            
        //regra de negócio de consulta    
        if((consultaInstance?.url?.length() <= 1 && consultaInstance?.url) ||
            (consultaInstance?.configAttribute?.length() <= 1 && consultaInstance?.configAttribute)){
            if (consultaInstance?.url?.length() <= 1 && consultaInstance?.url) {
                consultaInstance.errors.rejectValue("url", "default.minSize.message",
                    [message(code: 'permissao.label', default: 'Permissao'), message(code: 'permissao.url.label', default: 'Url')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.configAttribute?.length() <= 1 && consultaInstance?.configAttribute) {
                consultaInstance.errors.rejectValue("configAttribute", "default.minSize.message",
                    [message(code: 'permissao.label', default: 'Permissao'), message(code: 'permissao.configAttribute.label', default: 'Email')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    permissaoInstanceList: permissaoInstanceList, 
                    permissaoInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        permissaoInstanceList = Permissao.createCriteria().list(params){
            and{
                if(consultaInstance?.url?.length() > 1) ilike('url', "%" + consultaInstance?.url + "%")
                if(consultaInstance?.configAttribute?.length() > 1) ilike('configAttribute', "%" + consultaInstance?.configAttribute.trim() + "%")
            }
            order(params.sort,params.order)
        }
        
        //retorno
        [permissaoInstanceList: permissaoInstanceList, 
            permissaoInstanceTotal: permissaoInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [permissaoInstance: new Permissao(params)]
    }

    def save() {
        def permissaoInstance = new Permissao(params)
        if (!permissaoInstance.save(flush: true)) {
            render(view: "create", model: [permissaoInstance: permissaoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'permissao.label', default: 'Permissao'), permissaoInstance.id])
        redirect(action: "show", id: permissaoInstance.id)
    }

    def show(Long id) {
        def permissaoInstance = Permissao.get(id)
        if (!permissaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissao.label', default: 'Permissao'), id])
            redirect(action: "list")
            return
        }

        [permissaoInstance: permissaoInstance]
    }

    def edit(Long id) {
        def permissaoInstance = Permissao.get(id)
        if (!permissaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissao.label', default: 'Permissao'), id])
            redirect(action: "list")
            return
        }

        [permissaoInstance: permissaoInstance]
    }

    def update(Long id, Long version) {
        def permissaoInstance = Permissao.get(id)
        if (!permissaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissao.label', default: 'Permissao'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (permissaoInstance.version > version) {
                permissaoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'permissao.label', default: 'Permissao')] as Object[],
                          "Another user has updated this Permissao while you were editing")
                render(view: "edit", model: [permissaoInstance: permissaoInstance])
                return
            }
        }

        permissaoInstance.properties = params

        if (!permissaoInstance.save(flush: true)) {
            render(view: "edit", model: [permissaoInstance: permissaoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'permissao.label', default: 'Permissao'), permissaoInstance.id])
        redirect(action: "show", id: permissaoInstance.id)
    }

    def delete(Long id) {
        def permissaoInstance = Permissao.get(id)
        if (!permissaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permissao.label', default: 'Permissao'), id])
            redirect(action: "list")
            return
        }

        try {
            permissaoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'permissao.label', default: 'Permissao'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'permissao.label', default: 'Permissao'), id])
            redirect(action: "show", id: id)
        }
    }
}
