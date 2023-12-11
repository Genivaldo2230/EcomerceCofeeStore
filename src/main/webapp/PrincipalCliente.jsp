<%@ page import="br.com.gymcontrol.Model.UsuarioBackOffice" %>
<%@ page import="br.com.gymcontrol.Model.Produtos" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <title>Tela Inicial Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="css/PrincipalCliente.css">

    <style>
        .product-description {
            max-width: 300px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .product-image {
            width: 300px;
            height: 300px;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: auto;
        }

        .product-description, .product-name {
            max-width: 300px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
    </style>
    <%@ page contentType="text/html; charset=UTF-8" %>
</head>
<body>
<div class="slideshow-container">
    <img class="slideshow-image active" src="img/Fundo2.jpg">
    <img class="slideshow-image" src="img/Fundo3.jpg">
    <img class="slideshow-image" src="img/Fundo5.jpg">
</div>
<nav>
    <ul class="menu">
        <li class="menu-logo">
            <img src="img/Logo de cafe.png">
            <h1>BEM-VINDO AO BREWMASTERS CAFÉ </h1>
        </li>
        <div class="dropdown">
            <button style="width: auto" class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                    aria-expanded="false">
                Bem-vindo, ${sessionScope.cliente.nomeCompleto}
            </button>

            <ul class="dropdown-menu">

                <div class="container">

                    <div class="form-container">
                        <form action="Carrinho.jsp" method="get">
                        <button class="btn-primary1" type="submit">🛒<label>Comprar</label>
                        </button>
                    </form>
                        <div class="btn-container">
                            <c:choose>
                                <c:when test="${sessionScope.cliente != null}">
                                    <li><a class="dropdown-item" href="ListarEnderecosCliente">Meus Endereços</a></li>
                                    <li><a class="dropdown-item" href="EditarClienteServlet">Editar Perfil</a></li>
                                </c:when>
                                <c:otherwise>
                                    <form action="LoginCliente.jsp" method="get">
                                        <button class="btn-primary" type="submit">👤<p> Login ou crie Cadastrar
                                            <p/></button>
                                    </form>
                                </c:otherwise>
                            </c:choose>

<%--                            <form action="Carrinho.jsp" method="get">--%>
<%--                                <button class="btn-primary1" type="submit">🛒<label>Comprar</label>--%>
<%--                                </button>--%>
<%--                            </form>--%>
                        </div>
                    </div>
                </div>
                <br><br><hr><hr>
                <form action="LogoutServlet" method="post">
                    <input type="submit" value="Sair" class="botao-Sair-logout">
                </form>
            </ul>
        </div>
    </ul>
</nav>

<h2 class="titulo-centro">Nossos produtos </h2>
<hr>

<c:forEach var="produto" items="${Produtos}">
    <div class="product-box product-item">
        <div class="product-image">
            <img src="${produto.imagePATH}" alt="Imagem do Produto">
        </div>
        <div class="product-details">
            <h2 class="product-name">${produto.nomeProduto}</h2>
            <p class="product-description">${produto.descricaoDetalhada}</p>
            <span class="product-rating" id="product-rating-1"></span>
            <br>
            <p class="product-price">R$: <span>${produto.precoProduto}</span></p>
            <h2>${produto.avaliacao}</h2>
            <a class="buy-button" href="ComprarCliente?produtoID=<c:out value='${produto.produtoID}' />"> Detalhes
            </a>
            <form action="/carrinho" method="post">
                <input type="hidden" name="produtoID" value="${produto.produtoID}">
                <button type="submit">Adicionar ao Carrinho</button>
            </form>

        </div>
    </div>
</c:forEach>

<footer>
    © 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
</body>
</html>
