package rastrograo.seguranca

import org.springframework.dao.DataIntegrityViolationException
import rastrograo.empresa.Empresa
import rastrograo.propriedade.Propriedade

class AcessoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService
    
    def getRegraInstanceList = {
        List regraInstanceList
        if (acessoAtivoInstance?.authorities?.any { it.authority == "ROLE_ADMINISTRADOR" }) {
            regraInstanceList= Regra.list()
        }else{
            regraInstanceList = Regra.findAllByAuthorityNotEqual("ROLE_ADMINISTRADOR")
        }
        return regraInstanceList
    }
    
    def getEmpresaInstanceList = {
        def empresaInstanceList
        if (acessoAtivoInstance?.authorities?.any { it.authority == "ROLE_ADMINISTRADOR" }) {
            empresaInstanceList= Empresa.list()
        }else{
            empresaInstanceList= acessoAtivoInstance.empresas
        }
        return empresaInstanceList
    }
    
    def getPropriedadeInstanceList = {
        def propriedadeInstanceList
        if (acessoAtivoInstance?.authorities?.any { it.authority == "ROLE_ADMINISTRADOR" }) {
            propriedadeInstanceList= Propriedade.list()
        }else{
            propriedadeInstanceList= acessoAtivoInstance.propriedades
        }
        return propriedadeInstanceList
    }
    
    def getAcessoAtivoInstance = {
        def acessoAtivoInstance
        //verificar permissão do usuário para visualizar ou editar o registro
        if (springSecurityService.isLoggedIn()) {
            acessoAtivoInstance = rastrograo.seguranca.Acesso.get(springSecurityService?.principal?.id)
        }
        return acessoAtivoInstance
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'username'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new Acesso(params)
        consultaInstance?.username = params?.username?.trim()
        consultaInstance?.email = params?.email?.trim()
        
        def acessoInstanceList
        def acessoInstanceTotal
        
        //regra de negócio de consulta    
        if((consultaInstance?.username?.length() <= 1 && consultaInstance?.username) ||
            (consultaInstance?.email?.length() <= 1 && consultaInstance?.email)){
            if (consultaInstance?.username?.length() <= 1 && consultaInstance?.username) {
                consultaInstance.errors.rejectValue("username", "default.minSize.message",
                    [message(code: 'acesso.label', default: 'Acesso'), message(code: 'acesso.username.label', default: 'Username')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            if (consultaInstance?.email?.length() <= 1 && consultaInstance?.email) {
                consultaInstance.errors.rejectValue("email", "default.minSize.message",
                    [message(code: 'cidade.label', default: 'Cidade'), message(code: 'acesso.email.label', default: 'Email')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            }
            render(view: "list", model: [consultaInstance: consultaInstance,
                    acessoInstanceList: acessoInstanceList, 
                    acessoInstanceTotal: 0])
            return
        }

        //aplicação dos parâmetros à consulta
        acessoInstanceList = Acesso.createCriteria().list(params){
            and{
                if(acessoAtivoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }){
                    //lista todos os acessos
                    if(acessoAtivoInstance?.empresas){
                        empresas{
                            'in'('id', acessoAtivoInstance?.empresas?.id ?: (0).toLong())
                        }
                    }else{
                        eq('id', acessoAtivoInstance?.id) 
                    }
                }
                if(consultaInstance?.username?.length() > 1) ilike('username', "%" + params.username + "%")
                if(consultaInstance?.email?.length() > 1) ilike('email', "%" + consultaInstance.email + "%")
            }
            order(params.sort,params.order)             
        }
        acessoInstanceList: acessoInstanceList.unique{it}
        
        //retorno
        [acessoInstanceList: acessoInstanceList, 
            acessoInstanceTotal: acessoInstanceList?.size() ?: 0,
            consultaInstance: consultaInstance]
    }

    def autoCadastro() {
        [acessoInstance: new Acesso(params)]
    }
    
    def saveAutoCadastro() {
        def acessoInstance = new Acesso(params)
        if (!acessoInstance.save(flush: true)) {
            render(view: "autoCadastro", model: [acessoInstance: acessoInstance])
            return
        }
        
        def regraInstance = Regra.findByAuthority('ROLE_EMPRESA')
        AcessoRegra.create (acessoInstance, regraInstance, true)
        
        flash.message = message(code: 'default.created.message', args: [message(code: 'acesso.label', default: 'Acesso'), acessoInstance.id])
        redirect(action: "show", id: acessoInstance.id)
    }
    
    def create() {     
        if(!acessoAtivoInstance.empresas && !acessoAtivoInstance.propriedades){
            flash.message = message(code: 'acesso.hasMany.notNull', args: [message(code: 'acesso.label', default: 'Acesso'), acessoAtivoInstance])
            redirect(action: "list")
            return
        }
        [acessoInstance: new Acesso(params), 
            empresaInstanceList: empresaInstanceList,
            propriedadeInstanceList: propriedadeInstanceList, 
            regraInstanceList: regraInstanceList]
    }

    def save() {
        def acessoInstance = new Acesso(params)  

        if(acessoInstance.empresas.size()==0){
            acessoInstance.errors.rejectValue("empresas", "acesso.empresas.null.message",
                [message(code: 'acesso.label', default: 'Acesso')] as Object[],
                          "Selecione ao menos uma [Empresa] ou uma [Propriedade]")
            render(view: "edit", model: buildModel(acessoInstance))
            return
        }
        if(acessoInstance.propriedades.size()==0){
            acessoInstance.errors.rejectValue("propriedades", "acesso.propriedades.null.message",
                [message(code: 'acesso.label', default: 'Acesso')] as Object[],
                          "Selecione ao menos uma [Propriedade] ou uma [Empresa]")
            render(view: "edit", model: buildModel(acessoInstance))
            return
        }
        
        if (!acessoInstance.save(flush: true)) {
            render(view: "create", model: buildModel(acessoInstance))
            return
        }

        addPersistencia(acessoInstance)
        
        flash.message = message(code: 'default.created.message', args: [message(code: 'acesso.label', default: 'Acesso'), acessoInstance.id])
        redirect(action: "show", id: acessoInstance.id)
    }

    def show(Long id) {
        def acessoInstance = Acesso.get(id)
        if (!acessoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'acesso.label', default: 'Acesso'), id])
            redirect(action: "list")
            return
        }
        
        /*
         * Mensagem erro permissão visualização
         * Se não é administrador e acesso não está vinculado à empresa
         */
        if (acessoAtivoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }) {
            def acessoInstanceList = Acesso.createCriteria().list(){
                empresas{
                    'in'('id', acessoAtivoInstance?.empresas?.id ?: (0).toLong())
                }
            }
            if (!acessoInstanceList && acessoAtivoInstance != acessoInstance){
                redirect(action: "denied", controller: 'login')
                return
            }
        }
        
        [acessoInstance: acessoInstance]
    }

    def edit(Long id) {
        def acessoInstance = Acesso.get(id)
        if (!acessoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'acesso.label', default: 'Acesso'), id])
            redirect(action: "list")
            return
        }
        
        /*
         * Mensagem erro permissão edição
         * Se não é administrador e acesso não está vinculado à empresa
         */
        if (acessoAtivoInstance?.authorities?.any { it.authority != "ROLE_ADMINISTRADOR" }) {
            def acessoInstanceList = Acesso.createCriteria().list(){
                empresas{
                    'in'('id', acessoAtivoInstance?.empresas?.id ?: (0).toLong())
                }
            }
            if (!acessoInstanceList && acessoAtivoInstance != acessoInstance){
                redirect(action: "denied", controller: 'login')
                return
            }
        }
        
        buildModel(acessoInstance)
    }

    def update(Long id, Long version) {
        def acessoInstance = Acesso.get(id)
        if (!acessoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'acesso.label', default: 'Acesso'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (acessoInstance.version > version) {
                acessoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'acesso.label', default: 'Acesso')] as Object[],
                          "Another user has updated this Acesso while you were editing")
                render(view: "edit", model: buildModel(acessoInstance))
                return
            }
        }
        
        acessoInstance.properties = params
        
        addPersistencia(acessoInstance)
        
        if (!acessoInstance.save(flush: true)) {
            render(view: "edit", model: buildModel(acessoInstance), 
                empresaInstanceList: empresaInstanceList,
                propriedadeInstanceList: propriedadeInstanceList)
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'acesso.label', default: 'Acesso'), acessoInstance.id])
        redirect(action: "show", id: acessoInstance.id)
    }

    def delete(Long id) {
        def acessoInstance = Acesso.get(id)
        if (!acessoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'acesso.label', default: 'Acesso'), id])
            redirect(action: "list")
            return
        }

        /*
         * Validação antes da exclusão
         * @author Cláudio Agner
         * @params regras
         * @return caso verdadeiro tela de visualização do registro
         * 26/5/2016 9:38
         */
        if(acessoInstance.authorities){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'acesso.label', default: 'Acesso'), id])
            redirect(action: "show", id: id)
            return
        }
        
        try {
            acessoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'acesso.label', default: 'Acesso'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'acesso.label', default: 'Acesso'), id])
            redirect(action: "show", id: id)
        }
    }
    
    private void addPersistencia(acessoInstance) {
        //persistência regra
        AcessoRegra.removeAll(acessoInstance)
        for (String key in params.keySet()) {
            if (key.contains('ROLE') && 'on' == params.get(key)) {
                def regraInstance = Regra.findByAuthority(key)
                AcessoRegra.create (acessoInstance, regraInstance, true)
            }
        }
    }
    
    private Map buildModel(acessoInstance) {
        //mapeamento de regras do acesso
        Set acessoRegraNames = []
        for (regra in acessoInstance.authorities) {
            acessoRegraNames << regra.authority
        }
        LinkedHashMap<Regra, Boolean> regraMap = [:]
        for (regra in regraInstanceList) {
            regraMap[(regra)] = acessoRegraNames.contains(regra.authority)
        }     
        return [acessoInstance: acessoInstance, 
            regraMap: regraMap,
            empresaInstanceList: empresaInstanceList,
            propriedadeInstanceList: propriedadeInstanceList]
    }
}
