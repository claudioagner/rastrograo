package rastrograo.tabela

import rastrograo.empresa.Empresa
import rastrograo.propriedade.Propriedade
/*
 * Domínio Cidade
 * Será utilizado para filtro nos cadastros que utilizam o campo cidade 
 * onde após escolher o pais o campo estado será populado e após escolher o estado
 * o campo cidade será populado
 * Saída: "${nomeCidade}"
 */
class Cidade {
    
    //eventos auditáveis
    static auditable = true
    
    String nomeCidade

    static belongsTo=[estado:Estado]
    
    /*
     * @author Cláudio Agner
     * Incluido relacionamento um para muitos
     * Revisão 7/5/2016 12:55
     */
    static hasMany=[empresas: Empresa, propriedades: Propriedade]
    
    static constraints = {
        estado(nullable:false, blank:false)
        nomeCidade maxSize:128, nullable:false, blank:false, unique:true
        empresas()
        propriedades()
    }
    
    static mapping = {
        table 'cidade' 
        id generator:'identity'        
        version true
        sort nomeCidade: "asc"        
        
        comment  "Tabela contendo as Cidades por Estado"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        estado comment: ""
        nomeCidade comment: "Nome da cidade contendo no máximo 128 caracteres e com valor único"
        empresas comment: "Relacionamento um para muitos com empresas"
        propriedades comment: "Relacionamento um para muitos com propriedades"
    }
    
    String toString(){
        "${nomeCidade}"
    }
    
    void setNomeCidade( String s ){
        nomeCidade = s?.toUpperCase()
    }
}
