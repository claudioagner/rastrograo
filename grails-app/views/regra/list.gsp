
<%@ page import="rastrograo.seguranca.Regra" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'regra.label', default: 'Regra')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-regra" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-regra" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, regraInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="authority" title="${message(code: 'regra.authority.label', default: 'Authority')}" params="[authority: consultaInstance?.authority]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${regraInstanceList}" status="i" var="regraInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="regra" class="show" action="show" id="${regraInstance.id}"></g:link>

                                                        <g:link controller="regra" class="edit" action="edit" id="${regraInstance.id}"></g:link>
                                                </td>
                                                
						<td>${regraInstance?.encodeAsHTML()}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${regraInstanceTotal}" params="[authority: consultaInstance?.authority]"/>
			</div>
		</div>
	</body>
</html>
