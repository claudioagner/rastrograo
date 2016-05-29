<%@ page import="rastrograo.estrutura.Produto" %>


<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tipoProduto', 'error')} ">
	<label for="tipoProduto">
		<g:message code="consulta.tipoProduto.label" default="Tipo Produto" />
	</label>
	<g:select id="tipoProduto" 
            name="tipoProdutoId" 
            from="${rastrograo.tabela.TipoProduto.list()}" 
            optionKey="id" 
            value="${consultaInstance?.tipoProduto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Tipo Produto --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'descricaoProduto', 'error')} ">
	<label for="descricaoProduto">
		<g:message code="produto.descricaoProduto.label" default="Descricao Produto" />
	</label>
	<g:textField name="descricaoProduto" maxlength="128" value="${consultaInstance?.descricaoProduto}"/>
</div>