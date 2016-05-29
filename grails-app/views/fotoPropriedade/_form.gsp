<%@ page import="rastrograo.propriedade.FotoPropriedade" %>


<g:if test="${fotoPropriedadeInstance?.propriedade}">
        <div class="fieldcontain">
                <span id="propriedade-label" class="property-label"><g:message code="fotoPropriedade.propriedade.label" default="Propriedade" /></span>

                        <span class="property-value" aria-labelledby="propriedade-label">${fotoPropriedadeInstance?.propriedade?.encodeAsHTML()}
                                <g:link controller="propriedade" class="show" action="show" id="${fotoPropriedadeInstance?.propriedade?.id}"></g:link>
                                <g:link controller="propriedade" class="edit" action="edit" id="${fotoPropriedadeInstance?.propriedade?.id}"></g:link>
                        </span>

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: fotoPropriedadeInstance, field: 'propriedade', 'error')} required">
                <label for="propriedade">
                        <g:message code="fotoPropriedade.propriedade.label" default="Propriedade" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="propriedade" 
                    name="propriedade.id" 
                    from="${propriedadeInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${fotoPropriedadeInstance?.propriedade?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Propriedade --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: fotoPropriedadeInstance, field: 'tituloFoto', 'error')} ">
	<label for="tituloFoto">
		<g:message code="fotoPropriedade.tituloFoto.label" default="Titulo Foto" />
		
	</label>
	<g:textField name="tituloFoto" maxlength="128" value="${fotoPropriedadeInstance?.tituloFoto}"/>
</div>
		
<g:if test="${fotoPropriedadeInstance?.foto}">
        <div class="fieldcontain">
                <span id="foto-label" class="property-label"><g:message code="fotoPropriedade.foto.label" default="Foto" /></span>
                        <img src="${createLink(controller:'fotoPropriedade', action:'showFoto', id: fotoPropriedadeInstance?.id)}"/>
        </div>
</g:if>
                                
<div class="fieldcontain ${hasErrors(bean: fotoPropriedadeInstance, field: 'foto', 'error')} required">
	<label for="foto">
		<g:message code="fotoPropriedade.foto.label" default="Foto" />
		<span class="required-indicator">*</span>
	</label>
	<input type="file" id="foto" name="foto" />
</div>