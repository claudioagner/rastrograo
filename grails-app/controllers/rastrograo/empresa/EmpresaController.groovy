package rastrograo.empresa

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

import rastrograo.tabela.*

class EmpresaController {

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
    
    def getPermissao (empresaInstance) {
        /*
         * Mensagem erro permissão visualização/edição
         * Se não é administrador e acesso não está vinculado à empresa
         */
        if (acessoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }) {
            def acessoInstanceList = rastrograo.seguranca.Acesso.createCriteria().list(){
                empresas{
                    eq('id', empresaInstance?.id)
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
        params.sort = params?.sort?:'nomeEmpresa'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Empresa(params)
        consultaInstance?.tipoEmpresa = params?.tipoEmpresa?.trim()
        consultaInstance?.cnpj = params?.cnpj?.trim() ?: null
        consultaInstance?.cpf = params?.cpf?.trim() ?: null
        consultaInstance?.inscricaoEstadual = params?.inscricaoEstadual?.trim() ?: null
        consultaInstance?.nomeEmpresa = params?.nomeEmpresa?.trim()
        consultaInstance?.nomeFantasiaEmpresa = params?.nomeFantasiaEmpresa?.trim()
        consultaInstance?.emailEmpresa = params?.emailEmpresa?.trim()
        consultaInstance?.cidade?.estado?.pais = Pais.get(paisId)
        consultaInstance?.cidade?.estado = Estado.get(estadoId)
        consultaInstance?.cidade = Cidade.get(cidadeId)
        def empresaInstanceList
        def empresaInstanceTotal      
            
        //regra de negócio de consulta    
        if((consultaInstance?.nomeEmpresa?.length() <= 1 && consultaInstance?.nomeEmpresa) ||
            (consultaInstance?.nomeFantasiaEmpresa?.length() <= 1 && consultaInstance?.nomeFantasiaEmpresa)){
            if (consultaInstance?.nomeEmpresa?.length() <= 1 && consultaInstance?.nomeEmpresa) {
                consultaInstance.errors.rejectValue("nomeEmpresa", "default.minSize.message",
                    [message(code: 'empresa.label', default: 'Empresa'), message(code: 'empresa.nomeEmpresa.label', default: 'Url')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.nomeFantasiaEmpresa?.length() <= 1 && consultaInstance?.nomeFantasiaEmpresa) {
                consultaInstance.errors.rejectValue("nomeFantasiaEmpresa", "default.minSize.message",
                    [message(code: 'empresa.label', default: 'Empresa'), message(code: 'empresa.nomeFantasiaEmpresa.label', default: 'Email')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    empresaInstanceList: empresaInstanceList, 
                    empresaInstanceTotal: 0])
            return
        }
        
        //aplicação dos parâmetros à consulta
        empresaInstanceList = Empresa.createCriteria().list(params){
            and{
                'in'('id', acessoInstance?.empresas?.id ?: (0).toLong())
                if(consultaInstance?.tipoEmpresa) eq('tipoEmpresa', consultaInstance?.tipoEmpresa)
                if(consultaInstance?.cpf) eq('cpf', consultaInstance?.cpf)
                if(consultaInstance?.cnpj) eq('cnpj', consultaInstance?.cnpj)
                if(consultaInstance?.cnpj) eq('inscricaoEstadual', consultaInstance?.inscricaoEstadual)
                if(consultaInstance?.nomeEmpresa?.length() > 1) ilike('nomeEmpresa', "%" + consultaInstance?.nomeEmpresa + "%")
                if(consultaInstance?.nomeFantasiaEmpresa?.length() > 1) ilike('nomeFantasiaEmpresa', "%" + consultaInstance?.nomeFantasiaEmpresa + "%")
                if(consultaInstance?.emailEmpresa?.length() > 1) ilike('emailEmpresa', "%" + consultaInstance?.emailEmpresa + "%")
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
        [empresaInstanceList: empresaInstanceList, 
            empresaInstanceTotal: empresaInstanceList.totalCount,   
            consultaInstance: consultaInstance,
            SUBREPORT_DIR: SUBREPORT_DIR]
    }

    def create() {        
        [empresaInstance: new Empresa(params)]
    }

    def save() {
        def empresaInstance = new Empresa(params)
        
        if(empresaInstance.tipoEmpresa.equals('Pessoa Jurídica')){
            empresaInstance.cpf = null
            empresaInstance.tipoEmpresa = 'Pessoa Jurídica'
            if (!empresaInstance.cnpj) {
                empresaInstance.errors.rejectValue("cnpj", "empresa.cnpjNull.message",
                    [message(code: 'empresa.label', default: 'Empresa')] as Object[],
                          "O campo [CNPJ] da classe [Empresa] não pode ser vazia")
                render(view: "create", model: [empresaInstance: empresaInstance])
                return
            }
        }else{
            empresaInstance.cnpj = null
            empresaInstance.inscricaoEstadual = null
            empresaInstance.tipoEmpresa = 'Pessoa Física'
            if (!empresaInstance.cpf) {
                empresaInstance.errors.rejectValue("cpf", "empresa.cnpjNull.message",
                    [message(code: 'empresa.label', default: 'Empresa')] as Object[],
                          "O campo [CPF] da classe [Empresa] não pode ser vazia")
                render(view: "create", model: [empresaInstance: empresaInstance])
                return
            }
        }
        
        empresaInstance.addToAcessos(acessoInstance)
        
        if (!empresaInstance.save(flush: true)) {
            render(view: "create", model: [empresaInstance: empresaInstance])
            return
        }
        
        flash.message = message(code: 'default.created.message', args: [message(code: 'empresa.label', default: 'Empresa'), empresaInstance.id])
        redirect(action: "show", id: empresaInstance.id)
    }

    def show(Long id) {
        def empresaInstance = Empresa.get(id)
        if (!empresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'empresa.label', default: 'Empresa'), id])
            redirect(action: "list")
            return
        }

        getPermissao(empresaInstance)
        
        [empresaInstance: empresaInstance]
    }

    def edit(Long id) {
        def empresaInstance = Empresa.get(id)
        if (!empresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'empresa.label', default: 'Empresa'), id])
            redirect(action: "list")
            return
        }
        
        getPermissao(empresaInstance)
        
        [empresaInstance: empresaInstance]
    }

    def update(Long id, Long version) {
        def empresaInstance = Empresa.get(id)
        if (!empresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'empresa.label', default: 'Empresa'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (empresaInstance.version > version) {
                empresaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'empresa.label', default: 'Empresa')] as Object[],
                          "Another user has updated this Empresa while you were editing")
                render(view: "edit", model: [empresaInstance: empresaInstance])
                return
            }
        }

        if(params?.tipoEmpresa?.equals('Pessoa Jurídica')){
            empresaInstance?.cpf = null
            empresaInstance.tipoEmpresa = 'Pessoa Jurídica'
            if (!params?.cnpj) {
                empresaInstance.errors.rejectValue("cpf", "empresa.cnpjNull.message",
                    [message(code: 'empresa.label', default: 'Empresa')] as Object[],
                          "O campo [CNPJ] da classe [Empresa] não pode ser vazia")
                render(view: "create", model: [empresaInstance: empresaInstance])
                return
            }
        }else{
            empresaInstance?.cnpj = null
            empresaInstance?.inscricaoEstadual = null
            empresaInstance.tipoEmpresa = 'Pessoa Física'
            if (!params?.cpf) {
                empresaInstance.errors.rejectValue("cpf", "empresa.cnpjNull.message",
                    [message(code: 'empresa.label', default: 'Empresa')] as Object[],
                          "O campo [CPF] da classe [Empresa] não pode ser vazia")
                render(view: "create", model: [empresaInstance: empresaInstance])
                return
            }
        }
        
        empresaInstance.properties = params

        if (!empresaInstance.save(flush: true)) {
            render(view: "edit", model: [empresaInstance: empresaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'empresa.label', default: 'Empresa'), empresaInstance.id])
        redirect(action: "show", id: empresaInstance.id)
    }

    def delete(Long id) {
        def empresaInstance = Empresa.get(id)
        if (!empresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'empresa.label', default: 'Empresa'), id])
            redirect(action: "list")
            return
        }
        
        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params acessos, certificados, fotos, responsaveis, telefones, rastrosProduto
         * @return caso verdadeiro tela de visualização do registro
         * 7/5/2016 13:08
         */
        if(empresaInstance.acessos 
            || empresaInstance.certificados 
            || empresaInstance.fotos
            || empresaInstance.responsaveis
            || empresaInstance.telefones
            ||empresaInstance.rastrosProduto){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'empresa.label', default: 'Empresa'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            empresaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'empresa.label', default: 'Empresa'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'empresa.label', default: 'Empresa'), id])
            redirect(action: "show", id: id)
        }
    }
}