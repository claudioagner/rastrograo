<%@ page import="rastrograo.seguranca.Permissao" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'url', 'error')} ">
	<label for="url">
		<g:message code="permissao.url.label" default="Url" />
	</label>
	<g:textField name="url" maxlength="128" value="${consultaInstance?.url}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'configAttribute', 'error')} ">
	<label for="configAttribute">
		<g:message code="permissao.configAttribute.label" default="Config Attribute" />
	</label>
	<g:textField name="configAttribute" maxlength="128" value="${consultaInstance?.configAttribute}"/>
</div>

