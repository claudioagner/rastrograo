
<%@ page import="rastrograo.propriedade.Propriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'propriedade.label', default: 'Propriedade')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-propriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-propriedade" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list propriedade">
			
				<g:if test="${propriedadeInstance?.porte}">
				<li class="fieldcontain">
					<span id="porte-label" class="property-label"><g:message code="propriedade.porte.label" default="Porte" /></span>
					
						<span class="property-value" aria-labelledby="porte-label"><g:fieldValue bean="${propriedadeInstance}" field="porte"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.tipoPropriedade}">
				<li class="fieldcontain">
					<span id="tipoPropriedade-label" class="property-label"><g:message code="propriedade.tipoPropriedade.label" default="Tipo Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="tipoPropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="tipoPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.cnpj}">
				<li class="fieldcontain">
					<span id="cnpj-label" class="property-label"><g:message code="propriedade.cnpj.label" default="Cnpj" /></span>
					
						<span class="property-value" aria-labelledby="cnpj-label"><g:fieldValue bean="${propriedadeInstance}" field="cnpj"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.cpf}">
				<li class="fieldcontain">
					<span id="cpf-label" class="property-label"><g:message code="propriedade.cpf.label" default="Cpf" /></span>
					
						<span class="property-value" aria-labelledby="cpf-label"><g:fieldValue bean="${propriedadeInstance}" field="cpf"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.inscricaoEstadual}">
				<li class="fieldcontain">
					<span id="inscricaoEstadual-label" class="property-label"><g:message code="propriedade.inscricaoEstadual.label" default="Inscricao Estadual" /></span>
					
						<span class="property-value" aria-labelledby="inscricaoEstadual-label"><g:fieldValue bean="${propriedadeInstance}" field="inscricaoEstadual"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.nomePropriedade}">
				<li class="fieldcontain">
					<span id="nomePropriedade-label" class="property-label"><g:message code="propriedade.nomePropriedade.label" default="Nome Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="nomePropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="nomePropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.nomeFantasiaPropriedade}">
				<li class="fieldcontain">
					<span id="nomeFantasiaPropriedade-label" class="property-label"><g:message code="propriedade.nomeFantasiaPropriedade.label" default="Nome Fantasia Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="nomeFantasiaPropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="nomeFantasiaPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.emailPropriedade}">
				<li class="fieldcontain">
					<span id="emailPropriedade-label" class="property-label"><g:message code="propriedade.emailPropriedade.label" default="Email Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="emailPropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="emailPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.cidade?.estado?.pais}">
				<li class="fieldcontain">
					<span id="pais-label" class="property-label"><g:message code="estado.pais.label" default="Pais" /></span>
					
						<span class="property-value" aria-labelledby="pais-label">${propriedadeInstance?.cidade?.estado?.pais?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.cidade?.estado}">
				<li class="fieldcontain">
					<span id="estado-label" class="property-label"><g:message code="cidade.estado.label" default="Estado" /></span>
					
						<span class="property-value" aria-labelledby="estado-label">${propriedadeInstance?.cidade?.estado?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.cidade}">
				<li class="fieldcontain">
					<span id="cidade-label" class="property-label"><g:message code="propriedade.cidade.label" default="Cidade" /></span>
					
						<span class="property-value" aria-labelledby="cidade-label">${propriedadeInstance?.cidade?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.logradouroPropriedade}">
				<li class="fieldcontain">
					<span id="logradouroPropriedade-label" class="property-label"><g:message code="propriedade.logradouroPropriedade.label" default="Logradouro Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="logradouroPropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="logradouroPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.bairroPropriedade}">
				<li class="fieldcontain">
					<span id="bairroPropriedade-label" class="property-label"><g:message code="propriedade.bairroPropriedade.label" default="Bairro Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="bairroPropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="bairroPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.numeroPropriedade}">
				<li class="fieldcontain">
					<span id="numeroPropriedade-label" class="property-label"><g:message code="propriedade.numeroPropriedade.label" default="Numero Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="numeroPropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="numeroPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.cepPropriedade}">
				<li class="fieldcontain">
					<span id="cepPropriedade-label" class="property-label"><g:message code="propriedade.cepPropriedade.label" default="Cep Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="cepPropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="cepPropriedade"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${propriedadeInstance?.complementoPropriedade}">
				<li class="fieldcontain">
					<span id="complementoPropriedade-label" class="property-label"><g:message code="propriedade.complementoPropriedade.label" default="Complemento Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="complementoPropriedade-label"><g:fieldValue bean="${propriedadeInstance}" field="complementoPropriedade"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${propriedadeInstance?.id}" />
					<g:link class="edit" action="edit" id="${propriedadeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
                
                <g:render template="/certificacaoPropriedade/listCertificados"/>
                <g:render template="/fotoPropriedade/listFotos"/>
                <g:render template="/responsavelPropriedade/listResponsaveis"/>
                <g:render template="/talhaoPropriedade/listTalhoes"/>
                <g:render template="/telefonePropriedade/listTelefones"/>
                
	</body>
</html>
