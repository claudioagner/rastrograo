package rastrograo.tabela
/*
 * Domínio Pais
 * Será utilizado para filtro nos cadastros que utilizam o campo cidade 
 * onde após escolher o pais o campo estado será populado 
 * Saída: "${nomePais}"
 */
class Pais {
    
    //eventos auditáveis
    static auditable = true

    String nomePais
    String countryName
    
    static hasMany=[estados:Estado]
    
    static constraints = {
        nomePais maxSize:128, nullable:false, blank:false, unique:true
        countryName maxSize:128, nullable:false, blank:false, unique:true
        estados()
    }
    
    static mapping = {
        table 'pais' 
        id generator:'identity'        
        version true
        sort nomePais: "asc"        
        estados sort: 'nomeEstado', 'asc'
        
        comment  "Tabela contendo os paises do mundo"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        nomePais comment: "Nome do pais contendo no máximo 128 caracteres e com valor único"
        countryName comment: "Nome do pais em Inglês contendo no máximo 128 caracteres e com valor único"
    }
    
    String toString(){
        "${nomePais}"
    }
    
    void setNomePais( String s ){
        nomePais = s?.toUpperCase()
    }
}