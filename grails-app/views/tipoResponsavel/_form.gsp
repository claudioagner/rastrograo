<%@ page import="rastrograo.tabela.TipoResponsavel" %>



<div class="fieldcontain ${hasErrors(bean: tipoResponsavelInstance, field: 'descricaoTipoResponsavel', 'error')} required">
	<label for="descricaoTipoResponsavel">
		<g:message code="tipoResponsavel.descricaoTipoResponsavel.label" default="Descricao Tipo Responsavel" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descricaoTipoResponsavel" maxlength="128" required="" value="${tipoResponsavelInstance?.descricaoTipoResponsavel}"/>
</div>