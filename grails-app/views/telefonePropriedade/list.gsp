
<%@ page import="rastrograo.propriedade.TelefonePropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'telefonePropriedade.label', default: 'TelefonePropriedade')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-telefonePropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-telefonePropriedade" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, telefonePropriedadeInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="propriedade.nomePropriedade" title="${message(code: 'telefonePropriedade.propriedade.label', default: 'Propriedade')}" params="[propriedadeId: consultaInstance?.propriedade?.id, dddPropriedade: consultaInstance?.dddPropriedade, numeroTelefonePropriedade: consultaInstance?.numeroTelefonePropriedade]"/>
					
                                                <g:sortableColumn property="dddPropriedade" title="${message(code: 'telefonePropriedade.dddPropriedade.label', default: 'Ddd Propriedade')}" params="[propriedadeId: consultaInstance?.propriedade?.id, dddPropriedade: consultaInstance?.dddPropriedade, numeroTelefonePropriedade: consultaInstance?.numeroTelefonePropriedade]"/>
					
						<g:sortableColumn property="numeroTelefonePropriedade" title="${message(code: 'telefonePropriedade.numeroTelefonePropriedade.label', default: 'Numero Telefone Propriedade')}" params="[propriedadeId: consultaInstance?.propriedade?.id, dddPropriedade: consultaInstance?.dddPropriedade, numeroTelefonePropriedade: consultaInstance?.numeroTelefonePropriedade]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${telefonePropriedadeInstanceList}" status="i" var="telefonePropriedadeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="telefonePropriedade" class="show" action="show" id="${telefonePropriedadeInstance.id}"></g:link>

                                                        <g:link controller="telefonePropriedade" class="edit" action="edit" id="${telefonePropriedadeInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: telefonePropriedadeInstance, field: "propriedade")}</td>
					
						<td>${fieldValue(bean: telefonePropriedadeInstance, field: "dddPropriedade")}</td>
					
						<td>${fieldValue(bean: telefonePropriedadeInstance, field: "numeroTelefonePropriedade")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${telefonePropriedadeInstanceTotal}" params="[propriedadeId: consultaInstance?.propriedade?.id, dddPropriedade: consultaInstance?.dddPropriedade, numeroTelefonePropriedade: consultaInstance?.numeroTelefonePropriedade]"/>
			</div>
		</div>
	</body>
</html>
