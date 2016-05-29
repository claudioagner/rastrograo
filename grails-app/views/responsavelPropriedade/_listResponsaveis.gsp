<div id="list-responsavelPropriedade" class="content scaffold-list" role="main">
        <h1><g:message code="propriedade.responsaveis.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="responsavelPropriedade" class="create" action="create" params="['propriedade.id': propriedadeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'responsavelPropriedade.label', default: 'Responsavel Propriedade')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'responsavelPropriedade.nomeResponsavelPropriedade.label', default: 'Nome Responsavel Propriedade')}</th>

                                <th>${message(code: 'responsavelPropriedade.dddResponsavelPropriedade.label', default: 'Ddd Responsavel Propriedade')}</th>

                                <th>${message(code: 'responsavelPropriedade.numeroTelefoneResponsavelPropriedade.label', default: 'Numero Telefone Responsavel Propriedade')}</th>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${propriedadeInstance?.responsaveis}" status="i" var="responsavelPropriedadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="responsavelPropriedade" class="show" action="show" id="${responsavelPropriedadeInstance.id}"></g:link>

                                        <g:link controller="responsavelPropriedade" class="edit" action="edit" id="${responsavelPropriedadeInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: responsavelPropriedadeInstance, field: "nomeResponsavelPropriedade")}</td>

                                <td>${fieldValue(bean: responsavelPropriedadeInstance, field: "dddResponsavelPropriedade")}</td>

                                <td>${fieldValue(bean: responsavelPropriedadeInstance, field: "numeroTelefoneResponsavelPropriedade")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>