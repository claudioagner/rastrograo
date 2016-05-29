<div id="list-fotoTalhaoPropriedade" class="content scaffold-list" role="main">
        <h1><g:message code="propriedade.fotos.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="fotoTalhaoPropriedade" class="create" action="create" params="['talhaoPropriedade.id': talhaoPropriedadeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fotoTalhaoPropriedade.label', default: 'Foto Talhao Propriedade')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'fotoTalhaoPropriedade.tituloFoto.label', default: 'Titulo Foto')}</th>

                                <th>${message(code: 'fotoTalhaoPropriedade.foto.label', default: 'Foto')}</th>
                        </tr>
                </thead>
                <tbody>
                <g:each in="${talhaoPropriedadeInstance?.fotos}" status="i" var="fotoTalhaoPropriedadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="fotoTalhaoPropriedade" class="show" action="show" id="${fotoTalhaoPropriedadeInstance.id}"></g:link>

                                        <g:link controller="fotoTalhaoPropriedade" class="edit" action="edit" id="${fotoTalhaoPropriedadeInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: fotoTalhaoPropriedadeInstance, field: "tituloFoto")}</td>

                                <td><img style="width: 20%;"src="${createLink(controller:'fotoTalhaoPropriedade', action:'showFoto', id: fotoTalhaoPropriedadeInstance?.id)}"/></td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>