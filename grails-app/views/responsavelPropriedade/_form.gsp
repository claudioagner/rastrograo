<%@ page import="rastrograo.propriedade.ResponsavelPropriedade" %>


<g:if test="${responsavelPropriedadeInstance?.tipoResponsavel}">
        <div class="fieldcontain">
                <span id="tipoResponsavel-label" class="property-label"><g:message code="responsavelPropriedade.tipoResponsavel.label" default="Tipo Responsavel" /></span>

                        <span class="property-value" aria-labelledby="tipoResponsavel-label">${responsavelPropriedadeInstance?.tipoResponsavel?.encodeAsHTML()}
                                <g:link controller="tipoResponsavel" class="show" action="show" id="${responsavelPropriedadeInstance?.tipoResponsavel?.id}"></g:link>
                                <g:link controller="tipoResponsavel" class="edit" action="edit" id="${responsavelPropriedadeInstance?.tipoResponsavel?.id}"></g:link>
                        </span>
                        <g:hiddenField name="tipoResponsavel.id" value="${responsavelPropriedadeInstance?.tipoResponsavel?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: responsavelPropriedadeInstance, field: 'tipoResponsavel', 'error')} required">
                <label for="tipoResponsavel">
                        <g:message code="responsavelPropriedade.tipoResponsavel.label" default="Tipo Responsavel" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="tipoResponsavel" 
                    name="tipoResponsavel.id" 
                    from="${rastrograo.tabela.TipoResponsavel.list()}" 
                    optionKey="id" 
                    required="" 
                    value="${responsavelPropriedadeInstance?.tipoResponsavel?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um Tipo Responsável --']"/>
        </div>
</g:else>

<g:if test="${responsavelPropriedadeInstance?.propriedade}">
        <div class="fieldcontain">
                <span id="propriedade-label" class="property-label"><g:message code="responsavelPropriedade.propriedade.label" default="Propriedade" /></span>

                        <span class="property-value" aria-labelledby="propriedade-label">${responsavelPropriedadeInstance?.propriedade?.encodeAsHTML()}
                                <g:link controller="propriedade" class="show" action="show" id="${responsavelPropriedadeInstance?.propriedade?.id}"></g:link>
                                <g:link controller="propriedade" class="edit" action="edit" id="${responsavelPropriedadeInstance?.propriedade?.id}"></g:link>
                        </span>
                        <g:hiddenField name="propriedade.id" value="${responsavelPropriedadeInstance?.propriedade?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: responsavelPropriedadeInstance, field: 'propriedade', 'error')} required">
                <label for="propriedade">
                        <g:message code="responsavelPropriedade.propriedade.label" default="Propriedade" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="propriedade" 
                    name="propriedade.id" 
                    from="${propriedadeInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${responsavelPropriedadeInstance?.propriedade?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Propriedade --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: responsavelPropriedadeInstance, field: 'nomeResponsavelPropriedade', 'error')} required">
	<label for="nomeResponsavelPropriedade">
		<g:message code="responsavelPropriedade.nomeResponsavelPropriedade.label" default="Nome Responsavel Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomeResponsavelPropriedade" maxlength="128" required="" value="${responsavelPropriedadeInstance?.nomeResponsavelPropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: responsavelPropriedadeInstance, field: 'dddResponsavelPropriedade', 'error')} required">
	<label for="dddResponsavelPropriedade">
		<g:message code="responsavelPropriedade.dddResponsavelPropriedade.label" default="Ddd Responsavel Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="dddResponsavelPropriedade" maxlength="2" required="" value="${responsavelPropriedadeInstance?.dddResponsavelPropriedade}" style="width: 100px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: responsavelPropriedadeInstance, field: 'numeroTelefoneResponsavelPropriedade', 'error')} required">
	<label for="numeroTelefoneResponsavelPropriedade">
		<g:message code="responsavelPropriedade.numeroTelefoneResponsavelPropriedade.label" default="Numero Telefone Responsavel Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numeroTelefoneResponsavelPropriedade" maxlength="9" required="" value="${responsavelPropriedadeInstance?.numeroTelefoneResponsavelPropriedade}" style="width: 200px;"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="dddResponsavelPropriedade"]').setMask('ddd');
        $('input[name="numeroTelefoneResponsavelPropriedade"]').setMask('telefone9');
    });    
</script>