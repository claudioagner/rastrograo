<%@ page import="rastrograo.propriedade.CertificacaoPropriedade" %>


<g:if test="${certificacaoPropriedadeInstance?.tipoCertificacao}">
        <div class="fieldcontain">
                <span id="tipoCertificacao-label" class="property-label"><g:message code="certificacaoPropriedade.tipoCertificacao.label" default="Tipo Certificacao" /></span>

                        <span class="property-value" aria-labelledby="tipoCertificacao-label">${certificacaoPropriedadeInstance?.tipoCertificacao?.encodeAsHTML()}
                                <g:link controller="tipoCertificacao" class="show" action="show" id="${certificacaoPropriedadeInstance?.tipoCertificacao?.id}"></g:link>
                                <g:link controller="tipoCertificacao" class="edit" action="edit" id="${certificacaoPropriedadeInstance?.tipoCertificacao?.id}"></g:link>
                        </span>
                        <g:hiddenField name="tipoCertificacao.id" value="${certificacaoPropriedadeInstance?.tipoCertificacao?.id}" />

        </div>
</g:if>
<g:else>                                
        <div class="fieldcontain ${hasErrors(bean: certificacaoPropriedadeInstance, field: 'tipoCertificacao', 'error')} required">
                <label for="tipoCertificacao">
                        <g:message code="certificacaoPropriedade.tipoCertificacao.label" default="Tipo Certificacao" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="tipoCertificacao" 
                    name="tipoCertificacao.id" 
                    from="${rastrograo.tabela.TipoCertificacao.list()}" 
                    optionKey="id" 
                    required="" 
                    value="${certificacaoPropriedadeInstance?.tipoCertificacao?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um Tipo Certificação --']"/>
        </div>
</g:else>

<g:if test="${certificacaoPropriedadeInstance?.propriedade}">
        <div class="fieldcontain">
                <span id="propriedade-label" class="property-label"><g:message code="certificacaoPropriedade.propriedade.label" default="Propriedade" /></span>

                        <span class="property-value" aria-labelledby="propriedade-label">${certificacaoPropriedadeInstance?.propriedade?.encodeAsHTML()}
                                <g:link controller="propriedade" class="show" action="show" id="${certificacaoPropriedadeInstance?.propriedade?.id}"></g:link>
                                <g:link controller="propriedade" class="edit" action="edit" id="${certificacaoPropriedadeInstance?.propriedade?.id}"></g:link>
                        </span>
                        <g:hiddenField name="propriedade.id" value="${certificacaoPropriedadeInstance?.propriedade?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: certificacaoPropriedadeInstance, field: 'propriedade', 'error')} required">
                <label for="propriedade">
                        <g:message code="certificacaoPropriedade.propriedade.label" default="Propriedade" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="propriedade" 
                    name="propriedade.id" 
                    from="${propriedadeInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${certificacaoPropriedadeInstance?.propriedade?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Propriedade --']"/>
        </div>
</g:else>
    
<div class="fieldcontain ${hasErrors(bean: certificacaoPropriedadeInstance, field: 'dataCertificacao', 'error')} required">
	<label for="dataCertificacao">
		<g:message code="certificacaoPropriedade.dataCertificacao.label" default="Data Certificacao" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dataCertificacao" precision="day"  value="${certificacaoPropriedadeInstance?.dataCertificacao}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: certificacaoPropriedadeInstance, field: 'observacao', 'error')} ">
	<label for="observacao">
		<g:message code="certificacaoPropriedade.observacao.label" default="Observacao" />
		
	</label>
	<g:textArea name="observacao" cols="40" rows="5" maxlength="65534" value="${certificacaoPropriedadeInstance?.observacao}"/>
</div>

