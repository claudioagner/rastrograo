<%@ page import="rastrograo.seguranca.Regra" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'authority', 'error')} ">
	<label for="authority">
		<g:message code="regra.authority.label" default="Authority" />
	</label>
	<g:textField name="authority" maxlength="64" value="${consultaInstance?.authority}"/>
</div>

