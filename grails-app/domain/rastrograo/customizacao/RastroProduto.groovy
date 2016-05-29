package rastrograo.customizacao

import rastrograo.estrutura.Cultivar
import rastrograo.estrutura.Produto
import rastrograo.empresa.Empresa
import rastrograo.propriedade.Propriedade
import rastrograo.propriedade.TalhaoPropriedade
import rastrograo.rastreamento.Lote

import rastrograo.dados.RegistroDados

class RastroProduto {
    
    //eventos auditáveis
    static auditable = true

    String anoSafra
    String situacao
    Date dataCriado = new Date()
    Date dataAlterado
    
    static belongsTo=[empresa: Empresa, 
        propriedade: Propriedade,
        talhaoPropriedade: TalhaoPropriedade,
        cultivar: Cultivar, 
        produto: Produto]
    
    static hasMany=[rastrosFase: RastroFase, registros: RegistroDados]
    
    static constraints = {
        empresa(nullable:false, blank:false)
        propriedade(nullable:false, blank:false)
        talhaoPropriedade(nullable:false, blank:false)
        produto(nullable:false, blank:false)
        cultivar(nullable:false, blank:false)
        anoSafra nullable:false, blank:false, size:4..4, unique:['propriedade', 'produto', 'cultivar', 'anoSafra']
        rastrosFase()
        situacao inList:['Em andamento', 'Encerrado'], nullable:false, blank:false, maxSize:12
        dataCriado nullable:false, blank:false, editable:false
        dataAlterado nullable:true, blank:true, editable:false
    }
      
    static mapping = {
        table 'rastro_produto' 
        id generator:'identity'        
        version true
        sort anoSafra: "asc"    
        rastrosFase sort: 'fase', 'asc'
        rastrosFase cascade: 'all-delete-orphan'
        
        comment  "Tabela contendo os valores do rastro produto"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        empresa comment: "identificador da tabela empresa"
        propriedade comment: "identificador da tabela propriedade"
        talhaoPropriedade comment: "identificador da tabela talhão propriedade"
        cultivar comment: "identificador da tabela cultivar"
        produto comment: "identificador da tabela produto"
        anoSafra comment: "identificador do ano da safra"
        situacao comment: "responsável por determinar se a customização admite alterações"
        dataCriado comment: "data em que o rastro do produto foi criado"
        dataAlterado comment: "data em que o rastro do produto foi alterado"
        rastrosFase comment: "rastros da fase"
        registros comment: "valores registrados para o rastro atributo"
    }
    
    String toString(){
        "${produto} - ${cultivar} - ${anoSafra}"
    }
    
    Set<Lote> getLote() {
        if(this.id){
            Lote.findAllByRastroProduto(this).collect { it } as Set
        }        
    }
}
