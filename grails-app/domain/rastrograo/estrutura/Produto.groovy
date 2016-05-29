package rastrograo.estrutura

import rastrograo.tabela.TipoProduto

class Produto {
    
    //eventos auditáveis
    static auditable = true

    String descricaoProduto
    String observacaoProduto
    
    static belongsTo = [tipoProduto: TipoProduto]
    
    static hasMany = [cultivares: Cultivar, fases: Fase]
    
    static constraints = {
        tipoProduto(nullable:false, blank:false)
        descricaoProduto nullable:false, blank:false, maxSize: 128, unique:true
        observacaoProduto nullable:true, blank:true, maxSize: 65534
        cultivares()
        fases()
    }
      
    static mapping = {
        table 'produto' 
        id generator:'identity'        
        version true
        sort descricaoProduto: "asc"      
        observacaoProduto type: 'text'
        cultivares sort: 'descricaoCultivar', 'asc'
        fases sort: 'descricaoFase', 'asc'
        
        comment  "Tabela contendo os Produtos cadastrados no sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        tipoProduto comment: "identificador do tipo de produto"
        descricaoProduto comment: "descrição do produto cadastrado"
        observacaoProduto comment: "observações relacionadas ao produto"
        cultivares comment: "Cultivares do produto"
        fases comment: "Fases do produto"
    }
        
    String toString(){
        "${descricaoProduto}"
    }
    
    void setDescricaoProduto( String s ){
        descricaoProduto = s?.toUpperCase()
    }
}
