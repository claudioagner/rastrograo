package rastrograo.propriedade
/*
 * Domínio Foto Propriedade
 * Saída: "${foto}"
 */
class FotoPropriedade {
    
    //eventos auditáveis
    static auditable = true

    byte[] foto
    String tituloFoto
    
    static belongsTo=[propriedade:Propriedade]
    
    static constraints = {
        propriedade(nullable:false, blank:false)
        tituloFoto nullable:true, blank:true, maxSize:128
        foto nullble:false, blank:false
    }
    
    static mapping = {
        table 'foto_propriedade' 
        id generator:'identity'        
        version true  
        sort tituloFoto: "asc"     
        
        comment  "Tabela contendo as imagens das Propriedades do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        propriedade comment: "identificador da tabela propriedade"
        foto comment: "foto adicionada"
        tituloFoto comment: "título da foto contendo no máximo 128 caracteres"
    }
}
