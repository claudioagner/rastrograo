<%@ page import="rastrograo.tabela.Estado" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'pais', 'error')} ">
	<label for="pais">
		<g:message code="estado.pais.label" default="Pais" />
	</label>
	<g:select id="pais" 
            name="paisId" 
            from="${rastrograo.tabela.Pais.list()}"
            optionKey="id" 
            value="${consultaInstance?.pais?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um País --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nomeEstado', 'error')} ">
	<label for="nomeEstado">
		<g:message code="estado.nomeEstado.label" default="Nome Estado" />
	</label>
	<g:textField name="nomeEstado" maxlength="128" value="${consultaInstance?.nomeEstado}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'sigla', 'error')} ">
	<label for="sigla">
		<g:message code="estado.sigla.label" default="Sigla" />
	</label>
	<g:textField name="sigla" maxlength="2" value="${consultaInstance?.sigla}"/>
</div>