package rastrograo.empresa

//importação dos domínios vinculados
import rastrograo.customizacao.RastroProduto
import rastrograo.seguranca.Acesso
import rastrograo.tabela.Cidade

/*
 * Domínio Empresa
 * Saída: "${nomeEmpresa}"
 */
class Empresa {
    
    //eventos auditáveis
    static auditable = true
    
    //dados da empresa
    String tipoEmpresa
    String cnpj
    String cpf
    String inscricaoEstadual
    String nomeEmpresa
    String nomeFantasiaEmpresa
    String emailEmpresa
    
    //endereço da empresa
    Cidade cidade
    String logradouroEmpresa
    String bairroEmpresa
    String numeroEmpresa
    String cepEmpresa
    String complementoEmpresa
    
    static belongsTo=[Acesso]
    
    static hasMany=[acessos:Acesso,
        certificados: CertificacaoEmpresa, 
        fotos:FotoEmpresa,
        responsaveis: ResponsavelEmpresa,
        telefones:TelefoneEmpresa,
        rastrosProduto: RastroProduto]
    
    static constraints = {
        tipoEmpresa maxSize:32, nullable:false, blank:false, inList:['Pessoa Jurídica', 'Pessoa Física']
        cnpj size:18..18, nullable:true, blank:true, unique:true
        cpf size:14..14, nullable:true, blank:true, unique:true
        inscricaoEstadual size:20..20, nullable:true, blank:true, unique:true
        nomeEmpresa maxSize:128, nullable:false, blank:false
        nomeFantasiaEmpresa maxSize:128, nullable:false, blank:false
        emailEmpresa maxSize:128, nullable:true, blank:true, unique:true, email:true
        cidade(nullable:false, blank:false)
        logradouroEmpresa maxSize:128, nullable:false, blank:false
        bairroEmpresa maxSize:64, nullable:false, blank:false
        numeroEmpresa maxSize:10, nullable:false, blank:false
        cepEmpresa size:9..9, nullable:false, blank:false
        complementoEmpresa maxSize:128, nullable:true, blank:true
        acessos(nullable:false, blank:false)
        certificados()
        fotos()
        responsaveis()
        telefones()
        rastrosProduto()
    }
    
    static mapping = {
        table 'empresa' 
        id generator:'identity'        
        version true
        sort nomeEmpresa: "asc"   
        certificados sort: 'dataCertificacao', 'desc'
        fotos sort: 'tituloFoto', 'asc'
        responsaveis sort: 'nomeResponsavelEmpresa', 'asc'
        telefones sort: 'numeroTelefoneEmpresa', 'asc'
        
        comment  "Tabela contendo as Empresas do sistema"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        tipoEmpresa comment: ""
        cnpj comment: ""
        cpf comment: ""
        inscricaoEstadual comment: ""
        nomeEmpresa comment: "Nome da empresa contendo no máximo 128 caracteres"
        nomeFantasiaEmpresa comment: ""
        emailEmpresa comment: ""
        cidade comment: ""
        logradouroEmpresa comment: ""
        bairroEmpresa comment: ""
        numeroEmpresa comment: ""
        cepEmpresa comment: ""
        complementoEmpresa comment: ""
        certificados comment: ""
        fotos comment: ""
        responsaveis comment: ""
        telefones comment: ""
        rastrosProduto comment: "Relacionamento um para muitos com rastro produto"
    }
    
    String toString(){
        "${nomeEmpresa}"
    }
    
    void setNomeEmpresa( String s ){
        nomeEmpresa = s?.toUpperCase()
    }
    
    void setNomeFantasiaEmpresa( String s ){
        nomeFantasiaEmpresa = s?.toUpperCase()
    }
    
    void setEmailEmpresa( String s ){
        emailEmpresa = s?.toLowerCase()
    }
    
    void setLogradouroEmpresa( String s ){
        logradouroEmpresa = s?.toUpperCase()
    }
    
    void setBairroEmpresa( String s ){
        bairroEmpresa = s?.toUpperCase()
    }
    
    void setNumeroEmpresa( String s ){
        numeroEmpresa = s?.toUpperCase()
    }
    
    void setComplementoEmpresa( String s ){
        complementoEmpresa = s?.toUpperCase()
    }
}