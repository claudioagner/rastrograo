<div id="list-telefoneEmpresa" class="content scaffold-list" role="main">
        <h1><g:message code="empresa.telefones.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="telefoneEmpresa" class="create" action="create" params="['empresa.id': empresaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'telefoneEmpresa.label', default: 'Telefone Empresa')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'telefoneEmpresa.dddEmpresa.label', default: 'Ddd Empresa')}</th>

                                <th>${message(code: 'telefoneEmpresa.numeroTelefoneEmpresa.label', default: 'Numero Telefone Empresa')}</th>

                        </tr>
                </thead>
                <tbody>
                <g:each in="${empresaInstance?.telefones}" status="i" var="telefoneEmpresaInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="telefoneEmpresa" class="show" action="show" id="${telefoneEmpresaInstance.id}"></g:link>

                                        <g:link controller="telefoneEmpresa" class="edit" action="edit" id="${telefoneEmpresaInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: telefoneEmpresaInstance, field: "dddEmpresa")}</td>

                                <td>${fieldValue(bean: telefoneEmpresaInstance, field: "numeroTelefoneEmpresa")}</td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>