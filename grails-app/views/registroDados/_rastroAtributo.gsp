<div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'rastroAtributo', 'error')} required">
	<label for="rastroAtributo">
		<g:message code="registroDados.rastroAtributo.label" default="Rastro Atributo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="rastroAtributo" 
            name="rastroAtributo.id" 
            from="${registroDadosInstance?.rastroFase?.rastrosAtributo ?: consultaInstance?.rastroFase?.rastrosAtributo}" 
            optionKey="id" 
            required="" 
            value="${registroDadosInstance?.rastroAtributo?.id ?: consultaInstance?.rastroAtributo?.id}" 
            onClick="${remoteFunction (
                    controller: 'registroDados',
                    action: 'getAtributo',
                    params: '\'rastroAtributoId=\' + this.value',
                    update: 'configRastroAtributo'
              )}"
            onLoading="showSpinner(true)"
            onComplete="showSpinner(false)"
            noSelection="['': '-- Selecione um Atributo --']"
            class="many-to-one"/>
</div>