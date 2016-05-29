package rastrograo.tabela

import rastrograo.estrutura.Produto

class TipoProduto {
    
    //eventos auditáveis
    static auditable = true

    String descricaoTipoProduto 

    static hasMany=[produtos:Produto]
    
    static constraints = {
        descricaoTipoProduto maxSize:128, nullable:false, blank:false, unique:true
        produtos()
    }
    
    static mapping = {
        table 'tipo_produto' 
        id generator:'identity'        
        version true
        sort descricaoTipoProduto: "asc"        
        produtos sort: 'descricaoProduto', 'asc'
        
        comment  "Tabela contendo os Tipos de Produtos "
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        descricaoTipoProduto comment: "Descrição do tipo de responsável contendo no máximo 128 caracteres, com valor único"
        produtos comment: "relacionamento um tipo para muitos produtos"
    }
    
    String toString(){
        "${descricaoTipoProduto}"
    }
    
    void setDescricaoTipoProduto( String s ){
        descricaoTipoProduto = s?.toUpperCase()
    }
}