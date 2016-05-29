<%@ page import="rastrograo.seguranca.Regra" %>



<div class="fieldcontain ${hasErrors(bean: regraInstance, field: 'authority', 'error')} required">
	<label for="authority">
		<g:message code="regra.authority.label" default="Authority" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="authority" maxlength="64" required="" value="${regraInstance?.authority?.replace("ROLE_","")}"/><br>
</div>

