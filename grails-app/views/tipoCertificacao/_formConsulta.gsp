<%@ page import="rastrograo.tabela.TipoCertificacao" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'descricaoTipoCertificacao', 'error')} ">
	<label for="descricaoTipoCertificacao">
		<g:message code="tipoCertificacao.descricaoTipoCertificacao.label" default="Descricao Tipo Certificacao" />
	</label>
	<g:textField name="descricaoTipoCertificacao" maxlength="128" value="${consultaInstance?.descricaoTipoCertificacao}"/>
</div>