package rastrograo.seguranca

import org.apache.commons.lang.builder.HashCodeBuilder

class AcessoRegra implements Serializable {
    
    //eventos auditáveis
    static auditable = true

    private static final long serialVersionUID = 1

    Acesso acesso
    Regra regra

    boolean equals(other) {
        if (!(other instanceof AcessoRegra)) {
            return false
        }

        other.acesso?.id == acesso?.id &&
        other.regra?.id == regra?.id
    }

    int hashCode() {
        def builder = new HashCodeBuilder()
        if (acesso) builder.append(acesso.id)
        if (regra) builder.append(regra.id)
        builder.toHashCode()
    }

    static AcessoRegra get(long acessoId, long regraId) {
        find 'from AcessoRegra where acesso.id=:acessoId and regra.id=:regraId',
        [acessoId: acessoId, regraId: regraId]
    }
    
    static AcessoRegra create(Acesso acesso, Regra regra, boolean flush = false) {
        new AcessoRegra(acesso: acesso, regra: regra).save(flush: flush, insert: true)
    }

    static boolean remove(Acesso acesso, Regra regra, boolean flush = false) {
        AcessoRegra instance = AcessoRegra.findByAcessoAndRegra(acesso, regra)
        if (!instance) {
            return false
        }

        instance.delete(flush: flush)
        true
    }

    static void removeAll(Acesso acesso) {
        executeUpdate 'DELETE FROM AcessoRegra WHERE acesso=:acesso', [acesso: acesso]
    }

    static void removeAll(Regra regra) {
        executeUpdate 'DELETE FROM AcessoRegra WHERE regra=:regra', [regra: regra]
    }
    
    static mapping = {
        table 'acesso_regra' 
        id composite: ['regra', 'acesso']
        version false
    }
}
