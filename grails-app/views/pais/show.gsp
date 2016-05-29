
<%@ page import="rastrograo.tabela.Pais" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pais.label', default: 'Pais')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-pais" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-pais" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list pais">
			
				<g:if test="${paisInstance?.nomePais}">
				<li class="fieldcontain">
					<span id="nomePais-label" class="property-label"><g:message code="pais.nomePais.label" default="Nome Pais" /></span>
					
						<span class="property-value" aria-labelledby="nomePais-label"><g:fieldValue bean="${paisInstance}" field="nomePais"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${paisInstance?.countryName}">
				<li class="fieldcontain">
					<span id="countryName-label" class="property-label"><g:message code="pais.countryName.label" default="Country Name" /></span>
					
						<span class="property-value" aria-labelledby="countryName-label"><g:fieldValue bean="${paisInstance}" field="countryName"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${paisInstance?.id}" />
					<g:link class="edit" action="edit" id="${paisInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                        
                <g:render template="/estado/listEstados"/>
                        
	</body>
</html>
