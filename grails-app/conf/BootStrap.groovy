
import rastrograo.seguranca.Acesso
import rastrograo.seguranca.AcessoRegra
import rastrograo.seguranca.Permissao
import rastrograo.seguranca.Regra

class BootStrap {

    def init = { servletContext ->
        
        def regraInstance = Regra.findByAuthority('ROLE_ADMINISTRADOR') ?: new Regra(authority:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Regra.findByAuthority('ROLE_EMPRESA') ?: new Regra(authority:'ROLE_EMPRESA').save(failOnError: true)
        Regra.findByAuthority('ROLE_PROPRIEDADE') ?: new Regra(authority:'ROLE_PROPRIEDADE').save(failOnError: true)
        Regra.findByAuthority('ROLE_AGENTE') ?: new Regra(authority:'ROLE_AGENTE').save(failOnError: true)
        Regra.findByAuthority('ROLE_CLIENTE') ?: new Regra(authority:'ROLE_CLIENTE').save(failOnError: true)
        
        def acessoInstance = Acesso.findByUsername('admin') ?: new Acesso(username:'admin', password:'admin', email:'claudioagner@hotmail.com', enabled:true).save(failOnError: true)
        
        AcessoRegra.findByAcessoAndRegra(acessoInstance, regraInstance) ?: new AcessoRegra(acesso: acessoInstance, regra: regraInstance).save(failOnError: true)
        
        Permissao.findByUrl("/acesso/edit/**") ?: new Permissao(url:'/acesso/edit/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/acesso/show/**") ?: new Permissao(url:'/acesso/show/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/acesso/list/**") ?: new Permissao(url:'/acesso/list/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/acesso/create/**") ?: new Permissao(url:'/acesso/create/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/acesso/autoCadastro/**") ?: new Permissao(url:'/acesso/autoCadastro/**', configAttribute:'permitAll').save(failOnError: true)
        
        Permissao.findByUrl("/regra/**") ?: new Permissao(url:'/regra/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/permissao/**") ?: new Permissao(url:'/permissao/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/auditLogEvent/**") ?: new Permissao(url:'/auditLogEvent/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        
        Permissao.findByUrl("/empresa/**") ?: new Permissao(url:'/empresa/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/certificacaoEmpresa/**") ?: new Permissao(url:'/certificacaoEmpresa/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/fotoEmpresa/**") ?: new Permissao(url:'/fotoEmpresa/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/responsavelEmpresa/**") ?: new Permissao(url:'/responsavelEmpresa/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/telefoneEmpresa/**") ?: new Permissao(url:'/telefoneEmpresa/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        
        Permissao.findByUrl("/propriedade/**") ?: new Permissao(url:'/propriedade/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/certificacaoPropriedade/**") ?: new Permissao(url:'/certificacaoPropriedade/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/fotoPropriedade/**") ?: new Permissao(url:'/fotoPropriedade/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/responsavelPropriedade/**") ?: new Permissao(url:'/responsavelPropriedade/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/talhaoPropriedade/**") ?: new Permissao(url:'/talhaoPropriedade/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/fotoTalhaoPropriedade/**") ?: new Permissao(url:'/fotoTalhaoPropriedade/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        Permissao.findByUrl("/telefonePropriedade/**") ?: new Permissao(url:'/telefonePropriedade/**', configAttribute:'ROLE_ADMINISTRADOR,ROLE_EMPRESA').save(failOnError: true)
        
        Permissao.findByUrl("/cidade/create/**") ?: new Permissao(url:'/cidade/create/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/cidade/edit/**") ?: new Permissao(url:'/cidade/edit/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/cidade/show/**") ?: new Permissao(url:'/cidade/show/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/cidade/list/**") ?: new Permissao(url:'/cidade/list/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/cidade/ajaxGetCidade/**") ?: new Permissao(url:'/cidade/ajaxGetCidade/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)
        
        Permissao.findByUrl("/estado/create/**") ?: new Permissao(url:'/estado/create/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/estado/edit/**") ?: new Permissao(url:'/estado/edit/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/estado/show/**") ?: new Permissao(url:'/estado/show/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/estado/list/**") ?: new Permissao(url:'/estado/list/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/estado/ajaxGetEstado/**") ?: new Permissao(url:'/estado/ajaxGetEstado/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)
        
        Permissao.findByUrl("/pais/**") ?: new Permissao(url:'/pais/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)        
        
        Permissao.findByUrl("/atributo/**") ?: new Permissao(url:'/atributo/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)        
        Permissao.findByUrl("/fase/**") ?: new Permissao(url:'/fase/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)   
        Permissao.findByUrl("/listaAtributo/**") ?: new Permissao(url:'/listaAtributo/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)   
        Permissao.findByUrl("/produto/**") ?: new Permissao(url:'/produto/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)   
        
        Permissao.findByUrl("/cultivar/create/**") ?: new Permissao(url:'/cultivar/create/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/cultivar/edit/**") ?: new Permissao(url:'/cultivar/edit/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/cultivar/show/**") ?: new Permissao(url:'/cultivar/show/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/cultivar/list/**") ?: new Permissao(url:'/cultivar/list/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)
        Permissao.findByUrl("/cultivar/ajaxGetCultivar/**") ?: new Permissao(url:'/cultivar/ajaxGetCultivar/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)
        
        Permissao.findByUrl("/rastroProduto/create/**") ?: new Permissao(url:'/rastroProduto/create/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)   
        Permissao.findByUrl("/rastroProduto/edit/**") ?: new Permissao(url:'/rastroProduto/edit/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)   
        Permissao.findByUrl("/rastroProduto/list/**") ?: new Permissao(url:'/rastroProduto/list/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)   
        Permissao.findByUrl("/rastroProduto/show/**") ?: new Permissao(url:'/rastroProduto/show/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)   
        
        Permissao.findByUrl("/registroDados/**") ?: new Permissao(url:'/registroDados/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA, ROLE_PROPRIEDADE, ROLE_AGENTE').save(failOnError: true)   
        
        Permissao.findByUrl("/tipoProduto/**") ?: new Permissao(url:'/tipoProduto/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)   
        Permissao.findByUrl("/tipoCertificacao/**") ?: new Permissao(url:'/tipoCertificacao/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)   
        Permissao.findByUrl("/tipoResponsavel/**") ?: new Permissao(url:'/tipoResponsavel/**', configAttribute:'ROLE_ADMINISTRADOR').save(failOnError: true)   
        
        Permissao.findByUrl("/lote/**") ?: new Permissao(url:'/lote/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)   
        Permissao.findByUrl("/consolidacao/**") ?: new Permissao(url:'/consolidacao/**', configAttribute:'ROLE_ADMINISTRADOR, ROLE_EMPRESA').save(failOnError: true)   
    }
    def destroy = {
    }
}
