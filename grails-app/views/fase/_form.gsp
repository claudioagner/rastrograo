<%@ page import="rastrograo.estrutura.Fase" %>


<g:if test="${faseInstance?.produto}">
<div class="fieldcontain">
        <span id="produto-label" class="property-label"><g:message code="fase.produto.label" default="Produto" /></span>

                <span class="property-value" aria-labelledby="produto-label">${faseInstance?.produto?.encodeAsHTML()}
                        <g:link controller="produto" class="show" action="show" id="${faseInstance?.produto?.id}"></g:link>
                        <g:link controller="produto" class="edit" action="edit" id="${faseInstance?.produto?.id}"></g:link>
                </span> 
                <g:hiddenField name="produto.id" value="${faseInstance?.produto?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: faseInstance, field: 'produto', 'error')} required">
	<label for="produto">
		<g:message code="fase.produto.label" default="Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="produto" 
            name="produto.id" 
            from="${rastrograo.estrutura.Produto.list()}" 
            optionKey="id" 
            required="" 
            value="${faseInstance?.produto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: faseInstance, field: 'descricaoFase', 'error')} required">
	<label for="descricaoFase">
		<g:message code="fase.descricaoFase.label" default="Descricao Fase" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descricaoFase" maxlength="128" required="" value="${faseInstance?.descricaoFase}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: faseInstance, field: 'observacaoFase', 'error')} ">
	<label for="observacaoFase">
		<g:message code="fase.observacaoFase.label" default="Observacao Fase" />
		
	</label>
	<g:textArea name="observacaoFase" cols="40" rows="5" maxlength="65534" value="${faseInstance?.observacaoFase}"/>
</div>