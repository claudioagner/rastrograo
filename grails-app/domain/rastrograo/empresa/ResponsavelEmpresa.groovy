package rastrograo.empresa

//importação de classes de outros pacotes
import rastrograo.tabela.TipoResponsavel

/*
 * Domínio Responsável Empresa
 * Será utilizado nos cadastros de responsável vinculado aos cadastros de 
 * empresa
 * Saída: "${nomeResponsavelEmpresa}"
 */
class ResponsavelEmpresa {
    
    //eventos auditáveis
    static auditable = true

    String nomeResponsavelEmpresa
    String dddResponsavelEmpresa
    String numeroTelefoneResponsavelEmpresa
    
    static belongsTo=[tipoResponsavel:TipoResponsavel,empresa:Empresa]
    
    static constraints = {
        tipoResponsavel(nullable:false, blank:false)
        empresa(nullable:false, blank:false)
        nomeResponsavelEmpresa maxSize:128, nullable:false, blank:false
        dddResponsavelEmpresa size:2..2, nullable:false, blank:false
        numeroTelefoneResponsavelEmpresa size:8..9, nullable:false, blank:false, unique:['dddResponsavelEmpresa', 'numeroTelefoneResponsavelEmpresa']
    }
        
    static mapping = {
        table 'responsavel_empresa' 
        id generator:'identity'        
        version true
        sort nomeResponsavelEmpresa: "asc"      
        
        comment  "Tabela contendo as Cidades por Estado"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        tipoResponsavel comment: "identificador do tipo de responsável"
        empresa comment: "identificador da empresa"
        nomeResponsavelEmpresa comment: "Nome do responsável contendo no máximo 128 caracteres"
        dddResponsavelEmpresa comment: "DDD do telefone do responsável pela empresa contendo 2 caracteres"
        numeroTelefoneResponsavelEmpresa comment: "Número do Telefone do responsável pela empresa contendo de 8 a 9 caracteres e com valor unico somando o ddd e o numero do telefone"
    }
    
    String toString(){
        "${nomeResponsavelEmpresa}"
    }
    
    void setNomeResponsavelEmpresa( String s ){
        nomeResponsavelEmpresa = s?.toUpperCase()
    }
}
