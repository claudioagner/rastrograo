<%@ page import="rastrograo.tabela.Pais" %>



<div class="fieldcontain ${hasErrors(bean: paisInstance, field: 'nomePais', 'error')} required">
	<label for="nomePais">
		<g:message code="pais.nomePais.label" default="Nome Pais" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomePais" maxlength="128" required="" value="${paisInstance?.nomePais}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: paisInstance, field: 'countryName', 'error')} required">
	<label for="countryName">
		<g:message code="pais.countryName.label" default="Country Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="countryName" maxlength="128" required="" value="${paisInstance?.countryName}"/>
</div>

