<%@ page import="rastrograo.empresa.CertificacaoEmpresa" %>



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

<div class="fieldcontain ${hasErrors(bean: consultaInstance, field: 'empresa', 'error')} ">
	<label for="empresa">
		<g:message code="consulta.empresa.label" default="Empresa" />
	</label>
	<g:select id="empresa" 
            name="empresaId" 
            from="${empresaInstanceList}" 
            optionKey="id" 
            value="${consultaInstance?.empresa?.id}" 
            class="many-to-one"
            noSelection="['': '-- Selecione uma Empresa --']"/>
</div>