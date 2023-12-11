<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="br.com.gymcontrol.Model.UsuarioBackOffice" %>
<%@ page import="br.com.gymcontrol.Model.Produtos" %>
<%@ page import="DAO.ProdutosDAO" %>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/EditarProduto.css">
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


        <li><a href="/ListarProdutos_2">Voltar</a></li>
    </ul>
</nav>
<h1>Editar Produto</h1>
<div>

    <form action="EditarProdutoServlet" method="post" enctype="multipart/form-data">
        <c:if test="${not empty produto}">
            <input type="hidden" name="produtoID" value="<c:out value='${produto.produtoID}' />">

            <!-- Verificar se o usuário é um administrador ('Admin Group') -->
            <c:choose>
                <c:when test="${usuario != null && 'Admin Group' eq usuario.grupo}">
                    <!-- Campos de edição para administradores -->
                    <p> Nome do Produto: <input type="text" name="nomeProduto"
                                                value="<c:out value='${produto.nomeProduto}' />" required><br>
                    <p>
                    <p>Status do Produto: <input type="checkbox" name="status" value="1"
                                                 <c:if test="${produto.statusProduto}">checked</c:if>><br>
                    <p>
                    <p> Avaliação: <input type="number" name="avaliacao" min="1" max="5" step="0.1"
                                          value="<c:out value='${produto.avaliacao}' />" required><br>
                    <p>
                    <p> Descrição Detalhada: <textarea name="descricaoDetalhada" required><c:out
                            value='${produto.descricaoDetalhada}'/></textarea><br>
                    <p>
                    <p> Preço do Produto: <input type="number" name="precoProduto" step="0.01"
                                                 value="<c:out value='${produto.precoProduto}' />" required><br><p>
                </c:when>
                <c:otherwise>

                    <p> Nome do Produto: <c:out value='${produto.nomeProduto}'/><br>
                    <p>
                    <p>Status do Produto:
                        <c:if test="${produto.statusProduto}">Ativo</c:if>
                        <c:if test="${not produto.statusProduto}">Inativo</c:if><br>
                    <p>
                    <p> Avaliação: <c:out value='${produto.avaliacao}'/><br>
                    <p>
                    <p> Descrição Detalhada: <c:out value='${produto.descricaoDetalhada}'/><br>
                    <p>
                    <p>Preço do Produto: R$ <c:out value='${produto.precoProduto}'/><br><p>
                </c:otherwise>
            </c:choose>


            Quantidade em Estoque: <input type="number" name="qtdEstoque"
                                          value="<c:out value='${produto.qtdEstoque}' />" required><br>
            <hr>
            <!-- Adicione isso dentro do formulário existente no seu arquivo EditarProduto.jsp -->
            <h3>Imagens Existentes:</h3>
            <c:forEach items="${imagensExistentes}" var="imagemExistente">
                <div style="display: inline-block; margin-right: 10px;">
                    <img src="${imagemExistente}" alt="Imagem do Produto" style="max-width: 100px;">
                    <button type="button" class="main-button"
                            onclick="setMainImage('<c:out value="${produto.produtoID}"/>', '<c:out
                                    value="${imagemExistente}"/>')"
                            <c:if test="${usuario == null || 'Admin Group' ne usuario.grupo}">disabled</c:if>>Definir
                        como Principal
                    </button>
                    <button type="button" class="delete-button"
                            onclick="deleteImage('<c:out value="${imagemExistente}"/>', <c:out
                                    value="${produto.produtoID}"/>)"
                            <c:if test="${usuario == null || 'Admin Group' ne usuario.grupo}">disabled</c:if>>Deletar
                    </button>
                </div>
            </c:forEach>
            <hr>
            <!-- Campo para fazer upload de novas imagens -->
            <h3><label for="novaImagem">Nova Imagem:</label></h3>
            <p>
                <input type="file" name="novaImagem" id="novaImagem" accept="image/*" onchange="previewUserImages(this)"
                       multiple <c:if test="${usuario == null || 'Admin Group' ne usuario.grupo}">disabled</c:if>>
            </p> <!-- Desativar o botão para não administradores -->

            <!-- Container para exibir previews das imagens do usuário -->
            <div id="userImagePreviews"></div>

            <!-- Verificar se o usuário é um administrador ('Admin Group') -->
            <p>
                <input type="submit" value="Salvar Alterações">
            </p>

        </c:if>
    </form>
</div>


<script>
    function setMainImage(produtoID, imageUrl) {
        // Enviar uma solicitação para o servidor para definir a imagem como principal
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "SetMainImageServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // Atualize a interface do usuário após a definição bem-sucedida da imagem principal
                // Isso pode incluir destaque visual para a imagem principal ou outra forma de feedback para o usuário.
            }
        };
        xhr.send('produtoID=' + produtoID + '&imageUrl=' + encodeURIComponent(imageUrl));
    }

    function deleteImage(imageUrl, produtoID) {
        // Enviar uma solicitação para o servidor para excluir a imagem com a URL fornecida
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "DeleteImageServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // Atualize a interface do usuário após a exclusão bem-sucedida
                const deletedImage = document.querySelector('img[src="' + imageUrl + '"]');
                if (deletedImage) {
                    deletedImage.parentNode.remove(); // Remove a div que envolve a imagem e o botão
                }
            }
        };
        xhr.send('imageUrl=' + encodeURIComponent(imageUrl) + '&produtoID=' + produtoID);
    }

    function previewUserImages(input) {
        const previewContainer = document.getElementById("userImagePreviews");
        previewContainer.innerHTML = ""; // Limpe as pré-visualizações existentes

        if (input.files && input.files.length > 0) {
            for (let i = 0; i < input.files.length; i++) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const previewImage = document.createElement("img");
                    previewImage.src = e.target.result;
                    previewImage.style.maxWidth = "100px";
                    previewImage.style.maxHeight = "100px";
                    previewContainer.appendChild(previewImage);
                };
                reader.readAsDataURL(input.files[i]);
            }
        }
    }
</script>
<footer>
    <p1>&copy; 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</p1>
</footer>

</body>
</html>
