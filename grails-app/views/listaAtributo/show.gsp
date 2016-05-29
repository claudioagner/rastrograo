
<%@ page import="rastrograo.estrutura.ListaAtributo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'listaAtributo.label', default: 'ListaAtributo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-listaAtributo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-listaAtributo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list listaAtributo">
                            
                                <g:if test="${listaAtributoInstance?.atributo?.fase?.produto}">
				<li class="fieldcontain">
					<span id="produto-label" class="property-label"><g:message code="atributo.produto.label" default="Produto" /></span>
					
						<span class="property-value" aria-labelledby="produto-label">${listaAtributoInstance?.atributo?.fase?.produto?.encodeAsHTML()}
                                                        <g:link controller="produto" class="show" action="show" id="${listaAtributoInstance?.atributo?.fase?.produto?.id}"></g:link>
                                                        <g:link controller="produto" class="edit" action="edit" id="${listaAtributoInstance?.atributo?.fase?.produto?.id}"></g:link>
                                                </span> 
					
				</li>
				</g:if>
                            
                                <g:if test="${listaAtributoInstance?.atributo?.fase}">
				<li class="fieldcontain">
					<span id="fase-label" class="property-label"><g:message code="atributo.fase.label" default="Fase" /></span>
					
						<span class="property-value" aria-labelledby="fase-label">${listaAtributoInstance?.atributo?.fase?.encodeAsHTML()}
                                                        <g:link controller="fase" class="show" action="show" id="${listaAtributoInstance?.atributo?.fase?.id}"></g:link>
                                                        <g:link controller="fase" class="edit" action="edit" id="${listaAtributoInstance?.atributo?.fase?.id}"></g:link>
                                                </span> 
					
				</li>
				</g:if>
			
				<g:if test="${listaAtributoInstance?.atributo}">
				<li class="fieldcontain">
					<span id="atributo-label" class="property-label"><g:message code="listaAtributo.atributo.label" default="Atributo" /></span>
					
						<span class="property-value" aria-labelledby="atributo-label">${listaAtributoInstance?.atributo?.encodeAsHTML()}
                                                        <g:link controller="atributo" class="show" action="show" id="${listaAtributoInstance?.atributo?.id}"></g:link>
                                                        <g:link controller="atributo" class="edit" action="edit" id="${listaAtributoInstance?.atributo?.id}"></g:link>
                                                </span> 
					
				</li>
				</g:if>
			
				<g:if test="${listaAtributoInstance?.valorListaAtributo}">
				<li class="fieldcontain">
					<span id="valorListaAtributo-label" class="property-label"><g:message code="listaAtributo.valorListaAtributo.label" default="Valor Lista Atributo" /></span>
					
						<span class="property-value" aria-labelledby="valorListaAtributo-label"><g:fieldValue bean="${listaAtributoInstance}" field="valorListaAtributo"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${listaAtributoInstance?.id}" />
					<g:link class="edit" action="edit" id="${listaAtributoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                
                <g:render template="listListasAtributo"/>
	</body>
</html>
