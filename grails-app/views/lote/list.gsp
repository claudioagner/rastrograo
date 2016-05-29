
<%@ page import="rastrograo.rastreamento.Lote" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'lote.label', default: 'Lote')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-lote" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-lote" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, loteInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="rastroProduto.anoSafra" title="${message(code: 'lote.rastroProduto.label', default: 'Rastro Produto')}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, nrLoteManual: consultaInstance?.nrLoteManual]"/>
											
						<g:sortableColumn property="dataLote" title="${message(code: 'lote.dataLote.label', default: 'Data Lote')}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, nrLoteManual: consultaInstance?.nrLoteManual]"/>
					
						<g:sortableColumn property="validadeLote" title="${message(code: 'lote.validadeLote.label', default: 'Validade Lote')}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, nrLoteManual: consultaInstance?.nrLoteManual]"/>
					
						<g:sortableColumn property="volumeLote" title="${message(code: 'lote.volumeLote.label', default: 'Volume Lote')}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, nrLoteManual: consultaInstance?.nrLoteManual]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${loteInstanceList}" status="i" var="loteInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="lote" class="show" action="show" id="${loteInstance.id}"></g:link>

                                                        <g:link controller="lote" class="edit" action="edit" id="${loteInstance.id}"></g:link>
                                                </td>

                                                <td>${fieldValue(bean: loteInstance, field: "rastroProduto")}</td>
					
						<td><g:formatDate date="${loteInstance.dataLote}" /></td>
					
						<td><g:formatDate date="${loteInstance.validadeLote}" /></td>
					
						<td>${fieldValue(bean: loteInstance, field: "volumeLote")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${loteInstanceTotal}" params="['rastroProduto.id': consultaInstance?.rastroProduto?.id, nrLoteManual: consultaInstance?.nrLoteManual]"/>
			</div>
		</div>
	</body>
</html>
