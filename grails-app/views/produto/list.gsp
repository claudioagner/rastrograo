
<%@ page import="rastrograo.estrutura.Produto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'produto.label', default: 'Produto')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-produto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-produto" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, produtoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="tipoProduto" title="${message(code: 'produto.tipoProduto.label', default: 'Tipo Produto')}" params="['tipoProdutoId': consultaInstance?.tipoProduto?.id, descricaoProduto: consultaInstance?.descricaoProduto]"/>
					
						<g:sortableColumn property="descricaoProduto" title="${message(code: 'produto.descricaoProduto.label', default: 'Descricao Produto')}" params="['tipoProdutoId': consultaInstance?.tipoProduto?.id, descricaoProduto: consultaInstance?.descricaoProduto]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${produtoInstanceList}" status="i" var="produtoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="produto" class="show" action="show" id="${produtoInstance.id}"></g:link>

                                                        <g:link controller="produto" class="edit" action="edit" id="${produtoInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: produtoInstance, field: "tipoProduto")}</td>
                                                
						<td>${fieldValue(bean: produtoInstance, field: "descricaoProduto")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${produtoInstanceTotal}" params="['tipoProdutoId': consultaInstance?.tipoProduto?.id, descricaoProduto: consultaInstance?.descricaoProduto]"/>
			</div>
		</div>
	</body>
</html>
