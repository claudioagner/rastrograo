
<%@ page import="rastrograo.propriedade.FotoTalhaoPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'fotoTalhaoPropriedade.label', default: 'FotoTalhaoPropriedade')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-fotoTalhaoPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-fotoTalhaoPropriedade" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, fotoTalhaoPropriedadeInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <g:sortableColumn property="talhaoPropriedade.propriedade.nomePropriedade" title="${message(code: 'fotoTalhaoPropriedade.propriedade.label', default: 'Propriedade')}" params="[propriedadeId: consultaInstance?.talhaoPropriedade?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
                                                
                                                <g:sortableColumn property="talhaoPropriedade.descricaoTalhao" title="${message(code: 'fotoTalhaoPropriedade.propriedade.label', default: 'Propriedade')}" params="[propriedadeId: consultaInstance?.talhaoPropriedade?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
                                                
                                                <g:sortableColumn property="tituloFoto" title="${message(code: 'fotoPropriedade.tituloFoto.label', default: 'Titulo Foto')}" params="[propriedadeId: consultaInstance?.talhaoPropriedade?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
					
                                                <th>${message(code: 'fotoTalhaoPropriedade.foto.label', default: 'Foto')}</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${fotoTalhaoPropriedadeInstanceList}" status="i" var="fotoTalhaoPropriedadeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="fotoTalhaoPropriedade" class="show" action="show" id="${fotoTalhaoPropriedadeInstance.id}"></g:link>

                                                        <g:link controller="fotoTalhaoPropriedade" class="edit" action="edit" id="${fotoTalhaoPropriedadeInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: fotoTalhaoPropriedadeInstance, field: "talhaoPropriedade.propriedade")}</td>
					
						<td>${fieldValue(bean: fotoTalhaoPropriedadeInstance, field: "talhaoPropriedade")}</td>
					
						<td>${fieldValue(bean: fotoTalhaoPropriedadeInstance, field: "tituloFoto")}</td>
					
						<td><img style="width: 20%;"src="${createLink(controller:'fotoTalhaoPropriedade', action:'showFoto', id: fotoTalhaoPropriedadeInstance?.id)}"/></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${fotoTalhaoPropriedadeInstanceTotal}" params="[propriedadeId: consultaInstance?.talhaoPropriedade?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, tituloFoto: consultaInstance?.tituloFoto]"/>
			</div>
		</div>
	</body>
</html>
