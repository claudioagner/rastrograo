package rastrograo.propriedade

//importação de classes de outros pacotes
import rastrograo.tabela.TipoResponsavel

/*
 * Domínio Responsável Propriedade
 * Será utilizado nos cadastros de responsável vinculado aos cadastros de 
 * propriedade
 * Saída: "${nomeResponsavelPropriedade}"
 */
class ResponsavelPropriedade {
    
    //eventos auditáveis
    static auditable = true

    String nomeResponsavelPropriedade
    String dddResponsavelPropriedade
    String numeroTelefoneResponsavelPropriedade
    
    static belongsTo=[tipoResponsavel:TipoResponsavel,propriedade:Propriedade]
    
    static constraints = {
        tipoResponsavel(nullable:false, blank:false)
        propriedade(nullable:false, blank:false)
        nomeResponsavelPropriedade maxSize:128, nullable:false, blank:false
        dddResponsavelPropriedade size:2..2, nullable:false, blank:false
        numeroTelefoneResponsavelPropriedade size:8..9, nullable:false, blank:false, unique:['dddResponsavelPropriedade', 'numeroTelefoneResponsavelPropriedade']
    }
        
    static mapping = {
        table 'responsavel_propriedade' 
        id generator:'identity'        
        version true
        sort nomeResponsavelPropriedade: "asc"      
        
        comment  "Tabela contendo as Cidades por Estado"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        tipoResponsavel comment: "identificador do tipo de responsável"
        propriedade comment: "identificador da propriedade"
        nomeResponsavelPropriedade comment: "Nome do responsável contendo no máximo 128 caracteres"
        dddResponsavelPropriedade comment: "DDD do telefone do responsável pela propriedade contendo 2 caracteres"
        numeroTelefoneResponsavelPropriedade comment: "Número do Telefone do responsável pela propriedade contendo de 8 a 9 caracteres e com valor unico somando o ddd e o numero do telefone"
    }
    
    String toString(){
        "${nomeResponsavelPropriedade}"
    }
    
    void setNomeResponsavelPropriedade( String s ){
        nomeResponsavelPropriedade = s?.toUpperCase()
    }
}
