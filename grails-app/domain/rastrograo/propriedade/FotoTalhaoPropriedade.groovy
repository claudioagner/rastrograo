package rastrograo.propriedade
/*
 * Domínio Foto TalhaoPropriedade
 * Saída: "${foto}"
 */
class FotoTalhaoPropriedade {
    
    //eventos auditáveis
    static auditable = true

    byte[] foto
    String tituloFoto
    
    static belongsTo=[talhaoPropriedade:TalhaoPropriedade]
    
    static constraints = {
        talhaoPropriedade(nullable:false, blank:false)
        tituloFoto nullable:true, blank:true, maxSize:128
        foto nullble:false, blank:false
    }
    
    static mapping = {
        table 'foto_talhao_propriedade' 
        id generator:'identity'        
        version true      
        sort tituloFoto: "asc"
        
        comment  "Tabela contendo as imagens das TalhaoPropriedades do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        talhaoPropriedade comment: "identificador da tabela talhao propriedade"
        foto comment: "foto adicionada"
        tituloFoto comment: "título da foto contendo no máximo 128 caracteres"
    }
}
