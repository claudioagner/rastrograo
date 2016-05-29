<%@ page import="rastrograo.tabela.TipoProduto" %>



<div class="fieldcontain ${hasErrors(bean: tipoProdutoInstance, field: 'descricaoTipoProduto', 'error')} required">
	<label for="descricaoTipoProduto">
		<g:message code="tipoProduto.descricaoTipoProduto.label" default="Descricao Tipo Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descricaoTipoProduto" maxlength="128" required="" value="${tipoProdutoInstance?.descricaoTipoProduto}"/>
</div>