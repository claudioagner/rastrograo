
<%@ page import="rastrograo.tabela.Pais" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pais.label', default: 'Pais')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-pais" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-pais" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, paisInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="nomePais" title="${message(code: 'pais.nomePais.label', default: 'Nome Pais')}" params="[nomePais: consultaInstance?.nomePais, countryName: consultaInstance?.countryName]"/>
					
						<g:sortableColumn property="countryName" title="${message(code: 'pais.countryName.label', default: 'Country Name')}" params="[nomePais: consultaInstance?.nomePais, countryName: consultaInstance?.countryName]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${paisInstanceList}" status="i" var="paisInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="pais" class="show" action="show" id="${paisInstance.id}"></g:link>

                                                        <g:link controller="pais" class="edit" action="edit" id="${paisInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: paisInstance, field: "nomePais")}</td>
					
						<td>${fieldValue(bean: paisInstance, field: "countryName")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${paisInstanceTotal}" params="[nomePais: consultaInstance?.nomePais, countryName: consultaInstance?.countryName]"/>
			</div>
		</div>
	</body>
</html>
