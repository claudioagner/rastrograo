
<%@ page import="rastrograo.rastreamento.Lote" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'lote.label', default: 'Lote')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-lote" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-lote" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list lote">
			
				<g:if test="${loteInstance?.rastroProduto}">
				<li class="fieldcontain">
					<span id="rastroProduto-label" class="property-label"><g:message code="lote.rastroProduto.label" default="Rastro Produto" /></span>
					
						<span class="property-value" aria-labelledby="rastroProduto-label">${loteInstance?.rastroProduto?.encodeAsHTML()}
                                                        <g:link controller="rastroProduto" class="show" action="show" id="${loteInstance?.rastroProduto?.id}"></g:link>
                                                        <g:link controller="rastroProduto" class="edit" action="edit" id="${loteInstance?.rastroProduto?.id}"></g:link>
                                                </span>					
				</li>
				</g:if>
			
				<g:if test="${loteInstance?.dataLote}">
				<li class="fieldcontain">
					<span id="dataLote-label" class="property-label"><g:message code="lote.dataLote.label" default="Data Lote" /></span>
					
						<span class="property-value" aria-labelledby="dataLote-label"><g:formatDate date="${loteInstance?.dataLote}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loteInstance?.validadeLote}">
				<li class="fieldcontain">
					<span id="validadeLote-label" class="property-label"><g:message code="lote.validadeLote.label" default="Validade Lote" /></span>
					
						<span class="property-value" aria-labelledby="validadeLote-label"><g:formatDate date="${loteInstance?.validadeLote}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loteInstance?.nrLoteSequencial}">
				<li class="fieldcontain">
					<span id="nrLoteSequencial-label" class="property-label"><g:message code="lote.nrLoteSequencial.label" default="Nr Lote Sequencial" /></span>
					
						<span class="property-value" aria-labelledby="nrLoteSequencial-label"><g:formatBoolean boolean="${loteInstance?.nrLoteSequencial}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${loteInstance?.nrLoteManual}">
				<li class="fieldcontain">
					<span id="nrLoteManual-label" class="property-label"><g:message code="lote.nrLoteManual.label" default="Nr Lote Manual" /></span>
					
						<span class="property-value" aria-labelledby="nrLoteManual-label"><g:fieldValue bean="${loteInstance}" field="nrLoteManual"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loteInstance?.volumeLote}">
				<li class="fieldcontain">
					<span id="volumeLote-label" class="property-label"><g:message code="lote.volumeLote.label" default="Volume Lote" /></span>
					
						<span class="property-value" aria-labelledby="volumeLote-label"><g:fieldValue bean="${loteInstance}" field="volumeLote"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${loteInstance?.conservacao}">
				<li class="fieldcontain">
					<span id="conservacao-label" class="property-label"><g:message code="lote.conservacao.label" default="Conservacao" /></span>
					
						<span class="property-value" aria-labelledby="conservacao-label"><g:fieldValue bean="${loteInstance}" field="conservacao"/></span>
					
				</li>
				</g:if>
                                
				<g:if test="${loteInstance?.observacao}">
				<li class="fieldcontain">
					<span id="observacao-label" class="property-label"><g:message code="lote.observacao.label" default="Observacao" /></span>
					
						<span class="property-value" aria-labelledby="observacao-label"><g:fieldValue bean="${loteInstance}" field="observacao"/></span>
					
				</li>
				</g:if>
                                
                                <li class="fieldcontain">
                                    <span id="loteA9-label" class="property-label"><g:message code="lote.loteA9.label" default="LoteA9" /></span>

                                        <span>
                                            <g:jasperReport
                                                jasper="etiquetaA9"
                                                format="PDF"
                                                delimiter=" "
                                                name="EtiquetaA9">
                                                <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                <g:hiddenField name="loteId" value="${loteInstance?.id}" />
                                            </g:jasperReport>
                                        </span>

                                </li>
			
                                <li class="fieldcontain">
                                    <span id="loteA8-label" class="property-label"><g:message code="lote.loteA8.label" default="LoteA8" /></span>

                                        <span>
                                            <g:jasperReport
                                                jasper="etiquetaA8"
                                                format="PDF"
                                                delimiter=" "
                                                name="EtiquetaA8">
                                                <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                <g:hiddenField name="loteId" value="${loteInstance?.id}" />
                                            </g:jasperReport>
                                        </span>

                                </li>
			
                                <li class="fieldcontain">
                                    <span id="loteA7-label" class="property-label"><g:message code="lote.loteA7.label" default="LoteA7" /></span>

                                        <span>
                                            <g:jasperReport
                                                jasper="etiquetaA7"
                                                format="PDF"
                                                delimiter=" "
                                                name="EtiquetaA7">
                                                <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                <g:hiddenField name="loteId" value="${loteInstance?.id}" />
                                            </g:jasperReport>
                                        </span>

                                </li>
                                
                                <li class="fieldcontain">
                                    <span id="loteVarejoA7-label" class="property-label"><g:message code="lote.loteVarejoA7.label" default="LoteVarejoA7" /></span>

                                            <g:jasperReport
                                                jasper="etiquetaVarejoA7"
                                                format="PDF"
                                                delimiter=" "
                                                name="Etiqueta Varejo A7">
                                                <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                <g:hiddenField name="loteId" value="${loteInstance?.id}" />
                                            </g:jasperReport>
                                        

                                </li>
                                
                                <li class="fieldcontain">
                                    <span id="loteVarejoA5-label" class="property-label"><g:message code="lote.loteVarejoA5.label" default="LoteVarejoA5" /></span>

                                            <g:jasperReport
                                                jasper="etiquetaVarejoA5"
                                                format="PDF"
                                                delimiter=" "
                                                name="Etiqueta Varejo A5">
                                                <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                <g:hiddenField name="loteId" value="${loteInstance?.id}" />
                                            </g:jasperReport>
                                        

                                </li>
                                
                                <li class="fieldcontain">
                                    <span id="loteVarejoA4-label" class="property-label"><g:message code="lote.loteVarejoA4.label" default="LoteVarejoA4" /></span>

                                            <g:jasperReport
                                                jasper="etiquetaVarejoA4"
                                                format="PDF"
                                                delimiter=" "
                                                name="Etiqueta Varejo A4">
                                                <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                <g:hiddenField name="loteId" value="${loteInstance?.id}" />
                                            </g:jasperReport>
                                        

                                </li>
                                
			
				<g:if test="${loteInstance?.qrCodeImage}">
				<li class="fieldcontain">
					<span id="foto-label" class="property-label"><g:message code="lote.qrCodeImage.label" default="QrCode" /></span>
                                                <img src="${createLink(controller:'lote', action:'showQrCodeImage', id: loteInstance?.id)}"/>
				</li>
				</g:if>
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${loteInstance?.id}" />
					<g:link class="edit" action="edit" id="${loteInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>                    
	</body>
</html>
