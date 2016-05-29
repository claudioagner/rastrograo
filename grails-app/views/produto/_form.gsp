<%@ page import="rastrograo.estrutura.Produto" %>



<g:if test="${produtoInstance?.tipoProduto}">
        <div class="fieldcontain">
                <span id="tipoProduto-label" class="property-label"><g:message code="produtoPropriedade.tipoProduto.label" default="Tipo Produto" /></span>

                        <span class="property-value" aria-labelledby="tipoProduto-label">${produtoInstance?.tipoProduto?.encodeAsHTML()}
                                <g:link controller="tipoProduto" class="show" action="show" id="${produtoInstance?.tipoProduto?.id}"></g:link>
                                <g:link controller="tipoProduto" class="edit" action="edit" id="${produtoInstance?.tipoProduto?.id}"></g:link>
                        </span>
                        <g:hiddenField name="tipoProduto.id" value="${produtoInstance?.tipoProduto?.id}" />

        </div>
</g:if>
<g:else>                                
        <div class="fieldcontain ${hasErrors(bean: produtoInstance, field: 'tipoProduto', 'error')} required">
                <label for="tipoProduto">
                        <g:message code="produtoPropriedade.tipoProduto.label" default="Tipo Produto" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="tipoProduto" 
                    name="tipoProduto.id" 
                    from="${rastrograo.tabela.TipoProduto.list()}" 
                    optionKey="id" 
                    required="" 
                    value="${produtoInstance?.tipoProduto?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um Tipo Produto --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: produtoInstance, field: 'descricaoProduto', 'error')} required">
	<label for="descricaoProduto">
		<g:message code="produto.descricaoProduto.label" default="Descricao Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descricaoProduto" maxlength="128" required="" value="${produtoInstance?.descricaoProduto}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: produtoInstance, field: 'observacaoProduto', 'error')} ">
	<label for="observacaoProduto">
		<g:message code="produto.observacaoProduto.label" default="Observacao Produto" />
		
	</label>
	<g:textArea name="observacaoProduto" cols="40" rows="5" maxlength="65534" value="${produtoInstance?.observacaoProduto}"/>
</div>