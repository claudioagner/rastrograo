
<%@ page import="rastrograo.dados.RegistroDados" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'registroDados.label', default: 'RegistroDados')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-registroDados" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-registroDados" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, registroDadosInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="rastroProduto" title="${message(code: 'registroDados.rastroProduto.label', default: 'Rastro Produto')}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, 'rastroFase.id': consultaInstance?.rastroFase?.id, 'rastroAtributo.id': consultaInstance?.rastroAtributo?.id]"/>
                                                
                                                <g:sortableColumn property="rastroFase" title="${message(code: 'registroDados.rastroFase.label', default: 'Rastro Fase')}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, 'rastroFase.id': consultaInstance?.rastroFase?.id, 'rastroAtributo.id': consultaInstance?.rastroAtributo?.id]"/>
                                                
                                                <g:sortableColumn property="rastroAtributo" title="${message(code: 'registroDados.rastroAtributo.label', default: 'Rastro Atributo')}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, 'rastroFase.id': consultaInstance?.rastroFase?.id, 'rastroAtributo.id': consultaInstance?.rastroAtributo?.id]"/>
                                                
					</tr>
				</thead>
				<tbody>
				<g:each in="${registroDadosInstanceList}" status="i" var="registroDadosInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
                                                <td>
                                                        <g:link controller="registroDados" class="show" action="show" id="${registroDadosInstance.id}"></g:link>

                                                        <g:link controller="registroDados" class="edit" action="edit" id="${registroDadosInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: registroDadosInstance, field: "rastroAtributo.rastroFase.rastroProduto")}</td>
                                                
                                                <td>${fieldValue(bean: registroDadosInstance, field: "rastroAtributo.rastroFase")}</td>
                                                
						<td>${fieldValue(bean: registroDadosInstance, field: "rastroAtributo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${registroDadosInstanceTotal}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, 'rastroFase.id': consultaInstance?.rastroFase?.id, 'rastroAtributo.id': consultaInstance?.rastroAtributo?.id]"/>
			</div>
		</div>
	</body>
</html>
