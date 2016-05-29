<div id="list-certificacaoPropriedade" class="content scaffold-list" role="main">
        <h1><g:message code="propriedade.certificados.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="certificacaoPropriedade" class="create" action="create" params="['propriedade.id': propriedadeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'certificacaoPropriedade.label', default: 'Certificacao Propriedade')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'certificacaoPropriedade.tipoCertificacao.label', default: 'Tipo Certificacao')}</th>

                                <th>${message(code: 'certificacaoPropriedade.dataCertificacao.label', default: 'Data Certificacao')}</th>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${propriedadeInstance?.certificados}" status="i" var="certificacaoPropriedadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="certificacaoPropriedade" class="show" action="show" id="${certificacaoPropriedadeInstance.id}"></g:link>

                                        <g:link controller="certificacaoPropriedade" class="edit" action="edit" id="${certificacaoPropriedadeInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: certificacaoPropriedadeInstance, field: "tipoCertificacao")}</td>

                                <td><g:formatDate date="${certificacaoPropriedadeInstance.dataCertificacao}" format="dd/MM/yyyy"/></td>
                        </tr>
                </g:each>
                </tbody>
        </table>
</div>