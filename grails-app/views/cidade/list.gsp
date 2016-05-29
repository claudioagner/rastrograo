
<%@ page import="rastrograo.tabela.Cidade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cidade.label', default: 'Cidade')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cidade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cidade" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, cidadeInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="estado.pais" title="${message(code: 'estado.pais.label', default: 'Pais')}" params="[paisId: consultaInstance?.estado?.pais?.id, estadoId: consultaInstance?.estado?.id, nomeCidade: consultaInstance?.nomeCidade]"/>
                                                
						<g:sortableColumn property="estado" title="${message(code: 'cidade.estado.label', default: 'Estado')}" params="[paisId: consultaInstance?.estado?.pais?.id, estadoId: consultaInstance?.estado?.id, nomeCidade: consultaInstance?.nomeCidade]"/>
					
						<g:sortableColumn property="nomeCidade" title="${message(code: 'cidade.nomeCidade.label', default: 'Nome Cidade')}" params="[paisId: consultaInstance?.estado?.pais?.id, estadoId: consultaInstance?.estado?.id, nomeCidade: consultaInstance?.nomeCidade]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cidadeInstanceList}" status="i" var="cidadeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="cidade" class="show" action="show" id="${cidadeInstance?.id}"></g:link>

                                                        <g:link controller="cidade" class="edit" action="edit" id="${cidadeInstance?.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: cidadeInstance, field: "estado.pais")}</td>
                                                
						<td>${fieldValue(bean: cidadeInstance, field: "estado")}</td>
					
						<td>${fieldValue(bean: cidadeInstance, field: "nomeCidade")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cidadeInstanceTotal}" params="[paisId: paisId, estadoId: estadoId, nomeCidade: nomeCidade]"/>
			</div>
		</div>
	</body>
</html>
