<%@ page import="rastrograo.propriedade.TelefonePropriedade" %>


<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'propriedade', 'error')} ">
	<label for="propriedade">
		<g:message code="telefonePropriedade.propriedade.label" default="Propriedade" />
	</label>
	<g:select id="propriedade" 
            name="propriedadeId" 
            from="${propriedadeInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.propriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Propriedade --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'dddPropriedade', 'error')} ">
	<label for="dddPropriedade">
		<g:message code="telefonePropriedade.dddPropriedade.label" default="Ddd Propriedade" />
	</label>
	<g:textField name="dddPropriedade" maxlength="2" value="${consultaInstance?.dddPropriedade}" style="width: 100px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'numeroTelefonePropriedade', 'error')} ">
	<label for="numeroTelefonePropriedade">
		<g:message code="telefonePropriedade.numeroTelefonePropriedade.label" default="Numero Telefone Propriedade" />
	</label>
	<g:textField name="numeroTelefonePropriedade" maxlength="9" value="${consultaInstance?.numeroTelefonePropriedade}" style="width: 200px;"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="dddPropriedade"]').setMask('ddd');
        $('input[name="numeroTelefonePropriedade"]').setMask('telefone9');
    });    
</script>