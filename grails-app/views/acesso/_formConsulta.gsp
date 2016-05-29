<%@ page import="rastrograo.seguranca.Acesso" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'username', 'error')} ">
	<label for="username">
		<g:message code="acesso.username.label" default="Username" />
	</label>
	<g:textField name="username" maxlength="32" value="${consultaInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'email', 'error')} ">
	<label for="email">
		<g:message code="acesso.email.label" default="Email" />
	</label>
	<g:field type="email" name="email" maxlength="128" value="${consultaInstance?.email}"/>
</div>