<%@ page import="rastrograo.propriedade.Propriedade" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tipoPropriedade', 'error')} ">
	<label for="tipoPropriedade">
		<g:message code="propriedade.tipoPropriedade.label" default="Tipo Propriedade" />
	</label>
	<g:select name="tipoPropriedade" 
            from="${['Pessoa Jurídica', 'Pessoa Física']}"
            value="${consultaInstance?.tipoPropriedade}" 
            valueMessagePrefix="propriedade.tipoPropriedade"
            noSelection="['': '-- Selecione um Tipo Propriedade --']"/>
</div>

<div id="cnpjRequired" class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'cnpj', 'error')} " style="display: none">
	<label for="cnpj">
		<g:message code="propriedade.cnpj.label" default="Cnpj" />
	</label>
	<g:textField name="cnpj" maxlength="18"  value="${consultaInstance?.cnpj}" style="max-width: 200px;"/>
</div>

<div id="cpfRequired" class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'cpf', 'error')} " style="display: none">
	<label for="cpf">
		<g:message code="propriedade.cpf.label" default="Cpf" />
	</label>
	<g:textField name="cpf" maxlength="14"  value="${consultaInstance?.cpf}" style="max-width: 200px;"/>
</div>

<div id="inscricaoEstadualRequired" class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'inscricaoEstadual', 'error')} " style="display: none">
	<label for="inscricaoEstadual">
		<g:message code="propriedade.inscricaoEstadual.label" default="Inscricao Estadual" />
	</label>
	<g:textField name="inscricaoEstadual" maxlength="20"  value="${consultaInstance?.inscricaoEstadual}" style="max-width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomePropriedade', 'error')} ">
	<label for="nomePropriedade">
		<g:message code="propriedade.nomePropriedade.label" default="Nome Propriedade" />
	</label>
	<g:textField name="nomePropriedade" maxlength="128" value="${consultaInstance?.nomePropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomeFantasiaPropriedade', 'error')} ">
	<label for="nomeFantasiaPropriedade">
		<g:message code="propriedade.nomeFantasiaPropriedade.label" default="Nome Fantasia Propriedade" />
	</label>
	<g:textField name="nomeFantasiaPropriedade" maxlength="128" value="${consultaInstance?.nomeFantasiaPropriedade}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'emailPropriedade', 'error')} ">
	<label for="emailPropriedade">
		<g:message code="propriedade.emailPropriedade.label" default="Email Propriedade" />
	</label>
	<g:field type="email" name="emailPropriedade" maxlength="128" value="${consultaInstance?.emailPropriedade}"/>
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
		<g:message code="propriedade.cidade.label" default="Cidade" />
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
    });    
</script>