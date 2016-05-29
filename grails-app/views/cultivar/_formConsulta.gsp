<%@ page import="rastrograo.estrutura.Cultivar" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'produto', 'error')} ">
	<label for="produto">
		<g:message code="cultivar.produto.label" default="Produto" />
	</label>
	<g:select id="produto" 
            name="produtoId" 
            from="${rastrograo.estrutura.Produto.list()}" 
            optionKey="id" 
            value="${consultaInstance?.produto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'descricaoCultivar', 'error')} ">
	<label for="descricaoCultivar">
		<g:message code="cultivar.descricaoCultivar.label" default="Descricao Cultivar" />
	</label>
	<g:textField name="descricaoCultivar" maxlength="128" value="${consultaInstance?.descricaoCultivar}"/>
</div>

