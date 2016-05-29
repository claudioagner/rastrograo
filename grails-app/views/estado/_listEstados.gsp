<div id="list-estado" class="content scaffold-list" role="main">
        <h1><g:message code="pais.estados.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="estado" class="create" action="create" params="['pais.id': paisInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'estado.label', default: 'Estado')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'estado.nomeEstado.label', default: 'Nome Estado')}</th>

                                <th>${message(code: 'estado.sigla.label', default: 'Sigla')}</th>


                        </tr>
                </thead>
                <tbody>
                <g:each in="${paisInstance?.estados}" status="i" var="estadoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="estado" class="show" action="show" id="${estadoInstance.id}"></g:link>

                                        <g:link controller="estado" class="edit" action="edit" id="${estadoInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: estadoInstance, field: "nomeEstado")}</td>

                                <td>${fieldValue(bean: estadoInstance, field: "sigla")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>