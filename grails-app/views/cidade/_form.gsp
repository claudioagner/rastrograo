<%@ page import="rastrograo.tabela.Cidade" %>


<g:if test="${cidadeInstance?.estado?.pais}">
        <div class="fieldcontain">
                <span id="pais-label" class="property-label"><g:message code="estado.pais.label" default="Pais" /></span>

                        <span class="property-value" aria-labelledby="pais-label">${cidadeInstance?.estado?.pais?.encodeAsHTML()}
                                <g:link controller="pais" class="show" action="show" id="${cidadeInstance?.estado?.pais?.id}"></g:link>
                                <g:link controller="pais" class="edit" action="edit" id="${cidadeInstance?.estado?.pais?.id}"></g:link>
                        </span>

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: cidadeInstance, field: 'estado.pais', 'error')} required">
                <label for="pais">
                        <g:message code="estado.pais.label" default="Pais" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="pais" 
                    name="pais.id" 
                    from="${rastrograo.tabela.Pais.list()}" 
                    optionKey="id" 
                    required="" 
                    value="${cidadeInstance?.estado?.pais?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um País --']"/>
        </div>
</g:else>
<g:if test="${cidadeInstance?.estado}">
        <div class="fieldcontain">
                <span id="estado-label" class="property-label"><g:message code="cidade.estado.label" default="Estado" /></span>

                        <span class="property-value" aria-labelledby="estado-label">${cidadeInstance?.estado?.encodeAsHTML()}
                                <g:link controller="estado" class="show" action="show" id="${cidadeInstance?.estado?.id}"></g:link>
                                <g:link controller="estado" class="edit" action="edit" id="${cidadeInstance?.estado?.id}"></g:link>
                        </span>
                        <g:hiddenField name="estado.id" value="${cidadeInstance?.estado?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: cidadeInstance, field: 'estado', 'error')} required">
                <label for="estado">
                        <g:message code="cidade.estado.label" default="Estado" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="estado" 
                    name="estado.id" 
                    from="${cidadeInstance?.estado}" 
                    optionKey="id" 
                    required="" 
                    value="${cidadeInstance?.estado?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um Estado --']"/>
        </div>
</g:else>    
<div class="fieldcontain ${hasErrors(bean: cidadeInstance, field: 'nomeCidade', 'error')} required">
	<label for="nomeCidade">
		<g:message code="cidade.nomeCidade.label" default="Nome Cidade" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nomeCidade" maxlength="128" required="" value="${cidadeInstance?.nomeCidade}"/>
</div>

<script>
    $(document).ready(function() {
        $('#pais').change(function(){
            $.getJSON("${createLink(controller:'estado',action:'ajaxGetEstado')}",{id:$(this).val(), ajax: 'true'}, function(resposta){
                $("#estado").find("option").remove();
                $("#estado").append("<option value=''>-- Selecione um Estado --</option>");
                for(var i = 0 ; i < resposta.length ; i++){
                    $("#estado").append("<option value='" + resposta[i].id + "'>" + resposta[i].nomeEstado +"-"+resposta[i].sigla +"</option>");
                }
            })
        })
    });    
</script>