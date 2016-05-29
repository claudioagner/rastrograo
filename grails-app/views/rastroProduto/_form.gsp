<%@ page import="rastrograo.customizacao.RastroProduto" %>


<g:hiddenField name="situacao" value="${rastroProdutoInstance?.situacao ?: "Em andamento"}" />

<g:if test="${rastroProdutoInstance?.empresa}">
<div class="fieldcontain">
        <span id="empresa-label" class="property-label"><g:message code="rastroProduto.empresa.label" default="Empresa" /></span>

                <span class="property-value" aria-labelledby="empresa-label">${rastroProdutoInstance?.empresa?.encodeAsHTML()}
                        <g:link controller="empresa" class="show" action="show" id="${rastroProdutoInstance?.empresa?.id}"></g:link>
                        <g:link controller="empresa" class="edit" action="edit" id="${rastroProdutoInstance?.empresa?.id}"></g:link>
                </span>  
                <g:hiddenField name="empresa.id" value="${rastroProdutoInstance?.empresa?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'empresa', 'error')} required">
	<label for="empresa">
		<g:message code="rastroProduto.empresa.label" default="Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empresa" 
            name="empresa.id" 
            from="${empresaInstanceList}" 
            optionKey="id" 
            required="" 
            value="${rastroProdutoInstance?.empresa?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Empresa --']"/>
</div>
</g:else>

<g:if test="${rastroProdutoInstance?.propriedade}">
<div class="fieldcontain">
        <span id="propriedade-label" class="property-label"><g:message code="rastroProduto.propriedade.label" default="Propriedade" /></span>

                <span class="property-value" aria-labelledby="propriedade-label">${rastroProdutoInstance?.propriedade?.encodeAsHTML()}
                        <g:link controller="propriedade" class="show" action="show" id="${rastroProdutoInstance?.propriedade?.id}"></g:link>
                        <g:link controller="propriedade" class="edit" action="edit" id="${rastroProdutoInstance?.propriedade?.id}"></g:link>
                </span>  
                <g:hiddenField name="propriedade.id" value="${rastroProdutoInstance?.propriedade?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'propriedade', 'error')} required">
	<label for="propriedade">
		<g:message code="rastroProduto.propriedade.label" default="Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="propriedade" 
            name="propriedade.id" 
            from="${propriedadeInstanceList}" 
            optionKey="id" 
            required="" 
            value="${rastroProdutoInstance?.propriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Propriedade --']"/>
</div>
</g:else>

<g:if test="${rastroProdutoInstance?.talhaoPropriedade}">
<div class="fieldcontain">
        <span id="talhaoPropriedade-label" class="property-label"><g:message code="rastroProduto.talhaoPropriedade.label" default="Talhao Propriedade" /></span>

                <span class="property-value" aria-labelledby="talhaoPropriedade-label">${rastroProdutoInstance?.talhaoPropriedade?.encodeAsHTML()}
                        <g:link controller="talhaoPropriedade" class="show" action="show" id="${rastroProdutoInstance?.talhaoPropriedade?.id}"></g:link>
                        <g:link controller="talhaoPropriedade" class="edit" action="edit" id="${rastroProdutoInstance?.talhaoPropriedade?.id}"></g:link>
                </span>  
                <g:hiddenField name="talhaoPropriedade.id" value="${rastroProdutoInstance?.talhaoPropriedade?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'talhaoPropriedade', 'error')} required">
	<label for="talhaoPropriedade">
		<g:message code="rastroProduto.talhaoPropriedade.label" default="Talhao Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="talhaoPropriedade" 
            name="talhaoPropriedade.id" 
            from="${rastroProdutoInstance?.propriedade?.talhoes}" 
            optionKey="id" 
            required="" 
            value="${rastroProdutoInstance?.talhaoPropriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Talhão --']"/>
</div>
</g:else>

<g:if test="${rastroProdutoInstance?.produto}">
<div class="fieldcontain">
        <span id="produto-label" class="property-label"><g:message code="rastroProduto.produto.label" default="Produto" /></span>

                <span class="property-value" aria-labelledby="produto-label">${rastroProdutoInstance?.produto?.encodeAsHTML()}
                        <g:link controller="produto" class="show" action="show" id="${rastroProdutoInstance?.produto?.id}"></g:link>
                        <g:link controller="produto" class="edit" action="edit" id="${rastroProdutoInstance?.produto?.id}"></g:link>
                </span>  
                <g:hiddenField name="produto.id" value="${rastroProdutoInstance?.produto?.id}" />
</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'produto', 'error')} required">
	<label for="produto">
		<g:message code="rastroProduto.produto.label" default="Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="produto" 
            name="produto.id" 
            from="${rastrograo.estrutura.Produto.list()}"
            optionKey="id" 
            required="" 
            value="${rastroProdutoInstance?.produto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>
</g:else>

