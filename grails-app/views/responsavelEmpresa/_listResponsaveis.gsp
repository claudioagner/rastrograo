<div id="list-responsavelEmpresa" class="content scaffold-list" role="main">
        <h1><g:message code="empresa.responsaveis.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="responsavelEmpresa" class="create" action="create" params="['empresa.id': empresaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'responsavelEmpresa.label', default: 'Responsavel Empresa')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'responsavelEmpresa.nomeResponsavelEmpresa.label', default: 'Nome Responsavel Empresa')}</th>

                                <th>${message(code: 'responsavelEmpresa.dddResponsavelEmpresa.label', default: 'Ddd Responsavel Empresa')}</th>

                                <th>${message(code: 'responsavelEmpresa.numeroTelefoneResponsavelEmpresa.label', default: 'Numero Telefone Responsavel Empresa')}</th>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${empresaInstance?.responsaveis}" status="i" var="responsavelEmpresaInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="responsavelEmpresa" class="show" action="show" id="${responsavelEmpresaInstance.id}"></g:link>

                                        <g:link controller="responsavelEmpresa" class="edit" action="edit" id="${responsavelEmpresaInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: responsavelEmpresaInstance, field: "nomeResponsavelEmpresa")}</td>

                                <td>${fieldValue(bean: responsavelEmpresaInstance, field: "dddResponsavelEmpresa")}</td>

                                <td>${fieldValue(bean: responsavelEmpresaInstance, field: "numeroTelefoneResponsavelEmpresa")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>