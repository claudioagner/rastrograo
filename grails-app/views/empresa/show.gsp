
<%@ page import="rastrograo.empresa.Empresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-empresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-empresa" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list empresa">
			
				<g:if test="${empresaInstance?.tipoEmpresa}">
				<li class="fieldcontain">
					<span id="tipoEmpresa-label" class="property-label"><g:message code="empresa.tipoEmpresa.label" default="Tipo Empresa" /></span>
					
						<span class="property-value" aria-labelledby="tipoEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="tipoEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.cnpj}">
				<li class="fieldcontain">
					<span id="cnpj-label" class="property-label"><g:message code="empresa.cnpj.label" default="Cnpj" /></span>
					
						<span class="property-value" aria-labelledby="cnpj-label"><g:fieldValue bean="${empresaInstance}" field="cnpj"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.cpf}">
				<li class="fieldcontain">
					<span id="cpf-label" class="property-label"><g:message code="empresa.cpf.label" default="Cpf" /></span>
					
						<span class="property-value" aria-labelledby="cpf-label"><g:fieldValue bean="${empresaInstance}" field="cpf"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.inscricaoEstadual}">
				<li class="fieldcontain">
					<span id="inscricaoEstadual-label" class="property-label"><g:message code="empresa.inscricaoEstadual.label" default="Inscricao Estadual" /></span>
					
						<span class="property-value" aria-labelledby="inscricaoEstadual-label"><g:fieldValue bean="${empresaInstance}" field="inscricaoEstadual"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.nomeEmpresa}">
				<li class="fieldcontain">
					<span id="nomeEmpresa-label" class="property-label"><g:message code="empresa.nomeEmpresa.label" default="Nome Empresa" /></span>
					
						<span class="property-value" aria-labelledby="nomeEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="nomeEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.nomeFantasiaEmpresa}">
				<li class="fieldcontain">
					<span id="nomeFantasiaEmpresa-label" class="property-label"><g:message code="empresa.nomeFantasiaEmpresa.label" default="Nome Fantasia Empresa" /></span>
					
						<span class="property-value" aria-labelledby="nomeFantasiaEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="nomeFantasiaEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.emailEmpresa}">
				<li class="fieldcontain">
					<span id="emailEmpresa-label" class="property-label"><g:message code="empresa.emailEmpresa.label" default="Email Empresa" /></span>
					
						<span class="property-value" aria-labelledby="emailEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="emailEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.cidade?.estado?.pais}">
				<li class="fieldcontain">
					<span id="pais-label" class="property-label"><g:message code="estado.pais.label" default="Pais" /></span>
					
						<span class="property-value" aria-labelledby="pais-label">${empresaInstance?.cidade?.estado?.pais?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.cidade?.estado}">
				<li class="fieldcontain">
					<span id="estado-label" class="property-label"><g:message code="cidade.estado.label" default="Estado" /></span>
					
						<span class="property-value" aria-labelledby="estado-label">${empresaInstance?.cidade?.estado?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.cidade}">
				<li class="fieldcontain">
					<span id="cidade-label" class="property-label"><g:message code="empresa.cidade.label" default="Cidade" /></span>
					
						<span class="property-value" aria-labelledby="cidade-label">${empresaInstance?.cidade?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.logradouroEmpresa}">
				<li class="fieldcontain">
					<span id="logradouroEmpresa-label" class="property-label"><g:message code="empresa.logradouroEmpresa.label" default="Logradouro Empresa" /></span>
					
						<span class="property-value" aria-labelledby="logradouroEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="logradouroEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.bairroEmpresa}">
				<li class="fieldcontain">
					<span id="bairroEmpresa-label" class="property-label"><g:message code="empresa.bairroEmpresa.label" default="Bairro Empresa" /></span>
					
						<span class="property-value" aria-labelledby="bairroEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="bairroEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.numeroEmpresa}">
				<li class="fieldcontain">
					<span id="numeroEmpresa-label" class="property-label"><g:message code="empresa.numeroEmpresa.label" default="Numero Empresa" /></span>
					
						<span class="property-value" aria-labelledby="numeroEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="numeroEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.cepEmpresa}">
				<li class="fieldcontain">
					<span id="cepEmpresa-label" class="property-label"><g:message code="empresa.cepEmpresa.label" default="Cep Empresa" /></span>
					
						<span class="property-value" aria-labelledby="cepEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="cepEmpresa"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${empresaInstance?.complementoEmpresa}">
				<li class="fieldcontain">
					<span id="complementoEmpresa-label" class="property-label"><g:message code="empresa.complementoEmpresa.label" default="Complemento Empresa" /></span>
					
						<span class="property-value" aria-labelledby="complementoEmpresa-label"><g:fieldValue bean="${empresaInstance}" field="complementoEmpresa"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${empresaInstance?.id}" />
					<g:link class="edit" action="edit" id="${empresaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                
                <g:render template="/certificacaoEmpresa/listCertificados"/>
                <g:render template="/fotoEmpresa/listFotos"/>
                <g:render template="/responsavelEmpresa/listResponsaveis"/>
                <g:render template="/telefoneEmpresa/listTelefones"/>
                 
	</body>
</html>
