package rastrograo.seguranca

class Permissao {
    
    //eventos auditáveis
    static auditable = true

    String url
    String configAttribute

    static mapping = {
        table 'permissao' 
        id generator:'identity'        
        version true
        sort url: "asc"
        cache true
    }

    static constraints = {
        url blank: false, unique: true, maxSize:128
        configAttribute blank: false, maxSize:128
    }
}
