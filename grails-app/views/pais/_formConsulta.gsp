<%@ page import="rastrograo.tabela.Pais" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomePais', 'error')} ">
	<label for="nomePais">
		<g:message code="pais.nomePais.label" default="Nome Pais" />
	</label>
	<g:textField name="nomePais" maxlength="128" value="${consultaInstance?.nomePais}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'countryName', 'error')} ">
	<label for="countryName">
		<g:message code="pais.countryName.label" default="Country Name" />
	</label>
	<g:textField name="countryName" maxlength="128" value="${consultaInstance?.countryName}"/>
</div>