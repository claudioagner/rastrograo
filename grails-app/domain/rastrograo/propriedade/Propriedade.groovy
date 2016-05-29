package rastrograo.propriedade
/*
 * Domínio Propriedade
 * Saída: "${nomePropriedade}"
 */

//importação dos domínios vinculados
import rastrograo.customizacao.RastroProduto
import rastrograo.seguranca.Acesso
import rastrograo.tabela.Cidade

class Propriedade {
    
    //eventos auditáveis
    static auditable = true
    
    //dados da propriedade
    String tipoPropriedade
    String porte
    String cnpj
    String cpf
    String inscricaoEstadual    
    String nomePropriedade
    String nomeFantasiaPropriedade
    String emailPropriedade
    
    //endereço da propriedade
    Cidade cidade
    String logradouroPropriedade
    String bairroPropriedade
    String numeroPropriedade
    String cepPropriedade
    String complementoPropriedade
    
    static belongsTo=[Acesso]
    
    static hasMany=[acessos:Acesso,
        certificados: CertificacaoPropriedade, 
        fotos:FotoPropriedade,
        responsaveis: ResponsavelPropriedade,
        talhoes:TalhaoPropriedade,
        telefones:TelefonePropriedade,
        rastrosProduto: RastroProduto]
    
    static constraints = {
        porte maxSize:32, nullable:false, blank:false, inList:['Pequena', 'Média', 'Grande']
        tipoPropriedade maxSize:32, nullable:false, blank:false, inList:['Pessoa Jurídica', 'Pessoa Física']
        cnpj size:18..18, nullable:true, blank:true, unique:true
        cpf size:14..14, nullable:true, blank:true, unique:true
        inscricaoEstadual size:20..20, nullable:true, blank:true, unique:true
        nomePropriedade maxSize:128, nullable:false, blank:false
        nomeFantasiaPropriedade maxSize:128, nullable:true, blank:true
        emailPropriedade maxSize:128, nullable:true, blank:true, unique:true, email:true
        cidade(nullable:false, blank:false)
        logradouroPropriedade maxSize:128, nullable:false, blank:false
        bairroPropriedade maxSize:64, nullable:false, blank:false
        numeroPropriedade maxSize:10, nullable:false, blank:false
        cepPropriedade size:9..9, nullable:false, blank:false
        complementoPropriedade maxSize:128, nullable:true, blank:true
        acessos()
        certificados()
        fotos()
        responsaveis()
        talhoes()
        telefones()
        rastrosProduto()
    }
    
    static mapping = {
        table 'propriedade' 
        id generator:'identity'        
        version true
        sort nomePropriedade: "asc"   
        certificados sort: 'dataCertificacao', 'desc'
        fotos sort: 'tituloFoto', 'asc'
        responsaveis sort: 'nomeResponsavelPropriedade', 'asc'
        talhoes sort: 'descricaoTalhao', 'asc'
        telefones sort: 'numeroTelefonePropriedade', 'asc'
        
        comment  "Tabela contendo as Propriedades do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        tipoPropriedade comment: ""
        porte comment: ""
        cnpj comment: ""
        cpf comment: ""
        inscricaoEstadual comment: ""
        nomePropriedade comment: "Nome da propriedade contendo no máximo 128 caracteres"
        nomeFantasiaPropriedade comment: ""
        emailPropriedade comment: ""
        cidade comment: ""
        logradouroPropriedade comment: ""
        bairroPropriedade comment: ""
        numeroPropriedade comment: ""
        cepPropriedade comment: ""
        complementoPropriedade comment: ""
        certificados comment: ""
        fotos comment: ""
        responsaveis comment: ""
        talhoes comment: ""
        telefones comment: ""
        rastrosProduto comment: "relacionamento um para muitos com rastro produto"
    }
    
    String toString(){
        "${nomePropriedade}"
    }
    
    void setNomePropriedade( String s ){
        nomePropriedade = s?.toUpperCase()
    }
    
    void setNomeFantasiaPropriedade( String s ){
        nomeFantasiaPropriedade = s?.toUpperCase()
    }
    
    void setEmailPropriedade( String s ){
        emailPropriedade = s?.toLowerCase()
    }
    
    void setLogradouroPropriedade( String s ){
        logradouroPropriedade = s?.toUpperCase()
    }
    
    void setBairroPropriedade( String s ){
        bairroPropriedade = s?.toUpperCase()
    }
    
    void setNumeroPropriedade( String s ){
        numeroPropriedade = s?.toUpperCase()
    }
    
    void setComplementoPropriedade( String s ){
        complementoPropriedade = s?.toUpperCase()
    }
}