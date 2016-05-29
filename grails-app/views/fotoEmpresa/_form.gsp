<%@ page import="rastrograo.empresa.FotoEmpresa" %>


<g:if test="${fotoEmpresaInstance?.empresa}">
        <div class="fieldcontain">
                <span id="empresa-label" class="property-label"><g:message code="fotoEmpresa.empresa.label" default="Empresa" /></span>

                        <span class="property-value" aria-labelledby="empresa-label">${fotoEmpresaInstance?.empresa?.encodeAsHTML()}
                                <g:link controller="empresa" class="show" action="show" id="${fotoEmpresaInstance?.empresa?.id}"></g:link>
                                <g:link controller="empresa" class="edit" action="edit" id="${fotoEmpresaInstance?.empresa?.id}"></g:link>
                        </span>
                        <g:hiddenField name="empresa.id" value="${fotoEmpresaInstance?.empresa?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: fotoEmpresaInstance, field: 'empresa', 'error')} required">
                <label for="empresa">
                        <g:message code="fotoEmpresa.empresa.label" default="Empresa" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="empresa" 
                    name="empresa.id" 
                    from="${empresaInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${fotoEmpresaInstance?.empresa?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Empresa --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: fotoEmpresaInstance, field: 'tituloFoto', 'error')} ">
	<label for="tituloFoto">
		<g:message code="fotoEmpresa.tituloFoto.label" default="Titulo Foto" />
		
	</label>
	<g:textField name="tituloFoto" maxlength="128" value="${fotoEmpresaInstance?.tituloFoto}"/>
</div>
		
<g:if test="${fotoEmpresaInstance?.foto}">
        <div class="fieldcontain">
                <span id="foto-label" class="property-label"><g:message code="fotoEmpresa.foto.label" default="Foto" /></span>
                        <img src="${createLink(controller:'fotoEmpresa', action:'showFoto', id: fotoEmpresaInstance?.id)}"/>
        </div>
</g:if>
                                
<div class="fieldcontain ${hasErrors(bean: fotoEmpresaInstance, field: 'foto', 'error')} required">
	<label for="foto">
		<g:message code="fotoEmpresa.foto.label" default="Foto" />
		<span class="required-indicator">*</span>
	</label>
	<input type="file" id="foto" name="foto" />
</div>