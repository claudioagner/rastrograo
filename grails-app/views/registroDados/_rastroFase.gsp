<div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'rastroFase', 'error')} required">
	<label for="rastroFase">
		<g:message code="registroDados.rastroFase.label" default="Rastro Fase" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="rastroFase" 
            name="rastroFase.id" 
            from="${registroDadosInstance?.rastroProduto?.rastrosFase?.sort{it.fase.descricaoFase} ?: consultaInstance?.rastroProduto?.rastrosFase?.sort{it.fase.descricaoFase}}" 
            optionKey="id" 
            required="" 
            value="${registroDadosInstance?.rastroFase?.id ?: consultaInstance?.rastroFase?.id}" 
            onClick="${remoteFunction (
                        controller: 'registroDados',
                        action: 'getAtributos',
                        params: '\'rastroFaseId=\' + this.value',
                        update: 'rastroAtributo'
                  )}"
            onLoading="showSpinner(true)"
            onComplete="showSpinner(false)"
            noSelection="['': '-- Selecione uma Fase --']"
            class="many-to-one"/>
</div>