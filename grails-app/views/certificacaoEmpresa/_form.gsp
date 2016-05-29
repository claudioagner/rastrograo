<%@ page import="rastrograo.empresa.CertificacaoEmpresa" %>


<g:if test="${certificacaoEmpresaInstance?.tipoCertificacao}">
        <div class="fieldcontain">
                <span id="tipoCertificacao-label" class="property-label"><g:message code="certificacaoEmpresa.tipoCertificacao.label" default="Tipo Certificacao" /></span>

                        <span class="property-value" aria-labelledby="tipoCertificacao-label">${certificacaoEmpresaInstance?.tipoCertificacao?.encodeAsHTML()}
                                <g:link controller="tipoCertificacao" class="show" action="show" id="${certificacaoEmpresaInstance?.tipoCertificacao?.id}"></g:link>
                                <g:link controller="tipoCertificacao" class="edit" action="edit" id="${certificacaoEmpresaInstance?.tipoCertificacao?.id}"></g:link>
                        </span>
                        <g:hiddenField name="tipoCertificacao.id" value="${certificacaoEmpresaInstance?.tipoCertificacao?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: certificacaoEmpresaInstance, field: 'tipoCertificacao', 'error')} required">
                <label for="tipoCertificacao">
                        <g:message code="certificacaoEmpresa.tipoCertificacao.label" default="Tipo Certificacao" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="tipoCertificacao" 
                    name="tipoCertificacao.id" 
                    from="${rastrograo.tabela.TipoCertificacao.list()}" 
                    optionKey="id" 
                    required="" 
                    value="${certificacaoEmpresaInstance?.tipoCertificacao?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione um Tipo Certificação --']"/>
        </div>
</g:else>

<g:if test="${certificacaoEmpresaInstance?.empresa}">
        <div class="fieldcontain">
                <span id="empresa-label" class="property-label"><g:message code="certificacaoEmpresa.empresa.label" default="Empresa" /></span>

                        <span class="property-value" aria-labelledby="empresa-label">${certificacaoEmpresaInstance?.empresa?.encodeAsHTML()}
                                <g:link controller="empresa" class="show" action="show" id="${certificacaoEmpresaInstance?.empresa?.id}"></g:link>
                                <g:link controller="empresa" class="edit" action="edit" id="${certificacaoEmpresaInstance?.empresa?.id}"></g:link>
                        </span>
                        <g:hiddenField name="empresa.id" value="${certificacaoEmpresaInstance?.empresa?.id}" />

        </div>
</g:if>
<g:else>
        <div class="fieldcontain ${hasErrors(bean: certificacaoEmpresaInstance, field: 'empresa', 'error')} required">
                <label for="empresa">
                        <g:message code="certificacaoEmpresa.empresa.label" default="Empresa" />
                        <span class="required-indicator">*</span>
                </label>
                <g:select id="empresa" 
                    name="empresa.id" 
                    from="${empresaInstanceList}" 
                    optionKey="id" 
                    required="" 
                    value="${certificacaoEmpresaInstance?.empresa?.id}" 
                    class="many-to-one"
                    noSelection="['': '-- Selecione uma Empresa --']"/>
        </div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: certificacaoEmpresaInstance, field: 'dataCertificacao', 'error')} required">
	<label for="dataCertificacao">
		<g:message code="certificacaoEmpresa.dataCertificacao.label" default="Data Certificacao" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dataCertificacao" precision="day"  value="${certificacaoEmpresaInstance?.dataCertificacao}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: certificacaoEmpresaInstance, field: 'observacao', 'error')} ">
	<label for="observacao">
		<g:message code="certificacaoEmpresa.observacao.label" default="Observacao" />
		
	</label>
	<g:textArea name="observacao" cols="40" rows="5" maxlength="65534" value="${certificacaoEmpresaInstance?.observacao}"/>
</div>

