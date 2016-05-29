
<%@ page import="rastrograo.empresa.FotoEmpresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fotoEmpresa.label', default: 'FotoEmpresa')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-fotoEmpresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-fotoEmpresa" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list fotoEmpresa">
			
				<g:if test="${fotoEmpresaInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="fotoEmpresa.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label">${fotoEmpresaInstance?.empresa?.encodeAsHTML()}
                                                        <g:link controller="empresa" class="show" action="show" id="${fotoEmpresaInstance?.empresa?.id}"></g:link>
                                                        <g:link controller="empresa" class="edit" action="edit" id="${fotoEmpresaInstance?.empresa?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoEmpresaInstance?.tituloFoto}">
				<li class="fieldcontain">
					<span id="tituloFoto-label" class="property-label"><g:message code="fotoEmpresa.tituloFoto.label" default="Titulo Foto" /></span>
					
						<span class="property-value" aria-labelledby="tituloFoto-label"><g:fieldValue bean="${fotoEmpresaInstance}" field="tituloFoto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoEmpresaInstance?.foto}">
				<li class="fieldcontain">
					<span id="foto-label" class="property-label"><g:message code="fotoEmpresa.foto.label" default="Foto" /></span>
                                                <img src="${createLink(controller:'fotoEmpresa', action:'showFoto', id: fotoEmpresaInstance?.id)}"/>
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${fotoEmpresaInstance?.id}" />
					<g:link class="edit" action="edit" id="${fotoEmpresaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
