<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/ResumoPedido.css">
    <title>Resumo do Pedido</title>
</head>
<body>
<div class="slideshow-container">
    <img class="slideshow-image active" src="img/Fundo-pagamento.jpg">
</div>

<div id="logo">
    <div class="row-logo">
        <div class="col-12">
            <nav>
                <ul class="menu">
                    <li class="menu-logo">
                        <img src="img/Logo de cafe.png">
                        <h1-logo> BREWMASTERS CAFÉ</h1-logo>
                    </li>
                    <button-voltar onclick="MeiosDePagamentoServlet()">Voltar</button-voltar>

                    <script>
                        function MeiosDePagamentoServlet() {
                            window.history.back();
                        }
                    </script>
                </ul>
            </nav>
        </div>
    </div>
</div>


<div id="container-main">
    <div class="row-logo">
        <div class="col-12">
            <video poster="https://i.gifer.com/fetch/w300-preview/09/097db72c8ff26d217f187fedb73f6d32.gif" loop autoplay
                   muted
                   playsinline>
                <source src="https://i.gifer.com/1410.mp4" type="video/mp4">
            </video>

            <h1>Resumo do Pedido</h1>

            <div id="container">

                <!-- Exibir informações do pedido, por exemplo, produtos, valores, quantidades, frete, endereço, forma de pagamento, total geral -->
                <form action="PedidoServlet" method="post">
                    <table>
                        <!-- Tabela com informações do pedido -->
                        <tr>
                            <th>Produto</th>
                            <th>Quantidade</th>
                            <th>Preço unitário</th>
                            <th>Valor subtotal</th>
                        </tr>
                        <!-- Loop para exibir cada item do pedido -->
                        <c:forEach var="item" items="${itensCarrinho}">
                            <tr>
                                <td>${item.produto.nomeProduto}</td>
                                <td>${item.quantidade}</td>
                                <td>R$ ${item.produto.precoProduto}</td>
                                <td>R$ ${item.subtotal}</td>
                            </tr>
                        </c:forEach>


                        <tr>
                            <td colspan="3">Total sem frete</td>
                            <td>${totalGeral}</td>
                        </tr>
                        <tr>
                            <td colspan="3">Total com frete</td>
                            <td>${totalComFrete}</td>
                        </tr>

                    </table>
                    <div id="enderco-entrega">
                        <!-- Informações de entrega -->
                        <h2>Endereço de Entrega</h2>
                        <%--    <!-- Informações de entrega -->--%>
                        <p>ID: ${enderecoSelecionado.id}</p>
                        <p>CEP: ${enderecoSelecionado.cep}</p>
                        <p>Logradouro: ${enderecoSelecionado.logradouro}</p>
                        <p>Número: ${enderecoSelecionado.numero}</p>
                        <p>Complemento: ${enderecoSelecionado.complemento}</p>
                        <p>Bairro: ${enderecoSelecionado.bairro}</p>
                        <p>Cidade: ${enderecoSelecionado.cidade}</p>
                        <p>UF: ${enderecoSelecionado.uf}</p>


                        <p>${enderecoDeEntrega}</p><img
                            style="width: 60px; height: 40px; display: block; -webkit-user-select: none; margin: auto; background-color: hsl(0, 0%, 90%);"
                            src="https://www.boutiquea.cl/wp-content/uploads/2021/06/65047-delivery-truck-animation.gif">
                        <!-- Forma de pagamento -->
                        <h2>Forma de Pagamento</h2>
                        <p>${formaDePagamento}</p>


                    </div>

                    <style>
                        /* Estilos para o status EM_PROCESSAMENTO */
                        input[name="status"][value="Compra em processamento"] + .status-display {
                            color: orange;
                        }

                        /* Estilos para o status OUTRO_STATUS */
                        input[name="status"][value="OUTRO_STATUS"] + .status-display {
                            color: red;
                        }

                    </style>
                    <!-- Adiciona um campo hidden para o status do pedido -->
                    <input type="hidden" name="status" value="EM_PROCESSAMENTO">

                    <!-- Elemento visualmente relacionado com a classe status-display -->
                    <div class="status-display">Status: COMPRA EM PROCESSAMENTO</div>

                    <button type="submit" class="styled-button">
                        <img src="img/icon/carrinhoDeComprarIcon.ico" alt="Ícone do carrinho de compras" width="40"
                             height="40">
                        Concluir Compra
                    </button>
                </form>
            </div>


            <%--        <!-- Botões para Concluir Compra e Voltar -->--%>
            <%--        <img src="img/carrinhoComprar.jpg" width="40" height="40">--%>
            <%--        <input type="submit" value="Concluir Compra" class="styled-button">--%>

            <%--    </form>--%>
            <%--    <form action="MeiosDePagamentoServlet" method="get">--%>
            <%--        <input type="submit" value="Voltar" class="styled-button">--%>
            <%--    </form>--%>


            <script>
                function mudarStatus() {
                    // Simula a mudança de status para OUTRO_STATUS
                    document.querySelector('input[name="status"]').value = 'OUTRO_STATUS';
                    atualizarExibicaoStatus();
                }

                function atualizarExibicaoStatus() {
                    // Atualiza dinamicamente a exibição do status com base no valor do campo
                    const statusInput = document.querySelector('input[name="status"]');
                    const statusDisplay = document.querySelector('.status-display');

                    // Aplica os estilos com base no valor do campo de status
                    if (statusInput.value === 'COMPRA EM PROCESSAMENTO') {
                        statusDisplay.style.color = 'orange';
                    } else if (statusInput.value === 'OUTRO_STATUS') {
                        statusDisplay.style.color = 'red';
                    }

                    // Atualiza o texto do elemento de exibição do status
                    statusDisplay.textContent = 'Status: ' + statusInput.value;
                }

                // BUTTOM COMPRAR
                // Adicione este script para manipular o clique do botão
                document.addEventListener('DOMContentLoaded', function () {
                    var styledButton = document.querySelector('.styled-button');

                });


            </script>
        </div>
    </div>
</div>

</body>
</html>


