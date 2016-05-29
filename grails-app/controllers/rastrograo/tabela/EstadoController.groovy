package rastrograo.tabela

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class EstadoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    //método ajax para popular dinamicamente os estado de acordo com o país selecionado
    def ajaxGetEstado (Long id) {
        def paisInstance = Pais.get(id)
        def estadoInstanceList = Estado.withCriteria {
            if(paisInstance){
                pais{
                    eq('id', paisInstance?.id)
                }
            }
            order('nomeEstado', 'asc')
        }                
        def resposta = []
        resposta = estadoInstanceList
        render resposta as JSON
    }
    
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long paisId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'nomeEstado'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Estado(params)
        consultaInstance?.pais = Pais.get(paisId)
        consultaInstance?.nomeEstado = params?.nomeEstado?.trim()
        consultaInstance?.sigla = params?.sigla?.trim()
        def estadoInstanceList
        def estadoInstanceTotal 
        
        //regra de negócio de consulta    
        if((consultaInstance?.nomeEstado?.length() <= 1 && consultaInstance?.nomeEstado) ||
            (consultaInstance?.sigla?.length() <= 1 && consultaInstance?.sigla)){
            if (consultaInstance?.nomeEstado?.length() <= 1 && consultaInstance?.nomeEstado) {
                consultaInstance.errors.rejectValue("nomeEstado", "default.minSize.message",
                    [message(code: 'estado.label', default: 'Estado'), message(code: 'estado.nomeEstado.label', default: 'Nome Estado')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.sigla?.length() <= 1 && consultaInstance?.sigla) {
                consultaInstance.errors.rejectValue("sigla", "default.minSize.message",
                    [message(code: 'estado.label', default: 'Estado'), message(code: 'estado.sigla.label', default: 'Sigla')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    estadoInstanceList: estadoInstanceList, 
                    estadoInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        estadoInstanceList = Estado.createCriteria().list(params){
            and{
                pais{
                    if(consultaInstance?.pais) eq('id', consultaInstance?.pais?.id)
                    if(params?.sort.equals('pais')) order('nomePais',params.order)
                }
                if(consultaInstance?.nomeEstado?.length() > 1) ilike('nomeEstado', "%" + consultaInstance?.nomeEstado + "%")
                if(consultaInstance?.sigla?.length() >= 1) ilike('sigla', "%" + consultaInstance?.sigla + "%")
            }
            if(!params?.sort.equals('pais')) order(params.sort,params.order)
        }
        
        //retorno
        [estadoInstanceList: estadoInstanceList, 
            estadoInstanceTotal: estadoInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [estadoInstance: new Estado(params)]
    }

    def save() {
        def estadoInstance = new Estado(params)
        if (!estadoInstance.save(flush: true)) {
            render(view: "create", model: [estadoInstance: estadoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'estado.label', default: 'Estado'), estadoInstance.id])
        redirect(action: "show", id: estadoInstance.id)
    }

    def show(Long id) {
        def estadoInstance = Estado.get(id)
        if (!estadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estado.label', default: 'Estado'), id])
            redirect(action: "list")
            return
        }

        [estadoInstance: estadoInstance]
    }

    def edit(Long id) {
        def estadoInstance = Estado.get(id)
        if (!estadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estado.label', default: 'Estado'), id])
            redirect(action: "list")
            return
        }

        [estadoInstance: estadoInstance]
    }

    def update(Long id, Long version) {
        def estadoInstance = Estado.get(id)
        if (!estadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estado.label', default: 'Estado'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (estadoInstance.version > version) {
                estadoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'estado.label', default: 'Estado')] as Object[],
                          "Another user has updated this Estado while you were editing")
                render(view: "edit", model: [estadoInstance: estadoInstance])
                return
            }
        }

        estadoInstance.properties = params

        if (!estadoInstance.save(flush: true)) {
            render(view: "edit", model: [estadoInstance: estadoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'estado.label', default: 'Estado'), estadoInstance.id])
        redirect(action: "show", id: estadoInstance.id)
    }

    def delete(Long id) {
        def estadoInstance = Estado.get(id)
        if (!estadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'estado.label', default: 'Estado'), id])
            redirect(action: "list")
            return
        }
        
        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params cidades
         * @return caso verdadeiro tela de visualização do registro
         * 7/5/2016 12:46
         */
        if(estadoInstance.cidades){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'estado.label', default: 'Estado'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            estadoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'estado.label', default: 'Estado'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'estado.label', default: 'Estado'), id])
            redirect(action: "show", id: id)
        }
    }
}
