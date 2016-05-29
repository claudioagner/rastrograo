package rastrograo.tabela

import org.springframework.dao.DataIntegrityViolationException

class TipoResponsavelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'descricaoTipoResponsavel'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new TipoResponsavel(params)
        consultaInstance?.descricaoTipoResponsavel = params?.descricaoTipoResponsavel?.trim()
        def tipoResponsavelInstanceList
        def tipoResponsavelInstanceTotal      
        
        //regra de negócio de consulta    
        if(consultaInstance?.descricaoTipoResponsavel?.length() <= 1 && consultaInstance?.descricaoTipoResponsavel){
            consultaInstance.errors.rejectValue("descricaoTipoResponsavel", "default.minSize.message",
                [message(code: 'tipoResponsavel.label', default: 'Tipo Responsavel'), message(code: 'tipoResponsavel.descricaoTipoResponsavel.label', default: 'Descricao Tipo Responsavel')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    tipoResponsavelInstanceList: tipoResponsavelInstanceList, 
                    tipoResponsavelInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        tipoResponsavelInstanceList = TipoResponsavel.createCriteria().list(params){
            and{
                if(consultaInstance?.descricaoTipoResponsavel?.length() > 1) ilike('descricaoTipoResponsavel', "%" + consultaInstance?.descricaoTipoResponsavel + "%")
            }
            order(params.sort,params.order)
        }
        
        //retorno
        [tipoResponsavelInstanceList: tipoResponsavelInstanceList, 
            tipoResponsavelInstanceTotal: tipoResponsavelInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [tipoResponsavelInstance: new TipoResponsavel(params)]
    }

    def save() {
        def tipoResponsavelInstance = new TipoResponsavel(params)
        if (!tipoResponsavelInstance.save(flush: true)) {
            render(view: "create", model: [tipoResponsavelInstance: tipoResponsavelInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), tipoResponsavelInstance.id])
        redirect(action: "show", id: tipoResponsavelInstance.id)
    }

    def show(Long id) {
        def tipoResponsavelInstance = TipoResponsavel.get(id)
        if (!tipoResponsavelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), id])
            redirect(action: "list")
            return
        }

        [tipoResponsavelInstance: tipoResponsavelInstance]
    }

    def edit(Long id) {
        def tipoResponsavelInstance = TipoResponsavel.get(id)
        if (!tipoResponsavelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), id])
            redirect(action: "list")
            return
        }

        [tipoResponsavelInstance: tipoResponsavelInstance]
    }

    def update(Long id, Long version) {
        def tipoResponsavelInstance = TipoResponsavel.get(id)
        if (!tipoResponsavelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tipoResponsavelInstance.version > version) {
                tipoResponsavelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel')] as Object[],
                          "Another user has updated this TipoResponsavel while you were editing")
                render(view: "edit", model: [tipoResponsavelInstance: tipoResponsavelInstance])
                return
            }
        }

        tipoResponsavelInstance.properties = params

        if (!tipoResponsavelInstance.save(flush: true)) {
            render(view: "edit", model: [tipoResponsavelInstance: tipoResponsavelInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), tipoResponsavelInstance.id])
        redirect(action: "show", id: tipoResponsavelInstance.id)
    }

    def delete(Long id) {
        def tipoResponsavelInstance = TipoResponsavel.get(id)
        if (!tipoResponsavelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), id])
            redirect(action: "list")
            return
        }
        
        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params responsaveisEmpresa, responsaveisPropriedade
         * @return caso verdadeiro tela de visualização do registro
         * 7/5/2016 10:29
         */
        if(tipoResponsavelInstance.responsaveisEmpresa || tipoResponsavelInstance.responsaveisPropriedade){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            tipoResponsavelInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tipoResponsavel.label', default: 'TipoResponsavel'), id])
            redirect(action: "show", id: id)
        }
    }
}
