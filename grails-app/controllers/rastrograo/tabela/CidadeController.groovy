package rastrograo.tabela

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class CidadeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    //método ajax para popular dinamicamente as cidades de acordo com o estado selecionado
    def ajaxGetCidade (Long id) {
        def estadoInstance = Estado.get(id)
        def cidadeInstanceList = Cidade.withCriteria {
            if(estadoInstance){
                estado{
                    eq('id', estadoInstance?.id)
                }
            }
            order('nomeCidade', 'asc')
        }                
        def resposta = []
        resposta = cidadeInstanceList
        render resposta as JSON
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long paisId, Long estadoId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'nomeCidade'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Cidade(params)
        consultaInstance?.estado?.pais = Pais.get(paisId)
        consultaInstance?.estado = Estado.get(estadoId)
        consultaInstance?.nomeCidade = params?.nomeCidade?.trim()
        
        def cidadeInstanceList
        def cidadeInstanceTotal
        
        //regra de negócio de consulta        
        if (consultaInstance?.nomeCidade?.length() <= 1 && consultaInstance?.nomeCidade) {
            consultaInstance.errors.rejectValue("nomeCidade", "default.minSize.message",
                [message(code: 'cidade.label', default: 'Cidade'), message(code: 'cidade.nomeCidade.label', default: 'Nome Cidade')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    cidadeInstanceList: cidadeInstanceList, 
                    cidadeInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        cidadeInstanceList = Cidade.createCriteria().list(params){
            and{
                estado{
                    if(consultaInstance?.estado) eq('id', consultaInstance?.estado?.id)
                    if(params?.sort.equals('estado')) order('nomeEstado', params.order)
                    pais{
                        if(consultaInstance?.estado?.pais) eq('id', consultaInstance?.estado?.pais?.id)
                        if(params?.sort.contains('pais')) order('nomePais', params.order)
                    }
                }
                if(consultaInstance?.nomeCidade?.length() > 1) ilike('nomeCidade', "%" + consultaInstance?.nomeCidade + "%")
            }
            if(params?.sort.equals('nomeCidade')) order(params.sort, params.order)
        }
        
        [cidadeInstanceList: cidadeInstanceList, 
            cidadeInstanceTotal: cidadeInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [cidadeInstance: new Cidade(params)]
    }

    def save() {
        def cidadeInstance = new Cidade(params)
        if (!cidadeInstance.save(flush: true)) {
            render(view: "create", model: [cidadeInstance: cidadeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cidade.label', default: 'Cidade'), cidadeInstance.id])
        redirect(action: "show", id: cidadeInstance.id)
    }

    def show(Long id) {
        def cidadeInstance = Cidade.get(id)
        if (!cidadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cidade.label', default: 'Cidade'), id])
            redirect(action: "list")
            return
        }

        [cidadeInstance: cidadeInstance]
    }

    def edit(Long id) {
        def cidadeInstance = Cidade.get(id)
        if (!cidadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cidade.label', default: 'Cidade'), id])
            redirect(action: "list")
            return
        }

        [cidadeInstance: cidadeInstance]
    }

    def update(Long id, Long version) {
        def cidadeInstance = Cidade.get(id)
        if (!cidadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cidade.label', default: 'Cidade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cidadeInstance.version > version) {
                cidadeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'cidade.label', default: 'Cidade')] as Object[],
                          "Another user has updated this Cidade while you were editing")
                render(view: "edit", model: [cidadeInstance: cidadeInstance])
                return
            }
        }

        cidadeInstance.properties = params

        if (!cidadeInstance.save(flush: true)) {
            render(view: "edit", model: [cidadeInstance: cidadeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cidade.label', default: 'Cidade'), cidadeInstance.id])
        redirect(action: "show", id: cidadeInstance.id)
    }

    def delete(Long id) {
        def cidadeInstance = Cidade.get(id)
        if (!cidadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cidade.label', default: 'Cidade'), id])
            redirect(action: "list")
            return
        }

        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params empresas, propriedades
         * @return caso verdadeiro tela de visualização do registro
         * 7/5/2016 12:46
         */
        if(cidadeInstance.empresas || cidadesInstance.propriedades){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cidade.label', default: 'Cidade'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            cidadeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cidade.label', default: 'Cidade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cidade.label', default: 'Cidade'), id])
            redirect(action: "show", id: id)
        }
    }
}
