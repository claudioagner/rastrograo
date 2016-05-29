
<%@ page import="rastrograo.tabela.TipoCertificacao" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tipoCertificacao.label', default: 'TipoCertificacao')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tipoCertificacao" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-tipoCertificacao" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, tipoCertificacaoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="descricaoTipoCertificacao" title="${message(code: 'tipoCertificacao.descricaoTipoCertificacao.label', default: 'Descricao Tipo Certificacao')}" params="[descricaoTipoCertificacao: consultaInstance?.descricaoTipoCertificacao]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${tipoCertificacaoInstanceList}" status="i" var="tipoCertificacaoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="tipoCertificacao" class="show" action="show" id="${tipoCertificacaoInstance.id}"></g:link>

                                                        <g:link controller="tipoCertificacao" class="edit" action="edit" id="${tipoCertificacaoInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: tipoCertificacaoInstance, field: "descricaoTipoCertificacao")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${tipoCertificacaoInstanceTotal}" params="[descricaoTipoCertificacao: consultaInstance?.descricaoTipoCertificacao]"/>
			</div>
		</div>
	</body>
</html>
