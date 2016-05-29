
<%@ page import="rastrograo.estrutura.Atributo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'atributo.label', default: 'Atributo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-atributo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-atributo" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, atributoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
            					<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="fase.produto.descricaoProduto" title="${message(code: 'atributo.produto.label', default: 'Produto')}" params="[produtoId: produtoInstance?.id, faseId: consultaInstance?.fase?.id, nomeAtributo: consultaInstance?.nomeAtributo, tipoAtributo: consultaInstance?.tipoAtributo]"/>
					
                                                <g:sortableColumn property="fase.descricaoFase" title="${message(code: 'atributo.fase.label', default: 'Fase')}" params="[produtoId: produtoInstance?.id, faseId: consultaInstance?.fase?.id, nomeAtributo: consultaInstance?.nomeAtributo, tipoAtributo: consultaInstance?.tipoAtributo]"/>
					
						<g:sortableColumn property="nomeAtributo" title="${message(code: 'atributo.nomeAtributo.label', default: 'Nome Atributo')}" params="[produtoId: produtoInstance?.id, faseId: consultaInstance?.fase?.id, nomeAtributo: consultaInstance?.nomeAtributo, tipoAtributo: consultaInstance?.tipoAtributo]"/>
					
						<g:sortableColumn property="tipoAtributo" title="${message(code: 'atributo.tipoAtributo.label', default: 'Tipo Atributo')}" params="[produtoId: produtoInstance?.id, faseId: consultaInstance?.fase?.id, nomeAtributo: consultaInstance?.nomeAtributo, tipoAtributo: consultaInstance?.tipoAtributo]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${atributoInstanceList}" status="i" var="atributoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="atributo" class="show" action="show" id="${atributoInstance.id}"></g:link>

                                                        <g:link controller="atributo" class="edit" action="edit" id="${atributoInstance.id}"></g:link>
                                                </td>

                                                <td>${fieldValue(bean: atributoInstance, field: "fase.produto")}</td>
                                                
                                                <td>${fieldValue(bean: atributoInstance, field: "fase")}</td>
					
						<td>${fieldValue(bean: atributoInstance, field: "nomeAtributo")}</td>
					
						<td>${fieldValue(bean: atributoInstance, field: "tipoAtributo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${atributoInstanceTotal}" params="[produtoId: produtoInstance?.id, faseId: consultaInstance?.fase?.id, nomeAtributo: consultaInstance?.nomeAtributo, tipoAtributo: consultaInstance?.tipoAtributo]"/>
			</div>
		</div>
	</body>
</html>
