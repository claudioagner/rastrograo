<div id="list-telefonePropriedade" class="content scaffold-list" role="main">
        <h1><g:message code="propriedade.telefones.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="telefonePropriedade" class="create" action="create" params="['propriedade.id': propriedadeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'telefonePropriedade.label', default: 'Telefone Propriedade')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'telefonePropriedade.dddPropriedade.label', default: 'Ddd Propriedade')}</th>

                                <th>${message(code: 'telefonePropriedade.numeroTelefonePropriedade.label', default: 'Numero Telefone Propriedade')}</th>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${propriedadeInstance?.telefones}" status="i" var="telefonePropriedadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="telefonePropriedade" class="show" action="show" id="${telefonePropriedadeInstance.id}"></g:link>

                                        <g:link controller="telefonePropriedade" class="edit" action="edit" id="${telefonePropriedadeInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: telefonePropriedadeInstance, field: "dddPropriedade")}</td>

                                <td>${fieldValue(bean: telefonePropriedadeInstance, field: "numeroTelefonePropriedade")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>