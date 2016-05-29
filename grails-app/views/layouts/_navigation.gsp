<div id='cssmenu'>
    <ul>    
        <sec:ifLoggedIn>
            <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR">
                <li class='has-sub'><a href='#'><span><g:message code="menu.administracao.label" default="Administracao" /></span></a>
                    <ul>
                        <li><g:link controller="cidade" action="list">
                                <span>
                                    <g:message code="cidade.label" default="Cidade" />
                                </span>
                            </g:link>
                        </li>
                        <li><g:link controller="estado" action="list">
                                <span>
                                    <g:message code="estado.label" default="Estado" />
                                </span>
                            </g:link>
                        </li>
                        <li><g:link controller="pais" action="list">
                                <span>
                                    <g:message code="pais.label" default="Pais" />
                                </span>
                            </g:link>
                        </li>
                        <li class='has-sub'><a href='#'><span><g:message code="menu.seguranca.label" default="Seguranca" /></span></a>
                            <ul>
                                <li><g:link controller="acesso" action="list">
                                        <span>
                                            <g:message code="acesso.label" default="Acesso" />
                                        </span>
                                    </g:link>
                                </li>
                                <li><g:link controller="regra" action="list">
                                        <span>
                                            <g:message code="regra.label" default="Regra" />
                                        </span>
                                    </g:link>
                                </li>
                                <li><g:link controller="permissao" action="list">
                                        <span>
                                            <g:message code="permissao.label" default="Permissao" />
                                        </span>
                                    </g:link>
                                </li>
                                <li class='last'><g:link controller="auditLogEvent" action="list">
                                        <span>
                                            <g:message code="auditLogEvent.label" default="Audit Log Event" />
                                        </span>
                                    </g:link>
                                </li>
                            </ul>
                        </li>
                        <li><g:link controller="tipoCertificacao" action="list">
                                <span>
                                    <g:message code="tipoCertificacao.label" default="Tipo Certificacao" />
                                </span>
                            </g:link>
                        </li>
                        <li><g:link controller="tipoProduto" action="list">
                                <span>
                                    <g:message code="tipoProduto.label" default="Tipo Produto" />
                                </span>
                            </g:link>
                        </li>
                        <li class='last'><g:link controller="tipoResponsavel" action="list">
                                <span>
                                    <g:message code="tipoResponsavel.label" default="Tipo Responsavel" />
                                </span>
                            </g:link>
                        </li>
                    </ul>
                </li>   
            </sec:ifAnyGranted>
            <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_EMPRESA">
                <sec:ifAnyGranted roles="ROLE_EMPRESA">
                    <li class='has-sub'><a href='#'><span><g:message code="menu.seguranca.label" default="Seguranca" /></span></a>
                            <ul>
                                <li><g:link controller="acesso" action="list">
                                        <span>
                                            <g:message code="acesso.label" default="Acesso" />
                                        </span>
                                    </g:link>
                                </li>
                            </ul>
                    </li>
                </sec:ifAnyGranted>
                <li class='has-sub'><a href='#'><span><g:message code="menu.configuracao.label" default="Configuracao" /></span></a>
                    <ul>
                        <li class='has-sub'><a href='#'><span><g:message code="menu.empresa.label" default="Empresa" /></span></a>
                            <ul>
                                <li><g:link controller="empresa" action="list">
                                        <span>
                                            <g:message code="empresa.label" default="Empresa" />
                                        </span>
                                    </g:link>
                                </li>
                                <li><g:link controller="certificacaoEmpresa" action="list">
                                        <span>
                                            <g:message code="menu.certificacaoEmpresa.label" default="Certificacao Empresa" />
                                        </span>
                                    </g:link>
                                </li>
                                <li><g:link controller="fotoEmpresa" action="list">
                                        <span>
                                            <g:message code="menu.fotoEmpresa.label" default="Foto Empresa" />
                                        </span>
                                    </g:link>
                                </li>
                                <li><g:link controller="responsavelEmpresa" action="list">
                                        <span>
                                            <g:message code="menu.responsavelEmpresa.label" default="Responsavel Empresa" />
                                        </span>
                                    </g:link>
                                </li>  
                                <li class='last'><g:link controller="telefoneEmpresa" action="list">
                                        <span>
                                            <g:message code="menu.telefoneEmpresa.label" default="Telefone Empresa" />
                                        </span>
                                    </g:link>
                                </li>
                            </ul>
                        </li>
                        <li class='has-sub'><a href='#'><span><g:message code="menu.propriedade.label" default="Propriedade" /></span></a>
                            <ul>
                                <li><g:link controller="propriedade" action="list">
                                        <span>
                                            <g:message code="propriedade.label" default="Propriedade" />
                                        </span>
                                    </g:link>
                                </li>
                                <li><g:link controller="certificacaoPropriedade" action="list">
                                        <span>
                                            <g:message code="menu.certificacaoPropriedade.label" default="Certificacao Propriedade" />
                                        </span>
                                    </g:link>
                                </li>
                                <li><g:link controller="fotoPropriedade" action="list">
                                        <span>
                                            <g:message code="menu.fotoPropriedade.label" default="Foto Propriedade" />
                                        </span>
                                    </g:link>
                                </li>
                                <li><g:link controller="responsavelPropriedade" action="list">
                                        <span>
                                            <g:message code="menu.responsavelPropriedade.label" default="Responsavel Propriedade" />
                                        </span>
                                    </g:link>
                                </li>
                                <li class='has-sub'><a href='#'><span><g:message code="menu.talhao.label" default="Talhao" /></span></a>
                                    <ul>
                                        <li><g:link controller="talhaoPropriedade" action="list">
                                                <span>
                                                    <g:message code="menu.talhaoPropriedade.label" default="Talhao Propriedade" />
                                                </span>
                                            </g:link>
                                        </li>
                                        <li class='last'><g:link controller="fotoTalhaoPropriedade" action="list">
                                                <span>
                                                    <g:message code="menu.fotoTalhaoPropriedade.label" default="Foto Talhao Propriedade" />
                                                </span>
                                            </g:link>
                                        </li>
                                    </ul>
                                </li>
                                <li class='last'><g:link controller="telefonePropriedade" action="list">
                                        <span>
                                            <g:message code="menu.telefonePropriedade.label" default="Telefone Propriedade" />
                                        </span>
                                    </g:link>
                                </li>
                            </ul>
                        </li>
                        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR">
                            <li class='has-sub'><a href='#'><span><g:message code="menu.cadeiaProdutiva.label" default="Cadeia Produtiva" /></span></a>
                                <ul>
                                    <li><g:link controller="produto" action="list">
                                            <span>
                                                <g:message code="produto.label" default="Produto" />
                                            </span>
                                        </g:link>
                                    </li>
                                    <li><g:link controller="cultivar" action="list">
                                            <span>
                                                <g:message code="cultivar.label" default="Cultivar" />
                                            </span>
                                        </g:link>
                                    </li>
                                    <li><g:link controller="fase" action="list">
                                            <span>
                                                <g:message code="fase.label" default="Fase" />
                                            </span>
                                        </g:link>
                                    </li>
                                    <li class='has-sub'><a href='#'><span><g:message code="menu.atributo.label" default="Atributo" /></span></a>
                                        <ul>
                                            <li><g:link controller="atributo" action="list">
                                                    <span>
                                                        <g:message code="atributo.label" default="Atributo" />
                                                    </span>
                                                </g:link>
                                            </li>
                                            <li class='last'><g:link controller="listaAtributo" action="list">
                                                    <span>
                                                        <g:message code="menu.listaAtributo.label" default="Lista Atributo" />
                                                    </span>
                                                </g:link>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>    
                        </sec:ifAnyGranted>
                        <li><g:link controller="rastroProduto" action="list">
                                <span>
                                    <g:message code="rastroProduto.label" default="Rastro Produto" />
                                </span>
                            </g:link>
                        </li>    
                        <li class='has-sub'><a href='#'><span><g:message code="menu.rastreamento.label" default="Rastreamento" /></span></a>
                            <ul>
                                <li><g:link controller="lote" action="list">
                                        <span>
                                            <g:message code="lote.label" default="Lote" />
                                        </span>
                                    </g:link>
                                </li>
                                <li class="last"><g:link controller="consolidacao" action="list">
                                        <span>
                                            <g:message code="menu.consolidacao.label" default="Consolidacao" />
                                        </span>
                                    </g:link>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </sec:ifAnyGranted>
            <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_EMPRESA, ROLE_PROPRIEDADE, AGENTE">
                <li class='last'><g:link controller="registroDados" action="list"><span><g:message code="menu.registroDados.label" default="Registro Dados" /></span></g:link></li>
            </sec:ifAnyGranted>
            <li class='last'><g:link controller="logout"><span><g:message code="springSecurity.logout.label" default="Logout" />:&nbsp;(<sec:username />)</span></g:link></li>
        </sec:ifLoggedIn>   
        <sec:ifNotLoggedIn>   
            <li class='last'><g:link controller="login" action="auth"><span><g:message code="springSecurity.login.label" default="Login" /></span></g:link></li>
            <li class='last'><g:link controller="acesso" action="autoCadastro"><span><g:message code="acesso.autoCadastro.label" default="Cadastre-se" /></span></g:link></li>
        </sec:ifNotLoggedIn>
        <li><g:link controller="info"><span><g:message code="sobre.label" default="Sobre" /></span></g:link></li>
    </ul>
</div>