package rastrograo.estrutura

import org.springframework.dao.DataIntegrityViolationException

class ListaAtributoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def getListaAtributoInstanceList (id, atributoId) {
        //aplicação dos parâmetros à consulta
        def listaAtributoInstanceList = ListaAtributo.createCriteria().list(){
            and{
                atributo{
                    eq('id', atributoId?.toLong())
                }
                if(id) ne('id', id?.toLong())
                order('valorListaAtributo','asc')
            }
        }
        return listaAtributoInstanceList
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long produtoId, Long faseId, Long atributoId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'valorListaAtributo'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new ListaAtributo(params)
        def produtoInstance = Produto.get(produtoId)
        consultaInstance?.atributo?.fase = Fase.get(faseId)
        consultaInstance?.atributo = Atributo.get(atributoId)
        consultaInstance?.valorListaAtributo = params?.valorListaAtributo?.trim()
        def listaAtributoInstanceList
        def listaAtributoInstanceTotal     
            
        //regra de negócio de consulta    
        if(consultaInstance?.valorListaAtributo?.length() <= 1 && consultaInstance?.valorListaAtributo){
            consultaInstance.errors.rejectValue("valorListaAtributo", "default.minSize.message",
                [message(code: 'listaAtributo.label', default: 'Lista Atributo'), message(code: 'listaAtributo.valorListaAtributo.label', default: 'Valor Lista Atributo')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    listaAtributoInstanceList: listaAtributoInstanceList, 
                    listaAtributoInstanceTotal: 0])
            return
        } 
        
        //aplicação dos parâmetros à consulta
        listaAtributoInstanceList = ListaAtributo.createCriteria().list(params){
            and{
                atributo{
                    if(consultaInstance?.atributo) eq('id', consultaInstance?.atributo?.id)
                    if(params?.sort?.contains('nomeAtributo')) order('nomeAtributo',params.order)
                    fase{
                        if(consultaInstance?.atributo?.fase) eq('id', consultaInstance?.atributo?.fase?.id)
                        if(params?.sort?.contains('descricaoFase')) order('descricaoFase',params.order)
                        produto{
                            if(produtoInstance) eq('id',produtoInstance?.id)
                            if(params?.sort?.contains('descricaoProduto')) order('descricaoProduto',params.order)
                        }
                    }
                }
                if(consultaInstance?.valorListaAtributo?.length() > 1) ilike('valorListaAtributo', "%" + valorListaAtributo?.nomeListaAtributo + "%")
                if(params?.sort.contains('valorListaAtributo')) order('valorListaAtributo',params.order)
            }
        }
        
        //retorno
        [listaAtributoInstanceList: listaAtributoInstanceList, 
            listaAtributoInstanceTotal: listaAtributoInstanceList.totalCount,
            consultaInstance: consultaInstance,
            produtoInstance: produtoInstance]
    }

    def create() {
        [listaAtributoInstance: new ListaAtributo(params),
            listaAtributoInstanceList: getListaAtributoInstanceList(0, params?.atributo?.id)]
    }

    def save() {
        def listaAtributoInstance = new ListaAtributo(params)
        if (!listaAtributoInstance.save(flush: true)) {
            render(view: "create", model: [listaAtributoInstance: listaAtributoInstance,
                    listaAtributoInstanceList: getListaAtributoInstanceList(0, params?.atributo?.id)])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'listaAtributo.label', default: 'ListaAtributo'), listaAtributoInstance.id])
        redirect(action: "show", id: listaAtributoInstance.id)
    }

    def show(Long id) {
        def listaAtributoInstance = ListaAtributo.get(id)
        if (!listaAtributoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'listaAtributo.label', default: 'ListaAtributo'), id])
            redirect(action: "list")
            return
        }

        [listaAtributoInstance: listaAtributoInstance,
            listaAtributoInstanceList: getListaAtributoInstanceList(listaAtributoInstance?.id, listaAtributoInstance?.atributo?.id)]
    }

    def edit(Long id) {
        def listaAtributoInstance = ListaAtributo.get(id)
        if (!listaAtributoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'listaAtributo.label', default: 'ListaAtributo'), id])
            redirect(action: "list")
            return
        }

        [listaAtributoInstance: listaAtributoInstance,
            listaAtributoInstanceList: getListaAtributoInstanceList(listaAtributoInstance?.id, listaAtributoInstance?.atributo?.id)]
    }

    def update(Long id, Long version) {
        def listaAtributoInstance = ListaAtributo.get(id)
        if (!listaAtributoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'listaAtributo.label', default: 'ListaAtributo'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (listaAtributoInstance.version > version) {
                listaAtributoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'listaAtributo.label', default: 'ListaAtributo')] as Object[],
                          "Another user has updated this ListaAtributo while you were editing")
                render(view: "edit", model: [listaAtributoInstance: listaAtributoInstance,
                        listaAtributoInstanceList: getListaAtributoInstanceList(listaAtributoInstance?.id, listaAtributoInstance?.atributo?.id)])
                return
            }
        }

        listaAtributoInstance.properties = params

        if (!listaAtributoInstance.save(flush: true)) {
            render(view: "edit", model: [listaAtributoInstance: listaAtributoInstance,
                    listaAtributoInstanceList: getListaAtributoInstanceList(listaAtributoInstance?.id, listaAtributoInstance?.atributo?.id)])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'listaAtributo.label', default: 'ListaAtributo'), listaAtributoInstance.id])
        redirect(action: "show", id: listaAtributoInstance.id)
    }

    def delete(Long id) {
        def listaAtributoInstance = ListaAtributo.get(id)
        if (!listaAtributoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'listaAtributo.label', default: 'ListaAtributo'), id])
            redirect(action: "list")
            return
        }

        try {
            listaAtributoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'listaAtributo.label', default: 'ListaAtributo'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'listaAtributo.label', default: 'ListaAtributo'), id])
            redirect(action: "show", id: id)
        }
    }
}
