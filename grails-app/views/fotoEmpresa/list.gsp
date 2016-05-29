
<%@ page import="rastrograo.empresa.FotoEmpresa" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fotoEmpresa.label', default: 'FotoEmpresa')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-fotoEmpresa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-fotoEmpresa" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, fotoEmpresaInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="empresa.nomeEmpresa" title="${message(code: 'fotoEmpresa.empresa.label', default: 'Empresa')}" params="[empresaId: consultaInstance?.empresa?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
                                                
                                                <g:sortableColumn property="tituloFoto" title="${message(code: 'fotoEmpresa.tituloFoto.label', default: 'Titulo Foto')}" params="[empresaId: consultaInstance?.empresa?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
					
                                                <th>${message(code: 'fotoEmpresa.foto.label', default: 'Foto')}</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${fotoEmpresaInstanceList}" status="i" var="fotoEmpresaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="fotoEmpresa" class="show" action="show" id="${fotoEmpresaInstance.id}"></g:link>

                                                        <g:link controller="fotoEmpresa" class="edit" action="edit" id="${fotoEmpresaInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: fotoEmpresaInstance, field: "empresa")}</td>
					
                                                <td>${fieldValue(bean: fotoEmpresaInstance, field: "tituloFoto")}</td>
                                                
						<td><img style="width: 20%;"src="${createLink(controller:'fotoEmpresa', action:'showFoto', id: fotoEmpresaInstance?.id)}"/></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${fotoEmpresaInstanceTotal}" params="[empresaId: consultaInstance?.empresa?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
			</div>
		</div>
	</body>
</html>
