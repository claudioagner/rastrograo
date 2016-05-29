<%@ page import="rastrograo.customizacao.RastroProduto" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'empresa', 'error')} ">
	<label for="empresa">
		<g:message code="rastroProduto.empresa.label" default="Empresa" />
	</label>
	<g:select id="empresa" 
            name="empresaId" 
            from="${empresaInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.empresa?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Empresa --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'propriedade', 'error')} ">
	<label for="propriedade">
		<g:message code="rastroProduto.propriedade.label" default="Propriedade" />
	</label>
	<g:select id="propriedade" 
            name="propriedadeId" 
            from="${propriedadeInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.propriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Propriedade --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'talhaoPropriedade', 'error')} ">
	<label for="talhaoPropriedade">
		<g:message code="rastroProduto.talhaoPropriedade.label" default="Talhao Propriedade" />
	</label>
	<g:select id="talhaoPropriedade" 
            name="talhaoPropriedadeId" 
            from="${consultaInstance?.propriedade?.talhoes}" 
            optionKey="id"
            value="${consultaInstance?.talhaoPropriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Talhão --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'produto', 'error')} ">
	<label for="produto">
		<g:message code="rastroProduto.produto.label" default="Produto" />
	</label>
	<g:select id="produto" 
            name="produtoId" 
            from="${rastrograo.estrutura.Produto.list()}"
            optionKey="id" 
            value="${consultaInstance?.produto?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Produto --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'cultivar', 'error')} ">
	<label for="cultivar">
		<g:message code="rastroProduto.cultivar.label" default="Cultivar" />
	</label>
	<g:select id="cultivar" 
            name="cultivarId"
            from="${consultaInstance?.produto?.cultivares}"
            optionKey="id"
            value="${consultaInstance?.cultivar?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Cultivar --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'anoSafra', 'error')} ">
	<label for="anoSafra">
		<g:message code="rastroProduto.anoSafra.label" default="Ano Safra" />
	</label>
	<g:select name="anoSafra"
            from="${2016..2050}"
            value="${consultaInstance?.anoSafra}"
            noSelection="['': '-- Selecione um Ano Safra --']"/>
</div>
                
        
<script>
    $(document).ready(function() {
        $('#propriedade').change(function(){
            $.getJSON("${createLink(controller:'talhaoPropriedade',action:'ajaxGetTalhaoPropriedade')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#talhaoPropriedade").find("option").remove();
                $("#talhaoPropriedade").append("<option value=''>-- Selecione um Talhão --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#talhaoPropriedade").append("<option value='" + resposta[i].id + "'>" + resposta[i].descricaoTalhao +"</option>");
                }
            })
        });
        $('#produto').change(function(){
            $.getJSON("${createLink(controller:'cultivar',action:'ajaxGetCultivar')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#cultivar").find("option").remove();
                $("#cultivar").append("<option value=''>-- Selecione um Cultivar --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#cultivar").append("<option value='" + resposta[i].id + "'>" + resposta[i].descricaoCultivar +"</option>");
                }
            })
        });
    });    
</script>