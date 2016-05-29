
<%@ page import="rastrograo.seguranca.Acesso" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'acesso.label', default: 'Acesso')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-acesso" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-acesso" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, acessoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="username" title="${message(code: 'acesso.username.label', default: 'Username')}" params="[username: consultaInstance?.username, email: consultaInstance?.email]"/>
					
						<g:sortableColumn property="email" title="${message(code: 'acesso.email.label', default: 'Email')}" params="[username: consultaInstance?.username, email: consultaInstance?.email]"/>
					
						<g:sortableColumn property="enabled" title="${message(code: 'acesso.enabled.label', default: 'Enabled')}" params="[username: consultaInstance?.username, email: consultaInstance?.email]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${acessoInstanceList}" status="i" var="acessoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="acesso" class="show" action="show" id="${acessoInstance.id}"></g:link>

                                                        <g:link controller="acesso" class="edit" action="edit" id="${acessoInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: acessoInstance, field: "username")}</td>
					
						<td>${fieldValue(bean: acessoInstance, field: "email")}</td>
					
						<td><g:formatBoolean boolean="${acessoInstance.enabled}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${acessoInstanceTotal}" params="[username: consultaInstance?.username, email: consultaInstance?.email]"/>
			</div>
		</div>
	</body>
</html>
