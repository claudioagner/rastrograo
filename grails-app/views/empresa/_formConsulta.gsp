<%@ page import="rastrograo.empresa.Empresa" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tipoEmpresa', 'error')} ">
	<label for="tipoEmpresa">
		<g:message code="empresa.tipoEmpresa.label" default="Tipo Empresa" />
	</label>
	<g:select name="tipoEmpresa" 
            from="${['Pessoa Jurídica', 'Pessoa Física']}"
            value="${consultaInstance?.tipoEmpresa}" 
            valueMessagePrefix="empresa.tipoEmpresa"
            noSelection="['': '-- Selecione um Tipo Empresa --']"/>
</div>

<div id="cnpjRequired" class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'cnpj', 'error')} " style="display: none">
	<label for="cnpj">
		<g:message code="empresa.cnpj.label" default="Cnpj" />
	</label>
	<g:textField name="cnpj" maxlength="18"  value="${consultaInstance?.cnpj}" style="max-width: 200px;"/>
</div>

<div id="cpfRequired" class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'cpf', 'error')} " style="display: none">
	<label for="cpf">
		<g:message code="empresa.cpf.label" default="Cpf" />
	</label>
	<g:textField name="cpf" maxlength="14"  value="${consultaInstance?.cpf}" style="max-width: 200px;"/>
</div>

<div id="inscricaoEstadualRequired" class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'inscricaoEstadual', 'error')} " style="display: none">
	<label for="inscricaoEstadual">
		<g:message code="empresa.inscricaoEstadual.label" default="Inscricao Estadual" />
	</label>
	<g:textField name="inscricaoEstadual" maxlength="20"  value="${consultaInstance?.inscricaoEstadual}" style="max-width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomeEmpresa', 'error')} ">
	<label for="nomeEmpresa">
		<g:message code="empresa.nomeEmpresa.label" default="Nome Empresa" />
	</label>
	<g:textField name="nomeEmpresa" maxlength="128" value="${consultaInstance?.nomeEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomeFantasiaEmpresa', 'error')} ">
	<label for="nomeFantasiaEmpresa">
		<g:message code="empresa.nomeFantasiaEmpresa.label" default="Nome Fantasia Empresa" />
	</label>
	<g:textField name="nomeFantasiaEmpresa" maxlength="128" value="${consultaInstance?.nomeFantasiaEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'emailEmpresa', 'error')} ">
	<label for="emailEmpresa">
		<g:message code="empresa.emailEmpresa.label" default="Email Empresa" />
	</label>
	<g:field type="email" name="emailEmpresa" maxlength="128" value="${consultaInstance?.emailEmpresa}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'cidade.estado.pais', 'error')} ">
	<label for="pais">
		<g:message code="estado.pais.label" default="Pais" />
	</label>
	<g:select id="pais" 
            name="paisId" 
            from="${consultaInstance?.cidade?.estado?.pais ?: rastrograo.tabela.Pais.list()}" 
            optionKey="id" 
            value="${consultaInstance?.cidade?.estado?.pais?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um País --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'cidade.estado', 'error')} ">
	<label for="estado">
		<g:message code="cidade.estado.label" default="Estado" />
	</label>
	<g:select id="estado" 
            name="estadoId" 
            from="${consultaInstance?.cidade?.estado}" 
            optionKey="id" 
            value="${consultaInstance?.cidade?.estado?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Estado --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'cidade', 'error')} ">
	<label for="cidade">
		<g:message code="empresa.cidade.label" default="Cidade" />
	</label>
	<g:select id="cidade" 
            name="cidadeId" 
            from="${consultaInstance?.cidade}" 
            optionKey="id" 
            value="${consultaInstance?.cidade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Cidade --']"/>
</div>

<script>
    $(document).ready(function() {
        $('input[name="cpf"]').setMask('cpf');
        $('input[name="cnpj"]').setMask('cnpj');
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
    });    
</script>