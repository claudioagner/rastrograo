
<%@ page import="rastrograo.propriedade.FotoPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fotoPropriedade.label', default: 'FotoPropriedade')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-fotoPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-fotoPropriedade" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, fotoPropriedadeInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="propriedade.nomePropriedade" title="${message(code: 'fotoPropriedade.propriedade.label', default: 'Propriedade')}" params="[propriedadeId: consultaInstance?.propriedade?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
                                                
                                                <g:sortableColumn property="tituloFoto" title="${message(code: 'fotoPropriedade.tituloFoto.label', default: 'Titulo Foto')}" params="[propriedadeId: consultaInstance?.propriedade?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
					
                                                <th>${message(code: 'fotoPropriedade.foto.label', default: 'Foto')}</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${fotoPropriedadeInstanceList}" status="i" var="fotoPropriedadeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="fotoPropriedade" class="show" action="show" id="${fotoPropriedadeInstance.id}"></g:link>

                                                        <g:link controller="fotoPropriedade" class="edit" action="edit" id="${fotoPropriedadeInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: fotoPropriedadeInstance, field: "propriedade")}</td>
					
                                                <td>${fieldValue(bean: fotoPropriedadeInstance, field: "tituloFoto")}</td>
                                                
						<td><img style="width: 20%;"src="${createLink(controller:'fotoPropriedade', action:'showFoto', id: fotoPropriedadeInstance?.id)}"/></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${fotoPropriedadeInstanceTotal}" params="[propriedadeId: consultaInstance?.propriedade?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
			</div>
		</div>
	</body>
</html>
