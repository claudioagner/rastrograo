
<%@ page import="rastrograo.empresa.Empresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'empresa.label', default: 'Empresa')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-empresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-empresa" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, empresaInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="tipoEmpresa" title="${message(code: 'empresa.tipoEmpresa.label', default: 'Tipo Empresa')}" params="[tipoEmpresa: consultaInstance?.tipoEmpresa, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomeEmpresa: consultaInstance?.nomeEmpresa, nomeFantasiaEmpresa: consultaInstance?.nomeFantasiaEmpresa, emailEmpresa: consultaInstance?.emailEmpresa, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
					
						<g:sortableColumn property="cnpj" title="${message(code: 'empresa.cnpj-cpf.label', default: 'Cnpj-cpf')}" params="[tipoEmpresa: consultaInstance?.tipoEmpresa, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomeEmpresa: consultaInstance?.nomeEmpresa, nomeFantasiaEmpresa: consultaInstance?.nomeFantasiaEmpresa, emailEmpresa: consultaInstance?.emailEmpresa, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
					
						<g:sortableColumn property="nomeEmpresa" title="${message(code: 'empresa.nomeEmpresa.label', default: 'Nome Empresa')}" params="[tipoEmpresa: consultaInstance?.tipoEmpresa, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomeEmpresa: consultaInstance?.nomeEmpresa, nomeFantasiaEmpresa: consultaInstance?.nomeFantasiaEmpresa, emailEmpresa: consultaInstance?.emailEmpresa, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
					
						<g:sortableColumn property="emailEmpresa" title="${message(code: 'empresa.emailEmpresa.label', default: 'Email Empresa')}" params="[tipoEmpresa: consultaInstance?.tipoEmpresa, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomeEmpresa: consultaInstance?.nomeEmpresa, nomeFantasiaEmpresa: consultaInstance?.nomeFantasiaEmpresa, emailEmpresa: consultaInstance?.emailEmpresa, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${empresaInstanceList}" status="i" var="empresaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="empresa" class="show" action="show" id="${empresaInstance.id}"></g:link>

                                                        <g:link controller="empresa" class="edit" action="edit" id="${empresaInstance.id}"></g:link>
                                                        
                                                        <g:jasperReport
                                                            jasper="empresa"
                                                            format="PDF"
                                                            delimiter=" "
                                                            name="">
                                                            <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                            <g:hiddenField name="empresaId" value="${empresaInstance?.id}" />
                                                        </g:jasperReport>
                                                </td>
                                                
						<td>${fieldValue(bean: empresaInstance, field: "tipoEmpresa")}</td>
					
						<td>${empresaInstance.cnpj ?: empresaInstance.cpf}</td>
					
						<td>${fieldValue(bean: empresaInstance, field: "nomeEmpresa")}</td>
                                                
                                                <td>${fieldValue(bean: empresaInstance, field: "emailEmpresa")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${empresaInstanceTotal}" params="[tipoEmpresa: consultaInstance?.tipoEmpresa, cpf: consultaInstance?.cpf, cnpj: consultaInstance?.cnpj, nomeEmpresa: consultaInstance?.nomeEmpresa, nomeFantasiaEmpresa: consultaInstance?.nomeFantasiaEmpresa, emailEmpresa: consultaInstance?.emailEmpresa, paisId: consultaInstance?.cidade?.estado?.pais?.id, estadoId: consultaInstance?.cidade?.estado?.id, cidadeId: consultaInstance?.cidade?.id]"/>
			</div>
		</div>
	</body>
</html>
