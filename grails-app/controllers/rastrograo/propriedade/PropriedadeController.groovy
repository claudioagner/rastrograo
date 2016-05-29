package rastrograo.propriedade

import org.springframework.dao.DataIntegrityViolationException

import rastrograo.tabela.*

class PropriedadeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService
    
    def getAcessoInstance = {
        def acessoInstance
        //verificar permissão do usuário para visualizar ou editar o registro
        if (springSecurityService.isLoggedIn()) {
            acessoInstance = rastrograo.seguranca.Acesso.get(springSecurityService?.principal?.id)
        }
        return acessoInstance
    }
    
    def getPermissao (propriedadeInstance) {
        /*
         * Mensagem erro permissão visualização/edição
         * Se não é administrador e acesso não está vinculado à empresa
         */
        if (acessoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }) {
            def acessoInstanceList = rastrograo.seguranca.Acesso.createCriteria().list(){
                propriedades{
                    eq('id', propriedadeInstance?.id)
                }
                eq('id', acessoInstance?.id)
            }
            if (!acessoInstanceList){
                redirect(action: "denied", controller: 'login')
                return
            }
        }
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long paisId, Long estadoId, Long cidadeId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'nomePropriedade'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Propriedade(params)
        consultaInstance?.tipoPropriedade = params?.tipoPropriedade?.trim()
        consultaInstance?.cnpj = params?.cnpj?.trim() ?: null
        consultaInstance?.cpf = params?.cpf?.trim() ?: null
        consultaInstance?.inscricaoEstadual = params?.inscricaoEstadual?.trim() ?: null
        consultaInstance?.nomePropriedade = params?.nomePropriedade?.trim()
        consultaInstance?.nomeFantasiaPropriedade = params?.nomeFantasiaPropriedade?.trim()
        consultaInstance?.emailPropriedade = params?.emailPropriedade?.trim()
        consultaInstance?.cidade?.estado?.pais = Pais.get(paisId)
        consultaInstance?.cidade?.estado = Estado.get(estadoId)
        consultaInstance?.cidade = Cidade.get(cidadeId)
        def propriedadeInstanceList
        def propriedadeInstanceTotal      
            
        //regra de negócio de consulta    
        if((consultaInstance?.nomePropriedade?.length() <= 1 && consultaInstance?.nomePropriedade) ||
            (consultaInstance?.nomeFantasiaPropriedade?.length() <= 1 && consultaInstance?.nomeFantasiaPropriedade)){
            if (consultaInstance?.nomePropriedade?.length() <= 1 && consultaInstance?.nomePropriedade) {
                consultaInstance.errors.rejectValue("nomePropriedade", "default.minSize.message",
                    [message(code: 'propriedade.label', default: 'Propriedade'), message(code: 'propriedade.nomePropriedade.label', default: 'Url')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.nomeFantasiaPropriedade?.length() <= 1 && consultaInstance?.nomeFantasiaPropriedade) {
                consultaInstance.errors.rejectValue("nomeFantasiaPropriedade", "default.minSize.message",
                    [message(code: 'propriedade.label', default: 'Propriedade'), message(code: 'propriedade.nomeFantasiaPropriedade.label', default: 'Email')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    propriedadeInstanceList: propriedadeInstanceList, 
                    propriedadeInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        propriedadeInstanceList = Propriedade.createCriteria().list(params){
            and{
                'in'('id', acessoInstance?.propriedades?.id ?: (0).toLong())
                if(consultaInstance?.tipoPropriedade) eq('tipoPropriedade', consultaInstance?.tipoPropriedade)
                if(consultaInstance?.cpf) eq('cpf', consultaInstance?.cpf)
                if(consultaInstance?.cnpj) eq('cnpj', consultaInstance?.cnpj)
                if(consultaInstance?.inscricaoEstadual) eq('inscricaoEstadual', consultaInstance?.inscricaoEstadual)
                if(consultaInstance?.nomePropriedade?.length() > 1) ilike('nomePropriedade', "%" + consultaInstance?.nomePropriedade + "%")
                if(consultaInstance?.nomeFantasiaPropriedade?.length() > 1) ilike('nomeFantasiaPropriedade', "%" + consultaInstance?.nomeFantasiaPropriedade + "%")
                if(consultaInstance?.emailPropriedade?.length() > 1) ilike('emailPropriedade', "%" + consultaInstance?.emailPropriedade + "%")
                cidade{
                    if(consultaInstance?.cidade) eq('id', consultaInstance?.cidade?.id)
                    estado{
                        if(consultaInstance?.cidade?.estado) eq('id', consultaInstance?.cidade?.estado?.id)
                        pais{
                            if(consultaInstance?.cidade?.estado?.pais) eq('id', consultaInstance?.cidade?.estado?.pais?.id)
                        }
                    }
                }
                if(params?.sort?.equals('cnpj')){
                    order('cpf',params.order) 
                    order('cnpj', params.order)
                }
                else order(params.sort,params.order)
            }
        }
        
        def SUBREPORT_DIR = servletContext.getRealPath('reports') + "/"
        
        //retorno
        [propriedadeInstanceList: propriedadeInstanceList, 
            propriedadeInstanceTotal: propriedadeInstanceList.totalCount,   
            consultaInstance: consultaInstance,
            SUBREPORT_DIR: SUBREPORT_DIR]
    }

    def create() {
        [propriedadeInstance: new Propriedade(params)]
    }

    def save() {
        def propriedadeInstance = new Propriedade(params)
        
        if(propriedadeInstance.tipoPropriedade.equals('Pessoa Jurídica')){
            propriedadeInstance.cpf = null
            propriedadeInstance?.tipoPropriedade = 'Pessoa Jurídica'
            if (!propriedadeInstance.cnpj) {
                propriedadeInstance.errors.rejectValue("cnpj", "propriedade.cnpjNull.message",
                    [message(code: 'propriedade.label', default: 'Propriedade')] as Object[],
                          "O campo [CNPJ] da classe [Propriedade] não pode ser vazia")
                render(view: "create", model: [propriedadeInstance: propriedadeInstance])
                return
            }
        }else{
            propriedadeInstance.cnpj = null
            propriedadeInstance.inscricaoEstadual = null
            propriedadeInstance?.tipoPropriedade = 'Pessoa Física'
            if (!propriedadeInstance.cpf) {
                propriedadeInstance.errors.rejectValue("cnpj", "propriedade.cnpjNull.message",
                    [message(code: 'propriedade.label', default: 'Propriedade')] as Object[],
                          "O campo [CPF] da classe [Propriedade] não pode ser vazia")
                render(view: "create", model: [propriedadeInstance: propriedadeInstance])
                return
            }
        }
        
        propriedadeInstance.addToAcessos(acessoInstance)
        
        if (!propriedadeInstance.save(flush: true)) {
            render(view: "create", model: [propriedadeInstance: propriedadeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), propriedadeInstance.id])
        redirect(action: "show", id: propriedadeInstance.id)
    }

    def show(Long id) {
        def propriedadeInstance = Propriedade.get(id)
        if (!propriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(propriedadeInstance)
        
        [propriedadeInstance: propriedadeInstance]
    }

    def edit(Long id) {
        def propriedadeInstance = Propriedade.get(id)
        if (!propriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), id])
            redirect(action: "list")
            return
        }

        getPermissao(propriedadeInstance)
        
        [propriedadeInstance: propriedadeInstance]
    }

    def update(Long id, Long version) {
        def propriedadeInstance = Propriedade.get(id)
        if (!propriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (propriedadeInstance.version > version) {
                propriedadeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'propriedade.label', default: 'Propriedade')] as Object[],
                          "Another user has updated this Propriedade while you were editing")
                render(view: "edit", model: [propriedadeInstance: propriedadeInstance])
                return
            }
        }
        
        propriedadeInstance.properties = params

        if(params?.tipoPropriedade?.equals('Pessoa Jurídica')){
            propriedadeInstance?.cpf = null
            propriedadeInstance?.tipoPropriedade = 'Pessoa Jurídica'
            if (!params?.cnpj) {
                propriedadeInstance.errors.rejectValue("cnpj", "propriedade.cnpjNull.message",
                    [message(code: 'propriedade.label', default: 'Propriedade')] as Object[],
                          "O campo [CNPJ] da classe [Propriedade] não pode ser vazia")
                render(view: "edit", model: [propriedadeInstance: propriedadeInstance])
                return
            }
        }else{
            propriedadeInstance?.cnpj = null
            propriedadeInstance?.inscricaoEstadual = null
            propriedadeInstance?.tipoPropriedade = 'Pessoa Física'
            if (!params?.cpf) {
                propriedadeInstance.errors.rejectValue("cnpj", "propriedade.cnpjNull.message",
                    [message(code: 'propriedade.label', default: 'Propriedade')] as Object[],
                          "O campo [CPF] da classe [Propriedade] não pode ser vazia")
                render(view: "edit", model: [propriedadeInstance: propriedadeInstance])
                return
            }
        }

        if (!propriedadeInstance.save(flush: true)) {
            render(view: "edit", model: [propriedadeInstance: propriedadeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), propriedadeInstance.id])
        redirect(action: "show", id: propriedadeInstance.id)
    }

    def delete(Long id) {
        def propriedadeInstance = Propriedade.get(id)
        if (!propriedadeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), id])
            redirect(action: "list")
            return
        }

        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params acessos, certificados, fotos, responsaveis, talhoes, telefones, rastrosProduto
         * @return caso verdadeiro tela de visualização do registro
         * 7/5/2016 13:10
         */
        if(propriedadeInstance.acessos 
            || propriedadeInstance.certificados 
            || propriedadeInstance.fotos
            || propriedadeInstance.responsaveis
            || propriedadeInstance.talhoes
            || propriedadeInstance.telefones
            ||propriedadeInstance.rastrosProduto){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            propriedadeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'propriedade.label', default: 'Propriedade'), id])
            redirect(action: "show", id: id)
        }
    }
}
