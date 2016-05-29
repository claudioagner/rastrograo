
<%@ page import="rastrograo.propriedade.TelefonePropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-telefonePropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-telefonePropriedade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list telefonePropriedade">
			
				<g:if test="${telefonePropriedadeInstance?.propriedade}">
				<li class="fieldcontain">
					<span id="propriedade-label" class="property-label"><g:message code="telefonePropriedade.propriedade.label" default="Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="propriedade-label">${telefonePropriedadeInstance?.propriedade?.encodeAsHTML()}
                                                        <g:link controller="propriedade" class="show" action="show" id="${telefonePropriedadeInstance?.propriedade?.id}"></g:link>
                                                        <g:link controller="propriedade" class="edit" action="edit" id="${telefonePropriedadeInstance?.propriedade?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${telefonePropriedadeInstance?.dddPropriedade}">
				<li class="fieldcontain">
					<span id="dddPropriedade-label" class="property-label"><g:message code="telefonePropriedade.dddPropriedade.label" default="Ddd Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="dddPropriedade-label"><g:fieldValue bean="${telefonePropriedadeInstance}" field="dddPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${telefonePropriedadeInstance?.numeroTelefonePropriedade}">
				<li class="fieldcontain">
					<span id="numeroTelefonePropriedade-label" class="property-label"><g:message code="telefonePropriedade.numeroTelefonePropriedade.label" default="Numero Telefone Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="numeroTelefonePropriedade-label"><g:fieldValue bean="${telefonePropriedadeInstance}" field="numeroTelefonePropriedade"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${telefonePropriedadeInstance?.id}" />
					<g:link class="edit" action="edit" id="${telefonePropriedadeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
