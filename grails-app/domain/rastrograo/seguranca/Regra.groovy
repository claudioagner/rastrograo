package rastrograo.seguranca

class Regra {
    
    //eventos auditáveis
    static auditable = true

    String authority

    static mapping = {
        table 'regra' 
        id generator:'identity'        
        version true
        sort authority: "asc"
        cache true
    }

    static constraints = {
        authority blank: false, unique: true, maxSize:64
    }
    
    Set<Acesso> getAcessos() {
        if(this.id){
            AcessoRegra.findAllByRegra(this).collect { it.acesso } as Set
        }else{
            Acesso.list().collect { it } as Set
        }        
    }
    
    String toString(){
        "${authority.replace('ROLE_','')}"
    }
    
    void setAuthority( String s ){
        authority = s?.toUpperCase()
    }
}
