<%@ page import="br.com.gymcontrol.Model.UsuarioBackOffice" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.8">
    <link rel="stylesheet" type="text/css" href="css/EditarUsuarioBackOffice.css">
    <title>Editar Usuario Back Office</title>
</head>
<body>

<div id="conteiner-editar">
    <ul class="menu">
        <li class="menu-logo">
            <img src="img/Logo de cafe.png" alt="Logo do café">
            <h1>BEM-VINDO AO BREWMASTERS CAFÉ.BACKOFFICE</h1>
        </li>
    </ul>
</div>

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
<div class="error-message">${error}</div>

<div class="container">
    <h1>Editar Usuário</h1>
    <form action="/AlterarUsuarioServlet" method="post">
        <input type="hidden" name="userID" value="${param.userID}">

        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" value="${param.nome}" placeholder="Nome Completo" required><br>
        <hr>
        <br><br>
        <label for="cpf">CPF:</label>
        <input type="text" id="cpf" name="cpf" value="${param.cpf}" placeholder="000.000.000-00" required
               oninput="aplicarMascaraCPF(this)"><br>


        <%
            UsuarioBackOffice usuarioSessao = (UsuarioBackOffice) session.getAttribute("usuario");
            int userID = Integer.parseInt(request.getParameter("userID")); // Converte para int

            if (usuarioSessao != null && !String.valueOf(usuarioSessao.getID()).equals(String.valueOf(userID))) {
        %>
        <label for="grupo">Grupo:</label>
        <input type="text" id="grupo" name="grupo" value="${param.grupo}"><br>
        <% } %>
        <hr>
        <br><br>
        <div class="senha-box">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" placeholder="Senha:" required><br><br>

            <label for="confirmaSenha">Confirmar Senha:</label>
            <input type="password" id="confirmaSenha" name="confirmaSenha" placeholder="Confirmar Senha:" required><br>
        </div>
        <hr>
        <button type="submit">Salvar</button>
        <i class="fas fa-arrow-left"></i>

        <button onclick="window.location.href = '/ListarUsuarioBackOffice_2';" class="back-button">
            <i class="fas fa-arrow-left"></i> Voltar
        </button>

    </form>
    <hr2>
        <div id="mensagem-erro" style="color: red;"></div>
        <footer>

            <p1>&copy; 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</p1>
        </footer>

    </hr2>

</div>

<script>
    // Aqui pra baixo validação do cpf
    function aplicarMascaraCPF(input) {
        var cpfAtualizado = formatarCPF(input.value);
        input.value = cpfAtualizado;
    }

    function formatarCPF(cpf) {
        cpf = cpf.replace(/\D/g, ''); // Remove todos os caracteres não numéricos
        cpf = cpf.replace(/(\d{3})(\d)/, '$1.$2');
        cpf = cpf.replace(/(\d{3})(\d)/, '$1.$2');
        cpf = cpf.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
        return cpf;
    }
</script>
</body>
</html>
