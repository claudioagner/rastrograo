
<%@ page import="rastrograo.estrutura.Produto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'produto.label', default: 'Produto')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-produto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-produto" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list produto">
                            
                                <g:if test="${produtoInstance?.tipoProduto}">
                                <li class="fieldcontain">
                                        <span id="tipoProduto-label" class="property-label"><g:message code="produtoPropriedade.tipoProduto.label" default="Tipo Produto" /></span>

                                                <span class="property-value" aria-labelledby="tipoProduto-label">${produtoInstance?.tipoProduto?.encodeAsHTML()}
                                                        <g:link controller="tipoProduto" class="show" action="show" id="${produtoInstance?.tipoProduto?.id}"></g:link>
                                                        <g:link controller="tipoProduto" class="edit" action="edit" id="${produtoInstance?.tipoProduto?.id}"></g:link>
                                                </span>
                                                <g:hiddenField name="tipoProduto.id" value="${produtoInstance?.tipoProduto?.id}" />

                                </li>
                                </g:if>
			
				<g:if test="${produtoInstance?.descricaoProduto}">
				<li class="fieldcontain">
					<span id="descricaoProduto-label" class="property-label"><g:message code="produto.descricaoProduto.label" default="Descricao Produto" /></span>
					
						<span class="property-value" aria-labelledby="descricaoProduto-label"><g:fieldValue bean="${produtoInstance}" field="descricaoProduto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${produtoInstance?.observacaoProduto}">
				<li class="fieldcontain">
					<span id="observacaoProduto-label" class="property-label"><g:message code="produto.observacaoProduto.label" default="Observacao Produto" /></span>
					
						<span class="property-value" aria-labelledby="observacaoProduto-label"><g:fieldValue bean="${produtoInstance}" field="observacaoProduto"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${produtoInstance?.id}" />
					<g:link class="edit" action="edit" id="${produtoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                
                <g:render template="/cultivar/listCultivares"/>
                <g:render template="/fase/listFases"/>
                      
	</body>
</html>
