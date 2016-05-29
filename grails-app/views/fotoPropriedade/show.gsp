
<%@ page import="rastrograo.propriedade.FotoPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fotoPropriedade.label', default: 'FotoPropriedade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-fotoPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-fotoPropriedade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list fotoPropriedade">
			
				<g:if test="${fotoPropriedadeInstance?.propriedade}">
				<li class="fieldcontain">
					<span id="propriedade-label" class="property-label"><g:message code="fotoPropriedade.propriedade.label" default="Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="propriedade-label">${fotoPropriedadeInstance?.propriedade?.encodeAsHTML()}
                                                        <g:link controller="propriedade" class="show" action="show" id="${fotoPropriedadeInstance?.propriedade?.id}"></g:link>
                                                        <g:link controller="propriedade" class="edit" action="edit" id="${fotoPropriedadeInstance?.propriedade?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoPropriedadeInstance?.tituloFoto}">
				<li class="fieldcontain">
					<span id="tituloFoto-label" class="property-label"><g:message code="fotoPropriedade.tituloFoto.label" default="Titulo Foto" /></span>
					
						<span class="property-value" aria-labelledby="tituloFoto-label"><g:fieldValue bean="${fotoPropriedadeInstance}" field="tituloFoto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoPropriedadeInstance?.foto}">
				<li class="fieldcontain">
					<span id="foto-label" class="property-label"><g:message code="fotoPropriedade.foto.label" default="Foto" /></span>
                                                <img src="${createLink(controller:'fotoPropriedade', action:'showFoto', id: fotoPropriedadeInstance?.id)}"/>
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${fotoPropriedadeInstance?.id}" />
					<g:link class="edit" action="edit" id="${fotoPropriedadeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
