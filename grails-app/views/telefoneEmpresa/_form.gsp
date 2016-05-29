<%@ page import="rastrograo.empresa.TelefoneEmpresa" %>

<g:if test="${telefoneEmpresaInstance?.empresa}">
        <div class="fieldcontain">
                <span id="empresa-label" class="property-label"><g:message code="telefoneEmpresa.empresa.label" default="Empresa" /></span>

                        <span class="property-value" aria-labelledby="empresa-label">${telefoneEmpresaInstance?.empresa?.encodeAsHTML()}
                                <g:link controller="empresa" class="show" action="show" id="${telefoneEmpresaInstance?.empresa?.id}"></g:link>
                                <g:link controller="empresa" class="edit" action="edit" id="${telefoneEmpresaInstance?.empresa?.id}"></g:link>
                        </span>
                        <g:hiddenField name="empresa.id" value="${telefoneEmpresaInstance?.empresa?.id}" />

        </div>
</g:if>
<g:else>                                
        <div class="fieldcontain ${hasErrors(bean: telefoneEmpresaInstance, field: 'empresa', 'error')} required">
                <label for="empresa">
                        <g:message code="telefoneEmpresa.empresa.label" default="Empresa" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="empresa" 
                    name="empresa.id" 
                    from="${empresaInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${telefoneEmpresaInstance?.empresa?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Empresa --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: telefoneEmpresaInstance, field: 'dddEmpresa', 'error')} required">
	<label for="dddEmpresa">
		<g:message code="telefoneEmpresa.dddEmpresa.label" default="Ddd Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="dddEmpresa" maxlength="2" required="" value="${telefoneEmpresaInstance?.dddEmpresa}" style="width: 100px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: telefoneEmpresaInstance, field: 'numeroTelefoneEmpresa', 'error')} required">
	<label for="numeroTelefoneEmpresa">
		<g:message code="telefoneEmpresa.numeroTelefoneEmpresa.label" default="Numero Telefone Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numeroTelefoneEmpresa" maxlength="9" required="" value="${telefoneEmpresaInstance?.numeroTelefoneEmpresa}" style="width: 200px;"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="dddEmpresa"]').setMask('ddd');
        $('input[name="numeroTelefoneEmpresa"]').setMask('telefone9');
    });    
</script>