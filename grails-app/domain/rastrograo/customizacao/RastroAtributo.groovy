package rastrograo.customizacao

import rastrograo.estrutura.Atributo
import rastrograo.dados.RegistroDados

class RastroAtributo {
    
    //eventos auditáveis
    static auditable = true

    RastroFase rastroFase
    Atributo atributo
    Date dataCriado = new Date()
    Date dataAlterado
    boolean registrarDados = true
    boolean exibirQRConsumidor = false
    
    static hasMany = [registros: RegistroDados]
    
    static constraints = {
        rastroFase(nullable:false, blank:false)
        atributo(nullable:false, blank:false)
        registrarDados nullable:false, blank:false
        exibirQRConsumidor nullable:false, blank:false
        dataCriado nullable:false, blank:false, editable:false
        dataAlterado nullable:true, blank:true, editable:false
    }
      
    static mapping = {
        table 'rastro_atributo' 
        id generator:'identity'        
        version true 

        comment  "Tabela contendo os valores do rastro atributo"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        rastroFase comment: "identificador da tabela rastro fase"
        atributo comment: "identificador da tabela atributo"
        registrarDados comment: "permite registrar o valor"
        exibirQRConsumidor comment: "exibir o valor no qr code consumidor"
        dataCriado comment: "data em que o rastro do atributo foi criado"
        dataAlterado comment: "data em que o rastro do atributo foi alterado"
        registros comment: "valores registrados para o rastro atributo"
    }
    
    String toString(){
        "${atributo.nomeAtributo}"
    }
}
