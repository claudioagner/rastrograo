package rastrograo.dados

import org.springframework.dao.DataIntegrityViolationException
import rastrograo.customizacao.RastroProduto
import rastrograo.customizacao.RastroFase
import rastrograo.customizacao.RastroAtributo
import rastrograo.estrutura.Atributo
import rastrograo.estrutura.Fase

class RegistroDadosController {

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
    
    def getPermissao (empresaInstance, propriedadeInstance) {
        /*
         * Mensagem erro permissão visualização/edição
         * Se não é administrador e acesso não está vinculado à empresa
         */
        if (acessoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }) {
            def acessoInstanceList = rastrograo.seguranca.Acesso.createCriteria().list(){
                empresas{
                    eq('id', empresaInstance?.id)
                }
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
    
    def getFases(Long rastroProdutoId){
        def registroDadosInstance = new RegistroDados(params)
        registroDadosInstance?.rastroProduto = RastroProduto.get(rastroProdutoId)
        render(template: '/registroDados/rastroFase', model: [registroDadosInstance: registroDadosInstance])
        return  
    }
    
    def getAtributos(Long rastroFaseId){
        def registroDadosInstance = new RegistroDados(params)
        registroDadosInstance?.rastroFase = RastroFase.get(rastroFaseId)
        render(template: '/registroDados/rastroAtributo', model: [registroDadosInstance: registroDadosInstance])
        return  
    }
    
    def getAtributo(Long rastroAtributoId){
        def registroDadosInstance = new RegistroDados(params)
        registroDadosInstance?.rastroAtributo = RastroAtributo.get(rastroAtributoId)
        render(template: '/registroDados/configRastroAtributo', model: [registroDadosInstance: registroDadosInstance])
        return
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def getRastroProdutoInstanceList = {
        def rastroProdutoInstanceList = RastroProduto.createCriteria().list(){
            and{
                propriedade{
                    'in'('id', acessoInstance?.propriedades?.id ?: (0).toLong())
                }
                empresa{
                    'in'('id', acessoInstance?.empresas?.id  ?: (0).toLong())
                }
                eq('situacao', 'Em andamento')
            }
        }
        return rastroProdutoInstanceList
    }
    
    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'rastroProduto'
        params.order = params?.order?:'asc'
        
        def consultaInstance = new RegistroDados(params)
        consultaInstance.rastroProduto = RastroProduto.get(params?.rastroProduto?.id ? params?.rastroProduto?.id?.toLong() : 0)
        consultaInstance.rastroFase = RastroFase.get(params?.rastroFase?.id ? params?.rastroFase?.id?.toLong() : 0)
        consultaInstance.rastroAtributo = RastroAtributo.get(params?.rastroAtributo?.id ? params?.rastroAtributo?.id?.toLong() : 0)

        def registroDadosInstanceList
        def registroDadosInstanceTotal  
        registroDadosInstanceList = RegistroDados.createCriteria().list(params){
            and{
                rastroProduto{
                    propriedade{
                        'in'('id', acessoInstance?.propriedades?.id ?: (0).toLong())
                    }
                    empresa{
                        'in'('id', acessoInstance?.empresas?.id  ?: (0).toLong())
                    }
                    eq('situacao', 'Em andamento')
                }
                if(consultaInstance?.rastroProduto) eq('rastroProduto', consultaInstance?.rastroProduto)
                if(consultaInstance?.rastroFase) eq('rastroFase', consultaInstance?.rastroFase)
                if(consultaInstance?.rastroAtributo) eq('rastroAtributo', consultaInstance?.rastroAtributo)
            }
        }
        //retorno
        [registroDadosInstanceList: registroDadosInstanceList, 
            registroDadosInstanceTotal: registroDadosInstanceList.totalCount,
            consultaInstance: consultaInstance,
            rastroProdutoInstanceList: rastroProdutoInstanceList]
    }

    def create() {
        [registroDadosInstance: new RegistroDados(params),
            rastroProdutoInstanceList: rastroProdutoInstanceList]
    }

    def save() {
        def registroDadosInstance = new RegistroDados(params)
        
        if (registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo?.equals('Texto') 
            && registroDadosInstance?.valorAtributo?.trim()?.length() == 0) {
            registroDadosInstance.errors.rejectValue("valorAtributo", "registroDados.valorAtributo.null.message",
                [message(code: 'registroDados.label', default: 'RegistroDados')] as Object[],
                          "O campo [Valor Atributo] da classe [Registro] não pode ser vazia")
            render(view: "create", model: [registroDadosInstance: registroDadosInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }else if (registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo?.equals('Lista') 
            && !registroDadosInstance?.valorListaAtributo) {
            registroDadosInstance.errors.rejectValue("valorListaAtributo", "registroDados.valorAtributo.null.message",
                [message(code: 'registroDados.label', default: 'RegistroDados')] as Object[],
                          "O campo [Valor Atributo] da classe [Registro] não pode ser vazia")
            render(view: "create", model: [registroDadosInstance: registroDadosInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }else if (registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo?.equals('Data') 
            && !registroDadosInstance?.valorDataAtributo) {
            registroDadosInstance.errors.rejectValue("valorDataAtributo", "registroDados.valorAtributo.null.message",
                [message(code: 'registroDados.label', default: 'RegistroDados')] as Object[],
                          "O campo [Valor Atributo] da classe [Registro] não pode ser vazia")
            render(view: "create", model: [registroDadosInstance: registroDadosInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }
        
        if (!registroDadosInstance.save(flush: true)) {
            render(view: "create", model: [registroDadosInstance: registroDadosInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'registroDados.label', default: 'RegistroDados'), registroDadosInstance.id])
        redirect(action: "show", id: registroDadosInstance.id)
    }

    def show(Long id) {
        def registroDadosInstance = RegistroDados.get(id)
        if (!registroDadosInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registroDados.label', default: 'RegistroDados'), id])
            redirect(action: "list")
            return
        }

        getPermissao(registroDadosInstance?.rastroProduto?.empresa, registroDadosInstance?.rastroProduto?.propriedade)
        
        [registroDadosInstance: registroDadosInstance]
    }

    def edit(Long id) {
        def registroDadosInstance = RegistroDados.get(id)
        if (!registroDadosInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registroDados.label', default: 'RegistroDados'), id])
            redirect(action: "list")
            return
        }

        getPermissao(registroDadosInstance?.rastroProduto?.empresa, registroDadosInstance?.rastroProduto?.propriedade)
        
        [registroDadosInstance: registroDadosInstance]
    }

    def update(Long id, Long version) {
        def registroDadosInstance = RegistroDados.get(id)
        if (!registroDadosInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registroDados.label', default: 'RegistroDados'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (registroDadosInstance.version > version) {
                registroDadosInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'registroDados.label', default: 'RegistroDados')] as Object[],
                          "Another user has updated this RegistroDados while you were editing")
                render(view: "edit", model: [registroDadosInstance: registroDadosInstance,
                        rastroProdutoInstanceList: rastroProdutoInstanceList])
                return
            }
        }

        if (registroDadosInstance.rastroAtributo.atributo.tipoAtributo.equals('Texto') 
            && params?.valorAtributo?.trim()?.length() == 0) {
            registroDadosInstance.errors.rejectValue("valorAtributo", "registroDados.valorAtributo.null.message",
                [message(code: 'registroDados.label', default: 'RegistroDados')] as Object[],
                          "O campo [Valor Atributo] da classe [Registro] não pode ser vazia")
            render(view: "edit", model: [registroDadosInstance: registroDadosInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }else if (registroDadosInstance.rastroAtributo.atributo.tipoAtributo.equals('Lista') 
            && !params?.valorListaAtributo) {
            registroDadosInstance.errors.rejectValue("valorListaAtributo", "registroDados.valorAtributo.null.message",
                [message(code: 'registroDados.label', default: 'RegistroDados')] as Object[],
                          "O campo [Valor Atributo] da classe [Registro] não pode ser vazia")
            render(view: "edit", model: [registroDadosInstance: registroDadosInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }else if (registroDadosInstance.rastroAtributo.atributo.tipoAtributo.equals('Data') 
            && !params?.valorDataAtributo) {
            registroDadosInstance.errors.rejectValue("valorDataAtributo", "registroDados.valorAtributo.null.message",
                [message(code: 'registroDados.label', default: 'RegistroDados')] as Object[],
                          "O campo [Valor Atributo] da classe [Registro] não pode ser vazia")
            render(view: "edit", model: [registroDadosInstance: registroDadosInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }
        
        registroDadosInstance.properties = params
        registroDadosInstance.dataAlterado = new Date()
        
        if (!registroDadosInstance.save(flush: true)) {
            render(view: "edit", model: [registroDadosInstance: registroDadosInstance,
                    rastroProdutoInstanceList: rastroProdutoInstanceList])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'registroDados.label', default: 'RegistroDados'), registroDadosInstance.id])
        redirect(action: "show", id: registroDadosInstance.id)
    }

    def delete(Long id) {
        def registroDadosInstance = RegistroDados.get(id)
        if (!registroDadosInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registroDados.label', default: 'RegistroDados'), id])
            redirect(action: "list")
            return
        }

        try {
            registroDadosInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'registroDados.label', default: 'RegistroDados'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'registroDados.label', default: 'RegistroDados'), id])
            redirect(action: "show", id: id)
        }
    }
}