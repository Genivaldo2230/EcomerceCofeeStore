<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Editar Cliente</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<link rel="stylesheet" href="css/AlterarDadosCliente.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<body>
<div id="container-logo">
	<div class="row">
		<div class="col-12 col-lg-6 col-xl-6 col-md-6">
			<nav>
				<ul class="menu">
					<li class="menu-logo">
						<img src="img/Logo de cafe.png">
						<h1 style="text-decoration: none;">BEM-VINDO AO BREWMASTERS CAFÉ</h1>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</div>

<h1>Editar Informações do Cliente</h1>

<form action="EditarClienteServlet" method="post" onsubmit="return validarNome();">
    <label for="nomeCompleto">Nome Completo:</label>
    <input type="text" id="nomeCompleto" name="nomeCompleto" value="${cliente.nomeCompleto}"
           required onblur="validarNome()"><br><br>
    <div id="mensagemAlertaNome" style="color: red;"></div>

				<label for="dataNascimento">Data de Nascimento:</label>
				<input type="date" id="dataNascimento" name="dataNascimento" value="${cliente.dataNascimento}" required
				       max="2023-10-17"><br><br>
				
				
				<label for="genero">Gênero:</label>
				<input type="text" id="genero" name="genero" value="${cliente.genero}" required><br><br>
				
				
				<div id="password-container">
					<label for="senha">Nova Senha:</label>
					<input type="password" name="senha" id="senha"><br>
					
					<label for="confirmarSenha">Confirmar Senha:</label>
					<input type="password" name="confirmarSenha" id="confirmarSenha"><br>
					
					<label for="showPassword" id="showPasswordLabel">
						<input type="checkbox" id="showPassword">
						
						<span class="show-password-icon"><i class="fas fa-eye"></i></span>
					</label>
				</div>
				<input type="submit" value="Salvar Alterações" class="botao-salvar">
<%--				<input type="submit" value="Salvar Alterações"/>--%>
			</form>
		</div>
	</div>
</div>
<div id="mensagem-erro" style="color: red;"></div>

<form id="enderecoForm" action="AdicionarEnderecoServlet" method="post">
    <input type="hidden" name="clienteId" id="clienteId" value="${cliente.id}"/>
    <br>
    <button type="button" onclick="adicionarEndereco()">Adicionar Endereço</button>
    <br><br>

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
                <option value="AL">AL</option>
                <option value="AP">AP</option>
                <option value="AM">AM</option>
                <option value="BA">BA</option>
                <option value="CE">CE</option>
                <option value="DF">DF</option>
                <option value="ES">ES</option>
                <option value="GO">GO</option>
                <option value="MA">MA</option>
                <option value="MT">MT</option>
                <option value="MS">MS</option>
                <option value="MG">MG</option>
                <option value="PA">PA</option>
                <option value="PB">PB</option>
                <option value="PR">PR</option>
                <option value="PE">PE</option>
                <option value="PI">PI</option>
                <option value="RJ">RJ</option>
                <option value="RN">RN</option>
                <option value="RS">RS</option>
                <option value="RO">RO</option>
                <option value="RR">RR</option>
                <option value="SC">SC</option>
                <option value="SP">SP</option>
                <option value="SE">SE</option>
                <option value="TO">TO</option>

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




function validarNome() {
    var nomeCompleto = document.getElementById("nomeCompleto").value;
    var partesNome = nomeCompleto.split(" ");

    if (partesNome.length < 2 || partesNome.some(part => part.length < 3)) {
        document.getElementById("mensagemAlertaNome").innerText = "O nome do cliente deve ter no mínimo duas palavras, cada uma com no mínimo 3 letras.";
        return false; // Evita o envio do formulário se a validação falhar
    } else {
        document.getElementById("mensagemAlertaNome").innerText = "";
    }

    return true;
}

document.getElementById("salvarEnderecos").addEventListener("click", function () {
             // Validar os endereços antes de enviar o formulário
             if (validarEnderecos()) {
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
             }
         });

         function validarEnderecos() {
             // Coletar todos os dados de endereço adicionados
             var enderecos = [];

             var divsEndereco = document.querySelectorAll("#enderecos > div");
             if (divsEndereco.length === 0) {
                 alert("Adicione pelo menos um endereço antes de salvar.");
                 return false; // Retorna falso para impedir o envio
             }

             for (var i = 0; i < divsEndereco.length; i++) {
                 var divEndereco = divsEndereco[i];
                 var camposEndereco = divEndereco.querySelectorAll("input, select");
                 var enderecoValido = true;

                 camposEndereco.forEach(function (campo) {
                     if (campo.value.trim() === "") {
                         enderecoValido = false;
                     }
                 });

                 if (!enderecoValido) {
                     alert("Preencha todos os campos do endereço antes de salvar.");
                     return false; // Retorna falso para impedir o envio
                 }
             }

             return true; // Retorna verdadeiro se todos os endereços estiverem preenchidos
         }

</script>
<footer>© 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</footer>
</body>
</html>
