package rastrograo.dados

import rastrograo.customizacao.RastroAtributo
import rastrograo.customizacao.RastroFase
import rastrograo.customizacao.RastroProduto
import rastrograo.estrutura.ListaAtributo

class RegistroDados {
    
    //eventos auditáveis
    static auditable = true
    
    RastroProduto rastroProduto
    RastroFase rastroFase
    RastroAtributo rastroAtributo
    String valorAtributo
    Date valorDataAtributo
    String comentarioAtributo
    Date dataCriado = new Date()
    Date dataAlterado
    
    static belongsTo=[valorListaAtributo: ListaAtributo]
    
    static constraints = {
        rastroAtributo(nullable:false, blank:false)
        valorAtributo nullable:true, blank:true, maxSize:128
        valorDataAtributo nullable:true, blank:true
        valorListaAtributo(nullable:true, blank:true)
        comentarioAtributo nullable:true, blank:true, maxSize: 65534
        dataCriado nullable:false, blank:false, editable:false
        dataAlterado nullable:true, blank:true, editable:false
    }
      
    static mapping = {
        table 'registro_dados' 
        id generator:'identity'        
        version true 

        comment  "Tabela contendo os valores de registro"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        rastroAtributo comment: "identificador da tabela rastro atributo"
        valorAtributo comment: "quando valor do atributo do tipo texto"
        valorDataAtributo comment: "quando atributo for do tipo data"
        valorListaAtributo comment: "quando valor do atributo deriva da lista de valores do atributo"
        comentarioAtributo comment: "comentário do atributo"
        dataCriado comment: "data em que o rastro do atributo foi criado"
        dataAlterado comment: "data em que o rastro do atributo foi alterado"
    }
}
