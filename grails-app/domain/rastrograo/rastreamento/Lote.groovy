package rastrograo.rastreamento

import rastrograo.customizacao.RastroProduto

class Lote {

    Date dataLote = new Date()
    Date validadeLote = new Date()
    boolean nrLoteSequencial
    String nrLoteManual
    double volumeLote
    String conservacao
    String observacao
    byte[] qrCodeImage
    
    static belongsTo=[rastroProduto: RastroProduto]
    
    static hasMany=[consolidacoes: Consolidacao]
    
    static constraints = {
        rastroProduto(nullable:false, blank:false, unique:true)
        dataLote nullable:false, blank:false
        validadeLote nullable:false, blank:false
        nrLoteSequencial nullable:false, blank:false
        nrLoteManual nullable:true, blank:true, unique:true
        volumeLote nullable:false, blank:false
        observacao nullable:true, blank:true, maxSize: 65534
        conservacao nullable:true, blank:true, maxSize:128
        consolidacoes()
        qrCodeImage nullable:true, blank:true
    }
    static mapping = {
        table 'lote' 
        id generator:'identity'        
        version true  
        sort dataLote: "desc"     
        
        comment  "Tabela contendo os lotes da customização"
        id comment: "identificador do registro"
        version comment: "versionamento do registro e controle de concorrência"
        
        rastroProduto comment: "customização que será loteada"
        dataLote comment: "data da geração do lote"
        validadeLote comment: "data de validade do produto loteado"
        nrLoteSequencial comment: "quando ativado o número do lote será gerado pelo sistema, ou abre o campo para informe manual"
        nrLoteManual comment: "numeração especificada manualmente"
        volumeLote comment: "volume em kg do lote"
        observacao comment: "observação relacionadas ao lote"
        conservacao comment: 'condições de conservação recomendadas'
        consolidacoes comment: "consolidações do lote"
        qrCodeImage comment: "armazena a imagem do qrCode para exibição no ireport"
    }
    
    transient String getQrCode(){
        def s = new StringBuilder()
        if(this){
            s << "Produto: ${rastroProduto.produto.descricaoProduto}\n"
            s << "Produtor: ${rastroProduto.propriedade.nomeFantasiaPropriedade}\n"
            if(rastroProduto.propriedade.cnpj){
                s << "CNPJ: ${rastroProduto.propriedade.cnpj}\n"
                s << "Inscrição Estadual: ${rastroProduto.propriedade.inscricaoEstadual}\n"
            }else{
                s << "CPF: ${rastroProduto.empresa.cpf}\n"
            }
            s << "Logradouro: ${rastroProduto.propriedade.logradouroPropriedade}\n"
            s << "Número: ${rastroProduto.propriedade.numeroPropriedade}\n"
            s << "Bairro: ${rastroProduto.propriedade.bairroPropriedade}\n"
            s << "Cidade: ${rastroProduto.propriedade.cidade.nomeCidade}\n"
            s << "Estado: ${rastroProduto.propriedade.cidade.estado.nomeEstado} - ${rastroProduto.propriedade.cidade.estado.sigla}\n"
            s << "CEP: ${rastroProduto.propriedade.cepPropriedade}\n"
            if(nrLoteSequencial){
                s << "Lote: ${id.toString()}\n"
            }else{
                s << "Lote: ${nrLoteManual}\n"
            }
            s << "Volume Lote(kg): ${volumeLote.toString()}\n"
            s << "Validade: ${validadeLote.format("dd/MM/yyyy").toString()}\n"
            s << "Conservação: ${conservacao}\n"
            s << "Mais informações: http://rastro.jelasticlw.com.br/rastro/lote/cliente/${this.id}\n"
        }
        return s.toString()
    }
    
    String toString(){
        nrLoteSequencial ? "${rastroProduto.produto} - ${rastroProduto.anoSafra} - ${id}" : "${rastroProduto.produto} - ${rastroProduto.anoSafra} - ${nrLoteManual}"
    }
}
