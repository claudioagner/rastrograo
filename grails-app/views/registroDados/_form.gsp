<%@ page import="rastrograo.dados.RegistroDados" %>


<g:if test="${registroDadosInstance?.rastroProduto && registroDadosInstance?.id}">
<div class="fieldcontain">
        <span id="rastroProduto-label" class="property-label"><g:message code="registroDados.rastroProduto.label" default="Rastro Produto" /></span>

                <span class="property-value" aria-labelledby="rastroProduto-label">${registroDadosInstance?.rastroProduto?.encodeAsHTML()}
                        <g:link controller="rastroProduto" class="show" action="show" id="${registroDadosInstance?.rastroProduto?.id}"></g:link>
                        <g:link controller="rastroProduto" class="edit" action="edit" id="${registroDadosInstance?.rastroProduto?.id}"></g:link>
                </span>  

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'rastroProduto', 'error')} required">
	<label for="rastroProduto">
		<g:message code="registroDados.rastroProduto.label" default="Rastro Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="rastroProduto" 
            name="rastroProduto.id" 
            from="${rastroProdutoInstanceList}" 
            optionKey="id" 
            required="" 
            value="${registroDadosInstance?.rastroProduto?.id}" 
            onClick="${remoteFunction (
                        controller: 'registroDados',
                        action: 'getFases',
                        params: '\'rastroProdutoId=\' + this.value',
                        update: 'rastroFase'
                  )}"
            onLoading="showSpinner(true)"
            onComplete="showSpinner(false)"
            noSelection="['': '-- Selecione um Produto --']"
            class="many-to-one"/>
</div>
</g:else>

<g:if test="${registroDadosInstance?.rastroFase && registroDadosInstance?.id}">
<div class="fieldcontain">
        <span id="rastroFase-label" class="property-label"><g:message code="registroDados.rastroFase.label" default="Rastro Fase" /></span>

                <span class="property-value" aria-labelledby="rastroFase-label">${registroDadosInstance?.rastroFase?.encodeAsHTML()}</span>  

</div>
</g:if>
<g:else>
<div id="rastroFase"><g:render template="rastroFase"/></div>
</g:else>

<g:if test="${registroDadosInstance?.rastroAtributo && registroDadosInstance?.id}">
<div class="fieldcontain">
        <span id="rastroAtributo-label" class="property-label"><g:message code="registroDados.rastroAtributo.label" default="Rastro Atributo" /></span>

                <span class="property-value" aria-labelledby="rastroAtributo-label">${registroDadosInstance?.rastroAtributo?.encodeAsHTML()}</span>  

</div>
</g:if>
<g:else>
<div id="rastroAtributo"><g:render template="rastroAtributo"/></div>
</g:else>

<div id="configRastroAtributo"><g:render template="configRastroAtributo"/></div>

<div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'dataCriado', 'error')} required">
	<label for="dataCriado">
		<g:message code="registroDados.dataCriado.label" default="Data Criado" />
		<span class="required-indicator">*</span>
	</label>
        <g:formatDate date="${registroDadosInstance?.dataCriado}" format="dd/MM/yyyy HH:mm"/>
</div>

<div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'dataAlterado', 'error')} ">
	<label for="dataAlterado">
		<g:message code="registroDados.dataAlterado.label" default="Data Alterado" />
		
	</label>
	<g:formatDate date="${registroDadosInstance?.dataAlterado}" format="dd/MM/yyyy HH:mm"/>
</div>