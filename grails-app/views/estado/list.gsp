
<%@ page import="rastrograo.tabela.Estado" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'estado.label', default: 'Estado')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-estado" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-estado" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, estadoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="pais" title="${message(code: 'estado.pais.label', default: 'Pais')}" params="[paisId: consultaInstance?.pais?.id, nomeEstado: consultaInstance?.nomeEstado, sigla: consultaInstance?.sigla]"/>
                                                
						<g:sortableColumn property="nomeEstado" title="${message(code: 'estado.nomeEstado.label', default: 'Nome Estado')}" params="[paisId: consultaInstance?.pais?.id, nomeEstado: consultaInstance?.nomeEstado, sigla: consultaInstance?.sigla]"/>
					
						<g:sortableColumn property="sigla" title="${message(code: 'estado.sigla.label', default: 'Sigla')}" params="[paisId: consultaInstance?.pais?.id, nomeEstado: consultaInstance?.nomeEstado, sigla: consultaInstance?.sigla]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${estadoInstanceList}" status="i" var="estadoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="estado" class="show" action="show" id="${estadoInstance.id}"></g:link>

                                                        <g:link controller="estado" class="edit" action="edit" id="${estadoInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: estadoInstance, field: "pais")}</td>
					
						<td>${fieldValue(bean: estadoInstance, field: "nomeEstado")}</td>
					
						<td>${fieldValue(bean: estadoInstance, field: "sigla")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${estadoInstanceTotal}" params="[paisId: consultaInstance?.pais?.id, nomeEstado: consultaInstance?.nomeEstado, sigla: consultaInstance?.sigla]"/>
			</div>
		</div>
	</body>
</html>
