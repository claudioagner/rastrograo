<%@ page import="rastrograo.seguranca.Acesso" %>



<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="acesso.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" maxlength="32" value="${acessoInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="acesso.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" maxlength="128" required="" value="${acessoInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="acesso.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:passwordField name="password" required="" maxlength="64" value=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'passwordExpired', 'error')} ">
	<label for="passwordExpired">
		<g:message code="acesso.passwordExpired.label" default="Password Expired" />
		
	</label>    
        <g:radioGroup name="passwordExpired"
                labels="['Sim', 'Não']" 
                values="['true', 'false']" 
                required="" 
                value="${acessoInstance?.passwordExpired}">
                ${it.label} ${it.radio}
        </g:radioGroup>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'accountExpired', 'error')} ">
	<label for="accountExpired">
		<g:message code="acesso.accountExpired.label" default="Account Expired" />
		
	</label>        
        <g:radioGroup name="accountExpired"
                labels="['Sim', 'Não']" 
                values="['true', 'false']" 
                required="" 
                value="${acessoInstance?.accountExpired}">
                ${it.label} ${it.radio}
        </g:radioGroup>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'accountLocked', 'error')} ">
	<label for="accountLocked">
		<g:message code="acesso.accountLocked.label" default="Account Locked" />
		
	</label>
        <g:radioGroup name="accountLocked"
                labels="['Sim', 'Não']" 
                values="['true', 'false']" 
                required="" 
                value="${acessoInstance?.accountLocked}">
                ${it.label} ${it.radio}
        </g:radioGroup>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="acesso.enabled.label" default="Enabled" />
		
	</label>
        <g:radioGroup name="enabled"
                labels="['Sim', 'Não']" 
                values="['true', 'false']" 
                required="" 
                value="${acessoInstance?.enabled}">
                ${it.label} ${it.radio}
        </g:radioGroup>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'authorities', 'error')} ">
        <span id="regras-label" class="property-label"><g:message code="acesso.authorities.label" default="Authorities" /></span>
        <g:if test="${acessoInstance?.id}">
                <g:each var="entry" in="${regraMap}">
                        <span class="property-value" aria-labelledby="authorities-label"><g:checkBox id="${entry.key.authority}" name="${entry.key.authority}" value="${entry.value}"/>&nbsp;&nbsp;${entry.key.authority.encodeAsHTML()}</span>
                </g:each>
        </g:if>
        <g:else>
                <g:each in="${regraInstanceList}">
                        <span class="property-value" aria-labelledby="authorities-label"><g:checkBox id="${it.authority}" name="${it.authority}"/>&nbsp;&nbsp;${it.authority.encodeAsHTML()}</span>
                </g:each>
        </g:else>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'empresas', 'error')} ">
	<label for="empresas">
		<g:message code="propriedade.empresas.label" default="Empresas" />
	</label>
	<g:select name="empresas" 
            from="${empresaInstanceList}" 
            multiple="multiple" 
            optionKey="id" 
            size="5" 
            value="${acessoInstance?.empresas*.id ?: empresaInstanceList?.id}" 
            class="many-to-many"
            noSelection="['': '-- Selecione Empresa --']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acessoInstance, field: 'propriedades', 'error')} ">
	<label for="propriedades">
		<g:message code="propriedade.propriedades.label" default="Propriedades" />
	</label>
	<g:select name="propriedades" 
            from="${propriedadeInstanceList}" 
            multiple="multiple" 
            optionKey="id" 
            size="5" 
            value="${acessoInstance?.propriedades*.id ?: propriedadeInstanceList?.id}" 
            class="many-to-many"
            noSelection="['': '-- Selecione Propriedade --']"/>
</div>