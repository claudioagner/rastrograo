
<%@ page import="rastrograo.empresa.TelefoneEmpresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-telefoneEmpresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-telefoneEmpresa" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list telefoneEmpresa">
			
				<g:if test="${telefoneEmpresaInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="telefoneEmpresa.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label">${telefoneEmpresaInstance?.empresa?.encodeAsHTML()}
                                                        <g:link controller="empresa" class="show" action="show" id="${telefoneEmpresaInstance?.empresa?.id}"></g:link>
                                                        <g:link controller="empresa" class="edit" action="edit" id="${telefoneEmpresaInstance?.empresa?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${telefoneEmpresaInstance?.dddEmpresa}">
				<li class="fieldcontain">
					<span id="dddEmpresa-label" class="property-label"><g:message code="telefoneEmpresa.dddEmpresa.label" default="Ddd Empresa" /></span>
					
						<span class="property-value" aria-labelledby="dddEmpresa-label"><g:fieldValue bean="${telefoneEmpresaInstance}" field="dddEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${telefoneEmpresaInstance?.numeroTelefoneEmpresa}">
				<li class="fieldcontain">
					<span id="numeroTelefoneEmpresa-label" class="property-label"><g:message code="telefoneEmpresa.numeroTelefoneEmpresa.label" default="Numero Telefone Empresa" /></span>
					
						<span class="property-value" aria-labelledby="numeroTelefoneEmpresa-label"><g:fieldValue bean="${telefoneEmpresaInstance}" field="numeroTelefoneEmpresa"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${telefoneEmpresaInstance?.id}" />
					<g:link class="edit" action="edit" id="${telefoneEmpresaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
