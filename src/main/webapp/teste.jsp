<%@ page import="br.com.gymcontrol.Model.Produtos" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Detalhes produto</title>
	<link rel="stylesheet" href="css/ComprarCliente.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
				</ul>
			</nav>
		</div>
	</div>
	<div class="row-navbar">
		<div class="col-12 col-sm-12 col-md-12 col-xl-12">
			<div class="navbar">
				<a href="##">
					<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#043486}</style><path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"/></svg>
					Login
				</a>
				<a href="#">
					<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 640 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><style>svg{fill:#ffffff}</style><path d="M96 128a128 128 0 1 1 256 0A128 128 0 1 1 96 128zM0 482.3C0 383.8 79.8 304 178.3 304h91.4C368.2 304 448 383.8 448 482.3c0 16.4-13.3 29.7-29.7 29.7H29.7C13.3 512 0 498.7 0 482.3zM504 312V248H440c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V136c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H552v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z"/></svg>
					Cadastrar
				</a>
				<a href="http://localhost:8080/">
					<svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M48.5 224H40c-13.3 0-24-10.7-24-24V72c0-9.7 5.8-18.5 14.8-22.2s19.3-1.7 26.2 5.2L98.6 96.6c87.6-86.5 228.7-86.2 315.8 1c87.5 87.5 87.5 229.3 0 316.8s-229.3 87.5-316.8 0c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0c62.5 62.5 163.8 62.5 226.3 0s62.5-163.8 0-226.3c-62.2-62.2-162.7-62.5-225.3-1L185 183c6.9 6.9 8.9 17.2 5.2 26.2s-12.5 14.8-22.2 14.8H48.5z"/></svg>
					Voltar
				</a>
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
		c:out<%
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
			<h2> <%= nomeProduto %>
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
			</p>
			<p>Quantidade em Estoque: <%= qtdEstoque %>
			</p>
		</div>
		
		<a class="buy-button" disabled>Comprar</a>
		
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
</div>
</body>
</html>
