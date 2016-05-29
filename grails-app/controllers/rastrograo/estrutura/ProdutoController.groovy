package rastrograo.estrutura

import org.springframework.dao.DataIntegrityViolationException

import rastrograo.tabela.TipoProduto

class ProdutoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'descricaoProduto'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Produto(params)
        consultaInstance?.tipoProduto = params?.tipoProdutoId ? TipoProduto.get(params?.tipoProdutoId?.toLong()) : null
        consultaInstance?.descricaoProduto = params?.descricaoProduto?.trim()
        def produtoInstanceList
        def produtoInstanceTotal     
            
        //regra de negócio de consulta    
        if(consultaInstance?.descricaoProduto?.length() <= 1 && consultaInstance?.descricaoProduto){
            consultaInstance.errors.rejectValue("descricaoProduto", "default.minSize.message",
                [message(code: 'produto.label', default: 'Produto'), message(code: 'produto.descricaoProduto.label', default: 'Url')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    produtoInstanceList: produtoInstanceList, 
                    produtoInstanceTotal: 0])
            return
        } 
        
        //aplicação dos parâmetros à consulta
        produtoInstanceList = Produto.createCriteria().list(params){
            and{
                tipoProduto{
                    if(consultaInstance?.tipoProduto) eq('id', consultaInstance?.tipoProduto?.id)
                    if(params.sort.contains("tipoProduto")) order("descricaoTipoProduto",params.order)
                }
                if(consultaInstance?.descricaoProduto?.length() > 1) ilike('descricaoProduto', "%" + consultaInstance?.descricaoProduto + "%")
            }
            if(params.sort.contains("descricaoProduto")) order("descricaoProduto",params.order)
        }
        
        //retorno
        [produtoInstanceList: produtoInstanceList, 
            produtoInstanceTotal: produtoInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [produtoInstance: new Produto(params)]
    }

    def save() {
        def produtoInstance = new Produto(params)
        if (!produtoInstance.save(flush: true)) {
            render(view: "create", model: [produtoInstance: produtoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'produto.label', default: 'Produto'), produtoInstance.id])
        redirect(action: "show", id: produtoInstance.id)
    }

    def show(Long id) {
        def produtoInstance = Produto.get(id)
        if (!produtoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'produto.label', default: 'Produto'), id])
            redirect(action: "list")
            return
        }

        [produtoInstance: produtoInstance]
    }

    def edit(Long id) {
        def produtoInstance = Produto.get(id)
        if (!produtoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'produto.label', default: 'Produto'), id])
            redirect(action: "list")
            return
        }

        [produtoInstance: produtoInstance]
    }

    def update(Long id, Long version) {
        def produtoInstance = Produto.get(id)
        if (!produtoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'produto.label', default: 'Produto'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (produtoInstance.version > version) {
                produtoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'produto.label', default: 'Produto')] as Object[],
                          "Another user has updated this Produto while you were editing")
                render(view: "edit", model: [produtoInstance: produtoInstance])
                return
            }
        }

        produtoInstance.properties = params

        if (!produtoInstance.save(flush: true)) {
            render(view: "edit", model: [produtoInstance: produtoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'produto.label', default: 'Produto'), produtoInstance.id])
        redirect(action: "show", id: produtoInstance.id)
    }

    def delete(Long id) {
        def produtoInstance = Produto.get(id)
        if (!produtoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'produto.label', default: 'Produto'), id])
            redirect(action: "list")
            return
        }

        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params produtos
         * @return caso verdadeiro tela de visualização do registro
         * 7/5/2016 10:31
         */
        if(produtoInstance.cultivares || produtoInstance.fases){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'produto.label', default: 'Produto'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            produtoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'produto.label', default: 'Produto'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'produto.label', default: 'Produto'), id])
            redirect(action: "show", id: id)
        }
    }
}
