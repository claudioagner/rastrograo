<div id="list-fotoEmpresa" class="content scaffold-list" role="main">
        <h1><g:message code="empresa.fotos.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="fotoEmpresa" class="create" action="create" params="['empresa.id': empresaInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fotoEmpresa.label', default: 'Foto Empresa')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'fotoEmpresa.tituloFoto.label', default: 'Titulo Foto')}</th>

                                <th>${message(code: 'fotoEmpresa.foto.label', default: 'Foto')}</th>
                        </tr>
                </thead>
                <tbody>
                <g:each in="${empresaInstance?.fotos}" status="i" var="fotoEmpresaInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="fotoEmpresa" class="show" action="show" id="${fotoEmpresaInstance.id}"></g:link>

                                        <g:link controller="fotoEmpresa" class="edit" action="edit" id="${fotoEmpresaInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: fotoEmpresaInstance, field: "tituloFoto")}</td>

                                <td><img style="width: 20%;"src="${createLink(controller:'fotoEmpresa', action:'showFoto', id: fotoEmpresaInstance?.id)}"/></td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>