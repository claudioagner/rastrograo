package rastrograo.tabela

import org.springframework.dao.DataIntegrityViolationException

class PaisController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'nomePais'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Pais(params)
        consultaInstance?.nomePais = params?.nomePais?.trim()
        consultaInstance?.countryName = params?.countryName?.trim()
        def paisInstanceList
        def paisInstanceTotal      
        
        //regra de negócio de consulta    
        if((consultaInstance?.nomePais?.length() <= 1 && consultaInstance?.nomePais) ||
            (consultaInstance?.countryName?.length() <= 1 && consultaInstance?.countryName)){
            if (consultaInstance?.nomePais?.length() <= 1 && consultaInstance?.nomePais) {
                consultaInstance.errors.rejectValue("nomePais", "default.minSize.message",
                    [message(code: 'pais.label', default: 'Pais'), message(code: 'pais.nomePais.label', default: 'Url')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.countryName?.length() <= 1 && consultaInstance?.countryName) {
                consultaInstance.errors.rejectValue("countryName", "default.minSize.message",
                    [message(code: 'pais.label', default: 'Permissao'), message(code: 'pais.countryName.label', default: 'Email')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    paisInstanceList: paisInstanceList, 
                    paisInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        paisInstanceList = Pais.createCriteria().list(params){
            and{
                if(consultaInstance?.nomePais?.length() > 1) ilike('nomePais', "%" + consultaInstance?.nomePais + "%")
                if(consultaInstance?.countryName?.length() > 1) ilike('countryName', "%" + consultaInstance?.countryName + "%")
            }
            order(params.sort,params.order)
        }
        
        //retorno
        [paisInstanceList: paisInstanceList, 
            paisInstanceTotal: paisInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [paisInstance: new Pais(params)]
    }

    def save() {
        def paisInstance = new Pais(params)
        if (!paisInstance.save(flush: true)) {
            render(view: "create", model: [paisInstance: paisInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'pais.label', default: 'Pais'), paisInstance.id])
        redirect(action: "show", id: paisInstance.id)
    }

    def show(Long id) {
        def paisInstance = Pais.get(id)
        if (!paisInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'pais.label', default: 'Pais'), id])
            redirect(action: "list")
            return
        }

        [paisInstance: paisInstance]
    }

    def edit(Long id) {
        def paisInstance = Pais.get(id)
        if (!paisInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'pais.label', default: 'Pais'), id])
            redirect(action: "list")
            return
        }

        [paisInstance: paisInstance]
    }

    def update(Long id, Long version) {
        def paisInstance = Pais.get(id)
        if (!paisInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'pais.label', default: 'Pais'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (paisInstance.version > version) {
                paisInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'pais.label', default: 'Pais')] as Object[],
                          "Another user has updated this Pais while you were editing")
                render(view: "edit", model: [paisInstance: paisInstance])
                return
            }
        }

        paisInstance.properties = params

        if (!paisInstance.save(flush: true)) {
            render(view: "edit", model: [paisInstance: paisInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'pais.label', default: 'Pais'), paisInstance.id])
        redirect(action: "show", id: paisInstance.id)
    }

    def delete(Long id) {
        def paisInstance = Pais.get(id)
        if (!paisInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'pais.label', default: 'Pais'), id])
            redirect(action: "list")
            return
        }

        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params estados
         * @return caso verdadeiro tela de visualização do registro
         * 7/5/2016 12:46
         */
        if(paisInstance.estados){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'pais.label', default: 'Pais'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            paisInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'pais.label', default: 'Pais'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'pais.label', default: 'Pais'), id])
            redirect(action: "show", id: id)
        }
    }
}
