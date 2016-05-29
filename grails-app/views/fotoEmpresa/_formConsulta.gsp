<%@ page import="rastrograo.empresa.FotoEmpresa" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'empresa', 'error')} ">
	<label for="empresa">
		<g:message code="fotoEmpresa.empresa.label" default="Empresa" />
	</label>
	<g:select id="empresa" 
            name="empresaId" 
            from="${empresaInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.empresa?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Empresa --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tituloFoto', 'error')} ">
	<label for="tituloFoto">
		<g:message code="fotoEmpresa.tituloFoto.label" default="Titulo Foto" />
		
	</label>
	<g:textField name="tituloFoto" maxlength="128" value="${consultaInstance?.tituloFoto}"/>
</div>