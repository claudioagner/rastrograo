<%@ page import="rastrograo.empresa.ResponsavelEmpresa" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tipoResponsavel', 'error')} ">
	<label for="tipoResponsavel">
		<g:message code="responsavelEmpresa.tipoResponsavel.label" default="Tipo Responsavel" />
	</label>
	<g:select id="tipoResponsavel" 
            name="tipoResponsavelId" 
            from="${rastrograo.tabela.TipoResponsavel.list()}" 
            optionKey="id"
            value="${consultaInstance?.tipoResponsavel?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Tipo Responsável --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'empresa', 'error')} ">
	<label for="empresa">
		<g:message code="responsavelEmpresa.empresa.label" default="Empresa" />
	</label>
	<g:select id="empresa" 
            name="empresaId" 
            from="${empresaInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.empresa?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Empresa --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomeResponsavelEmpresa', 'error')} ">
	<label for="nomeResponsavelEmpresa">
		<g:message code="responsavelEmpresa.nomeResponsavelEmpresa.label" default="Nome Responsavel Empresa" />
	</label>
	<g:textField name="nomeResponsavelEmpresa" maxlength="128" value="${consultaInstance?.nomeResponsavelEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'dddResponsavelEmpresa', 'error')} ">
	<label for="dddResponsavelEmpresa">
		<g:message code="responsavelEmpresa.dddResponsavelEmpresa.label" default="Ddd Responsavel Empresa" />
	</label>
	<g:textField name="dddResponsavelEmpresa" maxlength="2" value="${consultaInstance?.dddResponsavelEmpresa}" style="width: 100px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'numeroTelefoneResponsavelEmpresa', 'error')} ">
	<label for="numeroTelefoneResponsavelEmpresa">
		<g:message code="responsavelEmpresa.numeroTelefoneResponsavelEmpresa.label" default="Numero Telefone Responsavel Empresa" />
        </label>
	<g:textField name="numeroTelefoneResponsavelEmpresa" maxlength="9" value="${consultaInstance?.numeroTelefoneResponsavelEmpresa}" style="width: 200px;"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="dddResponsavelEmpresa"]').setMask('ddd');
        $('input[name="numeroTelefoneResponsavelEmpresa"]').setMask('telefone9');
    });    
</script>