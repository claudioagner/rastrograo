package rastrograo.estrutura

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class AtributoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def getAtributoInstanceList (id, faseId) {
        //aplicação dos parâmetros à consulta
        def atributoInstanceList = Atributo.createCriteria().list(){
            and{
                fase{
                    eq('id', faseId?.toLong())
                }
                if(id) ne('id', id?.toLong())
                order('nomeAtributo','asc')
            }
        }
        return atributoInstanceList
    }

    //método ajax para popular dinamicamente os atributos de acordo com a fase selecionada
    def ajaxGetAtributo (Long id) {
        def faseInstance = Fase.get(id)
        def atributoInstanceList = Atributo.withCriteria {
            if(faseInstance){
                fase{
                    eq('id', faseInstance?.id)
                }
            }
            order('nomeAtributo', 'asc')
        }                
        def resposta = []
        resposta = atributoInstanceList
        render resposta as JSON
    }
    
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long faseId, Long produtoId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'nomeAtributo'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Atributo(params)
        def produtoInstance = Produto.get(produtoId)
        consultaInstance?.fase = Fase.get(faseId)
        consultaInstance?.nomeAtributo = params?.nomeAtributo?.trim()
        consultaInstance?.tipoAtributo = params?.tipoAtributo?.trim()
        def atributoInstanceList
        def atributoInstanceTotal     
            
        //regra de negócio de consulta    
        if(consultaInstance?.nomeAtributo?.length() <= 1 && consultaInstance?.nomeAtributo){
            consultaInstance.errors.rejectValue("nomeAtributo", "default.minSize.message",
                [message(code: 'atributo.label', default: 'Atributo'), message(code: 'atributo.nomeAtributo.label', default: 'Nome Atributo')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    atributoInstanceList: atributoInstanceList, 
                    atributoInstanceTotal: 0])
            return
        } 
        
        //aplicação dos parâmetros à consulta
        atributoInstanceList = Atributo.createCriteria().list(params){
            and{
                fase{
                    if(consultaInstance?.fase) eq('id', consultaInstance?.fase?.id)
                    if(params?.sort.contains('fase')) order('descricaoFase',params.order)
                    produto{
                        if(produtoInstance) eq('id', produtoInstance?.id)
                        if(params?.sort.contains('produto')) order('descricaoProduto',params.order)
                    }
                }
                if(consultaInstance?.nomeAtributo?.length() > 1) ilike('nomeAtributo', "%" + consultaInstance?.nomeAtributo + "%")
                if(consultaInstance?.tipoAtributo) eq('tipoAtributo', consultaInstance?.tipoAtributo)
                if(params?.sort.equals('nomeAtributo')) order('nomeAtributo',params.order)
                if(params?.sort.equals('tipoAtributo')) order('tipoAtributo',params.order)
            }
        }
        
        //retorno
        [atributoInstanceList: atributoInstanceList, 
            atributoInstanceTotal: atributoInstanceList.totalCount,
            consultaInstance: consultaInstance,
            produtoInstance: produtoInstance]
    }

    def create() {
        [atributoInstance: new Atributo(params), 
            atributoInstanceList: getAtributoInstanceList(0, params?.fase?.id)]
    }

    def save() {
        def atributoInstance = new Atributo(params)
        if (!atributoInstance.save(flush: true)) {
            render(view: "create", model: [atributoInstance: atributoInstance, 
                    atributoInstanceList: getAtributoInstanceList(0, params?.fase?.id)])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'atributo.label', default: 'Atributo'), atributoInstance.id])
        redirect(action: "show", id: atributoInstance.id)
    }

    def show(Long id) {
        def atributoInstance = Atributo.get(id)
        if (!atributoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'atributo.label', default: 'Atributo'), id])
            redirect(action: "list")
            return
        }

        [atributoInstance: atributoInstance, 
            atributoInstanceList: atributoInstance?.fase?.atributos]
    }

    def edit(Long id) {
        def atributoInstance = Atributo.get(id)
        if (!atributoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'atributo.label', default: 'Atributo'), id])
            redirect(action: "list")
            return
        }

        [atributoInstance: atributoInstance, 
            atributoInstanceList: getAtributoInstanceList(atributoInstance?.id, atributoInstance?.fase?.id)]
    }

    def update(Long id, Long version) {
        def atributoInstance = Atributo.get(id)
        if (!atributoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'atributo.label', default: 'Atributo'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (atributoInstance.version > version) {
                atributoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'atributo.label', default: 'Atributo')] as Object[],
                          "Another user has updated this Atributo while you were editing")
                render(view: "edit", model: [atributoInstance: atributoInstance, 
                        atributoInstanceList: getAtributoInstanceList(atributoInstance?.id, atributoInstance?.fase?.id)])
                return
            }
        }

        atributoInstance.properties = params

        if (!atributoInstance.save(flush: true)) {
            render(view: "edit", model: [atributoInstance: atributoInstance, 
                    atributoInstanceList: getAtributoInstanceList(atributoInstance?.id, atributoInstance?.fase?.id)])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'atributo.label', default: 'Atributo'), atributoInstance.id])
        redirect(action: "show", id: atributoInstance.id)
    }

    def delete(Long id) {
        def atributoInstance = Atributo.get(id)
        if (!atributoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'atributo.label', default: 'Atributo'), id])
            redirect(action: "list")
            return
        }

        try {
            atributoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'atributo.label', default: 'Atributo'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'atributo.label', default: 'Atributo'), id])
            redirect(action: "show", id: id)
        }
    }
}
