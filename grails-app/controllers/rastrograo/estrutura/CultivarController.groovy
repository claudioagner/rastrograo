package rastrograo.estrutura

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class CultivarController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def getCultivarInstanceList (id, produtoId) {
        //aplicação dos parâmetros à consulta
        def cultivarInstanceList = Cultivar.createCriteria().list(){
            and{
                produto{
                    eq('id', produtoId?.toLong())
                }
                if(id) ne('id', id?.toLong())
                order('descricaoCultivar','asc')
            }
        }
        return cultivarInstanceList
    }

    //método ajax para popular dinamicamente as cultivares de acordo com o produto selecionado
    def ajaxGetCultivar (Long id) {
        def produtoInstance = Produto.get(id)
        def cultivarInstanceList = Cultivar.withCriteria {
            if(produtoInstance){
                produto{
                    eq('id', produtoInstance?.id)
                }
            }
            order('descricaoCultivar', 'asc')
        }                
        def resposta = []
        resposta = cultivarInstanceList
        render resposta as JSON
    }
    
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long produtoId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'descricaoCultivar'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Cultivar(params)
        consultaInstance?.produto = Produto.get(produtoId)
        consultaInstance?.descricaoCultivar = params?.descricaoCultivar?.trim()
        def cultivarInstanceList
        def cultivarInstanceTotal     
            
        //regra de negócio de consulta    
        if(consultaInstance?.descricaoCultivar?.length() <= 1 && consultaInstance?.descricaoCultivar){
            consultaInstance.errors.rejectValue("descricaoCultivar", "default.minSize.message",
                [message(code: 'cultivar.label', default: 'Cultivar'), message(code: 'cultivar.descricaoCultivar.label', default: 'Descricao Cultivar')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    cultivarInstanceList: cultivarInstanceList, 
                    cultivarInstanceTotal: 0])
            return
        } 
        
        //aplicação dos parâmetros à consulta
        cultivarInstanceList = Cultivar.createCriteria().list(params){
            and{
                produto{
                    if(consultaInstance?.produto) eq('id', consultaInstance?.produto?.id)
                    if(params?.sort.contains('produto')) order('descricaoProduto',params.order)
                }
                if(consultaInstance?.descricaoCultivar?.length() > 1) ilike('descricaoCultivar', "%" + consultaInstance?.descricaoCultivar + "%")
                if(params?.sort.equals('descricaoCultivar')) order('descricaoCultivar',params.order)
            }
        }
        
        //retorno
        [cultivarInstanceList: cultivarInstanceList, 
            cultivarInstanceTotal: cultivarInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [cultivarInstance: new Cultivar(params), 
            cultivarInstanceList: getCultivarInstanceList(0, params?.produto?.id)]
    }

    def save() {
        def cultivarInstance = new Cultivar(params)
        if (!cultivarInstance.save(flush: true)) {
            render(view: "create", model: [cultivarInstance: cultivarInstance,
                    cultivarInstanceList: getCultivarInstanceList(0, params?.produto?.id)])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cultivar.label', default: 'Cultivar'), cultivarInstance.id])
        redirect(action: "show", id: cultivarInstance.id)
    }

    def show(Long id) {
        def cultivarInstance = Cultivar.get(id)
        if (!cultivarInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cultivar.label', default: 'Cultivar'), id])
            redirect(action: "list")
            return
        }

        [cultivarInstance: cultivarInstance, 
            cultivarInstanceList: getCultivarInstanceList(cultivarInstance?.id, params?.produto?.id)]
    }

    def edit(Long id) {
        def cultivarInstance = Cultivar.get(id)
        if (!cultivarInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cultivar.label', default: 'Cultivar'), id])
            redirect(action: "list")
            return
        }

        [cultivarInstance: cultivarInstance,
            cultivarInstanceList: getCultivarInstanceList(cultivarInstance?.id, cultivarInstance?.produto?.id)]
    }

    def update(Long id, Long version) {
        def cultivarInstance = Cultivar.get(id)
        if (!cultivarInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cultivar.label', default: 'Cultivar'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cultivarInstance.version > version) {
                cultivarInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'cultivar.label', default: 'Cultivar')] as Object[],
                          "Another user has updated this Cultivar while you were editing")
                render(view: "edit", model: [cultivarInstance: cultivarInstance, 
                        cultivarInstanceList: getCultivarInstanceList(cultivarInstance?.id, cultivarInstance?.produto?.id)])
                return
            }
        }

        cultivarInstance.properties = params

        if (!cultivarInstance.save(flush: true)) {
            render(view: "edit", model: [cultivarInstance: cultivarInstance, 
                    cultivarInstanceList: getCultivarInstanceList(cultivarInstance?.id, cultivarInstance?.produto?.id)])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cultivar.label', default: 'Cultivar'), cultivarInstance.id])
        redirect(action: "show", id: cultivarInstance.id)
    }

    def delete(Long id) {
        def cultivarInstance = Cultivar.get(id)
        if (!cultivarInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cultivar.label', default: 'Cultivar'), id])
            redirect(action: "list")
            return
        }

        try {
            cultivarInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cultivar.label', default: 'Cultivar'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cultivar.label', default: 'Cultivar'), id])
            redirect(action: "show", id: id)
        }
    }
}
