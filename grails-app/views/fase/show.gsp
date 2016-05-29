
<%@ page import="rastrograo.estrutura.Fase" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fase.label', default: 'Fase')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-fase" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-fase" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list fase">
			
				<g:if test="${faseInstance?.produto}">
				<li class="fieldcontain">
					<span id="produto-label" class="property-label"><g:message code="fase.produto.label" default="Produto" /></span>
					
						<span class="property-value" aria-labelledby="produto-label">${faseInstance?.produto?.encodeAsHTML()}
                                                        <g:link controller="produto" class="show" action="show" id="${faseInstance?.produto?.id}"></g:link>
                                                        <g:link controller="produto" class="edit" action="edit" id="${faseInstance?.produto?.id}"></g:link>
                                                </span> 
					
				</li>
				</g:if>
			
				<g:if test="${faseInstance?.descricaoFase}">
				<li class="fieldcontain">
					<span id="descricaoFase-label" class="property-label"><g:message code="fase.descricaoFase.label" default="Descricao Fase" /></span>
					
						<span class="property-value" aria-labelledby="descricaoFase-label"><g:fieldValue bean="${faseInstance}" field="descricaoFase"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${faseInstance?.observacaoFase}">
				<li class="fieldcontain">
					<span id="observacaoFase-label" class="property-label"><g:message code="fase.observacaoFase.label" default="Observacao Fase" /></span>
					
						<span class="property-value" aria-labelledby="observacaoFase-label"><g:fieldValue bean="${faseInstance}" field="observacaoFase"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${faseInstance?.id}" />
					<g:link class="edit" action="edit" id="${faseInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                
                <g:render template="/atributo/listAtributos"/>
                
                <g:render template="listFases"/>
                
	</body>
</html>
