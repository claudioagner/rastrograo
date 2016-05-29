<div id="list-listaAtributo" class="content scaffold-list" role="main">
        <h1><g:message code="atributo.listasAtributo.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="listaAtributo" class="create" action="create" params="['atributo.id': atributoInstance?.id ?: listaAtributoInstance?.atributo?.id]">${message(code: 'default.add.label', args: [message(code: 'listaAtributo.label', default: 'Lista Atributo')])}</g:link></li>

                </ul>
        </div>
        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <g:sortableColumn property="valorListaAtributo" title="${message(code: 'listaAtributo.valorListaAtributo.label', default: 'Valor Lista Atributo')}" />

                        </tr>
                </thead>
                <tbody>
                <g:each in="${atributoInstance?.listasAtributo ?: listaAtributoInstanceList}" status="i" var="listaAtributoInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="listaAtributo" class="show" action="show" id="${listaAtributoInstance.id}"></g:link>

                                        <g:link controller="listaAtributo" class="edit" action="edit" id="${listaAtributoInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: listaAtributoInstance, field: "valorListaAtributo")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>