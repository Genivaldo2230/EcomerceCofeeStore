<%@ page import="br.com.gymcontrol.Model.Produtos" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="br.com.gymcontrol.Model.Cliente" %>
<%@ page import="br.com.gymcontrol.Model.Endereco" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalhes produto</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/ComprarCliente.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<style>
    .product-description {
        max-width: 300px; /* Defina o valor máximo de largura desejado */
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }

    .product-image {
        width: 300px; /* Defina o tamanho horizontal desejado */
        height: 300px; /* Mantenha o mesmo valor que o tamanho horizontal para manter a imagem quadrada */
        overflow: hidden;
    }

    .product-image img {
        width: 100%; /* Ajusta a largura da imagem para preencher a div de imagem */
        height: auto; /* Altura automática para manter a proporção original da imagem */
    }

    .product-description, .product-name {
        max-width: 300px; /* Defina o valor máximo de largura desejado */
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }

</style>
<body>
<div id="container">
    <div class="row-container-logo-menu">
        <div class="col-12 col-sm-12 col-md-12 col-xl-12">
            <!-- Conteúdo da coluna -->
            <div class="slideshow-container">
                <img class="slideshow-image active" src="img/Fundo2.jpg">
                <img class="slideshow-image" src="img/Fundo3.jpg">
                <img class="slideshow-image" src="img/Fundo5.jpg">
            </div>
            <nav>
                <ul class="menu">
                    <li class="menu-logo">
                        <img src="img/Logo de cafe.png">
                        <h1>BEM-VINDO AO BREWMASTERS CAFÉ.BACKOFFICE</h1>
                    </li>
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                                aria-expanded="false">
                            <c:choose>
                                <c:when test="${empty sessionScope.cliente}">
                                    Bem-vindo, Visitante
                                </c:when>
                                <c:otherwise>
                                    Bem-vindo, ${sessionScope.cliente.nomeCompleto}
                                </c:otherwise>
                            </c:choose>
                        </button>
                        <ul class="dropdown-menu">
                            <c:choose>
                                <c:when test="${empty sessionScope.cliente}">
                                    <li><a class="dropdown-item" href="LoginCliente.jsp">Login Cliente</a></li>
                                    <form action="Carrinho.jsp" method="get">
                                        <button class="btn-primary1" type="submit">🛒<label>Comprar</label>
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <li><a class="dropdown-item" href="ListarEnderecosCliente">Meus Endereços</a></li>

                                    <li><a class="dropdown-item" href="EditarClienteServlet">Editar Perfil</a></li>
                                    <button action="Carrinho.jsp" class="btn-primary1" type="submit">
                                        🛒<label>Comprar</label>
                                    </button>
									<form action="LogoutServlet" method="post">
                                    <input type="submit" value="Logout" class="botao-Sair-logout">
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                    <br><br><br>
                </ul>
			</nav>
		</div>
	</div>
</div>

<div id="container-h1">
    <div class="row-h1-menu">
        <div class="col-12 col-sm-12 col-md-12 col-xl-12">
            <h1>Detalhes do Produto</h1>
        </div>
    </div>
</div>
<br><br>
<div class="produto-container">
    <%
        Produtos produto = (Produtos) request.getAttribute("produto");
        if (produto != null) {
            String nomeProduto = produto.getNomeProduto();
            String descricaoDetalhada = produto.getDescricaoDetalhada();
            double avaliacao = produto.getAvaliacao();
            double precoProduto = produto.getPrecoProduto();
            int qtdEstoque = produto.getQtdEstoque();
    %>

    <!-- Exibe todas as imagens do produto -->
    <div id="imageCarousel" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <%
                boolean firstImage = true;
                for (String imagePath : produto.getImagens()) {
            %>
            <div class="carousel-item <%= firstImage ? "active" : "" %>">
                <img src="<%= imagePath %>" alt="Imagem do Produto">
            </div>
            <%
                    firstImage = false;
                }
            %>
        </div>

        <!-- Controles do Carrossel -->
        <a class="carousel-control-prev" href="#imageCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Anterior</span>
        </a>
        <a class="carousel-control-next" href="#imageCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Próximo</span>
        </a>
    </div>

    <div class="product-details">
        <h2><%= nomeProduto %>
        </h2>
        <p><%= descricaoDetalhada %>
        </p>
        <p class="avaliacao">Avaliação:
            <%
                // Converte a avaliação em estrelas
                int avaliacaoEmEstrelas = (int) Math.floor(avaliacao); // Parte inteira da avaliação
                double parteDecimal = avaliacao - avaliacaoEmEstrelas; // Parte decimal (0.0 a 0.9)

                for (int i = 1; i <= 5; i++) {
                    if (i <= avaliacaoEmEstrelas) {
            %>
            <img class="estrela" src="img/estrela_cheia.png" alt="Estrela Cheia">
            <%
            } else if (i == avaliacaoEmEstrelas + 1 && parteDecimal >= 0.5) {
            %>
            <img class="estrela" src="img/estrela_meia.png" alt="Estrela Meia">
            <%
            } else {
            %>
            <img class="estrela" src="img/estrela_vazia.png" alt="Estrela Vazia">
            <%
                    }
                }
            %>
        </p>
        <p>Preço R$: <%= precoProduto %>
    </div>


    <form action="/carrinho" method="post">
        <input type="hidden" name="produtoID" value="${produto.produtoID}">
        <button type="submit" class="buy-button">Comprar</button>
    </form>


    <form action="/carrinho" method="post">
        <input type="hidden" name="produtoID" value="${produto.produtoID}">
        <button type="submit" class="buy-button">Adicionar ao carrinho</button>
    </form>


    <%
    } else {
    %>
    <p>Produto não encontrado.</p>

    <%
        }
    %>

</div>


<footer>
    © 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.
</footer>


<script>
    $(document).ready(function () {
        $("#buscarCEP").click(function () {

            var cep = $("#cepFaturamento").val();
            cep = cep.replace('-', '');

            // Verifique se o CEP possui 8 dígitos
            var cepRegex = /^[0-9]{8}$/;
            if (!cepRegex.test(cep)) {
                alert("CEP inválido. Digite um CEP com 8 dígitos.");
                return;
            }

            // Faça a chamada à API do ViaCEP
            $.get("https://viacep.com.br/ws/" + cep + "/json/", function (data) {
                if (data.erro) {
                    alert("CEP não encontrado.");
                } else {
                    $("#opcoesEntrega").show(); // Exibe as opções de entrega
                }
            });
        });
    });


    function adicionarAoCarrinho(produtoID) {
        // Envia a solicitação POST para o servlet
        $.post("/carrinho", {produtoID: produtoID}, function () {
            alert("Produto adicionado ao carrinho!");
        });
    }


</script>

</body>
</html>