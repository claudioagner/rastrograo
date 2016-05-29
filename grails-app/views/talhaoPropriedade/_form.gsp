<%@ page import="rastrograo.propriedade.TalhaoPropriedade" %>


<g:if test="${talhaoPropriedadeInstance?.propriedade}">
        <div class="fieldcontain">
                <span id="propriedade-label" class="property-label"><g:message code="talhaoPropriedade.propriedade.label" default="Propriedade" /></span>

                        <span class="property-value" aria-labelledby="propriedade-label">${talhaoPropriedadeInstance?.propriedade?.encodeAsHTML()}
                                <g:link controller="propriedade" class="show" action="show" id="${talhaoPropriedadeInstance?.propriedade?.id}"></g:link>
                                <g:link controller="propriedade" class="edit" action="edit" id="${talhaoPropriedadeInstance?.propriedade?.id}"></g:link>
                        </span>
                        <g:hiddenField name="propriedade.id" value="${talhaoPropriedadeInstance?.propriedade?.id}" />

        </div>
</g:if>
<g:else>                                
        <div class="fieldcontain ${hasErrors(bean: talhaoPropriedadeInstance, field: 'propriedade', 'error')} required">
                <label for="propriedade">
                        <g:message code="talhaoPropriedade.propriedade.label" default="Propriedade" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="propriedade" 
                    name="propriedade.id" 
                    from="${propriedadeInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${talhaoPropriedadeInstance?.propriedade?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Propriedade --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: talhaoPropriedadeInstance, field: 'descricaoTalhao', 'error')} required">
	<label for="descricaoTalhao">
		<g:message code="talhaoPropriedade.descricaoTalhao.label" default="Descricao Talhao" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="descricaoTalhao" required="" value="${talhaoPropriedadeInstance?.descricaoTalhao}" />
</div>

<div class="fieldcontain ${hasErrors(bean: talhaoPropriedadeInstance, field: 'haTalhao', 'error')} required">
	<label for="haTalhao">
		<g:message code="talhaoPropriedade.haTalhao.label" default="Ha Talhao" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="haTalhao" value="${fieldValue(bean: talhaoPropriedadeInstance, field: 'haTalhao')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: talhaoPropriedadeInstance, field: 'latitudeTalhao', 'error')} ">
	<label for="latitudeTalhao">
		<g:message code="talhaoPropriedade.latitudeTalhao.label" default="Latitude Talhao" />
	</label>
	<g:textField name="latitudeTalhao" maxlength="11" value="${talhaoPropriedadeInstance?.latitudeTalhao}" style="width: 200px;"/>
</div>

<div class="fieldcontain ${hasErrors(bean: talhaoPropriedadeInstance, field: 'longitudeTalhao', 'error')} ">
	<label for="longitudeTalhao">
		<g:message code="talhaoPropriedade.longitudeTalhao.label" default="Longitude Talhao" />
	</label>
	<g:textField name="longitudeTalhao" maxlength="11" value="${talhaoPropriedadeInstance?.longitudeTalhao}" style="width: 200px;"/>
</div>