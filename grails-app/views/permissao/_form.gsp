<%@ page import="rastrograo.seguranca.Permissao" %>



<div class="fieldcontain ${hasErrors(bean: permissaoInstance, field: 'url', 'error')} required">
	<label for="url">
		<g:message code="permissao.url.label" default="Url" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="url" maxlength="128" required="" value="${permissaoInstance?.url}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: permissaoInstance, field: 'configAttribute', 'error')} required">
	<label for="configAttribute">
		<g:message code="permissao.configAttribute.label" default="Config Attribute" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="configAttribute" maxlength="128" required="" value="${permissaoInstance?.configAttribute}"/>
</div>

