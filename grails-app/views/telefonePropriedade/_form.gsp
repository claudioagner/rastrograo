<%@ page import="rastrograo.propriedade.TelefonePropriedade" %>


<g:if test="${telefonePropriedadeInstance?.propriedade}">
        <div class="fieldcontain">
                <span id="propriedade-label" class="property-label"><g:message code="telefonePropriedade.propriedade.label" default="Propriedade" /></span>

                        <span class="property-value" aria-labelledby="propriedade-label">${telefonePropriedadeInstance?.propriedade?.encodeAsHTML()}
                                <g:link controller="propriedade" class="show" action="show" id="${telefonePropriedadeInstance?.propriedade?.id}"></g:link>
                                <g:link controller="propriedade" class="edit" action="edit" id="${telefonePropriedadeInstance?.propriedade?.id}"></g:link>
                        </span>
                        <g:hiddenField name="propriedade.id" value="${telefonePropriedadeInstance?.propriedade?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: telefonePropriedadeInstance, field: 'propriedade', 'error')} required">
                <label for="propriedade">
                        <g:message code="telefonePropriedade.propriedade.label" default="Propriedade" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="propriedade" 
                    name="propriedade.id" 
                    from="${propriedadeInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${telefonePropriedadeInstance?.propriedade?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Propriedade --']"/>
        </div>
</g:else>
    
<div class="fieldcontain ${hasErrors(bean: telefonePropriedadeInstance, field: 'dddPropriedade', 'error')} required">
	<label for="dddPropriedade">
		<g:message code="telefonePropriedade.dddPropriedade.label" default="Ddd Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="dddPropriedade" maxlength="2" required="" value="${telefonePropriedadeInstance?.dddPropriedade}" style="width: 100px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: telefonePropriedadeInstance, field: 'numeroTelefonePropriedade', 'error')} required">
	<label for="numeroTelefonePropriedade">
		<g:message code="telefonePropriedade.numeroTelefonePropriedade.label" default="Numero Telefone Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numeroTelefonePropriedade" maxlength="9" required="" value="${telefonePropriedadeInstance?.numeroTelefonePropriedade}" style="width: 200px;"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="dddPropriedade"]').setMask('ddd');
        $('input[name="numeroTelefonePropriedade"]').setMask('telefone9');
    });    
</script>