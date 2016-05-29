
<%@ page import="rastrograo.estrutura.Atributo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'atributo.label', default: 'Atributo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-atributo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-atributo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list atributo">
			
				<g:if test="${atributoInstance?.fase?.produto}">
				<li class="fieldcontain">
					<span id="produto-label" class="property-label"><g:message code="atributo.produto.label" default="Produto" /></span>
					
						<span class="property-value" aria-labelledby="produto-label">${atributoInstance?.fase?.produto?.encodeAsHTML()}
                                                        <g:link controller="produto" class="show" action="show" id="${atributoInstance?.fase?.produto?.id}"></g:link>
                                                        <g:link controller="produto" class="edit" action="edit" id="${atributoInstance?.fase?.produto?.id}"></g:link>
                                                </span> 
				</li>
				</g:if>
			
				<g:if test="${atributoInstance?.fase}">
				<li class="fieldcontain">
					<span id="fase-label" class="property-label"><g:message code="atributo.fase.label" default="Fase" /></span>
					
						<span class="property-value" aria-labelledby="fase-label">${atributoInstance?.fase?.encodeAsHTML()}
                                                        <g:link controller="fase" class="show" action="show" id="${atributoInstance?.fase?.id}"></g:link>
                                                        <g:link controller="fase" class="edit" action="edit" id="${atributoInstance?.fase?.id}"></g:link>
                                                </span> 
				</li>
				</g:if>
			
				<g:if test="${atributoInstance?.nomeAtributo}">
				<li class="fieldcontain">
					<span id="nomeAtributo-label" class="property-label"><g:message code="atributo.nomeAtributo.label" default="Nome Atributo" /></span>
					
						<span class="property-value" aria-labelledby="nomeAtributo-label"><g:fieldValue bean="${atributoInstance}" field="nomeAtributo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${atributoInstance?.descricaoAtributo}">
				<li class="fieldcontain">
					<span id="descricaoAtributo-label" class="property-label"><g:message code="atributo.descricaoAtributo.label" default="Descricao Atributo" /></span>
					
						<span class="property-value" aria-labelledby="descricaoAtributo-label"><g:fieldValue bean="${atributoInstance}" field="descricaoAtributo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${atributoInstance?.tipoAtributo}">
				<li class="fieldcontain">
					<span id="tipoAtributo-label" class="property-label"><g:message code="atributo.tipoAtributo.label" default="Tipo Atributo" /></span>
					
						<span class="property-value" aria-labelledby="tipoAtributo-label"><g:fieldValue bean="${atributoInstance}" field="tipoAtributo"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${atributoInstance?.id}" />
					<g:link class="edit" action="edit" id="${atributoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                
                <g:if test="${atributoInstance?.tipoAtributo.equals("Lista")}">
                    <g:render template="/listaAtributo/listListasAtributo"/>
                </g:if>
                
                <g:render template="listAtributos"/>
	</body>
</html>
