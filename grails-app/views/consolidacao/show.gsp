
<%@ page import="rastrograo.rastreamento.Consolidacao" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'consolidacao.label', default: 'Consolidacao')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-consolidacao" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-consolidacao" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list consolidacao">
			
				<g:if test="${consolidacaoInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="consolidacao.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label">${consolidacaoInstance?.empresa?.encodeAsHTML()}
                                                        <g:link controller="empresa" class="show" action="show" id="${consolidacaoInstance?.empresa?.id}"></g:link>
                                                        <g:link controller="empresa" class="edit" action="edit" id="${consolidacaoInstance?.empresa?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
                                
                                <g:if test="${consolidacaoInstance?.produto}">
				<li class="fieldcontain">
					<span id="produto-label" class="property-label"><g:message code="consolidacao.produto.label" default="Produto" /></span>
					
						<span class="property-value" aria-labelledby="produto-label">${consolidacaoInstance?.produto?.encodeAsHTML()}
                                                        <g:link controller="produto" class="show" action="show" id="${consolidacaoInstance?.produto?.id}"></g:link>
                                                        <g:link controller="produto" class="edit" action="edit" id="${consolidacaoInstance?.produto?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${consolidacaoInstance?.empresaOrigem}">
				<li class="fieldcontain">
					<span id="empresaOrigem-label" class="property-label"><g:message code="consolidacao.empresaOrigem.label" default="Empresa Origem" /></span>
					
						<span class="property-value" aria-labelledby="empresaOrigem-label">${consolidacaoInstance?.empresaOrigem?.encodeAsHTML()}
                                                        <g:link controller="empresa" class="show" action="show" id="${consolidacaoInstance?.empresaOrigem?.id}"></g:link>
                                                        <g:link controller="empresa" class="edit" action="edit" id="${consolidacaoInstance?.empresaOrigem?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
                                
                                <g:if test="${consolidacaoInstance?.propriedadeOrigem}">
				<li class="fieldcontain">
					<span id="propriedadeOrigem-label" class="property-label"><g:message code="consolidacao.propriedadeOrigem.label" default="Propriedade Origem" /></span>
					
						<span class="property-value" aria-labelledby="propriedadeOrigem-label">${consolidacaoInstance?.propriedadeOrigem?.encodeAsHTML()}
                                                        <g:link controller="propriedade" class="show" action="show" id="${consolidacaoInstance?.propriedadeOrigem?.id}"></g:link>
                                                        <g:link controller="propriedade" class="edit" action="edit" id="${consolidacaoInstance?.propriedadeOrigem?.id}"></g:link>
                                                </span>
					
				</li>
				</g:if>
			
				<g:if test="${consolidacaoInstance?.dataConsolidacao}">
				<li class="fieldcontain">
					<span id="dataConsolidacao-label" class="property-label"><g:message code="consolidacao.dataConsolidacao.label" default="Data Consolidacao" /></span>
					
						<span class="property-value" aria-labelledby="dataConsolidacao-label"><g:formatDate date="${consolidacaoInstance?.dataConsolidacao}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${consolidacaoInstance?.dataLoteOrigem}">
				<li class="fieldcontain">
					<span id="dataLoteOrigem-label" class="property-label"><g:message code="consolidacao.dataLoteOrigem.label" default="Data Lote Origem" /></span>
					
						<span class="property-value" aria-labelledby="dataLoteOrigem-label"><g:formatDate date="${consolidacaoInstance?.dataLoteOrigem}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${consolidacaoInstance?.validadeLoteOrigem}">
				<li class="fieldcontain">
					<span id="validadeLoteOrigem-label" class="property-label"><g:message code="consolidacao.validadeLoteOrigem.label" default="Validade Lote Origem" /></span>
					
						<span class="property-value" aria-labelledby="validadeLoteOrigem-label"><g:formatDate date="${consolidacaoInstance?.validadeLoteOrigem}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${consolidacaoInstance?.nrLoteConsolidado}">
				<li class="fieldcontain">
					<span id="nrLoteConsolidado-label" class="property-label"><g:message code="consolidacao.nrLoteConsolidado.label" default="Nr Lote Consolidado" /></span>
					
						<span class="property-value" aria-labelledby="nrLoteConsolidado-label"><g:fieldValue bean="${consolidacaoInstance}" field="nrLoteConsolidado"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${consolidacaoInstance?.volumeLoteOrigem}">
				<li class="fieldcontain">
					<span id="volumeLoteOrigem-label" class="property-label"><g:message code="consolidacao.volumeLoteOrigem.label" default="Volume Lote Origem" /></span>
					
						<span class="property-value" aria-labelledby="volumeLoteOrigem-label"><g:fieldValue bean="${consolidacaoInstance}" field="volumeLoteOrigem"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${consolidacaoInstance?.conservacao}">
				<li class="fieldcontain">
					<span id="conservacao-label" class="property-label"><g:message code="consolidacao.conservacao.label" default="Conservacao" /></span>
					
						<span class="property-value" aria-labelledby="conservacao-label"><g:fieldValue bean="${consolidacaoInstance}" field="conservacao"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${consolidacaoInstance?.observacao}">
				<li class="fieldcontain">
					<span id="observacao-label" class="property-label"><g:message code="consolidacao.observacao.label" default="Observacao" /></span>
					
						<span class="property-value" aria-labelledby="observacao-label"><g:fieldValue bean="${consolidacaoInstance}" field="observacao"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${consolidacaoInstance?.id}" />
					<g:link class="edit" action="edit" id="${consolidacaoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>                
	</body>
</html>
