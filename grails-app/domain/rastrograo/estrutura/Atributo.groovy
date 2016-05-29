package rastrograo.estrutura

import rastrograo.customizacao.RastroAtributo

class Atributo {
    
    //eventos auditáveis
    static auditable = true

    String nomeAtributo
    String descricaoAtributo
    String tipoAtributo
    
    static belongsTo=[fase: Fase]
    
    static hasMany=[listasAtributo: ListaAtributo, rastrosAtributo: RastroAtributo]
    
    static constraints = {
        fase(unique:["nomeAtributo", "fase"])
        nomeAtributo nullable:false, blank:false, maxSize:128
        descricaoAtributo nullable:true, blank:true, maxSize: 65534
        tipoAtributo nullable:false, blank:false, maxSize:32, inList:['Data', 'Data/Hora', 'Lista', 'Texto']
        listasAtributo()
    }
    
    static mapping = {
        table 'atributo' 
        id generator:'identity'        
        version true
        sort nomeAtributo: "asc"      
        descricaoAtributo type: 'text'
        listasAtributo sort: 'valorListaAtributo', 'asc'
        
        comment  "Tabela contendo os Atributos das Fases dos Produtos cadastrados no sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        fase comment: "identificador da tabela fase"
        nomeAtributo comment: "nome do atributo da fase do produto cadastrado"
        descricaoAtributo comment: "descrição do atributo da fase do produto"
        listasAtributo comment: "valores do atributo"
        rastrosAtributo comment: "rastros do atributo"
    }
        
    String toString(){
        "${nomeAtributo}"
    }
    
    void setNomeAtributo( String s ){
        nomeAtributo = s?.toUpperCase()
    }
}
