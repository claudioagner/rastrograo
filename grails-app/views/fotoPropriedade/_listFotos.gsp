<div id="list-fotoPropriedade" class="content scaffold-list" role="main">
        <h1><g:message code="propriedade.fotos.label" /></h1>
        <div class="nav">
                <ul>

                        <li><g:link controller="fotoPropriedade" class="create" action="create" params="['propriedade.id': propriedadeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'fotoPropriedade.label', default: 'Foto Propriedade')])}</g:link></li>

                </ul>
        </div>

        <table>
                <thead>
                        <tr>

                                <th>${message(code: 'default.action.label', default: 'Action')}</th>

                                <th>${message(code: 'fotoPropriedade.tituloFoto.label', default: 'Titulo Foto')}</th>

                                <th>${message(code: 'fotoPropriedade.foto.label', default: 'Foto')}</th>
                        </tr>
                </thead>
                <tbody>
                <g:each in="${propriedadeInstance?.fotos}" status="i" var="fotoPropriedadeInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                        <g:link controller="fotoPropriedade" class="show" action="show" id="${fotoPropriedadeInstance.id}"></g:link>

                                        <g:link controller="fotoPropriedade" class="edit" action="edit" id="${fotoPropriedadeInstance.id}"></g:link>
                                </td>

                                <td>${fieldValue(bean: fotoPropriedadeInstance, field: "tituloFoto")}</td>

                                <td><img style="width: 20%;"src="${createLink(controller:'fotoPropriedade', action:'showFoto', id: fotoPropriedadeInstance?.id)}"/></td>

                        </tr>
                </g:each>
                </tbody>
        </table>
</div>