package rastrograo.propriedade
/*
 * Domínio Talhão Propriedade
 * Será utilizado nos cadastros de talhões da propriedade
 * Saída: "${descricaoTalhao}" até 90 caracteres após será adicionado [...]
 */
class TalhaoPropriedade{
    
    //eventos auditáveis
    static auditable = true

    String descricaoTalhao
    double haTalhao
    String latitudeTalhao //-25.0794073
    String longitudeTalhao //-50.1916156
    
    static belongsTo=[propriedade:Propriedade]
    
    static hasMany=[fotos:FotoTalhaoPropriedade]
    
    static constraints = {
        propriedade(nullable:false, blank:false)
        descricaoTalhao nullable:false, blank:false, maxSize:128
        haTalhao nullable:false, blank:false
        latitudeTalhao nullable:true, blank:true, maxSize:11
        longitudeTalhao nullable:true, blank:true, maxSize:11
        fotos()
    }
    
    static mapping = {
        table 'talhao_propriedade' 
        id generator:'identity'        
        version true
        sort descricaoTalhao: "asc"            
        fotos sort: 'tituloFoto', 'asc' 
        
        comment  "Tabela contendo os Talhoes das Propriedades do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        propriedade comment: ""
        descricaoTalhao comment: ""
        haTalhao comment: ""
        latitudeTalhao comment: ""
        longitudeTalhao comment: ""
        fotos comment: ""
    }
    
    String toString(){
        if(descricaoTalhao.length()>90){
            "${descricaoTalhao.substring(0,90)} [...]"
        }else{
            descricaoTalhao
        }
    }
    
    void setNomePropriedade( String s ){
        nomePropriedade = s?.toUpperCase()
    }
}
