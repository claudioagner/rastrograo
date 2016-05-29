
<%@ page import="rastrograo.empresa.CertificacaoEmpresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'certificacaoEmpresa.label', default: 'CertificacaoEmpresa')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-certificacaoEmpresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-certificacaoEmpresa" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, certificacaoEmpresaInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="tipoCertificacao.descricaoTipoCertificacao" title="${message(code: 'certificacaoEmpresa.tipoCertificacao.label', default: 'Tipo Certificacao')}" params="[tipoCertificacaoId: consultaInstance?.tipoCertificacao?.id, empresaId: consultaInstance?.empresa?.id]"/>
					
                                                <g:sortableColumn property="empresa.nomeEmpresa" title="${message(code: 'certificacaoEmpresa.empresa.label', default: 'Empresa')}" params="[tipoCertificacaoId: consultaInstance?.tipoCertificacao?.id, empresaId: consultaInstance?.empresa?.id]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${certificacaoEmpresaInstanceList}" status="i" var="certificacaoEmpresaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="certificacaoEmpresa" class="show" action="show" id="${certificacaoEmpresaInstance.id}"></g:link>

                                                        <g:link controller="certificacaoEmpresa" class="edit" action="edit" id="${certificacaoEmpresaInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: certificacaoEmpresaInstance, field: "tipoCertificacao")}</td>
					
						<td>${fieldValue(bean: certificacaoEmpresaInstance, field: "empresa")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${certificacaoEmpresaInstanceTotal}" params="[tipoCertificacaoId: consultaInstance?.tipoCertificacao?.id, empresaId: consultaInstance?.empresa?.id]"/>
			</div>
		</div>
	</body>
</html>
