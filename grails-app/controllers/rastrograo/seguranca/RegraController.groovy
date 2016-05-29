package rastrograo.seguranca

import org.springframework.dao.DataIntegrityViolationException

class RegraController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'authority'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Regra(params)
        consultaInstance?.authority = params?.authority?.trim()
        def regraInstanceList
        def regraInstanceTotal
        
        //regra de negócio de consulta        
        if (consultaInstance?.authority?.length() <= 1 && consultaInstance?.authority) {
            consultaInstance.errors.rejectValue("authority", "default.minSize.message",
                [message(code: 'regra.label', default: 'Regra'), message(code: 'regra.authority.label', default: 'Authority')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    regraInstanceList: regraInstanceList, 
                    regraInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        regraInstanceList = Regra.createCriteria().list(params){
            if(consultaInstance?.authority?.length() > 1) ilike('authority', "%" + consultaInstance?.authority + "%")
            order(params.sort,params.order)
        }
        
        //retorno
        [regraInstanceList: regraInstanceList, 
            regraInstanceTotal: regraInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [regraInstance: new Regra(params)]
    }

    def save() {
        def regraInstance = new Regra(params)
        
        //adicionar o prefixo da regra antes de gravar no banco
        regraInstance.authority = ("ROLE_"+regraInstance.authority)
        
        if (!regraInstance.save(flush: true)) {
            render(view: "create", model: [regraInstance: regraInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'regra.label', default: 'Regra'), regraInstance.id])
        redirect(action: "show", id: regraInstance.id)
    }

    def show(Long id) {
        def regraInstance = Regra.get(id)
        if (!regraInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'regra.label', default: 'Regra'), id])
            redirect(action: "list")
            return
        }

        [regraInstance: regraInstance]
    }

    def edit(Long id) {
        def regraInstance = Regra.get(id)
        if (!regraInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'regra.label', default: 'Regra'), id])
            redirect(action: "list")
            return
        }

        [regraInstance: regraInstance]
    }

    def update(Long id, Long version) {
        def regraInstance = Regra.get(id)
        if (!regraInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'regra.label', default: 'Regra'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (regraInstance.version > version) {
                regraInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'regra.label', default: 'Regra')] as Object[],
                          "Another user has updated this Regra while you were editing")
                render(view: "edit", model: [regraInstance: regraInstance])
                return
            }
        }

        regraInstance.properties = params

        //adicionar o prefixo da regra antes de gravar no banco
        regraInstance.authority = ("ROLE_"+regraInstance.authority)
        
        if (!regraInstance.save(flush: true)) {
            render(view: "edit", model: [regraInstance: regraInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'regra.label', default: 'Regra'), regraInstance.id])
        redirect(action: "show", id: regraInstance.id)
    }

    def delete(Long id) {
        def regraInstance = Regra.get(id)
        if (!regraInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'regra.label', default: 'Regra'), id])
            redirect(action: "list")
            return
        }

        try {
            regraInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'regra.label', default: 'Regra'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'regra.label', default: 'Regra'), id])
            redirect(action: "show", id: id)
        }
    }
}
