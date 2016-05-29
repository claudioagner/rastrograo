
<%@ page import="rastrograo.tabela.TipoProduto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tipoProduto.label', default: 'TipoProduto')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tipoProduto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-tipoProduto" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, tipoProdutoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="descricaoTipoProduto" title="${message(code: 'tipoProduto.descricaoTipoProduto.label', default: 'Descricao Tipo Produto')}" params="[descricaoTipoProduto: consultaInstance?.descricaoTipoProduto]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${tipoProdutoInstanceList}" status="i" var="tipoProdutoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="tipoProduto" class="show" action="show" id="${tipoProdutoInstance.id}"></g:link>

                                                        <g:link controller="tipoProduto" class="edit" action="edit" id="${tipoProdutoInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: tipoProdutoInstance, field: "descricaoTipoProduto")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${tipoProdutoInstanceTotal}" params="[descricaoTipoProduto: consultaInstance?.descricaoTipoProduto]"/>
			</div>
		</div>
	</body>
</html>
