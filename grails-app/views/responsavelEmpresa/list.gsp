
<%@ page import="rastrograo.empresa.ResponsavelEmpresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'responsavelEmpresa.label', default: 'ResponsavelEmpresa')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-responsavelEmpresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-responsavelEmpresa" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, responsavelEmpresaInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="tipoResponsavel.descricaoTipoResponsavel" title="${message(code: 'responsavelEmpresa.tipoResponsavel.label', default: 'Tipo Responsavel')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, empresaId: consultaInstance?.empresa?.id, nomeResponsavelEmpresa: consultaInstance?.nomeResponsavelEmpresa, dddResponsavelEmpresa: consultaInstance?.dddResponsavelEmpresa, numeroTelefoneResponsavelEmpresa: consultaInstance?.numeroTelefoneResponsavelEmpresa]"/>
					
                                                <g:sortableColumn property="empresa.nomeEmpresa" title="${message(code: 'responsavelEmpresa.empresa.label', default: 'Empresa')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, empresaId: consultaInstance?.empresa?.id, nomeResponsavelEmpresa: consultaInstance?.nomeResponsavelEmpresa, dddResponsavelEmpresa: consultaInstance?.dddResponsavelEmpresa, numeroTelefoneResponsavelEmpresa: consultaInstance?.numeroTelefoneResponsavelEmpresa]"/>
					
                                                <g:sortableColumn property="nomeResponsavelEmpresa" title="${message(code: 'responsavelEmpresa.nomeResponsavelEmpresa.label', default: 'Nome Responsavel Empresa')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, empresaId: consultaInstance?.empresa?.id, nomeResponsavelEmpresa: consultaInstance?.nomeResponsavelEmpresa, dddResponsavelEmpresa: consultaInstance?.dddResponsavelEmpresa, numeroTelefoneResponsavelEmpresa: consultaInstance?.numeroTelefoneResponsavelEmpresa]"/>
					
						<g:sortableColumn property="dddResponsavelEmpresa" title="${message(code: 'responsavelEmpresa.dddResponsavelEmpresa.label', default: 'Ddd Responsavel Empresa')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, empresaId: consultaInstance?.empresa?.id, nomeResponsavelEmpresa: consultaInstance?.nomeResponsavelEmpresa, dddResponsavelEmpresa: consultaInstance?.dddResponsavelEmpresa, numeroTelefoneResponsavelEmpresa: consultaInstance?.numeroTelefoneResponsavelEmpresa]"/>
					
						<g:sortableColumn property="numeroTelefoneResponsavelEmpresa" title="${message(code: 'responsavelEmpresa.numeroTelefoneResponsavelEmpresa.label', default: 'Numero Telefone Responsavel Empresa')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, empresaId: consultaInstance?.empresa?.id, nomeResponsavelEmpresa: consultaInstance?.nomeResponsavelEmpresa, dddResponsavelEmpresa: consultaInstance?.dddResponsavelEmpresa, numeroTelefoneResponsavelEmpresa: consultaInstance?.numeroTelefoneResponsavelEmpresa]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${responsavelEmpresaInstanceList}" status="i" var="responsavelEmpresaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="responsavelEmpresa" class="show" action="show" id="${responsavelEmpresaInstance.id}"></g:link>

                                                        <g:link controller="responsavelEmpresa" class="edit" action="edit" id="${responsavelEmpresaInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: responsavelEmpresaInstance, field: "tipoResponsavel")}</td>
					
						<td>${fieldValue(bean: responsavelEmpresaInstance, field: "empresa")}</td>
					
						<td>${fieldValue(bean: responsavelEmpresaInstance, field: "nomeResponsavelEmpresa")}</td>
					
						<td>${fieldValue(bean: responsavelEmpresaInstance, field: "dddResponsavelEmpresa")}</td>
					
						<td>${fieldValue(bean: responsavelEmpresaInstance, field: "numeroTelefoneResponsavelEmpresa")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${responsavelEmpresaInstanceTotal}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, empresaId: consultaInstance?.empresa?.id, nomeResponsavelEmpresa: consultaInstance?.nomeResponsavelEmpresa, dddResponsavelEmpresa: consultaInstance?.dddResponsavelEmpresa, numeroTelefoneResponsavelEmpresa: consultaInstance?.numeroTelefoneResponsavelEmpresa]"/>
			</div>
		</div>
	</body>
</html>
