<div id="list-atributo" class="content scaffold-list" role="main">
        <h1><g:message code="fase.atributos.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="atributo" class="create" action="create" params="['fase.id': faseInstance?.id ?: atributoInstance?.fase?.id]">${message(code: 'default.add.label', args: [message(code: 'atributo.label', default: 'Atributo')])}</g:link></li>

                </ul>
        </div>
        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <g:sortableColumn property="nomeAtributo" title="${message(code: 'atributo.nomeAtributo.label', default: 'Nome Atributo')}" />

                                <g:sortableColumn property="tipoAtributo" title="${message(code: 'atributo.tipoAtributo.label', default: 'Tipo Atributo')}" />

                        </tr>
                </thead>
                <tbody>
                <g:each in="${faseInstance?.atributos ?: atributoInstanceList}" status="i" var="atributoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="atributo" class="show" action="show" id="${atributoInstance.id}"></g:link>

                                        <g:link controller="atributo" class="edit" action="edit" id="${atributoInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: atributoInstance, field: "nomeAtributo")}</td>

                                <td>${fieldValue(bean: atributoInstance, field: "tipoAtributo")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>