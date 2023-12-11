<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="br.com.gymcontrol.Model.UsuarioBackOffice" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/ListarProdutos.css">
    <title>Listar Produtos</title>
</head>
<body>

<div id="container">
    <div class="row">
        <div class=" col-12 col-sm-6 col-md-4">

            <ul class="menu">
                <li class="menu-logo">
                    <img src="img/Logo de cafe.png" alt="Logo do café">
                    <h1>BEM-VINDO AO BREWMASTERS CAFÉ.BACKOFFICE</h1>
                </li>
                <li><a href="/ListarTop8Produtos">
                    <button-voltar type="button">Voltar</button-voltar>
                </a></li>
                <%--                <li><a href="/ListarTop8Produtos">Voltar </a></li>--%>
            </ul>

            <div id="usuarios-grupos">
                <%
                    UsuarioBackOffice usuario = (UsuarioBackOffice) session.getAttribute("usuario");
                    if (usuario != null) {
                        out.println("Grupo do Usuário: " + usuario.getGrupo());
                    }
                %>
            </div>

            <div class="search-bar">
                <form action="ListarProdutos_2" method="get">
                    <input class="search-input" type="text" name="searchTerm" placeholder="Digite sua pesquisa">
                    <input type="submit" value="Buscar">
                </form>
                <br>
                     <c:if test="${usuario != null && usuario.getGrupo().equals('Admin Group')}">
                <button type="button" class="btn btn-primary" style="float: right;"
                        onclick="window.location.href='CadastroProduto.jsp'">
                    <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 640 512">
                        <path d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3zM504 312V248H440c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V136c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H552v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z"/>
                    </svg> Cadastrar Produto
                </button>
                                    </c:if>


            </div>


            <table border="1" class="table table-hover table-striped">
                <thead class="table-dark">

                <div class="pagination">

                    <c:forEach var="i" begin="1" end="${pageCount}">
                        <a href="#" onclick="irParaPagina(${i})">${i}</a>
                    </c:forEach>

                </div>

<%--                ESTA ROANDO PELO JSCRIPT--%>
                <%--                <div class="pagination">--%>
                <%--                    <svg xmlns="http://www.w3.org/2000/svg" height="3em" viewBox="0 0 448 512">--%>
                <%--                        <!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->--%>
                <%--                        <path d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l160 160c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L109.2 288 416 288c17.7 0 32-14.3 32-32s-14.3-32-32-32l-306.7 0L214.6 118.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-160 160z"/>--%>
                <%--                    </svg>--%>

                <%--                    <c:forEach var="i" begin="1" end="${pageCount}">--%>

                <%--                        <a href="#" onclick="irParaPagina(${i})">${i}</a>--%>

                <%--                    </c:forEach>--%>
                <%--                    <svg xmlns="http://www.w3.org/2000/svg" height="3em" viewBox="0 0 448 512">--%>
                <%--                        <!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. -->--%>
                <%--                        <path d="M438.6 278.6c12.5-12.5 12.5-32.8 0-45.3l-160-160c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3L338.8 224 32 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l306.7 0L233.4 393.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0l160-160z"/>--%>
                <%--                    </svg>--%>
                <%--                </div>--%>

                <tr>
                    <th>Código do Produto</th>
                    <th>Nome do Produto</th>
                    <th>Quantidade em estoque</th>
                    <th>Preço</th>
                    <th>Status</th>
                    <c:if test="${usuario != null && usuario.getGrupo().equals('Admin Group')}">
                        <th>Habilita/Desabilita</th>
                    </c:if>
                    <th>Editar</th>
                   <c:if test="${usuario != null && usuario.getGrupo().equals('Admin Group')}">
                    <th>Visualizar-Produto</th>
                    </c:if>

                </tr>
                </thead>
                <tbody id="tabela-produtos">
                <c:forEach var="produto" items="${produtos}">
                    <tr>
                        <td>${produto.produtoID}</td>
                        <td>${produto.nomeProduto}</td>
                        <td><c:out value="${produto.qtdEstoque}"/></td>
                        <td><c:out value="${produto.precoProduto}"/></td>
                        <td>${produto.statusProduto ? 'Ativo' : 'Inativo'}</td>
                        <c:if test="${usuario != null && usuario.getGrupo().equals('Admin Group')}">
                            <td>
                                <label class="switch">
                                    <input type="checkbox" ${produto.statusProduto ? 'checked' : ''}
                                           onchange="confirmarAtualizacaoStatus(${produto.produtoID}, this.checked)">
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </c:if>

                        <td>
                            <a href="EditarProdutoServlet?produtoID=<c:out value='${produto.produtoID}' />">
                                <img src="img/Editar.png" alt="Imagem Editar">
                            </a>
                        </td>

                        <c:if test="${usuario != null && usuario.getGrupo().equals('Admin Group')}">
                        <td>
                            <a href="VisualizarImagemServlet?produtoID=<c:out value='${produto.produtoID}' />">
                                <img src="img/visualizar.png" alt="Imagem visualizar">
                            </a>
                        </td>
                      </c:if>

                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <footer>
                <p1>
                    © 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.
                </p1>
            </footer>
            <script src="eventosProduto.js"></script>
            <div id="seu-elemento"></div>

            <%--            <script>--%>
            <%--                function irParaPagina(pagina) {--%>
            <%--                    var novaURL = window.location.href.split('?')[0] + '?page=' + pagina;--%>
            <%--                    window.location.href = novaURL;--%>
            <%--                }--%>
            <%--            </script>--%>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    // Seu código aqui
                    const prevPage = document.getElementById('prevPage');
                    const nextPage = document.getElementById('nextPage');
                    const pageLinks = document.querySelectorAll('.pagination a');
                    let currentPage = 1;
                });


                function irParaPagina(page) {
                    // Implemente a lógica para ir para a página selecionada aqui
                    // Por exemplo, você pode redirecionar para a URL da página selecionada ou executar alguma ação.
                    var novaURL = window.location.href.split('?')[0] + '?page=' + page;
                    window.location.href = novaURL;
                }

                prevPage.addEventListener('click', () => {
                    if (currentPage > 1) {
                        currentPage--;
                        irParaPagina(currentPage);
                    }
                });

                nextPage.addEventListener('click', () => {
                    if (currentPage < pageLinks.length) {
                        currentPage++;
                        irParaPagina(currentPage);
                    }
                });

                pageLinks.forEach((link, index) => {
                    link.addEventListener('click', () => {
                        currentPage = index + 1;
                        irParaPagina(currentPage);
                    });
                });


                // Crie um elemento <svg> para o ícone
                const svgElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
                svgElement.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
                svgElement.setAttribute('width', '16');
                svgElement.setAttribute('height', '16');
                svgElement.setAttribute('viewBox', '0 0 16 16');

                // Crie o caminho do ícone
                const pathElement = document.createElementNS('http://www.w3.org/2000/svg', 'path');
                pathElement.setAttribute('d', 'M10.293 5.293a1 1 0 0 1 1.414 1.414L7.414 11H11a1 1 0 0 1 0 2H5a1 1 0 0 1-1-1v-6a1 1 0 1 1 2 0v3.586l4.293-4.293z');
                pathElement.setAttribute('fill-rule', 'evenodd');

                // Adicione o caminho ao elemento <svg>
                svgElement.appendChild(pathElement);

                // Encontre o elemento <div> pelo ID
                const divElement = document.getElementById('seu-elemento');

                // Substitua o conteúdo do elemento <div> pelo elemento <svg>
                divElement.innerHTML = '';
                divElement.appendChild(svgElement);

            </script>
        </div>
    </div>
</div>

</body>
</html>
