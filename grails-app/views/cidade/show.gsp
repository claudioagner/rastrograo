
<%@ page import="rastrograo.tabela.Cidade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cidade.label', default: 'Cidade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-cidade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-cidade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list cidade">
			
				<g:if test="${cidadeInstance?.estado?.pais}">
				<li class="fieldcontain">
					<span id="pais-label" class="property-label"><g:message code="estado.pais.label" default="Pais" /></span>
					
						<span class="property-value" aria-labelledby="pais-label">${cidadeInstance?.estado?.pais?.encodeAsHTML()}
                                                        <g:link controller="pais" class="show" action="show" id="${cidadeInstance?.estado?.pais?.id}"></g:link>
                                                        <g:link controller="pais" class="edit" action="edit" id="${cidadeInstance?.estado?.pais?.id}"></g:link>
                                                </span>                                              
					
				</li>
				</g:if>
			
				<g:if test="${cidadeInstance?.estado}">
				<li class="fieldcontain">
					<span id="estado-label" class="property-label"><g:message code="cidade.estado.label" default="Estado" /></span>
					
                                                <span class="property-value" aria-labelledby="estado-label">${cidadeInstance?.estado?.encodeAsHTML()}
                                                        <g:link controller="estado" class="show" action="show" id="${cidadeInstance?.estado?.id}"></g:link>
                                                        <g:link controller="estado" class="edit" action="edit" id="${cidadeInstance?.estado?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${cidadeInstance?.nomeCidade}">
				<li class="fieldcontain">
					<span id="nomeCidade-label" class="property-label"><g:message code="cidade.nomeCidade.label" default="Nome Cidade" /></span>
					
						<span class="property-value" aria-labelledby="nomeCidade-label"><g:fieldValue bean="${cidadeInstance}" field="nomeCidade"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${cidadeInstance?.id}" />
					<g:link class="edit" action="edit" id="${cidadeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
