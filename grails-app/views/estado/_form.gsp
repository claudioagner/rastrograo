<%@ page import="rastrograo.tabela.Estado" %>


<g:if test="${estadoInstance?.pais}">
        <div class="fieldcontain">
                <span id="pais-label" class="property-label"><g:message code="estado.pais.label" default="Pais" /></span>

                        <span class="property-value" aria-labelledby="pais-label">${estadoInstance?.pais?.encodeAsHTML()}
                                <g:link controller="pais" class="show" action="show" id="${estadoInstance?.pais?.id}"></g:link>
                                <g:link controller="pais" class="edit" action="edit" id="${estadoInstance?.pais?.id}"></g:link>
                        </span>
                        <g:hiddenField name="pais.id" value="${estadoInstance?.pais?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: estadoInstance, field: 'pais', 'error')} required">
                <label for="pais">
                        <g:message code="estado.pais.label" default="Pais" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="pais" 
                    name="pais.id" 
                    from="${rastrograo.tabela.Pais.list()}" 
                    optionKey="id" 
                    required="" 
                    value="${estadoInstance?.pais?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um País --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: estadoInstance, field: 'nomeEstado', 'error')} required">
	<label for="nomeEstado">
		<g:message code="estado.nomeEstado.label" default="Nome Estado" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomeEstado" maxlength="128" required="" value="${estadoInstance?.nomeEstado}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estadoInstance, field: 'sigla', 'error')} required">
	<label for="sigla">
		<g:message code="estado.sigla.label" default="Sigla" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="sigla" maxlength="2" required="" value="${estadoInstance?.sigla}"/>
</div>