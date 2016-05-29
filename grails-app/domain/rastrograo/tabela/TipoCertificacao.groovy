package rastrograo.tabela

//importação das classes utilizadas
import rastrograo.empresa.CertificacaoEmpresa
import rastrograo.propriedade.CertificacaoPropriedade

/*
 * Domínio Tipo de Certificação
 * Será utilizado nos cadastros de certificação vinculado aos cadastros de 
 * empresa e propriedade
 * Saída: "${descricaoTipoCertificacao}"
 */
class TipoCertificacao {
    
    //eventos auditáveis
    static auditable = true

    String descricaoTipoCertificacao 

    static hasMany=[certificacoesEmpresa:CertificacaoEmpresa, certificacoesPropriedade:CertificacaoPropriedade]
    
    static constraints = {
        descricaoTipoCertificacao maxSize:128, nullable:false, blank:false, unique:true
        certificacoesEmpresa()
        certificacoesPropriedade()
    }
    
    static mapping = {
        table 'tipo_certificacao' 
        id generator:'identity'        
        version true
        sort descricaoTipoCertificacao: "asc"        
        certificacoesEmpresa sort: 'dataCertificacao', 'desc'
        certificacoesPropriedade sort: 'dataCertificacao', 'desc'
        
        comment  "Tabela contendo as Cidades por Estado"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        descricaoTipoCertificacao comment: "Descrição do tipo de responsável contendo no máximo 128 caracteres, com valor único"
        certificacoesEmpresa comment: "relacionamento uma empresa para muitos responsáveis"
        certificacoesPropriedade comment: "relacionamento uma propriedade para muitos responsáveis"
    }
    
    String toString(){
        "${descricaoTipoCertificacao}"
    }
    
    void setDescricaoTipoCertificacao( String s ){
        descricaoTipoCertificacao = s?.toUpperCase()
    }
}
