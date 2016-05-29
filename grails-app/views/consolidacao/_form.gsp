<%@ page import="rastrograo.rastreamento.Consolidacao" %>


<g:if test="${consolidacaoInstance?.empresa}">
<div class="fieldcontain">
        <span id="empresa-label" class="property-label"><g:message code="consolidacao.empresa.label" default="Empresa" /></span>

                <span class="property-value" aria-labelledby="empresa-label">${consolidacaoInstance?.empresa?.encodeAsHTML()}
                        <g:link controller="empresa" class="show" action="show" id="${consolidacaoInstance?.empresa?.id}"></g:link>
                        <g:link controller="empresa" class="edit" action="edit" id="${consolidacaoInstance?.empresa?.id}"></g:link>
                </span>
                <g:hiddenField name="empresa.id" value="${consolidacaoInstance?.empresa?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'empresa', 'error')} required">
	<label for="empresa">
		<g:message code="consolidacao.empresa.label" default="Empresa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empresa" 
            name="empresa.id" 
            from="${empresaInstanceList}" 
            optionKey="id" 
            required="" 
            value="${consolidacaoInstance?.empresa?.id}" 
            noSelection="['': '-- Selecione uma Empresa --']"
            class="many-to-one"/>
</div>
</g:else>

<g:if test="${consolidacaoInstance?.produto}">
<div class="fieldcontain">
        <span id="produto-label" class="property-label"><g:message code="consolidacao.produto.label" default="Produto" /></span>

                <span class="property-value" aria-labelledby="produto-label">${consolidacaoInstance?.produto?.encodeAsHTML()}
                        <g:link controller="produto" class="show" action="show" id="${consolidacaoInstance?.produto?.id}"></g:link>
                        <g:link controller="produto" class="edit" action="edit" id="${consolidacaoInstance?.produto?.id}"></g:link>
                </span>
                <g:hiddenField name="produto.id" value="${consolidacaoInstance?.produto?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'produto', 'error')} required">
	<label for="produto">
		<g:message code="consolidacao.produto.label" default="Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="produto" 
            name="produto.id" 
            from="${rastrograo.estrutura.Produto.list()}" 
            optionKey="id" 
            required="" 
            value="${consolidacaoInstance?.produto?.id}" 
            noSelection="['': '-- Selecione uma Empresa --']"
            class="many-to-one"/>
</div>
</g:else>

<g:if test="${consolidacaoInstance?.empresaOrigem}">
<div class="fieldcontain">
        <span id="empresaOrigem-label" class="property-label"><g:message code="consolidacao.empresaOrigem.label" default="Empresa Origem" /></span>

                <span class="property-value" aria-labelledby="empresaOrigem-label">${consolidacaoInstance?.empresaOrigem?.encodeAsHTML()}
                        <g:link controller="empresa" class="show" action="show" id="${consolidacaoInstance?.empresaOrigem?.id}"></g:link>
                        <g:link controller="empresa" class="edit" action="edit" id="${consolidacaoInstance?.empresaOrigem?.id}"></g:link>
                </span>
                <g:hiddenField name="empresaOrigem.id" value="${consolidacaoInstance?.empresaOrigem?.id}" />

</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'empresaOrigem', 'error')} required">
	<label for="empresaOrigem">
		<g:message code="consolidacao.empresaOrigem.label" default="Empresa Origem" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="empresaOrigem" 
            name="empresaOrigem.id" 
            from="${rastrograo.empresa.Empresa.list()}" 
            optionKey="id" 
            required="" 
            value="${consolidacaoInstance?.empresaOrigem?.id}" 
            noSelection="['': '-- Selecione uma Empresa de Origem --']"
            class="many-to-one"/>
</div>
</g:else>

<g:if test="${consolidacaoInstance?.propriedadeOrigem}">
<div class="fieldcontain">
        <span id="propriedadeOrigem-label" class="property-label"><g:message code="consolidacao.propriedadeOrigem.label" default="Propriedade Origem" /></span>

                <span class="property-value" aria-labelledby="propriedadeOrigem-label">${consolidacaoInstance?.propriedadeOrigem?.encodeAsHTML()}
                        <g:link controller="propriedade" class="show" action="show" id="${consolidacaoInstance?.propriedadeOrigem?.id}"></g:link>
                        <g:link controller="propriedade" class="edit" action="edit" id="${consolidacaoInstance?.propriedadeOrigem?.id}"></g:link>
                </span>
                <g:hiddenField name="propriedadeOrigem.id" value="${consolidacaoInstance?.propriedadeOrigem?.id}" />
</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'propriedadeOrigem', 'error')} required">
	<label for="propriedadeOrigem">
		<g:message code="consolidacao.propriedadeOrigem.label" default="Propriedade Origem" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="propriedadeOrigem" 
            name="propriedadeOrigem.id" 
            from="${rastrograo.propriedade.Propriedade.list()}" 
            optionKey="id" 
            required="" 
            value="${consolidacaoInstance?.propriedadeOrigem?.id}" 
            noSelection="['': '-- Selecione uma Propriedade de Origem --']"
            class="many-to-one"/>
</div>
</g:else>

<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'dataConsolidacao', 'error')} required">
	<label for="dataConsolidacao">
		<g:message code="consolidacao.dataConsolidacao.label" default="Data Consolidacao" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dataConsolidacao" precision="day"  value="${consolidacaoInstance?.dataConsolidacao}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'dataLoteOrigem', 'error')} required">
	<label for="dataLoteOrigem">
		<g:message code="consolidacao.dataLoteOrigem.label" default="Data Lote Origem" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dataLoteOrigem" precision="day"  value="${consolidacaoInstance?.dataLoteOrigem}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'validadeLoteOrigem', 'error')} required">
	<label for="validadeLoteOrigem">
		<g:message code="consolidacao.validadeLoteOrigem.label" default="Validade Lote Origem" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="validadeLoteOrigem" precision="day"  value="${consolidacaoInstance?.validadeLoteOrigem}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'nrLoteConsolidado', 'error')} required">
	<label for="nrLoteConsolidado">
		<g:message code="consolidacao.nrLoteConsolidado.label" default="Nr Lote Consolidado" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nrLoteConsolidado" maxlength="32" required="" value="${consolidacaoInstance?.nrLoteConsolidado}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'volumeLoteOrigem', 'error')} required">
	<label for="volumeLoteOrigem">
		<g:message code="consolidacao.volumeLoteOrigem.label" default="Volume Lote Origem" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="volumeLoteOrigem" value="${fieldValue(bean: consolidacaoInstance, field: 'volumeLoteOrigem')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'conservacao', 'error')} ">
	<label for="conservacao">
		<g:message code="consolidacao.conservacao.label" default="Conservacao" />
	</label>
	<g:textField name="conservacao" maxlength="128" value="${consolidacaoInstance?.conservacao}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: consolidacaoInstance, field: 'observacao', 'error')} ">
	<label for="observacao">
		<g:message code="consolidacao.observacao.label" default="Observacao" />
		
	</label>
	<g:textArea name="observacao" cols="40" rows="5" maxlength="65534" value="${consolidacaoInstance?.observacao}"/>
</div>

