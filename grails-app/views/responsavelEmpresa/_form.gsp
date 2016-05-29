<%@ page import="rastrograo.empresa.ResponsavelEmpresa" %>


<g:if test="${responsavelEmpresaInstance?.tipoResponsavel}">
        <div class="fieldcontain">
                <span id="tipoResponsavel-label" class="property-label"><g:message code="responsavelEmpresa.tipoResponsavel.label" default="Tipo Responsavel" /></span>

                        <span class="property-value" aria-labelledby="tipoResponsavel-label">${responsavelEmpresaInstance?.tipoResponsavel?.encodeAsHTML()}
                                <g:link controller="tipoResponsavel" class="show" action="show" id="${responsavelEmpresaInstance?.tipoResponsavel?.id}"></g:link>
                                <g:link controller="tipoResponsavel" class="edit" action="edit" id="${responsavelEmpresaInstance?.tipoResponsavel?.id}"></g:link>
                        </span>

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: responsavelEmpresaInstance, field: 'tipoResponsavel', 'error')} required">
                <label for="tipoResponsavel">
                        <g:message code="responsavelEmpresa.tipoResponsavel.label" default="Tipo Responsavel" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="tipoResponsavel" 
                    name="tipoResponsavel.id" 
                    from="${rastrograo.tabela.TipoResponsavel.list()}" 
                    optionKey="id" 
                    required="" 
                    value="${responsavelEmpresaInstance?.tipoResponsavel?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um Tipo Responsável --']"/>
        </div>
</g:else>

<g:if test="${responsavelEmpresaInstance?.empresa}">
        <div class="fieldcontain">
                <span id="empresa-label" class="property-label"><g:message code="responsavelEmpresa.empresa.label" default="Empresa" /></span>

                        <span class="property-value" aria-labelledby="empresa-label">${responsavelEmpresaInstance?.empresa?.encodeAsHTML()}
                                <g:link controller="empresa" class="show" action="show" id="${responsavelEmpresaInstance?.empresa?.id}"></g:link>
                                <g:link controller="empresa" class="edit" action="edit" id="${responsavelEmpresaInstance?.empresa?.id}"></g:link>
                        </span>

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: responsavelEmpresaInstance, field: 'empresa', 'error')} required">
                <label for="empresa">
                        <g:message code="responsavelEmpresa.empresa.label" default="Empresa" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="empresa" 
                    name="empresa.id" 
                    from="${empresaInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${responsavelEmpresaInstance?.empresa?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Empresa --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: responsavelEmpresaInstance, field: 'nomeResponsavelEmpresa', 'error')} required">
	<label for="nomeResponsavelEmpresa">
		<g:message code="responsavelEmpresa.nomeResponsavelEmpresa.label" default="Nome Responsavel Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomeResponsavelEmpresa" maxlength="128" required="" value="${responsavelEmpresaInstance?.nomeResponsavelEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: responsavelEmpresaInstance, field: 'dddResponsavelEmpresa', 'error')} required">
	<label for="dddResponsavelEmpresa">
		<g:message code="responsavelEmpresa.dddResponsavelEmpresa.label" default="Ddd Responsavel Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="dddResponsavelEmpresa" maxlength="2" required="" value="${responsavelEmpresaInstance?.dddResponsavelEmpresa}" style="width: 100px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: responsavelEmpresaInstance, field: 'numeroTelefoneResponsavelEmpresa', 'error')} required">
	<label for="numeroTelefoneResponsavelEmpresa">
		<g:message code="responsavelEmpresa.numeroTelefoneResponsavelEmpresa.label" default="Numero Telefone Responsavel Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numeroTelefoneResponsavelEmpresa" maxlength="9" required="" value="${responsavelEmpresaInstance?.numeroTelefoneResponsavelEmpresa}" style="width: 200px;"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="dddResponsavelEmpresa"]').setMask('ddd');
        $('input[name="numeroTelefoneResponsavelEmpresa"]').setMask('telefone9');
    });    
</script>