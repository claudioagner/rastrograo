<%@ page import="rastrograo.estrutura.Fase" %>


<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'produto', 'error')} ">
	<label for="produto">
		<g:message code="fase.produto.label" default="Produto" />
	</label>
	<g:select id="produto" 
            name="produtoId" 
            from="${rastrograo.estrutura.Produto.list()}" 
            optionKey="id" 
            value="${consultaInstance?.produto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'descricaoFase', 'error')} ">
	<label for="descricaoFase">
		<g:message code="fase.descricaoFase.label" default="Descricao Fase" />
	</label>
	<g:textField name="descricaoFase" maxlength="128" value="${consultaInstance?.descricaoFase}"/>
</div>