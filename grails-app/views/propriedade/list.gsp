
<%@ page import="rastrograo.propriedade.Propriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'propriedade.label', default: 'Propriedade')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-propriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-propriedade" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, propriedadeInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="tipoPropriedade" title="${message(code: 'propriedade.tipoPropriedade.label', default: 'Tipo Propriedade')}" params="[tipoPropriedade: consultaInstance?.tipoPropriedade, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomePropriedade: consultaInstance?.nomePropriedade, nomeFantasiaPropriedade: consultaInstance?.nomeFantasiaPropriedade, emailPropriedade: consultaInstance?.emailPropriedade, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
					
						<g:sortableColumn property="cnpj" title="${message(code: 'propriedade.cnpj-cpf.label', default: 'Cnpj-cpf')}" params="[tipoPropriedade: consultaInstance?.tipoPropriedade, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomePropriedade: consultaInstance?.nomePropriedade, nomeFantasiaPropriedade: consultaInstance?.nomeFantasiaPropriedade, emailPropriedade: consultaInstance?.emailPropriedade, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
					
						<g:sortableColumn property="nomePropriedade" title="${message(code: 'propriedade.nomePropriedade.label', default: 'Nome Propriedade')}" params="[tipoPropriedade: consultaInstance?.tipoPropriedade, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomePropriedade: consultaInstance?.nomePropriedade, nomeFantasiaPropriedade: consultaInstance?.nomeFantasiaPropriedade, emailPropriedade: consultaInstance?.emailPropriedade, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
					
						<g:sortableColumn property="emailPropriedade" title="${message(code: 'propriedade.emailPropriedade.label', default: 'Email Propriedade')}" params="[tipoPropriedade: consultaInstance?.tipoPropriedade, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomePropriedade: consultaInstance?.nomePropriedade, nomeFantasiaPropriedade: consultaInstance?.nomeFantasiaPropriedade, emailPropriedade: consultaInstance?.emailPropriedade, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${propriedadeInstanceList}" status="i" var="propriedadeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="propriedade" class="show" action="show" id="${propriedadeInstance.id}"></g:link>

                                                        <g:link controller="propriedade" class="edit" action="edit" id="${propriedadeInstance.id}"></g:link>
                                                        
                                                        <g:jasperReport
                                                            jasper="propriedade"
                                                            format="PDF"
                                                            delimiter=" "
                                                            name="">
                                                            <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                            <g:hiddenField name="propriedadeId" value="${propriedadeInstance?.id}" />
                                                        </g:jasperReport>
                                                </td>
                                                
						<td>${fieldValue(bean: propriedadeInstance, field: "tipoPropriedade")}</td>
					
						<td>${propriedadeInstance.cnpj ?: propriedadeInstance.cpf}</td>
					
						<td>${fieldValue(bean: propriedadeInstance, field: "nomePropriedade")}</td>
                                                
                                                <td>${fieldValue(bean: propriedadeInstance, field: "emailPropriedade")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${propriedadeInstanceTotal}" params="[tipoPropriedade: consultaInstance?.tipoPropriedade, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomePropriedade: consultaInstance?.nomePropriedade, nomeFantasiaPropriedade: consultaInstance?.nomeFantasiaPropriedade, emailPropriedade: consultaInstance?.emailPropriedade, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
			</div>
		</div>
	</body>
</html>
