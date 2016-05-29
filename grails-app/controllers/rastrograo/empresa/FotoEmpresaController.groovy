package rastrograo.empresa

import org.springframework.dao.DataIntegrityViolationException

class FotoEmpresaController {

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
    
    // Converte de byte para imagem
    def showFoto (Long id) {
        def fotoEmpresaInstance = FotoEmpresa.get(id)
        byte[] foto = fotoEmpresaInstance.foto
        response.outputStream << foto
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max, Long empresaId) {
        //params de consulta
        params.max = Math.min(max ?: 10, 100)
        params.offset = params?.offset?.toInteger()?: 0
        params.sort = params?.sort?:'tituloFoto'
        params.order = params?.order?:'asc'
        
        //parametros do formulário de consulta
        def consultaInstance = new FotoEmpresa(params)
        consultaInstance?.empresa = Empresa.get(empresaId)
        consultaInstance?.tituloFoto = params?.tituloFoto?.trim()
        
        def fotoEmpresaInstanceList
        def fotoEmpresaInstanceTotal          
            
        //regra de negócio de consulta    
        if(consultaInstance?.tituloFoto?.length() <= 1 && consultaInstance?.tituloFoto){
            consultaInstance.errors.rejectValue("tituloFoto", "default.minSize.message",
                [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), message(code: 'fotoEmpresa.tituloFoto.label', default: 'Url')] as Object[],
                          "Digite ao menos dois caracteres no campo {1} para realizar a consulta")
            
            render(view: "list", model: [consultaInstance: consultaInstance,
                    fotoEmpresaInstanceList: fotoEmpresaInstanceList, 
                    fotoEmpresaInstanceTotal: 0])
            return
        } 
        
        //aplicação dos parâmetros à consulta
        fotoEmpresaInstanceList = FotoEmpresa.createCriteria().list(params){
            and{
                empresa{
                    'in'('id', acessoInstance?.empresas?.id)
                    if(consultaInstance?.empresa) eq('id', consultaInstance?.empresa?.id)
                    if(params?.sort.contains('empresa')) order('nomeEmpresa',params.order)
                }
                if(consultaInstance?.tituloFoto?.length() > 1) ilike('tituloFoto', "%" + consultaInstance?.tituloFoto + "%")
            }
            if(params?.sort.equals('tituloFoto')) order(params.sort,params.order)
        }
        
        //retorno
        [fotoEmpresaInstanceList: fotoEmpresaInstanceList, 
            fotoEmpresaInstanceTotal: fotoEmpresaInstanceList.totalCount,
            consultaInstance: consultaInstance,
            empresaInstanceList: acessoInstance?.empresas]
    }

    def create() {
        [fotoEmpresaInstance: new FotoEmpresa(params),
            empresaInstanceList: acessoInstance?.empresas]
    }

    def save() {
        def fotoEmpresaInstance = new FotoEmpresa(params)
        
        if(!fotoEmpresaInstance.foto){
            fotoEmpresaInstance.errors.rejectValue("foto", "default.null.failure",
                [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa')] as Object[],
                          "O campo [Foto] da classe [Empresa] não pode ser vazia")
            render(view: "edit", model: [fotoEmpresaInstance: fotoEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }
            
        if (!fotoEmpresaInstance.save(flush: true)) {
            render(view: "create", model: [fotoEmpresaInstance: fotoEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), fotoEmpresaInstance.id])
        redirect(action: "show", id: fotoEmpresaInstance.id)
    }

    def show(Long id) {
        def fotoEmpresaInstance = FotoEmpresa.get(id)
        if (!fotoEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), id])
            redirect(action: "list")
            return
        }

        getPermissao(fotoEmpresaInstance?.empresa)
        
        [fotoEmpresaInstance: fotoEmpresaInstance]
    }

    def edit(Long id) {
        def fotoEmpresaInstance = FotoEmpresa.get(id)
        if (!fotoEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), id])
            redirect(action: "list")
            return
        }

        getPermissao(fotoEmpresaInstance?.empresa)
        
        [fotoEmpresaInstance: fotoEmpresaInstance,
            empresaInstanceList: acessoInstance?.empresas]
    }

    def update(Long id, Long version) {
        def fotoEmpresaInstance = FotoEmpresa.get(id)
        if (!fotoEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (fotoEmpresaInstance.version > version) {
                fotoEmpresaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa')] as Object[],
                          "Another user has updated this FotoEmpresa while you were editing")
                render(view: "edit", model: [fotoEmpresaInstance: fotoEmpresaInstance,
                        empresaInstanceList: acessoInstance?.empresas])
                return
            }
        }

        def imagemSalva
        if(params.foto.isEmpty()){
            if(!fotoEmpresaInstance.foto){
                fotoEmpresaInstance.errors.rejectValue("foto", "default.null.failure",
                    [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa')] as Object[],
                          "O campo [Foto] da classe [Empresa] não pode ser vazia")
                render(view: "edit", model: [fotoEmpresaInstance: fotoEmpresaInstance,
                        empresaInstanceList: acessoInstance?.empresas])
                return
            }else{
                imagemSalva = fotoEmpresaInstance.foto
            }
        }
        
        fotoEmpresaInstance.properties = params
        
        if(!fotoEmpresaInstance.foto){
            fotoEmpresaInstance.foto = imagemSalva
        }

        if (!fotoEmpresaInstance.save(flush: true)) {
            render(view: "edit", model: [fotoEmpresaInstance: fotoEmpresaInstance,
                    empresaInstanceList: acessoInstance?.empresas])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), fotoEmpresaInstance.id])
        redirect(action: "show", id: fotoEmpresaInstance.id)
    }

    def delete(Long id) {
        def fotoEmpresaInstance = FotoEmpresa.get(id)
        if (!fotoEmpresaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), id])
            redirect(action: "list")
            return
        }

        try {
            fotoEmpresaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'fotoEmpresa.label', default: 'FotoEmpresa'), id])
            redirect(action: "show", id: id)
        }
    }
}
