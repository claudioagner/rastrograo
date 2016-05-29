package rastrograo.customizacao

import rastrograo.estrutura.Fase
import rastrograo.dados.RegistroDados

class RastroFase {
    
    //eventos auditáveis
    static auditable = true
    
    Date dataCriado = new Date()

    static belongsTo=[rastroProduto: RastroProduto, fase:Fase]
    
    static hasMany=[rastrosAtributo: RastroAtributo, registros: RegistroDados]
    
    static constraints = {
        rastroProduto(nullable:false, blank:false)
        fase(nullable:false, blank:false)
        rastrosAtributo()
        dataCriado nullable:false, blank:false, editable:false
    }
      
    static mapping = {
        table 'rastro_fase' 
        id generator:'identity'        
        version true 
        rastrosAtributo sort: 'atributo', 'asc'
        rastrosAtributo cascade: 'all-delete-orphan'
        
        comment  "Tabela contendo os valores do rastro fase"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        rastroProduto comment: "identificador da tabela rastroProduto"
        fase comment: "identificador da tabela fase"
        dataCriado comment: "data em que o rastro da fase foi criado"
        rastrosAtributo comment: "rastros atributos"
        registros comment: "valores registrados para o rastro atributo"
    }
    
    String toString(){
        "${fase.descricaoFase}"
    }
}
