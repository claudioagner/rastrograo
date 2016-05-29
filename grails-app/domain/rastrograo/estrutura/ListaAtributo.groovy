package rastrograo.estrutura

class ListaAtributo {
    
    //eventos auditáveis
    static auditable = true

    String valorListaAtributo
    
    static belongsTo=[atributo: Atributo]
    
    static constraints = {
        atributo(unique:["atributo", "valorListaAtributo"])
        valorListaAtributo nullable:false, blank:false, maxSize:128
    }
      
    static mapping = {
        table 'lista_atributo' 
        id generator:'identity'        
        version true
        sort valorListaAtributo: "asc"    
        
        comment  "Tabela contendo os valores da lista do atributo cadastrados no sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        atributo comment: "identificador da tabela atributo"
        valorListaAtributo comment: "valor da lista do atributo cadastrado"
    }
        
    String toString(){
        "${valorListaAtributo}"
    }
    
    void setValorListaAtributo( String s ){
        valorListaAtributo = s?.toUpperCase()
    }
}