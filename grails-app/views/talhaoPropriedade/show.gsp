
<%@ page import="rastrograo.propriedade.TalhaoPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-talhaoPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-talhaoPropriedade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list talhaoPropriedade">
			
				<g:if test="${talhaoPropriedadeInstance?.propriedade}">
				<li class="fieldcontain">
					<span id="propriedade-label" class="property-label"><g:message code="talhaoPropriedade.propriedade.label" default="Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="propriedade-label">${talhaoPropriedadeInstance?.propriedade?.encodeAsHTML()}
                                                        <g:link controller="propriedade" class="show" action="show" id="${talhaoPropriedadeInstance?.propriedade?.id}"></g:link>
                                                        <g:link controller="propriedade" class="edit" action="edit" id="${talhaoPropriedadeInstance?.propriedade?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${talhaoPropriedadeInstance?.descricaoTalhao}">
				<li class="fieldcontain">
					<span id="descricaoTalhao-label" class="property-label"><g:message code="talhaoPropriedade.descricaoTalhao.label" default="Descricao Talhao" /></span>
					
						<span class="property-value" aria-labelledby="descricaoTalhao-label"><g:fieldValue bean="${talhaoPropriedadeInstance}" field="descricaoTalhao"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${talhaoPropriedadeInstance?.haTalhao}">
				<li class="fieldcontain">
					<span id="haTalhao-label" class="property-label"><g:message code="talhaoPropriedade.haTalhao.label" default="Ha Talhao" /></span>
					
						<span class="property-value" aria-labelledby="haTalhao-label"><g:fieldValue bean="${talhaoPropriedadeInstance}" field="haTalhao"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${talhaoPropriedadeInstance?.latitudeTalhao}">
				<li class="fieldcontain">
					<span id="latitudeTalhao-label" class="property-label"><g:message code="talhaoPropriedade.latitudeTalhao.label" default="Latitude Talhao" /></span>
					
						<span class="property-value" aria-labelledby="latitudeTalhao-label"><g:fieldValue bean="${talhaoPropriedadeInstance}" field="latitudeTalhao"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${talhaoPropriedadeInstance?.longitudeTalhao}">
				<li class="fieldcontain">
					<span id="longitudeTalhao-label" class="property-label"><g:message code="talhaoPropriedade.longitudeTalhao.label" default="Longitude Talhao" /></span>
					
						<span class="property-value" aria-labelledby="longitudeTalhao-label"><g:fieldValue bean="${talhaoPropriedadeInstance}" field="longitudeTalhao"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${talhaoPropriedadeInstance?.id}" />
					<g:link class="edit" action="edit" id="${talhaoPropriedadeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                
                <g:render template="/fotoTalhaoPropriedade/listFotos"/>
                 
	</body>
</html>
