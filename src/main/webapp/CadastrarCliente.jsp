<!DOCTYPE html>
<%@ page import="br.com.gymcontrol.Model.Cliente" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<html lang="pt-br">
<head>
	<meta charset="UTF-8">
	<meta name="viewport"
	      content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Cadastro de Cliente</title>
</head>
<link rel="stylesheet" href="css/CadastrarCliente.css">
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

<div id="container">
	<div class="row-cliente">
		<div class="col-12 col-lg-6 col-xl-6 col-md-6">
			<h1>Cadastro de Cliente</h1>
			
			<% String mensagemSucesso = (String) request.getAttribute("mensagemSucesso"); %>
			<% if (mensagemSucesso != null) { %>
			<div class="alert alert-success">
				<%= mensagemSucesso %>
			</div>
			<% } %>
			
			<% String mensagemAlertaCPF = (String) request.getAttribute("mensagemAlertaCPF"); %>
			<% if (mensagemAlertaCPF != null) { %>
			<div class="alert alert-danger">
				<%= mensagemAlertaCPF %>
			</div>
			<% } %>
			
			<% String mensagemAlerta = (String) request.getAttribute("mensagemAlerta"); %>
			<% if (mensagemAlerta != null) { %>
			<div class="alert alert-danger">
				<%= mensagemAlerta %>
			</div>
			<% } %>
			
			<%
				String mensagemAlertaEmail = (String) request.getAttribute("mensagemAlertaEmail");
				if (mensagemAlertaEmail != null && !mensagemAlertaEmail.isEmpty()) {
			%>
			<div class="alert alert-danger" role="alert">
				<%= mensagemAlertaEmail %>
			</div>
			<% } %>
			<section>
				<form action="/CadastrarClienteServlet" method="post" onsubmit="return validarNome();">
					
					<label for="nomeCompleto">Nome Completo:</label>
					<input type="text" name="nomeCompleto" id="nomeCompleto" required><br>
					<div id="mensagemAlertaNome" style="color: red;"></div>
					
					
					<label for="dataNascimento">Data de Nascimento:</label>
					<div class="data">
						<input type="date" name="dataNascimento" required style="width: 200px;"><br>
					</div>
				
					
					<div class="genero">
						<label for="genero">Gênero:</label>
						<select name="genero" required>
							<option value="##">Selecione</option>
							<option value="masculino">Masculino</option>
							<option value="feminino">Feminino</option>
							<option value="outro">Outro</option>
						</select>
					</div>
					<br><br><br>
					
					<label for="email">Email:</label>
					<input type="email" name="email" required><br>
					
					
					<label for="cpf">CPF:</label>
					<input type="text" name="cpf" id="cpf" placeholder="000.000.000-00" style="width: 200px;" necessário
					       oninput="aplicarMascaraCPF(this)">
					
					<div id="password-container">
						<label for="senha">Senha:</label>
						<input type="password" name="senha" id="senha" placeholder="Password" required><br>
						
						<label for="confirmarSenha">Confirmar:</label>
						<input type="password" name="confirmarSenha" id="confirmarSenha" placeholder="Password"
						       required><br>
						
						<label for="showPassword" id="showPasswordLabel">
							<input type="checkbox" id="showPassword">
							
							<span class="show-password-icon"><i class="fas fa-eye"></i></span>
						</label>
					</div>
					<br>
					<hr><hr><hr>
					
					<h2>Endereço Principal</h2>
					<br>
					<label for="cep">CEP:</label>
					<input type="text" name="cepFaturamento" id="cepFaturamento" placeholder="0.0000-000" required
					       style="width: 250px">
					
					<div id="container-button-cep">
						<div class="row-button">
							<button type="button" id="buscarCEP"><i class="fa-solid fa-location-dot"></i> Buscar CEP
							</button>
						</div>
					</div>
					<%--					<label for="cep">CEP:</label>--%>
					<%--					<input type="text" name="cepFaturamento"--%>
					<%--					       id="cepFaturamento" placeholder="  0.0000-000" required style="width: 200px;">--%>
					<%--					<button type="button" id="buscarCEP">Buscar CEP</button>--%>
					
					<div id="resultadoCEP">
						
						<label for="logradouroFaturamento">Logradouro Faturamento:</label>
						<input type="text" name="logradouroFaturamento" id="logradouroFaturamento" required><br>
						
						<label for="numeroFaturamento">Número Faturamento:</label>
						<input type="number" name="numeroFaturamento" required style="width: 200px"><br>
						
						<label for="complementoFaturamento">Complemento Faturamento:</label>
						<input type="text" name="complementoFaturamento" required><br>
						
						<label for="bairroFaturamento">Bairro Faturamento:</label>
						<input type="text" name="bairroFaturamento" id="bairroFaturamento" required><br>
						
						<label for="cidadeFaturamento">Cidade Faturamento:</label>
						<input type="text" name="cidadeFaturamento" id="cidadeFaturamento" required><br>
						
						<label for="ufFaturamento">UF Faturamento:</label>
						<select id="ufFaturamento" name="ufFaturamento" required>
							
							
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
						</select> <br>
					
					</div>
					<br>
					<div id="container-button-end">
						<div class="row-button">
							<div class="col-12 col-lg-6 col-xl-6 col-md-6">
								<button-end type="button" onclick="adicionarEndereco()"><i
										class="fa-regular fa-pen-to-square"></i> Adicionar
									Endereço
								</button-end>
							</div>
						</div>
					</div>
