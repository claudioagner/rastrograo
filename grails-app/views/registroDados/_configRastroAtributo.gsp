<g:if test="${registroDadosInstance?.rastroAtributo}">
<div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'rastroAtributo.exibirQRConsumidor', 'error')} ">
        <label for="exibirQRConsumidor">
		<g:message code="rastroAtributo.exibirQRConsumidor.label" default="Exibir QR Consumidor" />
		<span class="required-indicator">*</span>		
	</label>
        <g:if test="${registroDadosInstance?.rastroAtributo?.exibirQRConsumidor}">
            <img src="${resource(dir: 'images/skin', file: 'qrcode.png')}" alt="Este atributo será exibido na consulta do QR-Code para o Consumidor"/>
        </g:if>
        <g:else>
            <span><g:message code="registroDados.exibirQRConsumidor.img"/></span>
        </g:else>
</div>
</g:if>

<g:if test="${registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo.equals('Texto')}">
<div id="fieldText" class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'valorAtributo', 'error')} required" >
	<label for="valorAtributo">
		<g:message code="registroDados.valorAtributo.label" default="Valor Atributo" />
		<span class="required-indicator">*</span>		
	</label>
	<g:textField name="valorAtributo" maxlength="128" required="" value="${registroDadosInstance?.valorAtributo}" disabled="${!registroDadosInstance?.rastroAtributo?.registrarDados}"/>
</div>
</g:if>
<g:elseif test="${registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo.equals('Data')}">
<div id="fieldData" class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'valorDataAtributo', 'error')} required" >
	<label for="valorDataAtributo">
		<g:message code="registroDados.valorAtributo.label" default="Valor Atributo" />
		<span class="required-indicator">*</span>		
	</label>
	<g:datePicker name="valorDataAtributo" precision="day" required="" value="${registroDadosInstance?.valorDataAtributo}" years="${2016..2050}" disabled="${!registroDadosInstance?.rastroAtributo?.registrarDados}" default="none" noSelection="['': '']" />
</div>
</g:elseif>
<g:elseif test="${registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo.equals('Data/Hora')}">
<div id="fieldData" class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'valorDataAtributo', 'error')} required" >
	<label for="valorDataAtributo">
		<g:message code="registroDados.valorAtributo.label" default="Valor Atributo" />
		<span class="required-indicator">*</span>		
	</label>
	<g:datePicker name="valorDataAtributo" required="" value="${registroDadosInstance?.valorDataAtributo}" years="${2016..2050}" disabled="${!registroDadosInstance?.rastroAtributo?.registrarDados}" default="none" noSelection="['': '']" />
</div>
</g:elseif>
<g:elseif test="${registroDadosInstance?.rastroAtributo?.atributo?.tipoAtributo.equals('Lista')}">
<div id="fieldSelect" class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'valorListaAtributo', 'error')} required" >
	<label for="valorListaAtributo">
		<g:message code="registroDados.valorAtributo.label" default="Valor Atributo" />
		<span class="required-indicator">*</span>		
	</label>
	<g:select id="valorListaAtributo" 
            name="valorListaAtributo.id" 
            from="${registroDadosInstance?.rastroAtributo?.atributo?.listasAtributo}" 
            optionKey="id" 
            required=""
            value="${registroDadosInstance?.valorListaAtributo?.id}" 
            class="many-to-one" 
            noSelection="['': '-- Selecione um Valor Atributo --']"
            disabled="${!registroDadosInstance?.rastroAtributo?.registrarDados}"/>
</div>
</g:elseif>
        
<g:if test="${registroDadosInstance?.rastroAtributo && !registroDadosInstance?.rastroAtributo?.registrarDados}">
    <div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'rastroAtributo.registrarDados', 'error')} ">
            <label for="registrarDados">
                    <g:message code="rastroAtributo.registrarDados.label" default="Registrar Dados" />
                    <span class="required-indicator">*</span>		
            </label>
            <span style="color: red;">O [Atributo] está desativado na customização</span>
    </div>
</g:if>

<div class="fieldcontain ${hasErrors(bean: registroDadosInstance, field: 'comentarioAtributo', 'error')} ">
	<label for="comentarioAtributo">
		<g:message code="registroDados.comentarioAtributo.label" default="Comentario Atributo" />
		
	</label>
	<g:textArea name="comentarioAtributo" cols="40" rows="5" maxlength="65534" value="${registroDadosInstance?.comentarioAtributo}"/>
</div>