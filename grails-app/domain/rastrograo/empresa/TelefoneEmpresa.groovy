package rastrograo.empresa
/*
 * Domínio Telefone Empresa
 * Saída: "${ddd}-${numeroTelefone}"
 */
class TelefoneEmpresa {
    
    //eventos auditáveis
    static auditable = true
    
    String dddEmpresa
    String numeroTelefoneEmpresa

    static belongsTo=[empresa:Empresa]
    
    static constraints = {
        empresa(nullable:false, blank:false)
        dddEmpresa size:2..2, nullable:false, blank:false
        numeroTelefoneEmpresa size:8..9, nullable:false, blank:false, unique:['empresa', 'dddEmpresa', 'numeroTelefoneEmpresa']
    }
    
    static mapping = {
        table 'telefone_empresa' 
        id generator:'identity'        
        version true      
        sort numeroTelefoneEmpresa: "asc" 
        
        comment  "Tabela contendo os telefones das Empresas do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        empresa comment: "identificador da tabela empresa"
        dddEmpresa comment: "número do ddd do telefone"
        numeroTelefoneEmpresa comment: "número do telefone"
    }
    
    String toString(){
        "${ddd}-"{numeroTelefone}
    }
}
