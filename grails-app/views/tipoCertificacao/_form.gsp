<%@ page import="rastrograo.tabela.TipoCertificacao" %>



<div class="fieldcontain ${hasErrors(bean: tipoCertificacaoInstance, field: 'descricaoTipoCertificacao', 'error')} required">
	<label for="descricaoTipoCertificacao">
		<g:message code="tipoCertificacao.descricaoTipoCertificacao.label" default="Descricao Tipo Certificacao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descricaoTipoCertificacao" maxlength="128" required="" value="${tipoCertificacaoInstance?.descricaoTipoCertificacao}"/>
</div>