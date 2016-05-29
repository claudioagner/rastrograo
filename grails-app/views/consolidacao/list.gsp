
<%@ page import="rastrograo.rastreamento.Consolidacao" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'consolidacao.label', default: 'Consolidacao')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-consolidacao" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-consolidacao" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, consolidacaoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="empresa" title="${message(code: 'consolidacao.empresa.label', default: 'Empresa')}" params="[empresaId: consultaInstance?.empresa?.id, empresaOrigemId: consultaInstance?.empresaOrigem?.id, propriedadeOrigemId: consultaInstance?.propriedadeOrigem?.id, nrLoteConsolidado: consultaInstance?.nrLoteConsolidado]"/>
                                                
						<g:sortableColumn property="empresaOrigem" title="${message(code: 'consolidacao.empresaOrigem.label', default: 'Empresa Origem')}" params="[empresaId: consultaInstance?.empresa?.id, empresaOrigemId: consultaInstance?.empresaOrigem?.id, propriedadeOrigemId: consultaInstance?.propriedadeOrigem?.id, nrLoteConsolidado: consultaInstance?.nrLoteConsolidado]"/>
                                                
						<g:sortableColumn property="propriedadeOrigem" title="${message(code: 'consolidacao.propriedadeOrigem.label', default: 'Propriedade Origem')}" params="[empresaId: consultaInstance?.empresa?.id, empresaOrigemId: consultaInstance?.empresaOrigem?.id, propriedadeOrigemId: consultaInstance?.propriedadeOrigem?.id, nrLoteConsolidado: consultaInstance?.nrLoteConsolidado]"/>
					
						<g:sortableColumn property="dataConsolidacao" title="${message(code: 'consolidacao.dataConsolidacao.label', default: 'Data Consolidacao')}" params="[empresaId: consultaInstance?.empresa?.id, empresaOrigemId: consultaInstance?.empresaOrigem?.id, propriedadeOrigemId: consultaInstance?.propriedadeOrigem?.id, nrLoteConsolidado: consultaInstance?.nrLoteConsolidado]"/>
					
						<g:sortableColumn property="nrLoteConsolidado" title="${message(code: 'consolidacao.nrLoteConsolidado.label', default: 'Nr Lote Consolidado')}" params="[empresaId: consultaInstance?.empresa?.id, empresaOrigemId: consultaInstance?.empresaOrigem?.id, propriedadeOrigemId: consultaInstance?.propriedadeOrigem?.id, nrLoteConsolidado: consultaInstance?.nrLoteConsolidado]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${consolidacaoInstanceList}" status="i" var="consolidacaoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="consolidacao" class="show" action="show" id="${consolidacaoInstance.id}"></g:link>

                                                        <g:link controller="consolidacao" class="edit" action="edit" id="${consolidacaoInstance.id}"></g:link>
                                                </td>

                                                <td>${fieldValue(bean: consolidacaoInstance, field: "empresa")}</td>
					
						<td>${fieldValue(bean: consolidacaoInstance, field: "empresaOrigem")}</td>
					
                                                <td>${fieldValue(bean: consolidacaoInstance, field: "propriedadeOrigem")}</td>
                                                
						<td><g:formatDate date="${consolidacaoInstance.dataConsolidacao}" /></td>
					
						<td>${fieldValue(bean: consolidacaoInstance, field: "nrLoteConsolidado")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${consolidacaoInstanceTotal}" params="[empresaId: consultaInstance?.empresa?.id, empresaOrigemId: consultaInstance?.empresaOrigem?.id, propriedadeOrigemId: consultaInstance?.propriedadeOrigem?.id, nrLoteConsolidado: consultaInstance?.nrLoteConsolidado]"/>
			</div>
		</div>
	</body>
</html>
