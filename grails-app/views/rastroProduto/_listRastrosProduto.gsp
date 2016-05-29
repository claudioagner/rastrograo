		<div id="list-rastroProduto" class="content scaffold-list" role="main">
                        <table>
				<thead>
					<tr>
					
                                                <th>${message(code: 'default.action.label', default: 'Action')}</th>
					
                                                <th>${message(code: 'rastroProduto.empresa.label', default: 'Empresa')}</th>
                                                
                                                <th>${message(code: 'rastroProduto.propriedade.label', default: 'Propriedade')}</th>
                
                                                <th>${message(code: 'rastroProduto.talhaoPropriedade.label', default: 'Talhao Propriedade')}</th>
                
                                                <th>${message(code: 'rastroProduto.produto.label', default: 'Produto')}</th>
                
                                                <th>${message(code: 'rastroProduto.cultivar.label', default: 'Cultivar')}</th>
                
                                                <th>${message(code: 'rastroProduto.anoSafra.label', default: 'Ano Safra')}</th>
                
					</tr>
				</thead>
				<tbody>
				<g:each in="${rastroProdutoInstanceList}" status="i" var="rastroProdutoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>
                                                        <g:link controller="rastroProduto" class="show" action="show" id="${rastroProdutoInstance.id}"></g:link>
                
                                                        <g:link controller="registroDados" class="create" action="create"></g:link>
                                                </td>
                                                
						<td>${fieldValue(bean: rastroProdutoInstance, field: "empresa")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "propriedade")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "talhaoPropriedade")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "produto")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "cultivar")}</td>
					
						<td>${fieldValue(bean: rastroProdutoInstance, field: "anoSafra")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
