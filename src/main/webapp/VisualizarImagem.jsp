<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="br.com.gymcontrol.Model.Produtos" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Visualizar Produto</title>
	<link rel="stylesheet" href="css/VisualizarImg.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
			<h1>BEM-VINDO AO BREWMASTERS CAFÉ.BACKOFFICE</h1>
		</li>
		
		<a href="/ListarProdutos_2">Voltar para a lista de produtos</a>
		
		<li><a href="Login.jsp">Sair</a></li>
	
	</ul>
</nav>


<h1>Detalhes do Produto</h1>

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
</body>
</html>