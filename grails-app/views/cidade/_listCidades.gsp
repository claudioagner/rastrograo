<div id="list-cidade" class="content scaffold-list" role="main">
        <h1><g:message code="estado.cidades.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="cidade" class="create" action="create" params="['estado.id': estadoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'cidade.label', default: 'Cidade')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'cidade.nomeCidade.label', default: 'Nome Cidade')}</th>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${estadoInstance?.cidades}" status="i" var="cidadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="cidade" class="show" action="show" id="${cidadeInstance.id}"></g:link>

                                        <g:link controller="cidade" class="edit" action="edit" id="${cidadeInstance.id}"></g:link>
                                </td>
                                
                                <td>${fieldValue(bean: cidadeInstance, field: "nomeCidade")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>