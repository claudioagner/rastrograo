
<%@ page import="rastrograo.estrutura.Fase" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fase.label', default: 'Fase')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-fase" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-fase" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, faseInstanceTotal]" /></h1>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="produto.descricaoProduto" title="${message(code: 'fase.produto.label', default: 'Produto')}" params="[produtoId: consultaInstance?.produto?.id, descricaoFase: consultaInstance?.descricaoFase]"/>
					
						<g:sortableColumn property="descricaoFase" title="${message(code: 'fase.descricaoFase.label', default: 'Descricao Fase')}" params="[produtoId: consultaInstance?.produto?.id, descricaoFase: consultaInstance?.descricaoFase]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${faseInstanceList}" status="i" var="faseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="fase" class="show" action="show" id="${faseInstance.id}"></g:link>

                                                        <g:link controller="fase" class="edit" action="edit" id="${faseInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: faseInstance, field: "produto")}</td>
					
						<td>${fieldValue(bean: faseInstance, field: "descricaoFase")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${faseInstanceTotal}" params="[produtoId: consultaInstance?.produto?.id, descricaoFase: consultaInstance?.descricaoFase]"/>
			</div>
		</div>
	</body>
</html>
