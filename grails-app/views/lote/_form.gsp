<%@ page import="rastrograo.rastreamento.Lote" %>


<g:if test="${loteInstance?.rastroProduto}">
<div class="fieldcontain">
        <span id="rastroProduto-label" class="property-label"><g:message code="lote.rastroProduto.label" default="Rastro Produto" /></span>

                <span class="property-value" aria-labelledby="rastroProduto-label">${loteInstance?.rastroProduto?.encodeAsHTML()}
                        <g:link controller="rastroProduto" class="show" action="show" id="${loteInstance?.rastroProduto?.id}"></g:link>
                        <g:link controller="rastroProduto" class="edit" action="edit" id="${loteInstance?.rastroProduto?.id}"></g:link>
                </span>		
                <g:hiddenField name="rastroProduto.id" value="${loteInstance?.rastroProduto?.id}" />
</div>
</g:if>
<g:else>
<div class="fieldcontain ${hasErrors(bean: loteInstance, field: 'rastroProduto', 'error')} required">
	<label for="rastroProduto">
		<g:message code="lote.rastroProduto.label" default="Rastro Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="rastroProduto" 
            name="rastroProduto.id" 
            from="${rastroProdutoInstanceList}" 
            optionKey="id" 
            required="" 
            value="${loteInstance?.rastroProduto?.id}" 
            noSelection="['': '-- Selecione um Rastreamento --']"
            class="many-to-one"/>
</div>
</g:else>
<div class="fieldcontain ${hasErrors(bean: loteInstance, field: 'dataLote', 'error')} required">
	<label for="dataLote">
		<g:message code="lote.dataLote.label" default="Data Lote" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dataLote" precision="day"  value="${loteInstance?.dataLote}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: loteInstance, field: 'validadeLote', 'error')} required">
	<label for="validadeLote">
		<g:message code="lote.validadeLote.label" default="Validade Lote" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="validadeLote" precision="day"  value="${loteInstance?.validadeLote}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: loteInstance, field: 'nrLoteSequencial', 'error')} ">
	<label for="nrLoteSequencial">
		<g:message code="lote.nrLoteSequencial.label" default="Nr Lote Sequencial" />
		
	</label>
        <g:radioGroup id="nrLoteSequencial"
                name="nrLoteSequencial"
                labels="['Sim', 'Não']" 
                values="['true', 'false']" 
                required="" 
                value="${loteInstance?.nrLoteSequencial}"
                onClick="${remoteFunction (
                    controller: 'lote',
                    action: 'showNrLoteManual',
                    params: '\'nrLoteSequencial=\' + this.value',
                    update: 'nrLoteManual'
                )}"
                onLoading="showSpinner(true)"
                onComplete="showSpinner(false)">
                ${it.label} ${it.radio}
        </g:radioGroup>
</div>

<div id="nrLoteManual">
        <g:render template="fieldNrLoteManual"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loteInstance, field: 'volumeLote', 'error')} required">
	<label for="volumeLote">
		<g:message code="lote.volumeLote.label" default="Volume Lote" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="volumeLote" value="${fieldValue(bean: loteInstance, field: 'volumeLote')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: loteInstance, field: 'conservacao', 'error')} ">
	<label for="conservacao">
		<g:message code="consolidacao.conservacao.label" default="Conservacao" />
	</label>
	<g:textField name="conservacao" maxlength="128" value="${loteInstance?.conservacao}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: loteInstance, field: 'observacao', 'error')} ">
	<label for="observacao">
		<g:message code="lote.observacao.label" default="Observacao" />
		
	</label>
	<g:textArea name="observacao" cols="40" rows="5" maxlength="65534" value="${loteInstance?.observacao}"/>
</div>