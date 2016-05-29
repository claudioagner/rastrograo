
<%@ page import="rastrograo.propriedade.ResponsavelPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-responsavelPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-responsavelPropriedade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list responsavelPropriedade">
			
				<g:if test="${responsavelPropriedadeInstance?.tipoResponsavel}">
				<li class="fieldcontain">
					<span id="tipoResponsavel-label" class="property-label"><g:message code="responsavelPropriedade.tipoResponsavel.label" default="Tipo Responsavel" /></span>
					
						<span class="property-value" aria-labelledby="tipoResponsavel-label">${responsavelPropriedadeInstance?.tipoResponsavel?.encodeAsHTML()}
                                                        <g:link controller="tipoResponsavel" class="show" action="show" id="${responsavelPropriedadeInstance?.tipoResponsavel?.id}"></g:link>
                                                        <g:link controller="tipoResponsavel" class="edit" action="edit" id="${responsavelPropriedadeInstance?.tipoResponsavel?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${responsavelPropriedadeInstance?.propriedade}">
				<li class="fieldcontain">
					<span id="propriedade-label" class="property-label"><g:message code="responsavelPropriedade.propriedade.label" default="Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="propriedade-label">${responsavelPropriedadeInstance?.propriedade?.encodeAsHTML()}
                                                        <g:link controller="propriedade" class="show" action="show" id="${responsavelPropriedadeInstance?.propriedade?.id}"></g:link>
                                                        <g:link controller="propriedade" class="edit" action="edit" id="${responsavelPropriedadeInstance?.propriedade?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${responsavelPropriedadeInstance?.nomeResponsavelPropriedade}">
				<li class="fieldcontain">
					<span id="nomeResponsavelPropriedade-label" class="property-label"><g:message code="responsavelPropriedade.nomeResponsavelPropriedade.label" default="Nome Responsavel Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="nomeResponsavelPropriedade-label"><g:fieldValue bean="${responsavelPropriedadeInstance}" field="nomeResponsavelPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${responsavelPropriedadeInstance?.dddResponsavelPropriedade}">
				<li class="fieldcontain">
					<span id="dddResponsavelPropriedade-label" class="property-label"><g:message code="responsavelPropriedade.dddResponsavelPropriedade.label" default="Ddd Responsavel Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="dddResponsavelPropriedade-label"><g:fieldValue bean="${responsavelPropriedadeInstance}" field="dddResponsavelPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${responsavelPropriedadeInstance?.numeroTelefoneResponsavelPropriedade}">
				<li class="fieldcontain">
					<span id="numeroTelefoneResponsavelPropriedade-label" class="property-label"><g:message code="responsavelPropriedade.numeroTelefoneResponsavelPropriedade.label" default="Numero Telefone Responsavel Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="numeroTelefoneResponsavelPropriedade-label"><g:fieldValue bean="${responsavelPropriedadeInstance}" field="numeroTelefoneResponsavelPropriedade"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${responsavelPropriedadeInstance?.id}" />
					<g:link class="edit" action="edit" id="${responsavelPropriedadeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
