<%@ page import="br.com.gymcontrol.Model.UsuarioBackOffice" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Usuário</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="css/CadastrarUsuarioBackOffice.css">
</head>
<body>

<div id="container">

    <nav>
        <ul class="menu">
            <li class="menu-logo">
                <img src="img/Logo de cafe.png">
                <h1>Bem Vindo BREWMASTERS CAFÉ.</h1>
            </li>

            <li><a href="Logout">Sair</a></li>
        </ul>
    </nav>

    <heare>

        <h1>Cadastrar Usuário BackOffice</h1>

            <% String mensagemSucesso = (String) request.getAttribute("mensagemSucesso"); %>
            <% if (mensagemSucesso != null) { %>
        <div class="alert alert-success">
            <%= mensagemSucesso %>
        </div>
            <% } %>

            <% String mensagemAlerta = (String) request.getAttribute("mensagemAlerta"); %>
            <% if (mensagemAlerta != null) { %>
        <div class="alert alert-danger">
            <%= mensagemAlerta %>
        </div>
            <% } %>

            <% String mensagemAlertaCPF = (String) request.getAttribute("mensagemAlertaCPF"); %>
            <% if (mensagemAlertaCPF != null) { %>
        <div class="alert alert-danger">
            <%= mensagemAlertaCPF %>
        </div>
            <% } %>


        <form action="/CadastrarUsuarioBackOffice" method="post">
            <label for="nome">Nome:</label>
            <input type="text" name="nome" placeholder="Digite seu Nome Completo" required><br>

            <label for="CPF">CPF:</label>
            <input type="text" name="CPF" id="cpfInput" placeholder="000.000.000.-00" required
                   oninput="aplicarMascaraCPF(this)">

            <hr>
            <label for="email">E-mail:</label>
            <input type="email" name="email" placeholder="E-mail" required><br>

            <div id="password-container">
                <label for="senha">Senha:</label>
                <input type="password" name="senha" id="senha" placeholder="Password" required><br>

                <label for="confirmarSenha">Confirmar:</label>
                <input type="password" name="confirmarSenha" id="confirmarSenha" placeholder="Password" required><br>

                <label for="showPassword" id="showPasswordLabel">
                    <input type="checkbox" id="showPassword">
                    Mostrar senha
                    <span class="show-password-icon"><i class="fas fa-eye"></i></span>
                </label>
            </div>
            <hr>
            <div id="grupo">
                <label for="grupo">Grupo:</label>
                <input type="text" name="grupo"><br>
            </div>
            <!--<label for="status">Status:</label>
            <input type="checkbox" name="status" checked><br>

      <label for="status">Status:</label>
           <input type="checkbox" name="status" id="statusCheckbox" checked>
           <span id="statusIcon"><i class="far fa-check-circle"></i></span><br>-->
            <hr>

            <button type="submit" class="submit-button" onclick="return validarSenhas();">
                <i class="fas fa-user-plus"></i> Cadastrar
            </button>

            <button style="background-color: rgba(31,8,8,0.04)"></button> <!-- Back button -->

            <button onclick="window.location.href = '/ListarUsuarioBackOffice_2';" class="back-button">
                <i class="fas fa-arrow-left"></i> Voltar
            </button>


        </form>

        <div id="mensagem-erro" style="color: red;"></div>

        <footer>
            <p1>&copy; 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</p1>
        </footer>
</div>


<script>
    // Dentro da função de callback do XMLHttpRequest
    if (this.readyState == 4) {
        if (this.status == 200) {
            // Atualizar a página após a atualização do status
            window.location.reload();
        } else if (this.status == 400) {
            // Exibir a mensagem de erro na página
            var mensagemErro = document.getElementById("mensagem-erro");
            mensagemErro.innerHTML = "Erro: " + this.responseText;
        }
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

    const statusCheckbox = document.getElementById("statusCheckbox");
    const statusIcon = document.getElementById("statusIcon");
    const addButton = document.getElementById("addButton");

    addButton.addEventListener("click", function () {
        if (statusCheckbox.checked) {
            statusIcon.innerHTML = '<i class="far fa-check-circle"></i>';
        } else {
            statusIcon.innerHTML = '<i class="far fa-times-circle"></i>';
        }
    });


</script>

</body>
</html>
