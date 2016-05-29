<%@ page import="rastrograo.estrutura.Cultivar" %>



			
<g:if test="${cultivarInstance?.produto}">
<div class="fieldcontain">
        <span id="produto-label" class="property-label"><g:message code="cultivar.produto.label" default="Produto" /></span>

                <span class="property-value" aria-labelledby="produto-label">${cultivarInstance?.produto?.encodeAsHTML()}
                        <g:link controller="produto" class="show" action="show" id="${cultivarInstance?.produto?.id}"></g:link>
                        <g:link controller="produto" class="edit" action="edit" id="${cultivarInstance?.produto?.id}"></g:link>
                </span> 
                <g:hiddenField name="produto.id" value="${cultivarInstance?.produto?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: cultivarInstance, field: 'produto', 'error')} required">
	<label for="produto">
		<g:message code="cultivar.produto.label" default="Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="produto" 
            name="produto.id" 
            from="${rastrograo.estrutura.Produto.list()}" 
            optionKey="id" 
            required="" 
            value="${cultivarInstance?.produto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>
</g:else>
    
<div class="fieldcontain ${hasErrors(bean: cultivarInstance, field: 'descricaoCultivar', 'error')} required">
	<label for="descricaoCultivar">
		<g:message code="cultivar.descricaoCultivar.label" default="Descricao Cultivar" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descricaoCultivar" maxlength="128" required="" value="${cultivarInstance?.descricaoCultivar}"/>
</div>