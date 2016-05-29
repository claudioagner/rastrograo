package rastrograo.estrutura

import rastrograo.customizacao.RastroProduto

class Cultivar {
    
    //eventos auditáveis
    static auditable = true

    String descricaoCultivar

    static belongsTo = [produto: Produto]
    
    static hasMany = [rastrosProduto: RastroProduto]
    
    static constraints = {
        produto(unique:['produto', 'descricaoCultivar'])
        descricaoCultivar unique:true, nullable:false, blank:false, maxSize:128
        rastrosProduto()
    }
      
    static mapping = {
        table 'cultivar' 
        id generator:'identity'        
        version true
        sort descricaoCultivar: "asc" 
        rastrosProduto sort: 'anoSafra', 'asc'  
        
        comment  "Tabela contendo os Cultivares dos produtos cadastrados no sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        produto comment: "identificador do produto"
        descricaoCultivar comment: "descrição do cultivar cadastrado"
        rastrosProduto comment: "Rastros do Produto"
    }
        
    String toString(){
        "${descricaoCultivar}"
    }
    
    void setDescricaoCultivar( String s ){
        descricaoCultivar = s?.toUpperCase()
    }
}
