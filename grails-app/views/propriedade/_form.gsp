<%@ page import="rastrograo.propriedade.Propriedade" %>



<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'porte', 'error')} required">
	<label for="porte">
		<g:message code="propriedade.porte.label" default="Porte" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="porte" 
            from="${propriedadeInstance.constraints.porte.inList}" 
            required="" 
            value="${propriedadeInstance?.porte}" 
            valueMessagePrefix="propriedade.porte"
            noSelection="['': '-- Selecione um Porte --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'tipoPropriedade', 'error')} required">
	<label for="tipoPropriedade">
		<g:message code="propriedade.tipoPropriedade.label" default="Tipo Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="tipoPropriedade" 
            from="${propriedadeInstance.constraints.tipoPropriedade.inList}" 
            required="" 
            value="${propriedadeInstance?.tipoPropriedade}" 
            valueMessagePrefix="propriedade.tipoPropriedade"
            noSelection="['': '-- Selecione um Tipo Propriedade --']"/>
</div>

<div id="cnpjRequired" class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'cnpj', 'error')} required" style="display: none">
	<label for="cnpj">
		<g:message code="propriedade.cnpj.label" default="Cnpj" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cnpj" maxlength="18"  value="${propriedadeInstance?.cnpj}" style="max-width: 200px;"/>
</div>

<div id="cpfRequired" class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'cpf', 'error')} required" style="display: none">
	<label for="cpf">
		<g:message code="propriedade.cpf.label" default="Cpf" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cpf" maxlength="14"  value="${propriedadeInstance?.cpf}" style="max-width: 200px;"/>
</div>

<div id="inscricaoEstadualRequired" class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'inscricaoEstadual', 'error')} " style="display: none">
	<label for="inscricaoEstadual">
		<g:message code="propriedade.inscricaoEstadual.label" default="Inscricao Estadual" />
	</label>
	<g:textField name="inscricaoEstadual" maxlength="20"  value="${propriedadeInstance?.inscricaoEstadual}" style="max-width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'nomePropriedade', 'error')} required">
	<label for="nomePropriedade">
		<g:message code="propriedade.nomePropriedade.label" default="Nome Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomePropriedade" maxlength="128" required="" value="${propriedadeInstance?.nomePropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'nomeFantasiaPropriedade', 'error')} required">
	<label for="nomeFantasiaPropriedade">
		<g:message code="propriedade.nomeFantasiaPropriedade.label" default="Nome Fantasia Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomeFantasiaPropriedade" maxlength="128" required="" value="${propriedadeInstance?.nomeFantasiaPropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'emailPropriedade', 'error')} ">
	<label for="emailPropriedade">
		<g:message code="propriedade.emailPropriedade.label" default="Email Propriedade" />
	</label>
	<g:field type="email" name="emailPropriedade" maxlength="128" value="${propriedadeInstance?.emailPropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'cidade.estado.pais', 'error')} required">
	<label for="pais">
		<g:message code="estado.pais.label" default="Pais" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="pais" 
            name="pais.id" 
            from="${rastrograo.tabela.Pais.list()}" 
            optionKey="id" 
            required="" 
            value="${propriedadeInstance?.cidade?.estado?.pais?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um País --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'cidade.estado', 'error')} required">
	<label for="estado">
		<g:message code="cidade.estado.label" default="Estado" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="estado" 
            name="estado.id" 
            from="${propriedadeInstance?.cidade?.estado}" 
            optionKey="id" 
            required="" 
            value="${propriedadeInstance?.cidade?.estado?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Estado --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'cidade', 'error')} required">
	<label for="cidade">
		<g:message code="propriedade.cidade.label" default="Cidade" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="cidade" 
            name="cidade.id" 
            from="${propriedadeInstance?.cidade}" 
            optionKey="id" 
            required="" 
            value="${propriedadeInstance?.cidade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Cidade --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'logradouroPropriedade', 'error')} required">
	<label for="logradouroPropriedade">
		<g:message code="propriedade.logradouroPropriedade.label" default="Logradouro Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="logradouroPropriedade" maxlength="128" required="" value="${propriedadeInstance?.logradouroPropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'bairroPropriedade', 'error')} required">
	<label for="bairroPropriedade">
		<g:message code="propriedade.bairroPropriedade.label" default="Bairro Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="bairroPropriedade" maxlength="64" required="" value="${propriedadeInstance?.bairroPropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'numeroPropriedade', 'error')} required">
	<label for="numeroPropriedade">
		<g:message code="propriedade.numeroPropriedade.label" default="Numero Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numeroPropriedade" maxlength="10" required="" value="${propriedadeInstance?.numeroPropriedade}" style="max-width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'cepPropriedade', 'error')} required">
	<label for="cepPropriedade">
		<g:message code="propriedade.cepPropriedade.label" default="Cep Propriedade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="cepPropriedade" maxlength="9" required="" value="${propriedadeInstance?.cepPropriedade}" style="max-width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: propriedadeInstance, field: 'complementoPropriedade', 'error')} ">
	<label for="complementoPropriedade">
		<g:message code="propriedade.complementoPropriedade.label" default="Complemento Propriedade" />
		
	</label>
	<g:textField name="complementoPropriedade" maxlength="128" value="${propriedadeInstance?.complementoPropriedade}"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="cpf"]').setMask('cpf');
        $('input[name="cnpj"]').setMask('cnpj');
        $('input[name="cepPropriedade"]').setMask('cep');
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
        tipoPropriedade(document.getElementById("tipoPropriedade").value);
        $('#tipoPropriedade').change(function(){
            tipoPropriedade(document.getElementById("tipoPropriedade").value);
        })
        function tipoPropriedade(valor){
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
        $('#nomePropriedade').blur(function(){
            document.getElementById("nomeFantasiaPropriedade").value = document.getElementById("nomePropriedade").value;
        })
    });    
</script>