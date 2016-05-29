package rastrograo.tabela

//importação das classes utilizadas
import rastrograo.empresa.ResponsavelEmpresa
import rastrograo.propriedade.ResponsavelPropriedade

/*
 * Domínio Tipo de Responsável
 * Será utilizado nos cadastros de responsável vinculado aos cadastros de 
 * empresa e propriedade
 * Saída: "${descricao}"
 */
class TipoResponsavel {
    
    //eventos auditáveis
    static auditable = true

    String descricaoTipoResponsavel 

    static hasMany=[responsaveisEmpresa:ResponsavelEmpresa, responsaveisPropriedade:ResponsavelPropriedade]
    
    static constraints = {
        descricaoTipoResponsavel maxSize:128, nullable:false, blank:false, unique:true
        responsaveisEmpresa()
        responsaveisPropriedade()
    }
    
    static mapping = {
        table 'tipo_responsavel' 
        id generator:'identity'        
        version true
        sort descricaoTipoResponsavel: "asc"        
        responsaveisEmpresa sort: 'nomeResponsavelEmpresa', 'asc'
        responsaveisPropriedade sort: 'nomeResponsavelPropriedade', 'asc'
        
        comment  "Tabela contendo as Cidades por Estado"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        descricaoTipoResponsavel comment: "Descrição do tipo de responsável contendo no máximo 128 caracteres, com valor único"
        responsaveisEmpresa comment: "relacionamento uma empresa para muitos responsáveis"
        responsaveisPropriedade comment: "relacionamento uma propriedade para muitos responsáveis"
    }
    
    String toString(){
        "${descricaoTipoResponsavel}"
    }
    
    void setDescricaoTipoResponsavel( String s ){
        descricaoTipoResponsavel = s?.toUpperCase()
    }
}
