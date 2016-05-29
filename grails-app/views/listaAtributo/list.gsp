
<%@ page import="rastrograo.estrutura.ListaAtributo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'listaAtributo.label', default: 'ListaAtributo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-listaAtributo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-listaAtributo" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, listaAtributoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="atributo.fase.produto.descricaoProduto" title="${message(code: 'atributo.produto.label', default: 'Produto')}" params="[produtoId: produtoInstance?.id, atributoId: consultaInstance?.atributo?.id, faseId: consultaInstance?.atributo?.fase?.id, valorListaAtributo: consultaInstance?.valorListaAtributo]"/>
                                                
						<g:sortableColumn property="atributo.fase.descricaoFase" title="${message(code: 'atributo.fase.label', default: 'Fase')}" params="[produtoId: produtoInstance?.id, atributoId: consultaInstance?.atributo?.id, faseId: consultaInstance?.atributo?.fase?.id, valorListaAtributo: consultaInstance?.valorListaAtributo]"/>
					                                                
                                                <g:sortableColumn property="atributo.nomeAtributo" title="${message(code: 'listaAtributo.atributo.label', default: 'Atributo')}" params="[produtoId: produtoInstance?.id, atributoId: consultaInstance?.atributo?.id, faseId: consultaInstance?.atributo?.fase?.id, valorListaAtributo: consultaInstance?.valorListaAtributo]"/>
					                                                
						<g:sortableColumn property="valorListaAtributo" title="${message(code: 'listaAtributo.valorListaAtributo.label', default: 'Valor Lista Atributo')}" params="[produtoId: produtoInstance?.id, atributoId: consultaInstance?.atributo?.id, faseId: consultaInstance?.atributo?.fase?.id, valorListaAtributo: consultaInstance?.valorListaAtributo]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${listaAtributoInstanceList}" status="i" var="listaAtributoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="listaAtributo" class="show" action="show" id="${listaAtributoInstance.id}"></g:link>

                                                        <g:link controller="listaAtributo" class="edit" action="edit" id="${listaAtributoInstance.id}"></g:link>
                                                </td>

                                                <td>${fieldValue(bean: listaAtributoInstance, field: "atributo.fase.produto")}</td>
                                                
                                                <td>${fieldValue(bean: listaAtributoInstance, field: "atributo.fase")}</td>
                                                
                                                <td>${fieldValue(bean: listaAtributoInstance, field: "atributo")}</td>
					
						<td>${fieldValue(bean: listaAtributoInstance, field: "valorListaAtributo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${listaAtributoInstanceTotal}" params="[produtoId: produtoInstance?.id, atributoId: consultaInstance?.atributo?.id, faseId: consultaInstance?.atributo?.fase?.id, valorListaAtributo: consultaInstance?.valorListaAtributo]"/>
			</div>
		</div>
	</body>
</html>
