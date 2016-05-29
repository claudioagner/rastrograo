<g:if test="${!loteInstance?.nrLoteSequencial}">
        <div class="fieldcontain ${hasErrors(bean: loteInstance, field: 'nrLoteManual', 'error')} required">
                <label for="nrLoteManual">
                        <g:message code="lote.nrLoteManual.label" default="Nr Lote Manual" />
                        <span class="required-indicator">*</span>
                </label>
                <g:textField name="nrLoteManual" value="${loteInstance?.nrLoteManual}" required=""/>
        </div>
</g:if>