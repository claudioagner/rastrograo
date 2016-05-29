package rastrograo.rastreamento

import rastrograo.empresa.Empresa
import rastrograo.estrutura.Produto
import rastrograo.propriedade.Propriedade

class Consolidacao {

    Date dataConsolidacao = new Date()
    Date dataLoteOrigem = new Date()
    Date validadeLoteOrigem = new Date()
    String nrLoteConsolidado
    double volumeLoteOrigem
    String conservacao
    String observacao
    
    static belongsTo = [empresa: Empresa, produto: Produto, empresaOrigem: Empresa, propriedadeOrigem: Propriedade]
    
    static constraints = {
        empresa(nullable:false, blank:false)
        produto(nullable:false, blank:false)
        empresaOrigem(nullable:false, blank:false)       
        propriedadeOrigem(nullable:false, blank:false)  
        dataConsolidacao nullable:false, blank:false
        dataLoteOrigem nullable:false, blank:false
        validadeLoteOrigem nullable:false, blank:false
        nrLoteConsolidado nullable:false, blank:false, maxSize:32, unique:true
        volumeLoteOrigem nullable:false, blank:false
        conservacao nullable:true, blank:true, maxSize:128
        observacao nullable:true, blank:true, maxSize: 65534
    }
    
    static mapping = {
        table 'consolidacao' 
        id generator:'identity'        
        version true  
        sort dataConsolidacao: "desc"     
        
        comment  "Tabela contendo as consolidações do lote"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        empresa comment:"identificador da empresa que esta consolidado"
        produto comment:'identificador do produto que está sendo consolidado'
        empresaOrigem comment:"empresa de origem do produto"
        propriedadeOrigem comment:"propriedade de origem do produto"
        dataConsolidacao comment:"data da consolidação"
        dataLoteOrigem comment:"data do lote de origem"
        validadeLoteOrigem comment:"data de validade do lote de origem"
        nrLoteConsolidado comment:"numero do lote que está sendo consolidado"
        volumeLoteOrigem comment:"volume em kg do lote a ser consolidado"
        conservacao comment: 'condições de conservação do produto recomendadas pelo produtor'
        observacao comment:"observações relacionadas ao produto"
    }
}