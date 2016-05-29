<%@ page import="rastrograo.empresa.Empresa" %>



<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'tipoEmpresa', 'error')} required">
	<label for="tipoEmpresa">
		<g:message code="empresa.tipoEmpresa.label" default="Tipo Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="tipoEmpresa" 
            from="${empresaInstance.constraints.tipoEmpresa.inList}" 
            required="" 
            value="${empresaInstance?.tipoEmpresa}" 
            valueMessagePrefix="empresa.tipoEmpresa"
            noSelection="['': '-- Selecione um Tipo Empresa --']"/>
</div>

<div id="cnpjRequired" class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'cnpj', 'error')} required" style="display: none">
	<label for="cnpj">
		<g:message code="empresa.cnpj.label" default="Cnpj" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cnpj" maxlength="18"  value="${empresaInstance?.cnpj}" style="max-width: 200px;"/>
</div>

<div id="cpfRequired" class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'cpf', 'error')} required" style="display: none">
	<label for="cpf">
		<g:message code="empresa.cpf.label" default="Cpf" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cpf" maxlength="14"  value="${empresaInstance?.cpf}" style="max-width: 200px;"/>
</div>

<div id="inscricaoEstadualRequired" class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'inscricaoEstadual', 'error')} " style="display: none">
	<label for="inscricaoEstadual">
		<g:message code="empresa.inscricaoEstadual.label" default="Inscricao Estadual" />
	</label>
	<g:textField name="inscricaoEstadual" maxlength="20"  value="${empresaInstance?.inscricaoEstadual}" style="max-width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'nomeEmpresa', 'error')} required">
	<label for="nomeEmpresa">
		<g:message code="empresa.nomeEmpresa.label" default="Nome Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomeEmpresa" maxlength="128" required="" value="${empresaInstance?.nomeEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'nomeFantasiaEmpresa', 'error')} required">
	<label for="nomeFantasiaEmpresa">
		<g:message code="empresa.nomeFantasiaEmpresa.label" default="Nome Fantasia Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomeFantasiaEmpresa" maxlength="128" required="" value="${empresaInstance?.nomeFantasiaEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'emailEmpresa', 'error')} ">
	<label for="emailEmpresa">
		<g:message code="empresa.emailEmpresa.label" default="Email Empresa" />
	</label>
	<g:field type="email" name="emailEmpresa" maxlength="128" value="${empresaInstance?.emailEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'cidade.estado.pais', 'error')} required">
	<label for="pais">
		<g:message code="estado.pais.label" default="Pais" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="pais" 
            name="pais.id" 
            from="${rastrograo.tabela.Pais.list()}" 
            optionKey="id" 
            required="" 
            value="${empresaInstance?.cidade?.estado?.pais?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um País --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'cidade.estado', 'error')} required">
	<label for="estado">
		<g:message code="cidade.estado.label" default="Estado" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="estado" 
            name="estado.id" 
            from="${empresaInstance?.cidade?.estado}" 
            optionKey="id" 
            required="" 
            value="${empresaInstance?.cidade?.estado?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Estado --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'cidade', 'error')} required">
	<label for="cidade">
		<g:message code="empresa.cidade.label" default="Cidade" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cidade" 
            name="cidade.id" 
            from="${empresaInstance?.cidade}" 
            optionKey="id" 
            required="" 
            value="${empresaInstance?.cidade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Cidade --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'logradouroEmpresa', 'error')} required">
	<label for="logradouroEmpresa">
		<g:message code="empresa.logradouroEmpresa.label" default="Logradouro Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="logradouroEmpresa" maxlength="128" required="" value="${empresaInstance?.logradouroEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'bairroEmpresa', 'error')} required">
	<label for="bairroEmpresa">
		<g:message code="empresa.bairroEmpresa.label" default="Bairro Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="bairroEmpresa" maxlength="64" required="" value="${empresaInstance?.bairroEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'numeroEmpresa', 'error')} required">
	<label for="numeroEmpresa">
		<g:message code="empresa.numeroEmpresa.label" default="Numero Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numeroEmpresa" maxlength="10" required="" value="${empresaInstance?.numeroEmpresa}" style="max-width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'cepEmpresa', 'error')} required">
	<label for="cepEmpresa">
		<g:message code="empresa.cepEmpresa.label" default="Cep Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cepEmpresa" maxlength="9" required="" value="${empresaInstance?.cepEmpresa}" style="max-width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: empresaInstance, field: 'complementoEmpresa', 'error')} ">
	<label for="complementoEmpresa">
		<g:message code="empresa.complementoEmpresa.label" default="Complemento Empresa" />
		
	</label>
	<g:textField name="complementoEmpresa" maxlength="128" value="${empresaInstance?.complementoEmpresa}"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="cpf"]').setMask('cpf');
        $('input[name="cnpj"]').setMask('cnpj');
        $('input[name="cepEmpresa"]').setMask('cep');
        $("#cpf").blur(function(){
            var valor = document.getElementById("cpf").value;
            if(!validarCPF(valor)){
                alert("CPF Inválido!")
                $('input[name="cpf"]').val('');
            }
        });
        $("#cnpj").blur(function(){
            var valor = document.getElementById("cnpj").value;
            if(!validarCNPJ(valor)){
                alert("CNPJ Inválido!")
                $('input[name="cnpj"]').val('');
            }
        });
        
        $('#pais').change(function(){
            $.getJSON("${createLink(controller:'estado',action:'ajaxGetEstado')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#estado").find("option").remove();
                $("#estado").append("<option value=''>-- Selecione um Estado --</option>");
                $("#cidade").find("option").remove();
                $("#cidade").append("<option value=''>-- Selecione uma Cidade --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#estado").append("<option value='" + resposta[i].id + "'>" + resposta[i].nomeEstado +"-"+resposta[i].sigla +"</option>");
                }
            })
        })
        $('#estado').change(function(){
            $.getJSON("${createLink(controller:'cidade',action:'ajaxGetCidade')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#cidade").find("option").remove();
                $("#cidade").append("<option value=''>-- Selecione uma Cidade --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#cidade").append("<option value='" + resposta[i].id + "'>" + resposta[i].nomeCidade + "</option>");
                }
            })
        })
        tipoEmpresa(document.getElementById("tipoEmpresa").value);
        $('#tipoEmpresa').change(function(){
            tipoEmpresa(document.getElementById("tipoEmpresa").value);
        })
        function tipoEmpresa(valor){
            if(valor == "Pessoa Jurídica"){
                document.getElementById("cpfRequired").disabled = true;
                document.getElementById("cpfRequired").style.display = ('none');
                document.getElementById("cnpjRequired").disabled = false;
                document.getElementById("cnpjRequired").style.display = ('block');
                document.getElementById("inscricaoEstadualRequired").disabled = false;
                document.getElementById("inscricaoEstadualRequired").style.display = ('block');
            }else if(valor == "Pessoa Física"){
                document.getElementById("cpfRequired").disabled = false;
                document.getElementById("cpfRequired").style.display = ('block');
                document.getElementById("cnpjRequired").disabled = true;
                document.getElementById("cnpjRequired").style.display = ('none');
                document.getElementById("inscricaoEstadualRequired").disabled = true;
                document.getElementById("inscricaoEstadualRequired").style.display = ('none');
            }
        }
        $('#nomeEmpresa').blur(function(){
            document.getElementById("nomeFantasiaEmpresa").value = document.getElementById("nomeEmpresa").value;
        })
    });    
</script>