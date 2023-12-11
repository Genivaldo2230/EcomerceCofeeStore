<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Cliente</title>
        <link rel="stylesheet" href="css/LoginCliente.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

    <div class="fundo">

        <img class="imagem-fundo" src="https://nationalcoffeeblog.files.wordpress.com/2016/09/coffee-animated.gif" alt="GIF from Giphy">


    </div>

    <div class="quadrado">
        <div class="conteudo">

      <li class="menu-logo">
                <img src="img/Logo de cafe.png">
                <h1>BEM-VINDO AO BREWMASTERS CAFÉ </h1>
            </li>

   <h1>Faça seu login <span class="icone-usuario">&#9787;</span> </h1>
    <form action="LoginClienteServlet" method="post">
        Email: <input type="text" name="email"><br>
        Senha: <input type="password" name="senha"><br>
        <input type="submit" value="Entrar">
    </form>
            
            <li>
                <button class="meu-botao">
                    <a href="CadastrarCliente.jsp" style="color: inherit; text-decoration: none;"><i
                            class="fa-solid fa-user-pen"></i>  Cadastrar</a>
                </button>
            </li>

<%--        <li><a href="CadastrarCliente.jsp">Cadastrar </a></li>--%>


    <% String mensagemErro = (String) request.getAttribute("mensagemErro");
       if (mensagemErro != null) { %>
        <p1><%= mensagemErro %></p1>
    <% } %>
    </div>
    </div>


</body>
</html>
