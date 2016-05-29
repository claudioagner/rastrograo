<%@ page import="rastrograo.estrutura.Atributo" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'fase.produto', 'error')} ">
	<label for="produto">
		<g:message code="atributo.produto.label" default="Produto" />
	</label>
	<g:select id="produto" 
            name="produtoId" 
            from="${rastrograo.estrutura.Produto.list()}" 
            optionKey="id" 
            value="${produtoInstance?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'fase', 'error')} ">
	<label for="fase">
		<g:message code="atributo.fase.label" default="Fase" />
	</label>
	<g:select id="fase" 
            name="faseId" 
            from="${produtoInstance?.fases}" 
            optionKey="id" 
            value="${consultaInstance?.fase?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Fase --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomeAtributo', 'error')} ">
	<label for="nomeAtributo">
		<g:message code="atributo.nomeAtributo.label" default="Nome Atributo" />
	</label>
	<g:textField name="nomeAtributo" maxlength="128" value="${consultaInstance?.nomeAtributo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tipoAtributo', 'error')} ">
	<label for="tipoAtributo">
		<g:message code="atributo.tipoAtributo.label" default="Tipo Atributo" />
	</label>
	<g:select name="tipoAtributo" 
            from="${['Data', 'Data/Hora', 'Lista', 'Texto']}" 
            value="${consultaInstance?.tipoAtributo}" 
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