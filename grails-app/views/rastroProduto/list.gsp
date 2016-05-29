
<%@ page import="rastrograo.customizacao.RastroProduto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'rastroProduto.label', default: 'RastroProduto')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-rastroProduto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-rastroProduto" class="content scaffold-list" role="main">
                        
                        <g:render template="/layouts/formConsulta"/>
                        
			<h1><g:message code="default.listTotal.label" args="[entityName, rastroProdutoInstanceTotal]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
                                                <th>${message(code: 'default.action.label', default: 'Action')}</th>
					
						<g:sortableColumn property="empresa.nomeEmpresa" title="${message(code: 'rastroProduto.empresa.label', default: 'Empresa')}" params="[empresaId: consultaInstance?.empresa?.id, propriedadeId: consultaInstance?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, produtoId: consultaInstance?.produto?.id, cultivarId: consultaInstance?.cultivar?.id, anoSafra: consultaInstance?.anoSafra]"/>
                                                
                                                <g:sortableColumn property="propriedade.nomePropriedade" title="${message(code: 'rastroProduto.propriedade.label', default: 'Propriedade')}" params="[empresaId: consultaInstance?.empresa?.id, propriedadeId: consultaInstance?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, produtoId: consultaInstance?.produto?.id, cultivarId: consultaInstance?.cultivar?.id, anoSafra: consultaInstance?.anoSafra]"/>
                                                
						<g:sortableColumn property="talhaoPropriedade.descricaoTalhao" title="${message(code: 'rastroProduto.talhaoPropriedade.label', default: 'Talhao Propriedade')}" params="[empresaId: consultaInstance?.empresa?.id, propriedadeId: consultaInstance?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, produtoId: consultaInstance?.produto?.id, cultivarId: consultaInstance?.cultivar?.id, anoSafra: consultaInstance?.anoSafra]"/>
					
						<g:sortableColumn property="produto.descricaoProduto" title="${message(code: 'rastroProduto.produto.label', default: 'Produto')}" params="[empresaId: consultaInstance?.empresa?.id, propriedadeId: consultaInstance?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, produtoId: consultaInstance?.produto?.id, cultivarId: consultaInstance?.cultivar?.id, anoSafra: consultaInstance?.anoSafra]"/>
					
						<g:sortableColumn property="cultivar.descricaoCultivar" title="${message(code: 'rastroProduto.cultivar.label', default: 'Cultivar')}" params="[empresaId: consultaInstance?.empresa?.id, propriedadeId: consultaInstance?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, produtoId: consultaInstance?.produto?.id, cultivarId: consultaInstance?.cultivar?.id, anoSafra: consultaInstance?.anoSafra]"/>
					
						<g:sortableColumn property="anoSafra" title="${message(code: 'rastroProduto.anoSafra.label', default: 'Ano Safra')}" params="[empresaId: consultaInstance?.empresa?.id, propriedadeId: consultaInstance?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, produtoId: consultaInstance?.produto?.id, cultivarId: consultaInstance?.cultivar?.id, anoSafra: consultaInstance?.anoSafra]"/>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${rastroProdutoInstanceList}" status="i" var="rastroProdutoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="rastroProduto" class="show" action="show" id="${rastroProdutoInstance.id}"></g:link>

                                                        <g:link controller="rastroProduto" class="edit" action="edit" id="${rastroProdutoInstance.id}"></g:link>
                                                        
                                                        <g:jasperReport
                                                            jasper="rastreamento"
                                                            format="PDF"
                                                            delimiter=" "
                                                            name="">
                                                            <g:hiddenField name="SUBREPORT_DIR" value="${SUBREPORT_DIR}" />
                                                            <g:hiddenField name="rastreamentoId" value="${rastroProdutoInstance?.id}" />
                                                        </g:jasperReport>
                                                </td>
                                                
						<td>${fieldValue(bean: rastroProdutoInstance, field: "empresa")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "propriedade")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "talhaoPropriedade")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "produto")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "cultivar")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "anoSafra")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${rastroProdutoInstanceTotal}" params="[empresaId: consultaInstance?.empresa?.id, propriedadeId: consultaInstance?.propriedade?.id, talhaoPropriedadeId: consultaInstance?.talhaoPropriedade?.id, produtoId: consultaInstance?.produto?.id, cultivarId: consultaInstance?.cultivar?.id, anoSafra: consultaInstance?.anoSafra]"/>
			</div>
		</div>
	</body>
</html>
