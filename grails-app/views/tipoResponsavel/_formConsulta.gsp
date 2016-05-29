<%@ page import="rastrograo.tabela.TipoResponsavel" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'descricaoTipoResponsavel', 'error')} ">
	<label for="descricaoTipoResponsavel">
		<g:message code="tipoResponsavel.descricaoTipoResponsavel.label" default="Descricao Tipo Responsavel" />
	</label>
	<g:textField name="descricaoTipoResponsavel" maxlength="128" value="${consultaInstance?.descricaoTipoResponsavel}"/>
</div>