<%@ page import="rastrograo.rastreamento.Lote" %>


<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'rastroProduto', 'error')} ">
	<label for="rastroProduto">
		<g:message code="lote.rastroProduto.label" default="Rastro Produto" />
	</label>
	<g:select id="rastroProduto" 
            name="rastroProduto.id" 
            from="${rastroProdutoInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.rastroProduto?.id}" 
            noSelection="['': '-- Selecione um Rastreamento --']"
            class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nrLoteManual', 'error')} ">
        <label for="nrLoteManual">
                <g:message code="lote.nrLoteManual.label" default="Nr Lote Manual" />
        </label>
        <g:textField name="nrLoteManual" value="${consultaInstance?.nrLoteManual}" />
</div>