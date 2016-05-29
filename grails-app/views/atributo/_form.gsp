<%@ page import="rastrograo.estrutura.Atributo" %>

<g:if test="${atributoInstance?.fase?.produto}">
<div class="fieldcontain">
        <span id="produto-label" class="property-label"><g:message code="atributo.produto.label" default="Produto" /></span>

                <span class="property-value" aria-labelledby="produto-label">${atributoInstance?.fase?.produto?.encodeAsHTML()}
                        <g:link controller="fase" class="show" action="show" id="${atributoInstance?.fase?.produto?.id}"></g:link>
                        <g:link controller="fase" class="edit" action="edit" id="${atributoInstance?.fase?.produto?.id}"></g:link>
                </span>
</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: atributoInstance, field: 'fase.produto', 'error')} required">
	<label for="produto">
		<g:message code="atributo.produto.label" default="Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="produto" 
            name="produto.id" 
            from="${rastrograo.estrutura.Produto.list()}" 
            optionKey="id" 
            required="" 
            value="${atributoInstance?.fase?.produto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>
</g:else>

<g:if test="${atributoInstance?.fase}">
<div class="fieldcontain">
        <span id="fase-label" class="property-label"><g:message code="atributo.fase.label" default="Fase" /></span>

                <span class="property-value" aria-labelledby="fase-label">${atributoInstance?.fase?.encodeAsHTML()}
                        <g:link controller="fase" class="show" action="show" id="${atributoInstance?.fase?.id}"></g:link>
                        <g:link controller="fase" class="edit" action="edit" id="${atributoInstance?.fase?.id}"></g:link>
                </span>
                <g:hiddenField name="fase.id" value="${atributoInstance?.fase?.id}" />
</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: atributoInstance, field: 'fase', 'error')} required">
	<label for="fase">
		<g:message code="atributo.fase.label" default="Fase" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="fase" 
            name="fase.id" 
            from="${atributoInstance?.fase?.produto?.fases}" 
            optionKey="id" 
            required="" 
            value="${atributoInstance?.fase?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Fase --']"/>
</div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: atributoInstance, field: 'nomeAtributo', 'error')} required">
	<label for="nomeAtributo">
		<g:message code="atributo.nomeAtributo.label" default="Nome Atributo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomeAtributo" maxlength="128" required="" value="${atributoInstance?.nomeAtributo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: atributoInstance, field: 'descricaoAtributo', 'error')} ">
	<label for="descricaoAtributo">
		<g:message code="atributo.descricaoAtributo.label" default="Descricao Atributo" />
		
	</label>
	<g:textArea name="descricaoAtributo" cols="40" rows="5" maxlength="65534" value="${atributoInstance?.descricaoAtributo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: atributoInstance, field: 'tipoAtributo', 'error')} required">
	<label for="tipoAtributo">
		<g:message code="atributo.tipoAtributo.label" default="Tipo Atributo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="tipoAtributo" 
            from="${atributoInstance.constraints.tipoAtributo.inList}" 
            required="" 
            value="${atributoInstance?.tipoAtributo}" 
            valueMessagePrefix="atributo.tipoAtributo"
            noSelection="['': '-- Selecione um Tipo --']"/>
</div>

<script>
    $(document).ready(function() {
        $('#produto').change(function(){
            $.getJSON("${createLink(controller:'fase',action:'ajaxGetFase')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#fase").find("option").remove();
                $("#fase").append("<option value=''>-- Selecione uma Fase --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#fase").append("<option value='" + resposta[i].id + "'>" + resposta[i].descricaoFase +"</option>");
                }
            })
        });
    });
</script>