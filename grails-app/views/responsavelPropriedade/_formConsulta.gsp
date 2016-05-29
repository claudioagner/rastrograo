<%@ page import="rastrograo.propriedade.ResponsavelPropriedade" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tipoResponsavel', 'error')} ">
	<label for="tipoResponsavel">
		<g:message code="responsavelPropriedade.tipoResponsavel.label" default="Tipo Responsavel" />
	</label>
	<g:select id="tipoResponsavel" 
            name="tipoResponsavelId" 
            from="${rastrograo.tabela.TipoResponsavel.list()}" 
            optionKey="id"
            value="${consultaInstance?.tipoResponsavel?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Tipo Responsável --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'propriedade', 'error')} ">
	<label for="propriedade">
		<g:message code="responsavelPropriedade.propriedade.label" default="Propriedade" />
	</label>
	<g:select id="propriedade" 
            name="propriedadeId" 
            from="${propriedadeInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.propriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Propriedade --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomeResponsavelPropriedade', 'error')} ">
	<label for="nomeResponsavelPropriedade">
		<g:message code="responsavelPropriedade.nomeResponsavelPropriedade.label" default="Nome Responsavel Propriedade" />
	</label>
	<g:textField name="nomeResponsavelPropriedade" maxlength="128" value="${consultaInstance?.nomeResponsavelPropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'dddResponsavelPropriedade', 'error')} ">
	<label for="dddResponsavelPropriedade">
		<g:message code="responsavelPropriedade.dddResponsavelPropriedade.label" default="Ddd Responsavel Propriedade" />
	</label>
	<g:textField name="dddResponsavelPropriedade" maxlength="2" value="${consultaInstance?.dddResponsavelPropriedade}" style="width: 100px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'numeroTelefoneResponsavelPropriedade', 'error')} ">
	<label for="numeroTelefoneResponsavelPropriedade">
		<g:message code="responsavelPropriedade.numeroTelefoneResponsavelPropriedade.label" default="Numero Telefone Responsavel Propriedade" />
        </label>
	<g:textField name="numeroTelefoneResponsavelPropriedade" maxlength="9" value="${consultaInstance?.numeroTelefoneResponsavelPropriedade}" style="width: 200px;"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="dddResponsavelPropriedade"]').setMask('ddd');
        $('input[name="numeroTelefoneResponsavelPropriedade"]').setMask('telefone9');
    });    
</script>