<%@ page import="rastrograo.propriedade.FotoTalhaoPropriedade" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'talhaoPropriedade.propriedade', 'error')} ">
	<label for="propriedade">
		<g:message code="fotoTalhaoPropriedade.propriedade.label" default="Propriedade" />
	</label>
	<g:select id="propriedade" 
            name="propriedadeId" 
            from="${propriedadeInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.talhaoPropriedade?.propriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Propriedade --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'talhaoPropriedade', 'error')} ">
	<label for="talhaoPropriedade">
		<g:message code="fotoTalhaoPropriedade.talhaoPropriedade.label" default="Talhao Propriedade" />
	</label>
	<g:select id="talhaoPropriedade"
            name="talhaoPropriedadeId" 
            from="${consultaInstance?.talhaoPropriedade}" 
            optionKey="id" 
            value="${consultaInstance?.talhaoPropriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Talhão --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tituloFoto', 'error')} ">
	<label for="tituloFoto">
		<g:message code="fotoTalhaoPropriedade.tituloFoto.label" default="Titulo Foto" />
		
	</label>
	<g:textField name="tituloFoto" maxlength="128" value="${consultaInstance?.tituloFoto}"/>
</div>

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
        })
    });    
</script>