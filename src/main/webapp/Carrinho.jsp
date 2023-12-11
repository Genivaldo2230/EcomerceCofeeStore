<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrinho de Compras</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
      integrity="sha512-LCy8A+F8z+q0mz4D3XpUZq7E4A71KNfnr9V5z1GO6dB/Ty7PM08RKVf9eq4egF8tsL7EtqKvwnIcjVmGBw0r5A=="
      crossorigin="anonymous" referrerpolicy="no-referrer"/>
<link rel="stylesheet" type="text/css" href="css/Carrinho.css">
<style>
    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
    }
    td {
        text-align: center;
        font-family: system-ui;
        font-weight: 500;
        font-size: 1.5em;
        color: white;
    }
    th {
        background-color:#3d0909;
    }

    img {
        max-width: 100px;
        height: auto;
        display: block;
        margin: 0 auto;
    }

    .btn-menos, .btn-mais, .btn-excluir {
        padding: 5px 10px;
        cursor: pointer;
    }
</style>

<body>
<div id="container">
    <div class="row-main">
        <div class="col-12">

            <nav>
                <ul class="menu">
                    <li class="menu-logo">
                        <img src="img/Logo de cafe.png">
                        <h1-logo> BREWMASTERS CAFÉ</h1-logo>
                    </li>
                    <button-voltar onclick="voltarParaPrincipalCliente()">Voltar</button-voltar>

                    <script>
                        function voltarParaPrincipalCliente() {
                            window.history.back();
                        }
                    </script>
                </ul>
            </nav>
            <c:if test="${not empty erroQuantidade}">
                <div class="alert alert-danger">${erroQuantidade}</div>
            </c:if>

            <h1>Produtos no Carrinho</h1>

            <c:choose>
                <c:when test="${not empty carrinho}">
                    <table  border="1">
                        <tr>
                            <th>Produto</th>
                            <th>Nome do Produto</th>
                            <th>Quantidade</th>
                            <th>Subtotal</th>
                            <th>Qtd em estoque</th>
                            <th>DIMINUIR QTD</th>
                            <th>ADICIONAR QTD</th>
                            <th>Excluir</th>
                        </tr>
                        <c:set var="total" value="0"/> <!-- Inicializa a variável total -->
                        <c:forEach var="item" items="${carrinho}" varStatus="loop">

                            <tr data-id="${item.produto.produtoID}">


                                <td> <img src="${item.produto.imagePATH}" alt="Imagem do Produto"
                                          width="50"></td>
                                <td>${item.produto.nomeProduto}</td>

                                <td id="quantidade-${item.produto.produtoID}"
                                    data-qtd-estoque="${item.produto.qtdEstoque}">${item.quantidade}</td>
                                <td class="subtotal" data-preco="${item.produto.precoProduto}">R$ ${item.subtotal}</td>

                                <td id="produto">${item.produto.qtdEstoque}</td>

                                <td>
                                    <button class="btn-menos" data-id="${item.produto.produtoID}">-</button>
                                </td>
                                <td>
                                    <button class="btn-mais" data-id="${item.produto.produtoID}"
                                            data-qtd-estoque="${item.produto.qtdEstoque}">+
                                    </button>
                                </td>
                                <td>
                                    <button class="btn-excluir" data-id="${item.produto.produtoID}">Excluir</button>
                                </td>
                            </tr>
                            <c:set var="total" value="${total + item.subtotal}"/> <!-- Soma o subtotal ao total -->
                        </c:forEach>

                    </table>
                    <p id="totalSemFrete">Total sem frete: R$ ${total}</p> <!-- Exibe o total -->
                    <p id="totalAtualizado" style="display:none;" data-total="${total}">Total com frete : R$
                        <span>${total}</span></p>
                </c:when>
                <c:otherwise>
                    <p style="background-color: red;!important; color: #0c0401">Carrinho vazio, adicione algum item.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div id="container-sedex">
        <div class="row-sedex">
            <div class="col-4">
                <c:choose>
                <c:when test="${sessionScope.cliente == null}">
                <div id="container-sedex-frete">
                    <div class="row-sedex-frete">
                        <div class="col-4 class=frete1">
                            <h2> Calcular frete: </h2>
                            <label for="cepFaturamento">
                                <span-cep> Buscar Cep:</span-cep>
                            </label>
                            <input type="text" name="cepFaturamento" id="cepFaturamento" placeholder="   0.0000-000 "
                                   required>
                            <div id="container-button-cep">
                                <div class="row-button">
                                    <button type="button" id="buscarCEP"> Buscar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="opcoesEntrega" style="display:none;margin-top: -11em">
                    <h2>Tipos de entrega:</h2>
                    <p>RECEBER NO MEU ENDEREÇO</p>
                    <p>Turbo - Entrega em 60 minutos
                        <input type="radio" name="frete" value="10.90" id="freteTurbo"> 10.90<br>
                    </p>
                    <p>Entrega rápida
                        <input type="radio" name="frete" value="4.90" id="freteRapida"> 4.90<br>
                    </p>
                    <p>Normal - 1 dia(s) útil(eis)
                        <input type="radio" name="frete" value="3.90" id="freteNormal"> 3.90<br>
                    </p>

                    <div id="container-button-comprar">
                        <form action="LoginCliente.jsp" method="get">
                            <button class="btn-primary" type="submit"><span>COMPRAR</span></button>
                        </form>

                    </div>

                    </c:when>
                    </c:choose>

                    <c:choose>
                        <c:when test="${not empty cliente}">
                            <h3> CLIENTE LOGADO
                                <button style="background-color: rgba(12,4,1,0);font-weight: 900" class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                                        aria-expanded="false">
                                     ${sessionScope.cliente.nomeCompleto}
                                </button>
                            </h3>
                            <h1-tp>Tipos de entrega:</h1-tp>
                            <p>RECEBER NO MEU ENDEREÇO</p>
                            <p>CEP: ${cliente.cepFaturamento}</p>

                            <p>Turbo - Entrega em 60 minutos
                                <input type="radio" name="frete" value="10.90" id="freteTurbo"> 10.90<br>
                            </p>
                            <p>Entrega rápida
                                <input type="radio" name="frete" value="4.90" id="freteRapida"> 4.90<br>
                            </p>
                            <p>Normal - 1 dia(s) útil(eis)
                                <input type="radio" name="frete" value="3.90" id="freteNormal"> 3.90<br>
                            </p>

                            <form id="comprarForm" action="/ListarEnderecosCheckout" method="get">
                                <button id="btnComprar" class="btn-primary" type="submit">
                                    <p-comprar> COMPRAR</p-comprar>
                                </button>
                            </form>

                            <div id="container-sedex-frete">
                                <div class="row-sedex-frete">
                                    <div class="col-4 class=frete">
                                        <h2> Calcular frete: </h2>
                                        <label for="cepFaturamento">
                                            <span-cep> Buscar Cep:</span-cep>
                                        </label>
                                        <input type="text" name="cepFaturamento" id="cepFaturamento"
                                               placeholder="   0.0000-000 "
                                               required>

                                        <div id="container-button-cep">
                                            <div class="row-button">
                                                <button type="button" id="buscarCEP"> Buscar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <input type="hidden" name="totalComFrete" value="${totalComFrete}">

                            <div id="opcoesEntrega" style="display:none;">
                                <h2>Tipos de entrega:</h2>
                                <p>RECEBER NO MEU ENDEREÇO</p>
                                <p>Turbo - Entrega em 1 hora
                                    <input type="radio" name="frete" value="10.90" id="freteTurbo"> 15.90<br>
                                </p>
                                <p>Entrega rápida
                                    <input type="radio" name="frete" value="20.00" id="freteRapida"> 20.00<br>
                                </p>
                                <p>Normal - 1 dia(s) útil(eis)
                                    <input type="radio" name="frete" value="10.90" id="freteNormal"> 10.90<br>
                                </p>
                            </div>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
        <footer>
            <span-footer> * O prazo de retirada do pedido inicia-se após a confirmação do pagamento aceitamos a
                Seguintes
                Bandeiras.
                <a href="https://www.flaticon.com/free-icon/visa_349221"
                   class="view link-icon-detail related-icon active"
                   title="Visa" data-id="349221" data-src="?term=visa">
                    <img id="image" style="width:41;height:30px;" data-size="256" class="img-responsive"
                         src="https://cdn-icons-png.flaticon.com/512/349/349221.png" alt="Visa" title="Visa"
                         width="44"
                         height="44">
                    <img id="image" style="width:55;height:30px;" data-size="256"
                         src="https://cdn.icon-icons.com/icons2/130/PNG/256/master_card_e-commerce_business_20577.png"
                         title="ícone Mestre, cartão, e commerce, business Livre"
                         alt="ícone mestre, cartão, e commerce, business">
                    <img id="image" style="width:43;height:30px;" data-size="256"
                         src="https://th.bing.com/th/id/R.2977250b9ae745fe3b71742179bf2a04?rik=urMTIZ%2fTxZAd2g&amp;pid=ImgRaw&amp;r=0"
                         alt="La Tarjeta American Express Green Card | AMEX México" class=" nofocus" tabindex="0"
                         aria-label="La Tarjeta American Express Green Card | AMEX México" role="button">
                    <img id="image" style="width:90;height:30px;" data-size="256" class="img-responsive"
                         src="https://www.foxstextil.com.br/image/catalog/0-Banner/01-/meios-de-pagamentos.png">
                </a>
            </span-footer>
        </footer>
    </div>
    <script>
        $(document).ready(function () {
            $("#buscarCEP").click(function () {
                var cep = $("#cepFaturamento").val();
                cep = cep.replace('-', '');

                var cepRegex = /^[0-9]{8}$/;
                if (!cepRegex.test(cep)) {
                    alert("CEP inválido. Digite um CEP com 8 dígitos.");
                    return;
                }

                $.get("https://viacep.com.br/ws/" + cep + "/json/", function (data) {
                    if (data.erro) {
                        alert("CEP não encontrado.");
                    } else {
                        $("#opcoesEntrega").show();
                    }
                });
            });
            $('input[name="frete"]').change(function () {
                var freteSelecionado = $('input[name="frete"]:checked').val();
                var totalProdutos = parseFloat($('#totalAtualizado').data('total'));
                var total = parseFloat(freteSelecionado) + totalProdutos;
                $('#totalAtualizado span').text(total.toFixed(2));

                $('#totalAtualizado').show();
            });


            $('.btn-excluir').click(function () {
                var produtoID = $(this).data('id');

                $.ajax({
                    url: 'removerDoCarrinho',
                    method: 'POST',
                    data: {produtoID: produtoID},
                    success: function () {
                        $('tr[data-id="' + produtoID + '"]').remove(); // Remove a linha da tabela

                        $('img[data-id="' + produtoID + '"]').remove(); // Remove a imagem do produto

                        var total = calcularTotal();
                        $('#totalSemFrete').text('Total sem frete: R$ ' + total.toFixed(2));

                        var freteSelecionado = $('input[name="frete"]:checked').val();
                        var totalComFrete = parseFloat(freteSelecionado) + total;
                        $('#totalAtualizado span').text(totalComFrete.toFixed(2));
                        window.location.reload();


                    },
                    error: function () {
                        alert('Erro ao excluir o item do carrinho');
                    }
                });
            });

            function calcularTotal() {
                var total = 0;
                $('.subtotal').each(function () {
                    total += parseFloat($(this).text().replace('R$ ', ''));
                });
                return total;
            }
        });

        function calcularTotal() {
            var total = 0;
            $('.subtotal').each(function () {
                total += parseFloat($(this).text().replace('R$ ', ''));
            });
            return total;
        }

        $('.btn-menos').click(function () {
            var produtoID = $(this).data('id');
            var quantidadeElement = $('#quantidade-' + produtoID);
            var novaQuantidade = parseInt(quantidadeElement.text()) - 1;


            if (novaQuantidade >= 0) {
                quantidadeElement.text(novaQuantidade);

                var precoUnitario = parseFloat($('tr[data-id="' + produtoID + '"]').find('.subtotal').data('preco'));

                $.post('atualizarQuantidade', {
                    produtoID: produtoID,
                    novaQuantidade: novaQuantidade
                }, function (response) {
                    console.log(response);

                    var total = calcularTotal();
                    $('#totalSemFreteElement').text('Total sem frete: R$ ' + total.toFixed(2));


                    // Atualize a exibição conforme necessário
                    var subtotal = novaQuantidade * precoUnitario;
                    $('tr[data-id="' + produtoID + '"]').find('.subtotal').text('R$ ' + subtotal.toFixed(2));
                });

                if (novaQuantidade === 0) {
                    var btnExcluir = $(this).closest('tr').find('.btn-excluir');
                    btnExcluir.trigger('click');
                }

                // Atualize o total sem frete
                var total = calcularTotal();
                $('#totalSemFrete').text('Total sem frete: R$ ' + total.toFixed(2));

                // Atualize o total com frete
                var freteSelecionado = $('input[name="frete"]:checked').val();
                var totalComFrete = parseFloat(freteSelecionado) + total;
                $('#totalAtualizado span').text(totalComFrete.toFixed(2));
                window.location.reload();

            }
        });

        $('.btn-mais').click(function () {
            var produtoID = $(this).data('id');
            var quantidadeElement = $('#quantidade-' + produtoID);
            var novaQuantidade = parseInt(quantidadeElement.text()) + 1;
            var qtdEstoque = parseInt(quantidadeElement.data('qtd-estoque'));

            if (novaQuantidade <= qtdEstoque) {
                quantidadeElement.text(novaQuantidade);

                $.post('atualizarQuantidade', {
                    produtoID: produtoID,
                    novaQuantidade: novaQuantidade
                }, function (response) {
                    console.log(response);
                });

                var precoUnitario = parseFloat($('tr[data-id="' + produtoID + '"]').find('.subtotal').data('preco'));
                var subtotal = novaQuantidade * precoUnitario;

                // Atualize a exibição do subtotal
                $('tr[data-id="' + produtoID + '"]').find('.subtotal').text('R$ ' + subtotal.toFixed(2));

                var total = calcularTotal();
                $('#totalSemFreteElement').text('Total sem frete: R$ ' + total.toFixed(2));

                // Atualize o total sem frete
                $('#totalSemFrete').text('Total sem frete: R$ ' + total.toFixed(2));

                // Atualize o total com frete
                var freteSelecionado = $('input[name="frete"]:checked').val();
                var totalComFrete = parseFloat(freteSelecionado) + total;
                $('#totalAtualizado span').text(totalComFrete.toFixed(2));
            } else {
                alert('Quantidade máxima atingida para este produto.');
            }
        });


        $('#btnComprar').click(function (event) {
            if ($('input[name="frete"]:checked').length === 0) {
                alert("Selecione uma opção de frete antes de prosseguir.");
                event.preventDefault(); // Evita o envio do formulário
            }
        });


        $('input[name="frete"]').change(function () {
            var freteSelecionado = $('input[name="frete"]:checked').val();
            var totalProdutos = parseFloat($('#totalSemFrete').text().replace('Total sem frete: R$ ', ''));
            var total = parseFloat(freteSelecionado) + totalProdutos;
            $('#totalAtualizado span').text(total.toFixed(2));

            // Exibe o parágrafo com o total atualizado
            $('#totalAtualizado').show();
        });
        $('#btnComprar').click(function (event) {
            // Obtenha o valor total com frete do elemento HTML
            var totalComFrete = parseFloat($('#totalAtualizado span').text());

            // Atualize a sessão com o valor total com frete
            $.post('atualizarTotalComFrete', {totalComFrete: totalComFrete}, function (response) {
                console.log(response);

                // Após atualizar a sessão, redirecione para a servlet
                window.location.href = 'ListarEnderecosCheckout';
            });

            // Evita o envio do formulário
            event.preventDefault();
        });
        function voltarParaPrincipalCliente() {
            window.history.back();
        }
    </script>

</div>
</body>
</html>

