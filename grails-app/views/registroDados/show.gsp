
<%@ page import="rastrograo.dados.RegistroDados" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'registroDados.label', default: 'RegistroDados')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-registroDados" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-registroDados" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list registroDados">
			
                                <g:if test="${registroDadosInstance?.rastroAtributo?.rastroFase?.rastroProduto}">
				<li class="fieldcontain">
					<span id="rastroProduto-label" class="property-label"><g:message code="registroDados.rastroProduto.label" default="Rastro Produto" /></span>
					
						<span class="property-value" aria-labelledby="rastroProduto-label">${registroDadosInstance?.rastroAtributo?.rastroFase?.rastroProduto?.encodeAsHTML()}
                                                        <g:link controller="rastroProduto" class="show" action="show" id="${registroDadosInstance?.rastroAtributo?.rastroFase?.rastroProduto?.id}"></g:link>
                                                        <g:link controller="rastroProduto" class="edit" action="edit" id="${registroDadosInstance?.rastroAtributo?.rastroFase?.rastroProduto?.id}"></g:link>
                                                </span>  
					
				</li>
				</g:if>
                                
                                <g:if test="${registroDadosInstance?.rastroAtributo?.rastroFase}">
				<li class="fieldcontain">
					<span id="rastroFase-label" class="property-label"><g:message code="registroDados.rastroFase.label" default="Rastro Fase" /></span>
					
						<span class="property-value" aria-labelledby="rastroFase-label">${registroDadosInstance?.rastroAtributo?.rastroFase?.encodeAsHTML()}</span>  
					
				</li>
				</g:if>
                                
				<g:if test="${registroDadosInstance?.rastroAtributo}">
				<li class="fieldcontain">
					<span id="rastroAtributo-label" class="property-label"><g:message code="registroDados.rastroAtributo.label" default="Rastro Atributo" /></span>
					
						<span class="property-value" aria-labelledby="rastroAtributo-label">${registroDadosInstance?.rastroAtributo?.encodeAsHTML()}</span>  
					
				</li>
				</g:if>
			
				<g:if test="${registroDadosInstance?.valorAtributo}">
				<li class="fieldcontain">
					<span id="valorAtributo-label" class="property-label"><g:message code="registroDados.valorAtributo.label" default="Valor Atributo" /></span>
					
						<span class="property-value" aria-labelledby="valorAtributo-label"><g:fieldValue bean="${registroDadosInstance}" field="valorAtributo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${registroDadosInstance?.valorDataAtributo}">
				<li class="fieldcontain">
					<span id="valorDataAtributo-label" class="property-label"><g:message code="registroDados.valorDataAtributo.label" default="Valor Data Atributo" /></span>
					
						<span class="property-value" aria-labelledby="valorDataAtributo-label"><g:formatDate date="${registroDadosInstance?.valorDataAtributo}"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${registroDadosInstance?.valorListaAtributo}">
				<li class="fieldcontain">
					<span id="valorListaAtributo-label" class="property-label"><g:message code="registroDados.valorListaAtributo.label" default="Valor Lista Atributo" /></span>
					
						<span class="property-value" aria-labelledby="valorListaAtributo-label">${registroDadosInstance?.valorListaAtributo?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${registroDadosInstance?.comentarioAtributo}">
				<li class="fieldcontain">
					<span id="comentarioAtributo-label" class="property-label"><g:message code="registroDados.comentarioAtributo.label" default="Comentario Atributo" /></span>
					
						<span class="property-value" aria-labelledby="comentarioAtributo-label"><g:fieldValue bean="${registroDadosInstance}" field="comentarioAtributo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${registroDadosInstance?.dataCriado}">
				<li class="fieldcontain">
					<span id="dataCriado-label" class="property-label"><g:message code="registroDados.dataCriado.label" default="Data Criado" /></span>
					
						<span class="property-value" aria-labelledby="dataCriado-label"><g:formatDate date="${registroDadosInstance?.dataCriado}" format="dd/MM/yyyy HH:mm"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${registroDadosInstance?.dataAlterado}">
				<li class="fieldcontain">
					<span id="dataAlterado-label" class="property-label"><g:message code="registroDados.dataAlterado.label" default="Data Alterado" /></span>
					
						<span class="property-value" aria-labelledby="dataAlterado-label"><g:formatDate date="${registroDadosInstance?.dataAlterado}" format="dd/MM/yyyy HH:mm"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${registroDadosInstance?.id}" />
					<g:link class="edit" action="edit" id="${registroDadosInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
