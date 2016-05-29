<div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'rastroProduto', 'error')} required">
	<label for="rastroProduto">
		<g:message code="registroDados.rastroProduto.label" default="Rastro Produto" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="rastroProduto" 
            name="rastroProduto.id" 
            from="${rastroProdutoInstanceList}" 
            optionKey="id" 
            required=""
            value="${consultaInstance?.rastroProduto?.id}" 
            onClick="${remoteFunction (
                        controller: 'registroDados',
                        action: 'getFases',
                        params: '\'rastroProdutoId=\' + this.value',
                        update: 'rastroFase'
                  )}"
            onLoading="showSpinner(true)"
            onComplete="showSpinner(false)"
            noSelection="['': '-- Selecione um Produto --']"
            class="many-to-one"/>
</div>

<div id="rastroFase"><g:render template="rastroFase"/></div>

<div id="rastroAtributo"><g:render template="rastroAtributo"/></div>