<%@ page import="br.com.gymcontrol.Model.UsuarioBackOffice" %>
<%@ page import="br.com.gymcontrol.Model.Produtos" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <title>Backoffice - Principal</title>
    <link rel="stylesheet" href="css/Principal.css">
</head>
<body>
<div class="slideshow-container">
    <img class="slideshow-image active" src="img/Fundo2.jpg">
    <img class="slideshow-image" src="img/Fundo3.jpg">
    <img class="slideshow-image" src="img/Fundo5.jpg">
</div>
<nav>
    <ul class="menu">
        <li class="menu-logo">
            <img src="img/Logo de cafe.png">
            <h1>BEM-VINDO AO BREWMASTERS CAFÉ.BACKOFFICE</h1>
        </li>
        
        <div class="container">
            <div class="form-container">
                <div class="btn-container">
                    <form action="/ListarProdutos_2" method="get">
                        <button class="btn-primary" type="submit">Lista de Produtos</button>
                    </form>
                    <form action="/listarPedidos" method="get">
                                            <button class="btn-primary" type="submit">Lista de Pedidos</button>
                                        </form>
                    <hr>
                    
                    <% if (((UsuarioBackOffice) session.getAttribute("usuario")).getGrupo().equals("Admin Group")) { %>
                    
                    
                    
                    <form action="/ListarUsuarioBackOffice_2" method="get">
                        <button class="btn-primary" type="submit">Buscar usuários dos sistemas</button>
                    </form>
                
                
                </div>
                <% } %>
            </div>
        </div>
       <li><a href="Login.jsp">Sair</a></li>
    </ul>
</nav>



<footer>
    © 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.
</footer>
</body>
</html>