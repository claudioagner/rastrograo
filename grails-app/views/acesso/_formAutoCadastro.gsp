<%@ page import="rastrograo.seguranca.Acesso" %>



<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="acesso.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" maxlength="32" value="${acessoInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="acesso.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" maxlength="128" required="" value="${acessoInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="acesso.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:passwordField name="password" required="" maxlength="64" value=""/>
</div>

<g:hiddenField name="enabled" value="${true}" />