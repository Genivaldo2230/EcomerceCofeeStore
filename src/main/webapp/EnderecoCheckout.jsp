<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adicionar e Escolher Endereço</title>
    <link rel="stylesheet" type="text/css" href="css/EnderecoCheckout.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="center-box">
        <li class="menu-logo">
            <img src="img/Logo de cafe.png">
            <h1>BREWMASTERS O SHOPPING DO CAFE</h1>
        </li>
        <hr>
        <h1>Selecione o endereço de entrega</h1>

        <form id="escolherFormaPagamentoForm" action="/MeiosDePagamentoServlet" method="get">
        <c:forEach var="endereco" items="${enderecos2}">
            <p><strong>ID:</strong> ${endereco.id}</p>
            <p><strong>CEP:</strong> ${endereco.cep}</p>
            <input type="radio" name="enderecoSelecionadoId" value="${endereco.id}" ${endereco.id == cliente.idEnderecoPadrao ? 'checked' : ''}>
            <label for="logradouro">Logradouro:</label>
            <input type="text" id="logradouro" name="logradouro" value="${endereco.logradouro}" readonly>
            <br>
            <label for="numero">Número:</label>
            <input type="text" id="numero" name="numero" value="${endereco.numero}" readonly>
            <br>
            <label for="complemento">Complemento:</label>
            <input type="text" id="complemento" name="complemento" value="${endereco.complemento}" readonly>
            <br>
            <label for="bairro">Bairro:</label>
            <input type="text" id="bairro" name="bairro" value="${endereco.bairro}" readonly>
            <br>
            <label for="cidade">Cidade:</label>
            <input type="text" id="cidade" name="cidade" value="${endereco.cidade}" readonly>
            <br>
            <label for="uf">UF:</label>
            <input type="text" id="uf" name="uf" value="${endereco.uf}" readonly>
            <hr>
        </c:forEach>
          <input type="hidden" name="enderecoSelecionadoId" id="enderecoSelecionadoId" value="">
           <input type="submit" value="Escolher forma de pagamento" class="styled-button">
       </form>
         <form id="enderecoForm" action="AdicionarEnderecoCheckouServlet" method="post">
                    <input type="hidden" name="clienteId" id="clienteId" value="${cliente.id}" />
                    <br>
                    <button type="button" onclick="adicionarEndereco()" class="styled-button1">Adicionar Endereço </button><br><br>
                    <div id="enderecos"></div>
<button type="button" id="salvarEnderecos" class="styled-button2">Salvar novos endereços </button>
                </form>
    </div>
    <script>
        document.getElementById("escolherFormaPagamentoForm").addEventListener("submit", function () {
            var enderecoSelecionado = document.querySelector('input[name="enderecoSelecionadoId"]:checked');
            if (enderecoSelecionado) {
                document.getElementById("enderecoSelecionadoId").value = enderecoSelecionado.value;
            }
        });
        document.addEventListener('DOMContentLoaded', function () {
            // Recuperar o valor do ID do cliente do campo oculto
            var clienteIdInput = document.getElementById("clienteId");
            var idInput = document.getElementById("id");

            if (clienteIdInput && idInput) {
                idInput.value = clienteIdInput.value;
            }
        });

        function adicionarEndereco() {
            var divEnderecos = document.getElementById("enderecos");
            var novoEndereco = document.createElement("div");
            novoEndereco.innerHTML = `
                <h2>Endereço Adicional</h2>
                <label for="cepAdicional">CEP:</label>
                <input type="text" name="cepAdicional" id="cepAdicional" required>
                <button type="button" class="buscarCEPAdicional" class="styled-button2">Buscar CEP</button>

                <div id="resultadoCEPad">
                    <label for="logradouroAdicional">Logradouro:</label>
                    <input type="text" name="logradouroAdicional" id="logradouroAdicional" required><br>

                    <label for="numeroAdicional">Número:</label>
                    <input type="number" name="numeroAdicional" id="numeroAdicional" required><br>

                    <label for="complementoAdicional">Complemento Adicional:</label>
                    <input type="text" name="complementoAdicional" required><br>

                    <label for="bairroAdicional">Bairro Faturamento:</label>
                    <input type="text" name="bairroAdicional" id="bairroAdicional" required><br>

                    <label for="cidadeAdicional">Cidade Faturamento:</label>
                    <input type="text" name="cidadeAdicional" id="cidadeAdicional" required><br>

                    <label for="ufAdicional">UF Faturamento:</label>
                    <select id="ufAdicional" name="ufAdicional" required>
                        <option value="AC">AC</option>
                        <!-- Outros estados aqui -->
                    </select><br>
                </div>

                <br>

                <button type="button" onclick="apagarEndereco(this)"class="styled-button1">Apagar Endereço</button><br><br>
            `;
            divEnderecos.appendChild(novoEndereco);
        }

        document.addEventListener('click', function (e) {
            if (e.target && e.target.classList.contains('buscarCEPAdicional')) {
                buscarCEPAdicional(e.target);
            }
        });

        function apagarEndereco(botao) {
            var divEndereco = botao.parentElement;
            divEndereco.remove();
        }

        function buscarCEPAdicional(botao) {
            var divEndereco = botao.parentElement;

            var cepAdicional = divEndereco.querySelector("#cepAdicional").value;
            cepAdicional = cepAdicional.replace('-', '');

            // Verifique se o CEP possui 8 dígitos
            if (cepAdicional.length !== 8) {
                alert("CEP inválido. Digite um CEP com 8 dígitos.");
                return;
            }

            // Faça a chamada à API do ViaCEP
            $.get("https://viacep.com.br/ws/" + cepAdicional + "/json/", function (data) {
                if (data.erro) {
                    alert("CEP não encontrado.");
                } else {
                    divEndereco.querySelector("#logradouroAdicional").value = data.logradouro;
                    divEndereco.querySelector("#bairroAdicional").value = data.bairro;
                    divEndereco.querySelector("#cidadeAdicional").value = data.localidade;
                    divEndereco.querySelector("#ufAdicional").value = data.uf;
                }
            });
        }

        document.getElementById("salvarEnderecos").addEventListener("click", function () {
            // Coletar todos os dados de endereço adicionados
            var enderecos = [];

            var divsEndereco = document.querySelectorAll("#enderecos > div");
            divsEndereco.forEach(function (divEndereco) {
                var endereco = {
                    cepAdicional: divEndereco.querySelector("#cepAdicional").value,
                    logradouroAdicional: divEndereco.querySelector("#logradouroAdicional").value,
                    numeroAdicional: divEndereco.querySelector("#numeroAdicional").value,
                    complementoAdicional: divEndereco.querySelector("input[name='complementoAdicional']").value,
                    bairroAdicional: divEndereco.querySelector("#bairroAdicional").value,
                    cidadeAdicional: divEndereco.querySelector("#cidadeAdicional").value,
                    ufAdicional: divEndereco.querySelector("#ufAdicional").value,
                };
                enderecos.push(endereco);
            });

            // Enviar os dados para the Servlet via formulário
            var enderecoForm = document.getElementById("enderecoForm");
            var hiddenInput = document.createElement("input");
            hiddenInput.setAttribute("type", "hidden");
            hiddenInput.setAttribute("name", "enderecos");
            hiddenInput.setAttribute("value", JSON.stringify(enderecos));
            enderecoForm.appendChild(hiddenInput);

            enderecoForm.submit();
        });
    </script>
</body>
</html>
