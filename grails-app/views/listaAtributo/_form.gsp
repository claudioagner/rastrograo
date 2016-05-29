<%@ page import="rastrograo.estrutura.ListaAtributo" %>


<g:if test="${listaAtributoInstance?.atributo?.fase?.produto}">
<div class="fieldcontain">
        <span id="produto-label" class="property-label"><g:message code="atributo.produto.label" default="Produto" /></span>

                <span class="property-value" aria-labelledby="produto-label">${listaAtributoInstance?.atributo?.fase?.produto?.encodeAsHTML()}
                        <g:link controller="produto" class="show" action="show" id="${listaAtributoInstance?.atributo?.fase?.produto?.id}"></g:link>
                        <g:link controller="produto" class="edit" action="edit" id="${listaAtributoInstance?.atributo?.fase?.produto?.id}"></g:link>
                </span> 

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: listaAtributoInstance, field: 'atributo.fase.produto', 'error')} required">
	<label for="produto">
		<g:message code="atributo.produto.label" default="Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="produto" 
            name="produto.id" 
            from="${rastrograo.estrutura.Produto.list()}" 
            optionKey="id" 
            required="" 
            value="${listaAtributoInstance?.atributo?.fase?.produto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>
</g:else>

<g:if test="${listaAtributoInstance?.atributo?.fase}">
<div class="fieldcontain">
        <span id="fase-label" class="property-label"><g:message code="atributo.fase.label" default="Fase" /></span>

                <span class="property-value" aria-labelledby="fase-label">${listaAtributoInstance?.atributo?.fase?.encodeAsHTML()}
                        <g:link controller="fase" class="show" action="show" id="${listaAtributoInstance?.atributo?.fase?.id}"></g:link>
                        <g:link controller="fase" class="edit" action="edit" id="${listaAtributoInstance?.atributo?.fase?.id}"></g:link>
                </span> 

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: listaAtributoInstance, field: 'atributo.fase', 'error')} required">
	<label for="fase">
		<g:message code="atributo.fase.label" default="Fase" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="fase" 
            name="fase.id" 
            from="${listaAtributoInstance?.atributo?.fase?.produto?.fases}" 
            optionKey="id" 
            required="" 
            value="${listaAtributoInstance?.atributo?.fase?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Fase --']"/>
</div>
</g:else>

<g:if test="${listaAtributoInstance?.atributo}">
<div class="fieldcontain">
        <span id="atributo-label" class="property-label"><g:message code="listaAtributo.atributo.label" default="Atributo" /></span>

                <span class="property-value" aria-labelledby="atributo-label">${listaAtributoInstance?.atributo?.encodeAsHTML()}
                        <g:link controller="atributo" class="show" action="show" id="${listaAtributoInstance?.atributo?.id}"></g:link>
                        <g:link controller="atributo" class="edit" action="edit" id="${listaAtributoInstance?.atributo?.id}"></g:link>
                </span> 
                <g:hiddenField name="atributo.id" value="${listaAtributoInstance?.atributo?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: listaAtributoInstance, field: 'atributo', 'error')} required">
	<label for="atributo">
		<g:message code="listaAtributo.atributo.label" default="Atributo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="atributo" 
            name="atributo.id" 
            from="${listaAtributoInstance?.atributo?.fase?.atributos}" 
            optionKey="id" 
            required="" 
            value="${listaAtributoInstance?.atributo?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Atributo --']"/>
</div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: listaAtributoInstance, field: 'valorListaAtributo', 'error')} required">
	<label for="valorListaAtributo">
		<g:message code="listaAtributo.valorListaAtributo.label" default="Valor Lista Atributo" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="valorListaAtributo" maxlength="128" required="" value="${listaAtributoInstance?.valorListaAtributo}"/>
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
        $('#fase').change(function(){
            $.getJSON("${createLink(controller:'atributo',action:'ajaxGetAtributo')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#atributo").find("option").remove();
                $("#atributo").append("<option value=''>-- Selecione um Atributo --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#atributo").append("<option value='" + resposta[i].id + "'>" + resposta[i].nomeAtributo + "</option>");
                }
            })
        });
    });    
</script>