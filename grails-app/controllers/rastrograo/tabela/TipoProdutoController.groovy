package rastrograo.tabela

import org.springframework.dao.DataIntegrityViolationException

class TipoProdutoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'descricaoTipoProduto'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new TipoProduto(params)
        consultaInstance?.descricaoTipoProduto = params?.descricaoTipoProduto?.trim()
        def tipoProdutoInstanceList
        def tipoProdutoInstanceTotal      
        
        //regra de negócio de consulta    
        if(consultaInstance?.descricaoTipoProduto?.length() <= 1 && consultaInstance?.descricaoTipoProduto){
            consultaInstance.errors.rejectValue("descricaoTipoProduto", "default.minSize.message",
                [message(code: 'tipoProduto.label', default: 'Tipo Produto'), message(code: 'tipoProduto.descricaoTipoProduto.label', default: 'Descricao Tipo Produto')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    tipoProdutoInstanceList: tipoProdutoInstanceList, 
                    tipoProdutoInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        tipoProdutoInstanceList = TipoProduto.createCriteria().list(params){
            and{
                if(consultaInstance?.descricaoTipoProduto?.length() > 1) ilike('descricaoTipoProduto', "%" + consultaInstance?.descricaoTipoProduto + "%")
            }
            order(params.sort,params.order)
        }
        
        //retorno
        [tipoProdutoInstanceList: tipoProdutoInstanceList, 
            tipoProdutoInstanceTotal: tipoProdutoInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [tipoProdutoInstance: new TipoProduto(params)]
    }

    def save() {
        def tipoProdutoInstance = new TipoProduto(params)
        if (!tipoProdutoInstance.save(flush: true)) {
            render(view: "create", model: [tipoProdutoInstance: tipoProdutoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), tipoProdutoInstance.id])
        redirect(action: "show", id: tipoProdutoInstance.id)
    }

    def show(Long id) {
        def tipoProdutoInstance = TipoProduto.get(id)
        if (!tipoProdutoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), id])
            redirect(action: "list")
            return
        }

        [tipoProdutoInstance: tipoProdutoInstance]
    }

    def edit(Long id) {
        def tipoProdutoInstance = TipoProduto.get(id)
        if (!tipoProdutoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), id])
            redirect(action: "list")
            return
        }

        [tipoProdutoInstance: tipoProdutoInstance]
    }

    def update(Long id, Long version) {
        def tipoProdutoInstance = TipoProduto.get(id)
        if (!tipoProdutoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tipoProdutoInstance.version > version) {
                tipoProdutoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'tipoProduto.label', default: 'TipoProduto')] as Object[],
                          "Another user has updated this TipoProduto while you were editing")
                render(view: "edit", model: [tipoProdutoInstance: tipoProdutoInstance])
                return
            }
        }

        tipoProdutoInstance.properties = params

        if (!tipoProdutoInstance.save(flush: true)) {
            render(view: "edit", model: [tipoProdutoInstance: tipoProdutoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), tipoProdutoInstance.id])
        redirect(action: "show", id: tipoProdutoInstance.id)
    }

    def delete(Long id) {
        def tipoProdutoInstance = TipoProduto.get(id)
        if (!tipoProdutoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), id])
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
        if(tipoProdutoInstance.produtos){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            tipoProdutoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tipoProduto.label', default: 'TipoProduto'), id])
            redirect(action: "show", id: id)
        }
    }
}
