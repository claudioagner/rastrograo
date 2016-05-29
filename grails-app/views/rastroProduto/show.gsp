
<%@ page import="rastrograo.customizacao.RastroProduto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'rastroProduto.label', default: 'RastroProduto')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-rastroProduto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-rastroProduto" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list rastroProduto">
			
				<g:if test="${rastroProdutoInstance?.empresa}">
				<li class="fieldcontain">
					<span id="empresa-label" class="property-label"><g:message code="rastroProduto.empresa.label" default="Empresa" /></span>
					
						<span class="property-value" aria-labelledby="empresa-label">${rastroProdutoInstance?.empresa?.encodeAsHTML()}
                                                        <g:link controller="empresa" class="show" action="show" id="${rastroProdutoInstance?.empresa?.id}"></g:link>
                                                        <g:link controller="empresa" class="edit" action="edit" id="${rastroProdutoInstance?.empresa?.id}"></g:link>
                                                </span>  
					
				</li>
				</g:if>
			
				<g:if test="${rastroProdutoInstance?.propriedade}">
				<li class="fieldcontain">
					<span id="propriedade-label" class="property-label"><g:message code="rastroProduto.propriedade.label" default="Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="propriedade-label">${rastroProdutoInstance?.propriedade?.encodeAsHTML()}
                                                        <g:link controller="propriedade" class="show" action="show" id="${rastroProdutoInstance?.propriedade?.id}"></g:link>
                                                        <g:link controller="propriedade" class="edit" action="edit" id="${rastroProdutoInstance?.propriedade?.id}"></g:link>
                                                </span> 
					
				</li>
				</g:if>
			
				<g:if test="${rastroProdutoInstance?.talhaoPropriedade}">
				<li class="fieldcontain">
					<span id="talhaoPropriedade-label" class="property-label"><g:message code="rastroProduto.talhaoPropriedade.label" default="Talhao Propriedade" /></span>
					
						<span class="property-value" aria-labelledby="talhaoPropriedade-label">${rastroProdutoInstance?.talhaoPropriedade?.encodeAsHTML()}
                                                        <g:link controller="talhaoPropriedade" class="show" action="show" id="${rastroProdutoInstance?.talhaoPropriedade?.id}"></g:link>
                                                        <g:link controller="talhaoPropriedade" class="edit" action="edit" id="${rastroProdutoInstance?.talhaoPropriedade?.id}"></g:link>
                                                </span> 
					
				</li>
				</g:if>
			
				<g:if test="${rastroProdutoInstance?.produto}">
				<li class="fieldcontain">
					<span id="produto-label" class="property-label"><g:message code="rastroProduto.produto.label" default="Produto" /></span>
					
						<span class="property-value" aria-labelledby="produto-label">${rastroProdutoInstance?.produto?.encodeAsHTML()}
                                                        <g:link controller="produto" class="show" action="show" id="${rastroProdutoInstance?.produto?.id}"></g:link>
                                                        <g:link controller="produto" class="edit" action="edit" id="${rastroProdutoInstance?.produto?.id}"></g:link>
                                                </span> 
					
				</li>
				</g:if>
			
				<g:if test="${rastroProdutoInstance?.cultivar}">
				<li class="fieldcontain">
					<span id="cultivar-label" class="property-label"><g:message code="rastroProduto.cultivar.label" default="Cultivar" /></span>
					
						<span class="property-value" aria-labelledby="cultivar-label">${rastroProdutoInstance?.cultivar?.encodeAsHTML()}
                                                        <g:link controller="cultivar" class="show" action="show" id="${rastroProdutoInstance?.cultivar?.id}"></g:link>
                                                        <g:link controller="cultivar" class="edit" action="edit" id="${rastroProdutoInstance?.cultivar?.id}"></g:link>
                                                </span> 
					
				</li>
				</g:if>
			
				<g:if test="${rastroProdutoInstance?.anoSafra}">
				<li class="fieldcontain">
					<span id="anoSafra-label" class="property-label"><g:message code="rastroProduto.anoSafra.label" default="Ano Safra" /></span>
					
						<span class="property-value" aria-labelledby="anoSafra-label"><g:fieldValue bean="${rastroProdutoInstance}" field="anoSafra"/></span>
					
				</li>
				</g:if>
                                
                                <g:if test="${rastroProdutoInstance?.situacao}">
				<li class="fieldcontain">
					<span id="situacao-label" class="property-label"><g:message code="rastroProduto.situacao.label" default="Situacao" /></span>
					
						<span class="property-value" aria-labelledby="situacao-label"><g:fieldValue bean="${rastroProdutoInstance}" field="situacao"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${rastroProdutoInstance?.rastrosFase}">
                                    <div id="list-rastrosAtributo" class="content scaffold-list" role="main">
                                        <g:each in="${rastroProdutoInstance?.rastrosFase.sort{it.fase.descricaoFase}}" var="rastroFaseInstance">
                                            <h1>${rastroFaseInstance?.encodeAsHTML()}</h1>
                                            <table>
                                                <thead>
                                                    <tr>
                                                        <th style="width: 75%; vertical-align: middle;">${message(code: 'rastroAtributo.atributo.label', default: 'Atributo')}</th>
                                                        <th style="vertical-align: middle; text-align:center;">${message(code: 'rastroAtributo.registrarDados.label', default: 'Registrar<br>Dados')}</th>
                                                        <th style="vertical-align: middle; text-align:center;">${message(code: 'rastroAtributo.exibirQRConsumidor.label', default: 'QRCode<br>Consumidor')}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <g:each in="${rastroFaseInstance?.rastrosAtributo}" status="i" var="rastroAtributoInstance">
                                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                            <td>${rastroAtributoInstance?.atributo?.encodeAsHTML()}</td>
                                                            <td style="text-align:center;"><g:formatBoolean boolean="${rastroAtributoInstance?.registrarDados}" /></td>
                                                            <td style="text-align:center;"><g:formatBoolean boolean="${rastroAtributoInstance?.exibirQRConsumidor}" /></td>
                                                        </tr>
                                                        <g:each in="${rastroAtributoInstance.registros}" status="j" var="registroDadosInstance">
                                                            <tr class="${(j % 2) == 0 ? 'even' : 'odd'}">
                                                                <td colspan="3" style="text-indent: 15px;"><i><b>
                                                                            <g:if test="${registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo?.equals('Data')}">
                                                                                <g:formatDate date="${registroDadosInstance?.valorDataAtributo}" format="dd/MM/yyyy"/>
                                                                            </g:if>
                                                                            <g:elseif test="${registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo?.equals('Data/Hora')}">
                                                                                <g:formatDate date="${registroDadosInstance?.valorDataAtributo}" format="dd/MM/yyyy HH:mm"/>
                                                                            </g:elseif>
                                                                            <g:elseif test="${registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo?.equals('Lista')}">
                                                                                ${fieldValue(bean: registroDadosInstance, field: "valorListaAtributo")}
                                                                            </g:elseif>
                                                                            <g:elseif test="${registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo?.equals('Texto')}">
                                                                                ${fieldValue(bean: registroDadosInstance, field: "valorAtributo")}
                                                                            </g:elseif>
                                                                        </b></i></td>
                                                            </tr>
                                                        </g:each>
                                                    </g:each>
                                                </tbody>
                                            </table>
                                        </g:each>
                                    </div>
                                </g:if>    
                                
				<g:if test="${rastroProdutoInstance?.dataCriado}">
				<li class="fieldcontain">
					<span id="dataCriado-label" class="property-label"><g:message code="rastroProduto.dataCriado.label" default="Data Criado" /></span>
					
						<span class="property-value" aria-labelledby="dataCriado-label"><g:formatDate date="${rastroProdutoInstance?.dataCriado}" format="dd/MM/yyyy HH:mm"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${rastroProdutoInstance?.dataAlterado}">
				<li class="fieldcontain">
					<span id="dataAlterado-label" class="property-label"><g:message code="rastroProduto.dataAlterado.label" default="Data Alterado" /></span>
					
						<span class="property-value" aria-labelledby="dataAlterado-label"><g:formatDate date="${rastroProdutoInstance?.dataAlterado}" format="dd/MM/yyyy HH:mm"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${rastroProdutoInstance?.id}" />
					<g:link class="edit" action="edit" id="${rastroProdutoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
