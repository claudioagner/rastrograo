
<%@ page import="rastrograo.propriedade.FotoTalhaoPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-fotoTalhaoPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-fotoTalhaoPropriedade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list fotoTalhaoPropriedade">
			
				<g:if test="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade}">
				<li class="fieldcontain">
					<span id="propriedade-label" class="property-label"><g:message code="fotoTalhaoPropriedade.propriedade.label" default="Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="propriedade-label">${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade?.encodeAsHTML()}
                                                        <g:link controller="propriedade" class="show" action="show" id="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade?.id}"></g:link>
                                                        <g:link controller="propriedade" class="edit" action="edit" id="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade}">
				<li class="fieldcontain">
					<span id="talhaoPropriedade-label" class="property-label"><g:message code="fotoTalhaoPropriedade.talhaoPropriedade.label" default="Talhao Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="talhaoPropriedade-label">${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.encodeAsHTML()}
                                                        <g:link controller="talhaoPropriedade" class="show" action="show" id="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.id}"></g:link>
                                                        <g:link controller="talhaoPropriedade" class="edit" action="edit" id="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoTalhaoPropriedadeInstance?.tituloFoto}">
				<li class="fieldcontain">
					<span id="tituloFoto-label" class="property-label"><g:message code="fotoTalhaoPropriedade.tituloFoto.label" default="Titulo Foto" /></span>
					
						<span class="property-value" aria-labelledby="tituloFoto-label"><g:fieldValue bean="${fotoTalhaoPropriedadeInstance}" field="tituloFoto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${fotoTalhaoPropriedadeInstance?.foto}">
				<li class="fieldcontain">
					<span id="foto-label" class="property-label"><g:message code="fotoTalhaoPropriedade.foto.label" default="Foto" /></span>
					<img src="${createLink(controller:'fotoTalhaoPropriedade', action:'showFoto', id: fotoTalhaoPropriedadeInstance?.id)}"/>
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${fotoTalhaoPropriedadeInstance?.id}" />
					<g:link class="edit" action="edit" id="${fotoTalhaoPropriedadeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
