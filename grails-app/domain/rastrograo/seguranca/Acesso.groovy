package rastrograo.seguranca

import rastrograo.empresa.Empresa
import rastrograo.propriedade.Propriedade

class Acesso {
    
    //eventos auditáveis
    static auditable = true

    transient springSecurityService

    String username
    String password
    String email
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    
    
    static hasMany=[empresas:Empresa, propriedades:Propriedade]
    
    static constraints = {
        username blank: false, unique: true, maxSize:32
        email maxSize:128, nullable:false, blank:false, email:true, unique:true
        password blank: false, maxSize:64
    }

    static mapping = {
        table 'acesso' 
        id generator:'identity'        
        version true
        sort username: "asc"
        password column: '`password`'
        
        comment  "Tabela contendo os acessos do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        username comment: ""
        password comment: ""
        email comment: ""
        enabled comment: ""
        accountExpired comment: ""
        accountLocked comment: ""
        passwordExpired comment: ""
    }

    Set<Regra> getAuthorities() {
        if(this.id){
            AcessoRegra.findAllByAcesso(this).collect { it.regra } as Set
        }
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }
    
    String toString(){
        "${username}"
    }
}
