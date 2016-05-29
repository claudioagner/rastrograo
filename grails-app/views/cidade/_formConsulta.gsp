<%@ page import="rastrograo.tabela.Cidade" %>


<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'estado.pais', 'error')} ">
	<label for="pais">
		<g:message code="estado.pais.label" default="Pais" />
	</label>
	<g:select id="pais" 
            name="paisId" 
            from="${rastrograo.tabela.Pais.list()}" 
            optionKey="id" 
            value="${consultaInstance?.estado?.pais?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um País --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'estado', 'error')} ">
	<label for="estado">
		<g:message code="cidade.estado.label" default="Estado" />
	</label>
	<g:select id="estado" 
            name="estadoId" 
            from="${estadoInstance}" 
            optionKey="id" 
            value="${consultaInstance?.estado?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Estado --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomeCidade', 'error')} ">
	<label for="nomeCidade">
		<g:message code="cidade.nomeCidade.label" default="Nome Cidade" />
	</label>
	<g:textField name="nomeCidade" maxlength="128" value="${consultaInstance?.nomeCidade}"/>
</div>

<script>
    $(document).ready(function() {
        $('#pais').change(function(){
            $.getJSON("${createLink(controller:'estado',action:'ajaxGetEstado')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#estado").find("option").remove();
                $("#estado").append("<option value=''>-- Selecione um Estado --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#estado").append("<option value='" + resposta[i].id + "'>" + resposta[i].nomeEstado +"-"+resposta[i].sigla +"</option>");
                }
            })
        })
    });    
</script>