
<%@ page import="rastrograo.propriedade.ResponsavelPropriedade" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'responsavelPropriedade.label', default: 'ResponsavelPropriedade')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-responsavelPropriedade" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-responsavelPropriedade" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, responsavelPropriedadeInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="tipoResponsavel.descricaoTipoResponsavel" title="${message(code: 'responsavelPropriedade.tipoResponsavel.label', default: 'Tipo Responsavel')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, propriedadeId: consultaInstance?.propriedade?.id, nomeResponsavelPropriedade: consultaInstance?.nomeResponsavelPropriedade, dddResponsavelPropriedade: consultaInstance?.dddResponsavelPropriedade, numeroTelefoneResponsavelPropriedade: consultaInstance?.numeroTelefoneResponsavelPropriedade]"/>
					
                                                <g:sortableColumn property="propriedade.nomePropriedade" title="${message(code: 'responsavelPropriedade.propriedade.label', default: 'Propriedade')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, propriedadeId: consultaInstance?.propriedade?.id, nomeResponsavelPropriedade: consultaInstance?.nomeResponsavelPropriedade, dddResponsavelPropriedade: consultaInstance?.dddResponsavelPropriedade, numeroTelefoneResponsavelPropriedade: consultaInstance?.numeroTelefoneResponsavelPropriedade]"/>
					
                                                <g:sortableColumn property="nomeResponsavelPropriedade" title="${message(code: 'responsavelPropriedade.nomeResponsavelPropriedade.label', default: 'Nome Responsavel Propriedade')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, propriedadeId: consultaInstance?.propriedade?.id, nomeResponsavelPropriedade: consultaInstance?.nomeResponsavelPropriedade, dddResponsavelPropriedade: consultaInstance?.dddResponsavelPropriedade, numeroTelefoneResponsavelPropriedade: consultaInstance?.numeroTelefoneResponsavelPropriedade]"/>
					
						<g:sortableColumn property="dddResponsavelPropriedade" title="${message(code: 'responsavelPropriedade.dddResponsavelPropriedade.label', default: 'Ddd Responsavel Propriedade')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, propriedadeId: consultaInstance?.propriedade?.id, nomeResponsavelPropriedade: consultaInstance?.nomeResponsavelPropriedade, dddResponsavelPropriedade: consultaInstance?.dddResponsavelPropriedade, numeroTelefoneResponsavelPropriedade: consultaInstance?.numeroTelefoneResponsavelPropriedade]"/>
					
						<g:sortableColumn property="numeroTelefoneResponsavelPropriedade" title="${message(code: 'responsavelPropriedade.numeroTelefoneResponsavelPropriedade.label', default: 'Numero Telefone Responsavel Propriedade')}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, propriedadeId: consultaInstance?.propriedade?.id, nomeResponsavelPropriedade: consultaInstance?.nomeResponsavelPropriedade, dddResponsavelPropriedade: consultaInstance?.dddResponsavelPropriedade, numeroTelefoneResponsavelPropriedade: consultaInstance?.numeroTelefoneResponsavelPropriedade]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${responsavelPropriedadeInstanceList}" status="i" var="responsavelPropriedadeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="responsavelPropriedade" class="show" action="show" id="${responsavelPropriedadeInstance.id}"></g:link>

                                                        <g:link controller="responsavelPropriedade" class="edit" action="edit" id="${responsavelPropriedadeInstance.id}"></g:link>
                                                </td>
                                                
                                                <td>${fieldValue(bean: responsavelPropriedadeInstance, field: "tipoResponsavel")}</td>
					
						<td>${fieldValue(bean: responsavelPropriedadeInstance, field: "propriedade")}</td>
					
						<td>${fieldValue(bean: responsavelPropriedadeInstance, field: "nomeResponsavelPropriedade")}</td>
					
						<td>${fieldValue(bean: responsavelPropriedadeInstance, field: "dddResponsavelPropriedade")}</td>
					
						<td>${fieldValue(bean: responsavelPropriedadeInstance, field: "numeroTelefoneResponsavelPropriedade")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${responsavelPropriedadeInstanceTotal}" params="[tipoResponsavelId: consultaInstance?.tipoResponsavel?.id, propriedadeId: consultaInstance?.propriedade?.id, nomeResponsavelPropriedade: consultaInstance?.nomeResponsavelPropriedade, dddResponsavelPropriedade: consultaInstance?.dddResponsavelPropriedade, numeroTelefoneResponsavelPropriedade: consultaInstance?.numeroTelefoneResponsavelPropriedade]"/>
			</div>
		</div>
	</body>
</html>