<%--					<button type="button" onclick="adicionarEndereco()">Adicionar Endereço</button>--%>
					<br>
					<br>
					
					<div id="enderecos"></div>
					
					<hr>
					<br>
					<button type="submit" class="submit-button" onclick="return validarSenhas();">
						<i class="fas fa-user-plus"></i> Cadastrar
					</button>
					<div id="voltar-button">
						<a href="LoginCliente.jsp" class="botao-voltar">
							<i class="fa-solid fa-reply-all"></i> Voltar</a>
					</div>
				
				</form>
			</section>
			
			
			<script>
                function adicionarEndereco() {
                    var divEnderecos = document.getElementById("enderecos");
                    var novoEndereco = document.createElement("div");
                    novoEndereco.innerHTML = `
                <h2>Endereço Adicional</h2>
            <label for="cepAD">CEP:</label>
                <input type="text" name="cepAdicional" id="cepAdicional" required>
        <button type="button" class="buscarCEPAdicional">Buscar CEP</button>

                <div id="resultadoCEPad">

            <label for="logradouroAdicional">Logradouro:</label>
                    <input type="text" name="logradouroAdicional" id="logradouroAdicional" required><br>

                    <label for="numeroAdicional">Número:</label>
                     <input type="número" name="numeroAdicional" required><br>

                     <label for="complementoAdicional">complemento Adicional:</label>
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
                   </select>    <br>
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


                function formatarCPF(cpf) {
                    cpf = cpf.replace(/\D/g, ''); // Remove todos os caracteres não numéricos
                    cpf = cpf.replace(/(\d{3})(\d)/, '$1.$2');
                    cpf = cpf.replace(/(\d{3})(\d)/, '$1.$2');
                    cpf = cpf.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
                    return cpf;
                }

                function aplicarMascaraCPF(input) {
                    var cpfAtualizado = formatarCPF(input.value);
                    input.value = cpfAtualizado;
                }


                function validarSenhas() {
                    var senha = document.getElementById("senha").value;
                    var confirmarSenha = document.getElementById("confirmarSenha").value;

                    if (senha !== confirmarSenha) {
                        alert("As senhas não coincidem. Por favor, verifique novamente.");
                        return false;
                    }
                    return true;
                }


                const showPasswordCheckbox = document.getElementById("showPassword");
                const senhaInput = document.getElementById("senha");
                const confirmarSenhaInput = document.getElementById("confirmarSenha");
                const showPasswordIcon = document.querySelector(".show-password-icon");

                showPasswordCheckbox.addEventListener("change", function () {
                    if (this.checked) {
                        senhaInput.type = "text";
                        confirmarSenhaInput.type = "text";
                        showPasswordIcon.innerHTML = '<i class="fas fa-eye-slash"></i>';
                    } else {
                        senhaInput.type = "password";
                        confirmarSenhaInput.type = "password";
                        showPasswordIcon.innerHTML = '<i class="fas fa-eye"></i>';
                    }
                });


                $(document).ready(function () {
                    $("#buscarCEP").click(function () {

                        var cep = $("#cepFaturamento").val();
                        cep = cep.replace('-', '');

                        // Verifique se o CEP possui 8 dígitos
                        if (cep.length !== 8) {
                            alert("CEP inválido. Digite um CEP com 8 dígitos.");
                            return;
                        }

                        // Faça a chamada à API do ViaCEP
                        $.get("https://viacep.com.br/ws/" + cep + "/json/", function (data) {
                            if (data.erro) {
                                alert("CEP não encontrado.");
                            } else {
                                // Preencha os campos com os dados do CEP
                                $("#logradouroFaturamento").val(data.logradouro);
                                $("#bairroFaturamento").val(data.bairro);
                                $("#cidadeFaturamento").val(data.localidade);
                                $("#ufFaturamento").val(data.uf);
                                // Adicione outras informações que desejar preencher
                            }
                        });
                    });
                });


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
                            // Preencha os campos com os dados do CEP
                            divEndereco.querySelector("#logradouroAdicional").value = data.logradouro;
                            divEndereco.querySelector("#bairroAdicional").value = data.bairro;
                            divEndereco.querySelector("#cidadeAdicional").value = data.localidade;
                            divEndereco.querySelector("#ufAdicional").value = data.uf;  // Adicione outras informações que desejar preencher
                        }
                    });
                }


               function validarNome() {
                      var nomeCompleto = document.getElementById("nomeCompleto").value;
                      var partesNome = nomeCompleto.split(" ");

                      if (partesNome.length < 2 || partesNome[0].length < 3 || partesNome[1].length < 3) {
                          document.getElementById("mensagemAlertaNome").innerText = "O nome do cliente deve ter no mínimo duas palavras, cada uma com no mínimo 3 letras.";
                          return false;
                      }

                      return true;
                  }
			
			</script>
		
		</div>
	</div>
	<footer>© 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</footer>
</div>

</body>
</html>
