<div id="list-cultivar" class="content scaffold-list" role="main">
        <h1><g:message code="produto.cultivares.label" /></h1>
        
        <div class="nav">
                <ul>

                        <li><g:link controller="cultivar" class="create" action="create" params="['produto.id': produtoInstance?.id ?: cultivarInstance?.produto?.id]">${message(code: 'default.add.label', args: [message(code: 'cultivar.label', default: 'Cultivar')])}</g:link></li>

                </ul>
        </div>
        
        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <g:sortableColumn property="descricaoCultivar" title="${message(code: 'cultivar.descricaoCultivar.label', default: 'Descricao Cultivar')}"/>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${produtoInstance?.cultivares ?: cultivarInstanceList}" status="i" var="cultivarInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">


                                <td>
                                        <g:link controller="cultivar" class="show" action="show" id="${cultivarInstance.id}"></g:link>

                                        <g:link controller="cultivar" class="edit" action="edit" id="${cultivarInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: cultivarInstance, field: "descricaoCultivar")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>