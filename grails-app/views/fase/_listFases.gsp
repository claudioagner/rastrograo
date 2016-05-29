<div id="list-fase" class="content scaffold-list" role="main">
        <h1><g:message code="produto.fases.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="fase" class="create" action="create" params="['produto.id': produtoInstance?.id ?: faseInstance?.produto?.id]">${message(code: 'default.add.label', args: [message(code: 'fase.label', default: 'Fase')])}</g:link></li>

                </ul>
        </div>
        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <g:sortableColumn property="descricaoFase" title="${message(code: 'fase.descricaoFase.label', default: 'Descricao Fase')}" />

                        </tr>
                </thead>
                <tbody>
                <g:each in="${produtoInstance?.fases ?: faseInstanceList}" status="i" var="faseInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="fase" class="show" action="show" id="${faseInstance.id}"></g:link>

                                        <g:link controller="fase" class="edit" action="edit" id="${faseInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: faseInstance, field: "descricaoFase")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>