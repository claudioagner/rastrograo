
<%@ page import="rastrograo.seguranca.Permissao" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'permissao.label', default: 'Permissao')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-permissao" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-permissao" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, permissaoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="url" title="${message(code: 'permissao.url.label', default: 'Url')}" params="[url: consultaInstance?.url, configAttribute: consultaInstance?.configAttribute]"/>
					
						<g:sortableColumn property="configAttribute" title="${message(code: 'permissao.configAttribute.label', default: 'Config Attribute')}" params="[url: consultaInstance?.url, configAttribute: consultaInstance?.configAttribute]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${permissaoInstanceList}" status="i" var="permissaoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="permissao" class="show" action="show" id="${permissaoInstance.id}"></g:link>

                                                        <g:link controller="permissao" class="edit" action="edit" id="${permissaoInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: permissaoInstance, field: "url")}</td>
					
						<td>${fieldValue(bean: permissaoInstance, field: "configAttribute")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${permissaoInstanceTotal}" params="[url: consultaInstance?.url, configAttribute: consultaInstance?.configAttribute]"/>
			</div>
		</div>
	</body>
</html>