<g:if test="${rastroProdutoInstance?.cultivar}">
<div class="fieldcontain">
        <span id="cultivar-label" class="property-label"><g:message code="rastroProduto.cultivar.label" default="Cultivar" /></span>

                <span class="property-value" aria-labelledby="cultivar-label">${rastroProdutoInstance?.cultivar?.encodeAsHTML()}
                        <g:link controller="cultivar" class="show" action="show" id="${rastroProdutoInstance?.cultivar?.id}"></g:link>
                        <g:link controller="cultivar" class="edit" action="edit" id="${rastroProdutoInstance?.cultivar?.id}"></g:link>
                </span>  
                <g:hiddenField name="cultivar.id" value="${rastroProdutoInstance?.cultivar?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'cultivar', 'error')} required">
	<label for="cultivar">
		<g:message code="rastroProduto.cultivar.label" default="Cultivar" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cultivar" 
            name="cultivar.id"
            from="${rastroProdutoInstance?.produto?.cultivares}"
            optionKey="id"
            required="" 
            value="${rastroProdutoInstance?.cultivar?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Cultivar --']"/>
</div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'anoSafra', 'error')} required">
	<label for="anoSafra">
		<g:message code="rastroProduto.anoSafra.label" default="Ano Safra" />
		<span class="required-indicator">*</span>
	</label>
	<g:select disabled="${rastroProdutoInstance?.situacao.equals('Encerrado')}"
            name="anoSafra"
            from="${2016..2050}"
            required="" 
            value="${rastroProdutoInstance?.anoSafra ?: Calendar.getInstance().get(Calendar.YEAR)}"/>
</div>
    
<div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'situacao', 'error')} ">
        <label for="situacao">
                <g:message code="rastroProduto.situacao.label" default="Situacao" />

        </label>
        <g:fieldValue bean="${rastroProdutoInstance}" field="situacao"/>
</div>

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
                            <td style="text-align:center;"><g:checkBox disabled="${rastroProdutoInstance?.situacao.equals('Encerrado')}" name="${rastroAtributoInstance?.id}" value="${rastroAtributoInstance?.registrarDados}" onClick="saveRastroAtributo(this.id, this.checked, 'registrarDados');"/></td>
                            <td style="text-align:center;"><g:checkBox name="${rastroAtributoInstance?.id}" value="${rastroAtributoInstance?.exibirQRConsumidor}" onClick="saveRastroAtributo(this.id, this.checked, 'exibirQRConsumidor');"/></td>
                        </tr>
                        <g:each in="${rastroAtributoInstance.registros}" status="j" var="registroDadosInstance">
                            <tr class="${(j % 2) == 0 ? 'even' : 'odd'}">
                                <td colspan="3" style="text-indent: 15px;"><i><b>${registroDadosInstance.valorAtributo ?: registroDadosInstance.valorDataAtributo ?: registroDadosInstance.valorListaAtributo}</b></i></td>
                            </tr>
                        </g:each>
                    </g:each>
                </tbody>
            </table>
        </g:each>
    </div>
</g:if>    
            
<div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'dataCriado', 'error')} required">
	<label for="dataCriado">
		<g:message code="rastroProduto.dataCriado.label" default="Data Criado" />
		<span class="required-indicator">*</span>
	</label>
        <g:formatDate format="dd/MM/yyyy HH:mm" date="${rastroProdutoInstance?.dataCriado}"/>
</div>

<g:if test="${rastroProdutoInstance?.dataAlterado}">
        <div class="fieldcontain ${hasErrors(bean: rastroProdutoInstance, field: 'dataAlterado', 'error')} ">
                <label for="dataAlterado">
                        <g:message code="rastroProduto.dataAlterado.label" default="Data Alterado" />

                </label>
                <g:formatDate format="dd/MM/yyyy HH:mm" date="${rastroProdutoInstance?.dataAlterado}"/>
        </div>
</g:if>
                
        
<script>
    $(document).ready(function() {
        $('#propriedade').change(function(){
            $.getJSON("${createLink(controller:'talhaoPropriedade',action:'ajaxGetTalhaoPropriedade')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#talhaoPropriedade").find("option").remove();
                $("#talhaoPropriedade").append("<option value=''>-- Selecione um Talhão --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#talhaoPropriedade").append("<option value='" + resposta[i].id + "'>" + resposta[i].descricaoTalhao +"</option>");
                }
            })
        });
        $('#produto').change(function(){
            $.getJSON("${createLink(controller:'cultivar',action:'ajaxGetCultivar')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#cultivar").find("option").remove();
                $("#cultivar").append("<option value=''>-- Selecione um Cultivar --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#cultivar").append("<option value='" + resposta[i].id + "'>" + resposta[i].descricaoCultivar +"</option>");
                }
            })
        });
    });
    
    function saveRastroAtributo(rastroAtributoId, valorBoolean, campo){
        <g:remoteFunction controller="rastroProduto" action="saveCheck" params="'rastroAtributoId='+rastroAtributoId+'&valorBoolean='+valorBoolean+'&campo='+campo"/>
    }
</script>