<div id="list-certificacaoEmpresa" class="content scaffold-list" role="main">
        <h1><g:message code="empresa.certificados.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="certificacaoEmpresa" class="create" action="create" params="['empresa.id': empresaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'certificacaoEmpresa.label', default: 'Certificacao Empresa')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'certificacaoEmpresa.tipoCertificacao.label', default: 'Tipo Certificacao')}</th>

                                <th>${message(code: 'certificacaoEmpresa.dataCertificacao.label', default: 'Data Certificacao')}</th>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${empresaInstance?.certificados}" status="i" var="certificacaoEmpresaInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="certificacaoEmpresa" class="show" action="show" id="${certificacaoEmpresaInstance.id}"></g:link>

                                        <g:link controller="certificacaoEmpresa" class="edit" action="edit" id="${certificacaoEmpresaInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: certificacaoEmpresaInstance, field: "tipoCertificacao")}</td>

                                <td><g:formatDate date="${certificacaoEmpresaInstance.dataCertificacao}" format="dd/MM/yyyy"/></td>
                        </tr>
                </g:each>
                </tbody>
        </table>
</div>