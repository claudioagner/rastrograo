package rastrograo.empresa

//importação de classes
import rastrograo.tabela.TipoCertificacao

/*
 * Domínio Certificação Empresa
 * Será utilizado nos cadastros de certificação vinculado aos cadastros de 
 * empresa
 * Saída: "${dataCertificacao}"
 */
class CertificacaoEmpresa {
    
    //eventos auditáveis
    static auditable = true

    Date dataCertificacao = new Date().clearTime()
    String observacao
    
    static belongsTo=[tipoCertificacao:TipoCertificacao,empresa:Empresa]
    
    static constraints = {
        tipoCertificacao(nullable:false, blank:false)
        empresa(nullable:false, blank:false)
        dataCertificacao nullable:false, blank:false, max: new Date()
        observacao nullable:true, blank:true, maxSize: 65534
    }
        
    static mapping = {
        table 'certificacao_empresa' 
        id generator:'identity'        
        version true
        sort dataCertificacao: "desc"      
        observacao type: 'text'
        
        comment  "Tabela contendo as Cidades por Estado"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        tipoCertificacao comment: "identificador do tipo de certificação"
        empresa comment: "identificador da empresa"
        dataCertificacao comment: "Data da certificacao"
        observacao comment: "Observacao da certificação sem limite de caracteres"
    }
    
    String toString(){
        "${dataCertificacao.format("dd/MM/yyyy")}"
    }
}
