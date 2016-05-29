
<%@ page import="rastrograo.tabela.TipoResponsavel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tipoResponsavel.label', default: 'TipoResponsavel')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tipoResponsavel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-tipoResponsavel" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, tipoResponsavelInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="descricaoTipoResponsavel" title="${message(code: 'tipoResponsavel.descricaoTipoResponsavel.label', default: 'Descricao Tipo Responsavel')}" params="[descricaoTipoResponsavel: consultaInstance?.descricaoTipoResponsavel]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${tipoResponsavelInstanceList}" status="i" var="tipoResponsavelInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="tipoResponsavel" class="show" action="show" id="${tipoResponsavelInstance.id}"></g:link>

                                                        <g:link controller="tipoResponsavel" class="edit" action="edit" id="${tipoResponsavelInstance.id}"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: tipoResponsavelInstance, field: "descricaoTipoResponsavel")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${tipoResponsavelInstanceTotal}" params="[descricaoTipoResponsavel: consultaInstance?.descricaoTipoResponsavel]"/>
			</div>
		</div>
	</body>
</html>
