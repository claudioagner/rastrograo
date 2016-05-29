package rastrograo.tabela
/*
 * Domínio Estado
 * Será utilizado para filtro nos cadastros que utilizam o campo cidade 
 * onde após escolher o pais o campo estado será populado e após escolher o estado
 * o campo cidade será populado
 * Saída: "${nomeEstado}-${sigla}"
 */
class Estado {
    
    //eventos auditáveis
    static auditable = true

    String nomeEstado
    String sigla

    static belongsTo=[pais:Pais]
    
    static hasMany=[cidades:Cidade]
    
    static constraints = {
        pais(nullable:false, blank:false)
        nomeEstado maxSize:128, nullable:false, blank:false, unique:true
        sigla size:2..2, nullable:false, blank:false, unique:true
        cidades()
    }
    
    static mapping = {
        table 'estado' 
        id generator:'identity'        
        version true
        sort nomeEstado: "asc"        
        cidades sort: 'nomeCidade', 'asc'
        
        comment  "Tabela contendo os Estados por Pais"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        pais comment: ""
        nomeEstado comment: "Nome do estado contendo no máximo 128 caracteres e com valor único"
        sigla comment: "Sigla do estado contendo no mínimo 2 e no máximo 2 caracteres e com valor único"
    }
    
    String toString(){
        "${nomeEstado}-${sigla}"
    }
    
    void setNomeEstado( String s ){
        nomeEstado = s?.toUpperCase()
    }
    
    void setSigla( String s ){
        sigla = s?.toUpperCase()
    }
}
