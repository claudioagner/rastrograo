
<%@ page import="rastrograo.empresa.ResponsavelEmpresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-responsavelEmpresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-responsavelEmpresa" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list responsavelEmpresa">
			
				<g:if test="${responsavelEmpresaInstance?.tipoResponsavel}">
				<li class="fieldcontain">
					<span id="tipoResponsavel-label" class="property-label"><g:message code="responsavelEmpresa.tipoResponsavel.label" default="Tipo Responsavel" /></span>
					
						<span class="property-value" aria-labelledby="tipoResponsavel-label">${responsavelEmpresaInstance?.tipoResponsavel?.encodeAsHTML()}
                                                        <g:link controller="tipoResponsavel" class="show" action="show" id="${responsavelEmpresaInstance?.tipoResponsavel?.id}"></g:link>
                                                        <g:link controller="tipoResponsavel" class="edit" action="edit" id="${responsavelEmpresaInstance?.tipoResponsavel?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${responsavelEmpresaInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="responsavelEmpresa.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label">${responsavelEmpresaInstance?.empresa?.encodeAsHTML()}
                                                        <g:link controller="empresa" class="show" action="show" id="${responsavelEmpresaInstance?.empresa?.id}"></g:link>
                                                        <g:link controller="empresa" class="edit" action="edit" id="${responsavelEmpresaInstance?.empresa?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${responsavelEmpresaInstance?.nomeResponsavelEmpresa}">
				<li class="fieldcontain">
					<span id="nomeResponsavelEmpresa-label" class="property-label"><g:message code="responsavelEmpresa.nomeResponsavelEmpresa.label" default="Nome Responsavel Empresa" /></span>
					
						<span class="property-value" aria-labelledby="nomeResponsavelEmpresa-label"><g:fieldValue bean="${responsavelEmpresaInstance}" field="nomeResponsavelEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${responsavelEmpresaInstance?.dddResponsavelEmpresa}">
				<li class="fieldcontain">
					<span id="dddResponsavelEmpresa-label" class="property-label"><g:message code="responsavelEmpresa.dddResponsavelEmpresa.label" default="Ddd Responsavel Empresa" /></span>
					
						<span class="property-value" aria-labelledby="dddResponsavelEmpresa-label"><g:fieldValue bean="${responsavelEmpresaInstance}" field="dddResponsavelEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${responsavelEmpresaInstance?.numeroTelefoneResponsavelEmpresa}">
				<li class="fieldcontain">
					<span id="numeroTelefoneResponsavelEmpresa-label" class="property-label"><g:message code="responsavelEmpresa.numeroTelefoneResponsavelEmpresa.label" default="Numero Telefone Responsavel Empresa" /></span>
					
						<span class="property-value" aria-labelledby="numeroTelefoneResponsavelEmpresa-label"><g:fieldValue bean="${responsavelEmpresaInstance}" field="numeroTelefoneResponsavelEmpresa"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${responsavelEmpresaInstance?.id}" />
					<g:link class="edit" action="edit" id="${responsavelEmpresaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
