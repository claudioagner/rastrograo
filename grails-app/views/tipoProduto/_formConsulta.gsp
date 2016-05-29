<%@ page import="rastrograo.tabela.TipoProduto" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'descricaoTipoProduto', 'error')} ">
	<label for="descricaoTipoProduto">
		<g:message code="tipoProduto.descricaoTipoProduto.label" default="Descricao Tipo Produto" />
	</label>
	<g:textField name="descricaoTipoProduto" maxlength="128" value="${consultaInstance?.descricaoTipoProduto}"/>
</div>