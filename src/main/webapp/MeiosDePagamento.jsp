<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Meios de Pagamento</title>
    <link rel="stylesheet" type="text/css" href="css/MeiosDePagamento.css">
       <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="slideshow-container">
    <img class="slideshow-image active" src="img/Fundo-pagamento.jpg">

</div>

    <div class="conteudo">
        <h1>Escolha seu Meio de Pagamento</h1>


        <form id="meiosDePagamentoForm" action="/ResumoPedidoServlet" method="get"> <!-- Alterado para método POST -->
            <label for="formaPagamento">Forma de Pagamento:</label>
            <select name="formaPagamento" id="formaPagamento">
                <option value="boleto">Boleto</option>
                <option value="cartao">Cartão de Crédito</option>
            </select>

            <div id="cartaoFields" style="display: none;">
                <label for="numeroCartao">Número do Cartão:</label>
                <input type="text" name="numeroCartao" id="numeroCartao">

                <label for="codigoVerificador">Código Verificador:</label>
                <input type="text" name="codigoVerificador" id="codigoVerificador">

                <label for="nomeCompleto">Nome Completo:</label>
                <input type="text" name="nomeCompleto" id="nomeCompleto">

                <label for="dataVencimento">Data de Vencimento:</label>
                <input type="text" name="dataVencimento" id="dataVencimento">

                <label for="quantidadeParcelas">Quantidade de Parcelas:</label>
                <input type="number" name="quantidadeParcelas" id="quantidadeParcelas">
            </div>
<%-- Verificar se o atributo não é nulo e é uma instância de String --%>
<%
    String enderecoSelecionadoId = (String) request.getAttribute("enderecoSelecionadoId");

    if (enderecoSelecionadoId != null) {
%>
    <p>Endereço Selecionado:</p>
    <p>ID: <%= enderecoSelecionadoId %></p>
    <%-- Adicione aqui as demais informações do endereço --%>
<% } else { %>
    <p>Nenhum endereço selecionado.</p>
<% } %>
<input type="hidden" name="enderecoSelecionadoId" value="<%= enderecoSelecionadoId %>">

            <input type="submit" value="Avançar para Validar Pedido Final" class="styled-button">
        </form>
    </div>

    <div class="cartao-visual" id="cartaoVisual">
        <div id="numeroCartaoVisual" class="cartao-numero">•••• •••• •••• ••••</div>
        <div id="nomeCartaoVisual" class="cartao-nome">NOME COMPLETO</div>
        <div id="validadeCartaoVisual" class="cartao-validade">MM/AA</div>
       <div id="chipCartaoVisual">
               <i class="fas fa-microchip" style="color: gold;"></i>
           </div>
    </div>

    <script>
        document.getElementById("formaPagamento").addEventListener("change", function() {
            var selectedValue = this.value;
            var cartaoFields = document.getElementById("cartaoFields");
            var cartaoVisual = document.getElementById("cartaoVisual");
            if (selectedValue === "cartao") {
                cartaoFields.style.display = "block";
                cartaoVisual.style.display = "block";
            } else {
                cartaoFields.style.display = "none";
                cartaoVisual.style.display = "none";
            }
        });

        function atualizarCartaoVisual() {
            var numeroCartao = document.getElementById("numeroCartao").value;
            var nomeCompleto = document.getElementById("nomeCompleto").value;
            var dataVencimento = document.getElementById("dataVencimento").value;

            document.getElementById("numeroCartaoVisual").innerText = numeroCartao !== "" ? numeroCartao : "•••• •••• •••• ••••";
            document.getElementById("nomeCartaoVisual").innerText = nomeCompleto !== "" ? nomeCompleto.toUpperCase() : "NOME COMPLETO";
            document.getElementById("validadeCartaoVisual").innerText = dataVencimento !== "" ? dataVencimento : "MM/AA";
        }

        document.getElementById("numeroCartao").addEventListener("keyup", atualizarCartaoVisual);
        document.getElementById("nomeCompleto").addEventListener("keyup", atualizarCartaoVisual);
        document.getElementById("dataVencimento").addEventListener("keyup", atualizarCartaoVisual);


    </script>

</body>
</html>
