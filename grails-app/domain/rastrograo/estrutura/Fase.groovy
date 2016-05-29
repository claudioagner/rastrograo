package rastrograo.estrutura

import rastrograo.customizacao.RastroFase

class Fase {
    
    //eventos auditáveis
    static auditable = true

    String descricaoFase
    String observacaoFase
    
    static belongsTo=[produto: Produto]
    
    static hasMany=[atributos: Atributo, rastrosFase: RastroFase]
    
    static constraints = {
        produto(nullable:false, blank:false)
        descricaoFase unique:["descricaoFase", "produto"], nullable:false, blank:false, maxSize:128
        observacaoFase nullable:true, blank:true, maxSize: 65534
        atributos()
        rastrosFase()
    }
    
    static mapping = {
        table 'fase' 
        id generator:'identity'        
        version true
        sort descricaoFase: "asc"      
        observacaoFase type: 'text'
        atributos sort: 'nomeAtributo', 'asc'
        
        comment  "Tabela contendo as Fases dos Produtos cadastrados no sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        produto comment: "identificador do produto"
        descricaoFase comment: "descrição da fase do produto cadastrado"
        observacaoFase comment: "observações relacionadas à fase do produto"
        atributos comment: "Fases do produto"
        rastrosFase comment: "Rastros das Fases"
    }
        
    String toString(){
        "${descricaoFase}"
    }
    
    void setDescricaoFase( String s ){
        descricaoFase = s?.toUpperCase()
    }
}
