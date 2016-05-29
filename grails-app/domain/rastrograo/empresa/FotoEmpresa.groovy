package rastrograo.empresa
/*
 * Domínio Foto Empresa
 * Saída: "${imagem}"
 */
class FotoEmpresa {
    
    //eventos auditáveis
    static auditable = true

    byte[] foto
    String tituloFoto
    
    static belongsTo=[empresa:Empresa]
    
    static constraints = {
        empresa(nullable:false, blank:false)
        tituloFoto nullable:true, blank:true, maxSize:128
        foto nullble:false, blank:false
    }
    
    static mapping = {
        table 'foto_empresa' 
        id generator:'identity'        
        version true      
        sort tituloFoto: "asc"  
        
        comment  "Tabela contendo as imganes das Empresas do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        empresa comment: "identificador da tabela empresa"
        foto comment: "foto adicionada"
        tituloFoto comment: "título da foto contendo no máximo 128 caracteres"
    }
}
