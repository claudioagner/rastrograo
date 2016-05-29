<%@ page import="rastrograo.propriedade.CertificacaoPropriedade" %>



<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'tipoCertificacao', 'error')} ">
	<label for="tipoCertificacao">
		<g:message code="consulta.tipoCertificacao.label" default="Tipo Certificacao" />
	</label>
	<g:select id="tipoCertificacao" 
            name="tipoCertificacaoId" 
            from="${rastrograo.tabela.TipoCertificacao.list()}" 
            optionKey="id" 
            value="${consultaInstance?.tipoCertificacao?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione um Tipo Certificação --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'propriedade', 'error')} ">
	<label for="propriedade">
		<g:message code="consulta.propriedade.label" default="Propriedade" />
	</label>
	<g:select id="propriedade" 
            name="propriedadeId" 
            from="${propriedadeInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.propriedade?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Propriedade --']"/>
</div>