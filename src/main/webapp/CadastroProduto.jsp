<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--<%@ taglib uri="tiles.apache.org/tags-tiles" prefix="tiles"%>--%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cadastro de Produto</title>
</head>
    <link rel="stylesheet" href="css/CadastroDeProduto.css">
    <style>
        .image-preview {
            margin-bottom: 10px;
        }
    </style>

<body>
<div id="container">
    <nav>
        <ul class="menu">
            <li class="menu-logo">
                <img src="img/Logo de cafe.png">
                <h1>BEM-VINDO AO BREWMASTERS CAFÉ.BACKOFFICE</h1>
            </li>
            <li><a href="Principal.jsp">Voltar</a></li>
        </ul>
    </nav>

    <section>
        <h1>
            <img src="/img/Icon-cadastro.png" alt="Ícone do Produto" class="icon">
            Cadastro de Produto
        </h1>
    </section>
    
    <form action="CadastroProdutoServlet" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
        <p>Nome do Produto:</p> <input type="text" name="nomeProduto" required><br>
        <input type="hidden" name="status" value="1">
        <p>Avaliação: </p>  <input type="number" name="avaliacao" min="1" max="5" step="0.1" required><br>
        <p>Descrição Detalhada:</p> <textarea name="descricaoDetalhada" required></textarea><br>
        <p> Preço do Produto:</p> <input type="number" name="precoProduto" step="0.01" required><br>
        <p>Quantidade em Estoque:</p> <input type="number" name="qtdEstoque" required><br>

        <!-- Adicione os botões de rádio para selecionar a imagem principal -->

        <div id="radioButtons">
            <h3>Selecione a Imagem Principal:</h3>
            <!-- Botão de rádio para a imagem principal -->
            <input type="radio" name="imagemPrincipalRadio" value="1" checked data-preview-id="preview1"><br>
        </div>

        <!-- Campo inicial de imagem do produto -->
        <div class="image-preview">
            <%--            <label for="imagemProduto1">Imagem do Produto 1:</label>--%>
            <input type="file" name="imagemProduto1" id="imagemProduto1" accept="image/*"
                   onchange="previewImage(this)">
            <img class="preview" src="#" alt="Preview da Imagem"
                 style="display: none; max-width: 100px; max-height: 100px;">
        </div>

        <div class="image-previews"></div>
        <hr>
        <div class=" container">
            <div id="row">
                <div class="col-12 col-sm-6 col-md-4">
                    <div class="btn-add">
                        <!-- Botão para adicionar mais campos de imagem -->
                        <button type="button" onclick="addImageField()">Adicionar</button>
                    
                        <button id="cancelButton">Cancelar</button>
                        <!-- Conteúdo da sua página aqui -->

                        <input type="submit" value="Cadastrar" class="meu-botao">
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="roda-pe">
    <footer>
        <p1>&copy; 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</p1>
    </footer>
</div>

<br>
<script>
    // Contador para rastrear o número de campos de imagem adicionados
    let imageCount = 1;

    function addImageField() {
        imageCount++;
        const fileInput = document.createElement("input");
        fileInput.type = "file";
        fileInput.name = "imagemProduto" + imageCount;
        fileInput.id = "imagemProduto" + imageCount;
        fileInput.accept = "image/*";
        fileInput.setAttribute("onchange", `previewImage(this)`);

        const label = document.createElement("label");
        label.htmlFor = "imagemProduto" + imageCount;
        label.textContent = "Imagem do Produto " + imageCount + ":";

        const preview = document.createElement("img");
        preview.classList.add("preview");
        preview.src = "#";
        preview.alt = "Preview da Imagem";
        preview.style.display = "none";
        preview.style.maxWidth = "100px";
        preview.style.maxHeight = "100px";

        const imagePreview = document.querySelector(".image-previews");
        imagePreview.appendChild(label);
        imagePreview.appendChild(fileInput);
        imagePreview.appendChild(preview);

        // Adicione um botão de rádio associado à imagem atual
        const radioButtons = document.getElementById("radioButtons");
        const radioButton = document.createElement("input");
        radioButton.type = "radio";
        radioButton.name = "imagemPrincipalRadio";
        radioButton.value = imageCount;
        radioButtons.appendChild(radioButton);
    }

    function previewImage(input) {
        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function (e) {
                const preview = input.nextElementSibling;
                preview.style.display = "block";
                preview.src = e.target.result;
            };

            reader.readAsDataURL(input.files[0]);
        }
    }

    /*button cancelar */
    // Adicione um evento de clique ao botão
    const cancelButton = document.getElementById('cancelButton');

    cancelButton.addEventListener('click', () => {
        // Redirecionar para a tela anterior ou executar a ação desejada de cancelamento
        // Este exemplo apenas volta uma página no histórico do navegador
        window.history.back();
    });

</script>

</body>
</html>
