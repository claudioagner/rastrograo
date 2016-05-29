<%@ page import="rastrograo.empresa.TelefoneEmpresa" %>


<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'empresa', 'error')} ">
	<label for="empresa">
		<g:message code="telefoneEmpresa.empresa.label" default="Empresa" />
	</label>
	<g:select id="empresa" 
            name="empresaId" 
            from="${empresaInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.empresa?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Empresa --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'dddEmpresa', 'error')} ">
	<label for="dddEmpresa">
		<g:message code="telefoneEmpresa.dddEmpresa.label" default="Ddd Empresa" />
	</label>
	<g:textField name="dddEmpresa" maxlength="2" value="${consultaInstance?.dddEmpresa}" style="width: 100px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'numeroTelefoneEmpresa', 'error')} ">
	<label for="numeroTelefoneEmpresa">
		<g:message code="telefoneEmpresa.numeroTelefoneEmpresa.label" default="Numero Telefone Empresa" />
	</label>
	<g:textField name="numeroTelefoneEmpresa" maxlength="9" value="${consultaInstance?.numeroTelefoneEmpresa}" style="width: 200px;"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="dddEmpresa"]').setMask('ddd');
        $('input[name="numeroTelefoneEmpresa"]').setMask('telefone9');
    });    
</script>