<%@ page import="rastrograo.propriedade.TalhaoPropriedade" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'propriedade', 'error')} ">
	<label for="propriedade">
		<g:message code="talhaoPropriedade.propriedade.label" default="Propriedade" />
	</label>
	<g:select id="propriedade" 
            name="propriedadeId" 
            from="${propriedadeInstanceList}" 
            optionKey="id"  
            value="${consultaInstance?.propriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Propriedade --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'descricaoTalhao', 'error')} ">
	<label for="descricaoTalhao">
		<g:message code="talhaoPropriedade.descricaoTalhao.label" default="Descricao Talhao" />
	</label>
	<g:textField name="descricaoTalhao" value="${consultaInstance?.descricaoTalhao}" />
</div>