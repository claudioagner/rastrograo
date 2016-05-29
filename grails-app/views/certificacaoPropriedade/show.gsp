
<%@ page import="rastrograo.propriedade.CertificacaoPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'certificacaoPropriedade.label', default: 'CertificacaoPropriedade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-certificacaoPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-certificacaoPropriedade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list certificacaoPropriedade">
			
				<g:if test="${certificacaoPropriedadeInstance?.tipoCertificacao}">
				<li class="fieldcontain">
					<span id="tipoCertificacao-label" class="property-label"><g:message code="certificacaoPropriedade.tipoCertificacao.label" default="Tipo Certificacao" /></span>
					
						<span class="property-value" aria-labelledby="tipoCertificacao-label">${certificacaoPropriedadeInstance?.tipoCertificacao?.encodeAsHTML()}
                                                        <g:link controller="tipoCertificacao" class="show" action="show" id="${certificacaoPropriedadeInstance?.tipoCertificacao?.id}"></g:link>
                                                        <g:link controller="tipoCertificacao" class="edit" action="edit" id="${certificacaoPropriedadeInstance?.tipoCertificacao?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${certificacaoPropriedadeInstance?.propriedade}">
				<li class="fieldcontain">
					<span id="propriedade-label" class="property-label"><g:message code="certificacaoPropriedade.propriedade.label" default="Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="propriedade-label">${certificacaoPropriedadeInstance?.propriedade?.encodeAsHTML()}
                                                        <g:link controller="propriedade" class="show" action="show" id="${certificacaoPropriedadeInstance?.propriedade?.id}"></g:link>
                                                        <g:link controller="propriedade" class="edit" action="edit" id="${certificacaoPropriedadeInstance?.propriedade?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${certificacaoPropriedadeInstance?.dataCertificacao}">
				<li class="fieldcontain">
					<span id="dataCertificacao-label" class="property-label"><g:message code="certificacaoPropriedade.dataCertificacao.label" default="Data Certificacao" /></span>
					
						<span class="property-value" aria-labelledby="dataCertificacao-label"><g:formatDate date="${certificacaoPropriedadeInstance?.dataCertificacao}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${certificacaoPropriedadeInstance?.observacao}">
				<li class="fieldcontain">
					<span id="observacao-label" class="property-label"><g:message code="certificacaoPropriedade.observacao.label" default="Observacao" /></span>
					
						<span class="property-value" aria-labelledby="observacao-label"><g:fieldValue bean="${certificacaoPropriedadeInstance}" field="observacao"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${certificacaoPropriedadeInstance?.id}" />
					<g:link class="edit" action="edit" id="${certificacaoPropriedadeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
