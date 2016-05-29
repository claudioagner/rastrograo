package rastrograo.tabela

import org.springframework.dao.DataIntegrityViolationException

class TipoCertificacaoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'descricaoTipoCertificacao'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new TipoCertificacao(params)
        consultaInstance?.descricaoTipoCertificacao = params?.descricaoTipoCertificacao?.trim()
        def tipoCertificacaoInstanceList
        def tipoCertificacaoInstanceTotal      
        
        //regra de negócio de consulta    
        if(consultaInstance?.descricaoTipoCertificacao?.length() <= 1 && consultaInstance?.descricaoTipoCertificacao){
            consultaInstance.errors.rejectValue("descricaoTipoCertificacao", "default.minSize.message",
                [message(code: 'tipoCertificacao.label', default: 'Tipo Certificacao'), message(code: 'tipoCertificacao.descricaoTipoCertificacao.label', default: 'Descricao Tipo Certificacao')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            render(view: "list", model: [consultaInstance: consultaInstance,
                    tipoCertificacaoInstanceList: tipoCertificacaoInstanceList, 
                    tipoCertificacaoInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        tipoCertificacaoInstanceList = TipoCertificacao.createCriteria().list(params){
            and{
                if(consultaInstance?.descricaoTipoCertificacao?.length() > 1) ilike('descricaoTipoCertificacao', "%" + consultaInstance?.descricaoTipoCertificacao + "%")
            }
            order(params.sort,params.order)
        }
        
        //retorno
        [tipoCertificacaoInstanceList: tipoCertificacaoInstanceList, 
            tipoCertificacaoInstanceTotal: tipoCertificacaoInstanceList.totalCount,
            consultaInstance: consultaInstance]
    }

    def create() {
        [tipoCertificacaoInstance: new TipoCertificacao(params)]
    }

    def save() {
        def tipoCertificacaoInstance = new TipoCertificacao(params)
        if (!tipoCertificacaoInstance.save(flush: true)) {
            render(view: "create", model: [tipoCertificacaoInstance: tipoCertificacaoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), tipoCertificacaoInstance.id])
        redirect(action: "show", id: tipoCertificacaoInstance.id)
    }

    def show(Long id) {
        def tipoCertificacaoInstance = TipoCertificacao.get(id)
        if (!tipoCertificacaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), id])
            redirect(action: "list")
            return
        }

        [tipoCertificacaoInstance: tipoCertificacaoInstance]
    }

    def edit(Long id) {
        def tipoCertificacaoInstance = TipoCertificacao.get(id)
        if (!tipoCertificacaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), id])
            redirect(action: "list")
            return
        }

        [tipoCertificacaoInstance: tipoCertificacaoInstance]
    }

    def update(Long id, Long version) {
        def tipoCertificacaoInstance = TipoCertificacao.get(id)
        if (!tipoCertificacaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tipoCertificacaoInstance.version > version) {
                tipoCertificacaoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao')] as Object[],
                          "Another user has updated this TipoCertificacao while you were editing")
                render(view: "edit", model: [tipoCertificacaoInstance: tipoCertificacaoInstance])
                return
            }
        }

        tipoCertificacaoInstance.properties = params

        if (!tipoCertificacaoInstance.save(flush: true)) {
            render(view: "edit", model: [tipoCertificacaoInstance: tipoCertificacaoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), tipoCertificacaoInstance.id])
        redirect(action: "show", id: tipoCertificacaoInstance.id)
    }

    def delete(Long id) {
        def tipoCertificacaoInstance = TipoCertificacao.get(id)
        if (!tipoCertificacaoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), id])
            redirect(action: "list")
            return
        }
        
        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params certificacoesEmpresa, certificacoesPropriedade
         * @return caso verdadeiro tela de visualização do registro
         * 7/5/2016 10:23
         */
        if(tipoCertificacaoInstance.certificacoesEmpresa || tipoCertificacaoInstance.certificacoesPropriedade){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            tipoCertificacaoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tipoCertificacao.label', default: 'TipoCertificacao'), id])
            redirect(action: "show", id: id)
        }
    }
}
