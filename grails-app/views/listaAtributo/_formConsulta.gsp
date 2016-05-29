<%@ page import="rastrograo.estrutura.ListaAtributo" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'atributo.fase.produto', 'error')} ">
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

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'atributo.fase', 'error')} ">
	<label for="fase">
		<g:message code="atributo.fase.label" default="Fase" />
	</label>
	<g:select id="fase" 
            name="faseId" 
            from="${produtoInstance?.fases}" 
            optionKey="id" 
            value="${consultaInstance?.atributo?.fase?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Fase --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'atributo', 'error')} ">
	<label for="atributo">
		<g:message code="listaAtributo.atributo.label" default="Atributo" />
	</label>
	<g:select id="atributo" 
            name="atributoId" 
            from="${consultaInstance?.atributo?.fase?.atributos}" 
            optionKey="id" 
            value="${consultaInstance?.atributo?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Atributo --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'valorListaAtributo', 'error')} ">
	<label for="valorListaAtributo">
		<g:message code="listaAtributo.valorListaAtributo.label" default="Valor Lista Atributo" />
	</label>
	<g:textField name="valorListaAtributo" maxlength="128" value="${consultaInstance?.valorListaAtributo}"/>
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
        })
    });    
</script>