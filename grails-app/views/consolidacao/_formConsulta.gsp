<%@ page import="rastrograo.rastreamento.Consolidacao" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'empresa', 'error')} ">
	<label for="empresa">
		<g:message code="consulta.empresa.label" default="Empresa" />
	</label>
	<g:select id="empresa" 
            name="empresaId" 
            from="${empresaInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.empresa?.id}" 
            noSelection="['': '-- Selecione uma Empresa --']"
            class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'empresaOrigem', 'error')} ">
	<label for="empresaOrigem">
		<g:message code="consulta.empresaOrigem.label" default="Empresa Origem" />
	</label>
	<g:select id="empresaOrigem" 
            name="empresaOrigemId" 
            from="${rastrograo.empresa.Empresa.list()}" 
            optionKey="id" 
            value="${consultaInstance?.empresaOrigem?.id}" 
            noSelection="['': '-- Selecione uma Empresa de Origem --']"
            class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'propriedadeOrigem', 'error')} ">
	<label for="propriedadeOrigem">
		<g:message code="consulta.propriedadeOrigem.label" default="Propriedade Origem" />
	</label>
	<g:select id="propriedadeOrigem" 
            name="propriedadeOrigemId" 
            from="${rastrograo.propriedade.Propriedade.list()}" 
            optionKey="id" 
            value="${consultaInstance?.propriedadeOrigem?.id}" 
            noSelection="['': '-- Selecione uma Propriedade de Origem --']"
            class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'nrLoteConsolidado', 'error')} ">
	<label for="nrLoteConsolidado">
		<g:message code="consulta.nrLoteConsolidado.label" default="Nr Lote Consolidado" />
	</label>
	<g:textField name="nrLoteConsolidado" maxlength="32" value="${consultaInstance?.nrLoteConsolidado}"/>
</div>