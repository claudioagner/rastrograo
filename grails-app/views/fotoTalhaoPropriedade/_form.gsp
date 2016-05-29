<%@ page import="rastrograo.propriedade.FotoTalhaoPropriedade" %>


<g:if test="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade}">
        <div class="fieldcontain">
                <span id="propriedade-label" class="property-label"><g:message code="fotoTalhaoPropriedade.propriedade.label" default="Propriedade" /></span>

                        <span class="property-value" aria-labelledby="propriedade-label">${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade?.encodeAsHTML()}
                                <g:link controller="propriedade" class="show" action="show" id="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade?.id}"></g:link>
                                <g:link controller="propriedade" class="edit" action="edit" id="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade?.id}"></g:link>
                        </span>

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: fotoTalhaoPropriedadeInstance, field: 'propriedade', 'error')} required">
                <label for="propriedade">
                        <g:message code="fotoTalhaoPropriedade.propriedade.label" default="Propriedade" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="propriedade" 
                    name="propriedade.id" 
                    from="${propriedadeInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.propriedade?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Propriedade --']"/>
        </div>
</g:else>
  
<g:if test="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade}">
        <div class="fieldcontain">
                <span id="talhaoPropriedade-label" class="property-label"><g:message code="fotoTalhaoPropriedade.talhaoPropriedade.label" default="Talhao Propriedade" /></span>

                        <span class="property-value" aria-labelledby="talhaoPropriedade-label">${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.encodeAsHTML()}
                                <g:link controller="talhaoPropriedade" class="show" action="show" id="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.id}"></g:link>
                                <g:link controller="talhaoPropriedade" class="edit" action="edit" id="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.id}"></g:link>
                        </span>
                        <g:hiddenField name="talhaoPropriedade.id" value="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: fotoTalhaoPropriedadeInstance, field: 'talhaoPropriedade', 'error')} required">
                <label for="talhaoPropriedade">
                        <g:message code="fotoTalhaoPropriedade.talhaoPropriedade.label" default="Talhao Propriedade" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="talhaoPropriedade"
                    name="talhaoPropriedade.id" 
                    from="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade}" 
                    optionKey="id" 
                    required="" 
                    value="${fotoTalhaoPropriedadeInstance?.talhaoPropriedade?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um Talhão --']"/>
        </div>
</g:else>
    
<div class="fieldcontain ${hasErrors(bean: fotoTalhaoPropriedadeInstance, field: 'tituloFoto', 'error')} ">
	<label for="tituloFoto">
		<g:message code="fotoTalhaoPropriedade.tituloFoto.label" default="Titulo Foto" />
		
	</label>
	<g:textField name="tituloFoto" maxlength="128" value="${fotoTalhaoPropriedadeInstance?.tituloFoto}"/>
</div>
	
<g:if test="${fotoTalhaoPropriedadeInstance?.foto}">
        <div class="fieldcontain">
                <span id="foto-label" class="property-label"><g:message code="fotoTalhaoPropriedade.foto.label" default="Foto" /></span>
                        <img src="${createLink(controller:'fotoTalhaoPropriedade', action:'showFoto', id: fotoTalhaoPropriedadeInstance?.id)}"/>
        </div>
</g:if>
        
<div class="fieldcontain ${hasErrors(bean: fotoTalhaoPropriedadeInstance, field: 'foto', 'error')} required">
	<label for="foto">
		<g:message code="fotoTalhaoPropriedade.foto.label" default="Foto" />
		<span class="required-indicator">*</span>
	</label>
	<input type="file" id="foto" name="foto" />
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