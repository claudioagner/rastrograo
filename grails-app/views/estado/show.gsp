
<%@ page import="rastrograo.tabela.Estado" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'estado.label', default: 'Estado')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-estado" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-estado" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list estado">
			
				<g:if test="${estadoInstance?.pais}">
				<li class="fieldcontain">
					<span id="pais-label" class="property-label"><g:message code="estado.pais.label" default="Pais" /></span>
					
						<span class="property-value" aria-labelledby="pais-label">${estadoInstance?.pais?.encodeAsHTML()}
                                                        <g:link controller="pais" class="show" action="show" id="${estadoInstance?.pais?.id}"></g:link>
                                                        <g:link controller="pais" class="edit" action="edit" id="${estadoInstance?.pais?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${estadoInstance?.nomeEstado}">
				<li class="fieldcontain">
					<span id="nomeEstado-label" class="property-label"><g:message code="estado.nomeEstado.label" default="Nome Estado" /></span>
					
						<span class="property-value" aria-labelledby="nomeEstado-label"><g:fieldValue bean="${estadoInstance}" field="nomeEstado"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${estadoInstance?.sigla}">
				<li class="fieldcontain">
					<span id="sigla-label" class="property-label"><g:message code="estado.sigla.label" default="Sigla" /></span>
					
						<span class="property-value" aria-labelledby="sigla-label"><g:fieldValue bean="${estadoInstance}" field="sigla"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${estadoInstance?.id}" />
					<g:link class="edit" action="edit" id="${estadoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                
                <g:render template="/cidade/listCidades"/>
                      
	</body>
</html>
