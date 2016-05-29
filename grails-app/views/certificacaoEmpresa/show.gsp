
<%@ page import="rastrograo.empresa.CertificacaoEmpresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-certificacaoEmpresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-certificacaoEmpresa" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list certificacaoEmpresa">
			
				<g:if test="${certificacaoEmpresaInstance?.tipoCertificacao}">
				<li class="fieldcontain">
					<span id="tipoCertificacao-label" class="property-label"><g:message code="certificacaoEmpresa.tipoCertificacao.label" default="Tipo Certificacao" /></span>
					
						<span class="property-value" aria-labelledby="tipoCertificacao-label">${certificacaoEmpresaInstance?.tipoCertificacao?.encodeAsHTML()}
                                                        <g:link controller="tipoCertificacao" class="show" action="show" id="${certificacaoEmpresaInstance?.tipoCertificacao?.id}"></g:link>
                                                        <g:link controller="tipoCertificacao" class="edit" action="edit" id="${certificacaoEmpresaInstance?.tipoCertificacao?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${certificacaoEmpresaInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="certificacaoEmpresa.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label">${certificacaoEmpresaInstance?.empresa?.encodeAsHTML()}
                                                        <g:link controller="empresa" class="show" action="show" id="${certificacaoEmpresaInstance?.empresa?.id}"></g:link>
                                                        <g:link controller="empresa" class="edit" action="edit" id="${certificacaoEmpresaInstance?.empresa?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${certificacaoEmpresaInstance?.dataCertificacao}">
				<li class="fieldcontain">
					<span id="dataCertificacao-label" class="property-label"><g:message code="certificacaoEmpresa.dataCertificacao.label" default="Data Certificacao" /></span>
					
						<span class="property-value" aria-labelledby="dataCertificacao-label"><g:formatDate date="${certificacaoEmpresaInstance?.dataCertificacao}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${certificacaoEmpresaInstance?.observacao}">
				<li class="fieldcontain">
					<span id="observacao-label" class="property-label"><g:message code="certificacaoEmpresa.observacao.label" default="Observacao" /></span>
					
						<span class="property-value" aria-labelledby="observacao-label"><g:fieldValue bean="${certificacaoEmpresaInstance}" field="observacao"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${certificacaoEmpresaInstance?.id}" />
					<g:link class="edit" action="edit" id="${certificacaoEmpresaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
