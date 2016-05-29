
<%@ page import="rastrograo.empresa.TelefoneEmpresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'telefoneEmpresa.label', default: 'TelefoneEmpresa')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-telefoneEmpresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-telefoneEmpresa" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, telefoneEmpresaInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="empresa.nomeEmpresa" title="${message(code: 'telefoneEmpresa.empresa.label', default: 'Empresa')}" params="[empresaId: consultaInstance?.empresa?.id, dddEmpresa: consultaInstance?.dddEmpresa, numeroTelefoneEmpresa: consultaInstance?.numeroTelefoneEmpresa]"/>
					
                                                <g:sortableColumn property="dddEmpresa" title="${message(code: 'telefoneEmpresa.dddEmpresa.label', default: 'Ddd Empresa')}" params="[empresaId: consultaInstance?.empresa?.id, dddEmpresa: consultaInstance?.dddEmpresa, numeroTelefoneEmpresa: consultaInstance?.numeroTelefoneEmpresa]"/>
					
						<g:sortableColumn property="numeroTelefoneEmpresa" title="${message(code: 'telefoneEmpresa.numeroTelefoneEmpresa.label', default: 'Numero Telefone Empresa')}" params="[empresaId: consultaInstance?.empresa?.id, dddEmpresa: consultaInstance?.dddEmpresa, numeroTelefoneEmpresa: consultaInstance?.numeroTelefoneEmpresa]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${telefoneEmpresaInstanceList}" status="i" var="telefoneEmpresaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="telefoneEmpresa" class="show" action="show" id="${telefoneEmpresaInstance.id}"></g:link>

                                                        <g:link controller="telefoneEmpresa" class="edit" action="edit" id="${telefoneEmpresaInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: telefoneEmpresaInstance, field: "empresa")}</td>
					
						<td>${fieldValue(bean: telefoneEmpresaInstance, field: "dddEmpresa")}</td>
					
						<td>${fieldValue(bean: telefoneEmpresaInstance, field: "numeroTelefoneEmpresa")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${telefoneEmpresaInstanceTotal}" params="[empresaId: consultaInstance?.empresa?.id, dddEmpresa: consultaInstance?.dddEmpresa, numeroTelefoneEmpresa: consultaInstance?.numeroTelefoneEmpresa]"/>
			</div>
		</div>
	</body>
</html>
