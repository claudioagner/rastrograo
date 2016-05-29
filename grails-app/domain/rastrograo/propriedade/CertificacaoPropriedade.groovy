package rastrograo.propriedade

//importação de classes de outros pacotes
import rastrograo.tabela.TipoCertificacao

/*
 * Domínio Responsável Propriedade
 * Será utilizado nos cadastros de certificação vinculado aos cadastros de 
 * propriedade
 * Saída: "${dataCertificacao}"
 */
class CertificacaoPropriedade {
    
    //eventos auditáveis
    static auditable = true

    Date dataCertificacao = new Date().clearTime()
    String observacao
    
    static belongsTo=[tipoCertificacao:TipoCertificacao,propriedade:Propriedade]
    
    static constraints = {
        tipoCertificacao(nullable:false, blank:false)
        propriedade(nullable:false, blank:false)
        dataCertificacao nullable:false, blank:false, max: new Date()
        observacao nullable:true, blank:true, maxSize: 65534
    }
        
    static mapping = {
        table 'certificacao_propriedade' 
        id generator:'identity'        
        version true
        sort dataCertificacao: "desc"     
        observacao type: 'text'     
        
        comment  "Tabela contendo as Cidades por Estado"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        tipoCertificacao comment: "identificador do tipo de certificação"
        propriedade comment: "identificador da propriedade"
        dataCertificacao comment: "Data da certificacao"
        observacao comment: "Observacao da certificação sem limite de caracteres"
    }
    
    String toString(){
        "${dataCertificacao.format("dd/MM/yyyy")}"
    }
}
