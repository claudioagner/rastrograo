
<%@ page import="rastrograo.seguranca.Acesso" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'acesso.label', default: 'Acesso')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-acesso" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-acesso" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list acesso">
			
				<g:if test="${acessoInstance?.username}">
				<li class="fieldcontain">
					<span id="username-label" class="property-label"><g:message code="acesso.username.label" default="Username" /></span>
					
						<span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${acessoInstance}" field="username"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${acessoInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="acesso.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${acessoInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				
				<li class="fieldcontain">
					<span id="passwordExpired-label" class="property-label"><g:message code="acesso.passwordExpired.label" default="Password Expired" /></span>
					
						<span class="property-value" aria-labelledby="passwordExpired-label"><g:formatBoolean boolean="${acessoInstance?.passwordExpired}" /></span>
					
				</li>
				
			
				
				<li class="fieldcontain">
					<span id="accountExpired-label" class="property-label"><g:message code="acesso.accountExpired.label" default="Account Expired" /></span>
					
						<span class="property-value" aria-labelledby="accountExpired-label"><g:formatBoolean boolean="${acessoInstance?.accountExpired}" /></span>
					
				</li>
				
			
				
				<li class="fieldcontain">
					<span id="accountLocked-label" class="property-label"><g:message code="acesso.accountLocked.label" default="Account Locked" /></span>
					
						<span class="property-value" aria-labelledby="accountLocked-label"><g:formatBoolean boolean="${acessoInstance?.accountLocked}" /></span>
					
				</li>
				
			
				
				<li class="fieldcontain">
					<span id="enabled-label" class="property-label"><g:message code="acesso.enabled.label" default="Enabled" /></span>
					
						<span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean boolean="${acessoInstance?.enabled}" /></span>
					
				</li>
				
			
				<g:if test="${acessoInstance?.authorities}">
				<li class="fieldcontain">
					<span id="authorities-label" class="property-label"><g:message code="acesso.authorities.label" default="Authorities" /></span>
					
						<g:each in="${acessoInstance.authorities}" var="p">
                                                        <span class="property-value" aria-labelledby="authorities-label">${p?.encodeAsHTML()}</span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${acessoInstance?.empresas}">
				<li class="fieldcontain">
					<span id="empresas-label" class="property-label"><g:message code="acesso.empresas.label" default="Empresas" /></span>
					
						<g:each in="${acessoInstance.empresas}" var="p">
                                                        <span class="property-value" aria-labelledby="empresas-label">${p?.encodeAsHTML()}</span>
						</g:each>
					
				</li>
				</g:if>
			
                                <g:if test="${acessoInstance?.propriedades}">
				<li class="fieldcontain">
					<span id="propriedades-label" class="property-label"><g:message code="acesso.propriedades.label" default="Propriedades" /></span>
					
						<g:each in="${acessoInstance.propriedades}" var="p">
                                                        <span class="property-value" aria-labelledby="propriedades-label">${p?.encodeAsHTML()}</span>
						</g:each>
					
				</li>
				</g:if>
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${acessoInstance?.id}" />
					<g:link class="edit" action="edit" id="${acessoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
