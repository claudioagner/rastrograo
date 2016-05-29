
<%@ page import="rastrograo.propriedade.TalhaoPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'talhaoPropriedade.label', default: 'TalhaoPropriedade')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-talhaoPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-talhaoPropriedade" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                                  
			<h1><g:message code="default.listTotal.label" args="[entityName, talhaoPropriedadeInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="propriedade.nomePropriedade" title="${message(code: 'fotoPropriedade.propriedade.label', default: 'Propriedade')}" params="[propriedadeId: consultaInstance?.propriedade?.id, descricaoTalhao: consultaInstance?.descricaoTalhao]"/>                                                
                                                
                                                <g:sortableColumn property="descricaoTalhao" title="${message(code: 'talhaoPropriedade.descricaoTalhao.label', default: 'Descricao Talhao')}" params="[propriedadeId: consultaInstance?.propriedade?.id, descricaoTalhao: consultaInstance?.descricaoTalhao]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${talhaoPropriedadeInstanceList}" status="i" var="talhaoPropriedadeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="talhaoPropriedade" class="show" action="show" id="${talhaoPropriedadeInstance.id}"></g:link>

                                                        <g:link controller="talhaoPropriedade" class="edit" action="edit" id="${talhaoPropriedadeInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: talhaoPropriedadeInstance, field: "propriedade")}</td>
					
						<td>${fieldValue(bean: talhaoPropriedadeInstance, field: "descricaoTalhao")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${talhaoPropriedadeInstanceTotal}" params="[propriedadeId: consultaInstance?.propriedade?.id, descricaoTalhao: consultaInstance?.descricaoTalhao]"/>
			</div>
		</div>
	</body>
</html>
