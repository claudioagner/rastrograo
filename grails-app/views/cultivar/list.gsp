
<%@ page import="rastrograo.estrutura.Cultivar" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cultivar.label', default: 'Cultivar')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cultivar" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cultivar" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, cultivarInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="produto.descricaoProduto" title="${message(code: 'cultivar.produto.label', default: 'Produto')}" params="[produtoId: consultaInstance?.produto?.id, descricaoCultivar: consultaInstance?.descricaoCultivar]"/>
					
						<g:sortableColumn property="descricaoCultivar" title="${message(code: 'cultivar.descricaoCultivar.label', default: 'Descricao Cultivar')}" params="[produtoId: consultaInstance?.produto?.id, descricaoCultivar: consultaInstance?.descricaoCultivar]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cultivarInstanceList}" status="i" var="cultivarInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						
                                                <td>
                                                        <g:link controller="cultivar" class="show" action="show" id="${cultivarInstance.id}"></g:link>

                                                        <g:link controller="cultivar" class="edit" action="edit" id="${cultivarInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: cultivarInstance, field: "produto")}</td>
					
						<td>${fieldValue(bean: cultivarInstance, field: "descricaoCultivar")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cultivarInstanceTotal}" params="[produtoId: consultaInstance?.produto?.id, descricaoCultivar: consultaInstance?.descricaoCultivar]"/>
			</div>
		</div>
	</body>
</html>
