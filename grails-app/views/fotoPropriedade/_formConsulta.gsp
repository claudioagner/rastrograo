<%@ page import="rastrograo.propriedade.FotoPropriedade" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'propriedade', 'error')} ">
	<label for="propriedade">
		<g:message code="fotoPropriedade.propriedade.label" default="Propriedade" />
	</label>
	<g:select id="propriedade" 
            name="propriedadeId" 
            from="${propriedadeInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.propriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Propriedade --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tituloFoto', 'error')} ">
	<label for="tituloFoto">
		<g:message code="fotoPropriedade.tituloFoto.label" default="Titulo Foto" />
		
	</label>
	<g:textField name="tituloFoto" maxlength="128" value="${consultaInstance?.tituloFoto}"/>
</div>