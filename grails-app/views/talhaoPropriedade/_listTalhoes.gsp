<div id="list-talhaoPropriedade" class="content scaffold-list" role="main">
        <h1><g:message code="propriedade.talhoes.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="talhaoPropriedade" class="create" action="create" params="['propriedade.id': propriedadeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'talhaoPropriedade.label', default: 'Talhao Propriedade')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'talhaoPropriedade.descricaoTalhao.label', default: 'Descricao Talhao')}</th>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${propriedadeInstance?.talhoes}" status="i" var="talhaoPropriedadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="talhaoPropriedade" class="show" action="show" id="${talhaoPropriedadeInstance.id}"></g:link>

                                        <g:link controller="talhaoPropriedade" class="edit" action="edit" id="${talhaoPropriedadeInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: talhaoPropriedadeInstance, field: "descricaoTalhao")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>