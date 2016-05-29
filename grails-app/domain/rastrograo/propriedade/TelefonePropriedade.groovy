package rastrograo.propriedade
/*
 * Domínio Telefone Propriedade
 * Saída: "${ddd}-${numeroTelefone}"
 */
class TelefonePropriedade {
    
    //eventos auditáveis
    static auditable = true
    
    String dddPropriedade
    String numeroTelefonePropriedade

    static belongsTo=[propriedade:Propriedade]
    
    static constraints = {
        propriedade(nullable:false, blank:false)
        dddPropriedade size:2..2, nullable:false, blank:false
        numeroTelefonePropriedade size:8..9, nullable:false, blank:false, unique:['propriedade', 'dddPropriedade', 'numeroTelefonePropriedade']
    }
    
    static mapping = {
        table 'telefone_propriedade' 
        id generator:'identity'        
        version true    
        sort numeroTelefonePropriedade: "asc"    
        
        comment  "Tabela contendo os telefones das Propriedades do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        propriedade comment: "identificador da tabela propriedade"
        dddPropriedade comment: "número do ddd do telefone"
        numeroTelefonePropriedade comment: "número do telefone"
    }
    
    String toString(){
        "${dddPropriedade}-"{numeroTelefonePropriedade}
    }
}
