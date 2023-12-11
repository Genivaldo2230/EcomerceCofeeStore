<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adicionar Endereço</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <h1>Adicionar Endereço</h1>
    <form id="enderecoForm" action="AdicionarEnderecoServlet" method="post">
<input type="hidden" name="clienteId" id="clienteId" value="${cliente.id}" />
    <br>
    <button type="button" onclick="adicionarEndereco()">Adicionar Endereço</button><br><br>

    <div id="enderecos"></div>
 <button type="button" id="salvarEnderecos">Salvar Endereços</button>
</form>
    <script>
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
                <button type="button" class="buscarCEPAdicional">Buscar CEP</button>

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
                <button type="button" onclick="apagarEndereco(this)">Apagar Endereço</button><br><br>
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

        // Enviar os dados para o Servlet via formulário
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
