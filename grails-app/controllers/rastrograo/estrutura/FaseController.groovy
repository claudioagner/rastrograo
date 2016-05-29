package rastrograo.estrutura

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class FaseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    /*
     * Método ajax para popular dinamicamente as fases de acordo com o produto selecionado
     * utilizado no cadastro de atributo (form, formConsulta)
     */
    def ajaxGetFase (Long id) {
        def produtoInstance = Produto.get(id)
        def faseInstanceList = Fase.withCriteria {
            produto{
                eq('id', produtoInstance?.id)
            }            
            order('descricaoFase', 'asc')
        }                
        def resposta = []
        resposta = faseInstanceList
        render resposta as JSON
    }
        
    def getFaseInstanceList (id, produtoId) {
        //aplicação dos parâmetros à consulta
        def faseInstanceList = Fase.createCriteria().list(){
            and{
                produto{
                    eq('id', produtoId?.toLong())
                }
                if(id) ne('id', id?.toLong())
                order('descricaoFase','asc')
            }
        }
        return faseInstanceList
    }
    
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long produtoId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'descricaoFase'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Fase(params)
        consultaInstance?.produto = Produto.get(produtoId)
        consultaInstance?.descricaoFase = params?.descricaoFase?.trim()
        def faseInstanceList
        def faseInstanceTotal     
            
        //regra de negócio de consulta    
        if(consultaInstance?.descricaoFase?.length() <= 1 && consultaInstance?.descricaoFase){
            consultaInstance.errors.rejectValue("descricaoFase", "default.minSize.message",
                [message(code: 'fase.label', default: 'Fase'), message(code: 'fase.descricaoFase.label', default: 'Descricao Fase')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    faseInstanceList: faseInstanceList, 
                    faseInstanceTotal: 0])
            return
        } 
        
        //aplicação dos parâmetros à consulta
        faseInstanceList = Fase.createCriteria().list(params){
            and{
                produto{
                    if(consultaInstance?.produto) eq('id', consultaInstance?.produto?.id)
                    if(params?.sort.contains('produto')) order('descricaoProduto',params.order)
                }
                if(consultaInstance?.descricaoFase?.length() > 1) ilike('descricaoFase', "%" + consultaInstance?.descricaoFase + "%")
                if(params?.sort.equals('descricaoFase')) order('descricaoFase',params.order)
            }
        }
        
        //retorno
        [faseInstanceList: faseInstanceList, 
            faseInstanceTotal: faseInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [faseInstance: new Fase(params),
            faseInstanceList: getFaseInstanceList(0, params?.produto?.id)]
    }

    def save() {
        def faseInstance = new Fase(params)
        if (!faseInstance.save(flush: true)) {
            render(view: "create", model: [faseInstance: faseInstance,
                    faseInstanceList: getFaseInstanceList(0, params?.produto?.id)])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'fase.label', default: 'Fase'), faseInstance.id])
        redirect(action: "show", id: faseInstance.id)
    }

    def show(Long id) {
        def faseInstance = Fase.get(id)
        if (!faseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), id])
            redirect(action: "list")
            return
        }

        [faseInstance: faseInstance, 
            faseInstanceList: getFaseInstanceList(faseInstance?.id, faseInstance?.produto?.id)]
    }

    def edit(Long id) {
        def faseInstance = Fase.get(id)
        if (!faseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), id])
            redirect(action: "list")
            return
        }

        [faseInstance: faseInstance, 
            faseInstanceList: getFaseInstanceList(faseInstance?.id, faseInstance?.produto?.id)]
    }

    def update(Long id, Long version) {
        def faseInstance = Fase.get(id)
        if (!faseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (faseInstance.version > version) {
                faseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'fase.label', default: 'Fase')] as Object[],
                          "Another user has updated this Fase while you were editing")
                render(view: "edit", model: [faseInstance: faseInstance, 
                        faseInstanceList: getFaseInstanceList(faseInstance?.id, faseInstance?.produto?.id)])
                return
            }
        }

        faseInstance.properties = params

        if (!faseInstance.save(flush: true)) {
            render(view: "edit", model: [faseInstance: faseInstance, 
                    faseInstanceList: getFaseInstanceList(faseInstance?.id, faseInstance?.produto?.id)])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'fase.label', default: 'Fase'), faseInstance.id])
        redirect(action: "show", id: faseInstance.id)
    }

    def delete(Long id) {
        def faseInstance = Fase.get(id)
        if (!faseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fase.label', default: 'Fase'), id])
            redirect(action: "list")
            return
        }

        try {
            faseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'fase.label', default: 'Fase'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'fase.label', default: 'Fase'), id])
            redirect(action: "show", id: id)
        }
    }
}
