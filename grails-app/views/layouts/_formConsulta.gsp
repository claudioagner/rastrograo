<h1><g:message code="default.consulta.label" args="[entityName]" /></h1>

<g:hasErrors bean="${consultaInstance}">
<ul class="errors" role="alert">
        <g:eachError bean="${consultaInstance}" var="error">
        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
        </g:eachError>
</ul>
</g:hasErrors>

<g:form action="list" method="POST" >
        <fieldset class="form">
                <g:render template="formConsulta"/>
        </fieldset>
        <fieldset class="buttons">
                <g:submitButton class="list" name="consulta" value="${message(code: 'default.button.consulta.label', default: 'Consultar')}" />
        </fieldset>
</g:form>
