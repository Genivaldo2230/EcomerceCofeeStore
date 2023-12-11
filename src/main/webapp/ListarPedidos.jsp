<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listagem de Pedidos</title>
</head>
<link rel="stylesheet" href="css/ListarPedidos.css">
<body>
<nav>
    <ul class="menu">
        <li class="menu-logo">
            <img src="img/Logo de cafe.png">
            <h1> BREWMASTERS CAFÉ</h1>
        </li>
        <button-voltar onclick="voltarParaPrincipal()">Voltar</button-voltar>
    </ul>
</nav>
<div id="container">
    <form action="Principal.jsp" method="get">
        <button class="btn-primary" type="submit">Voltar</button>
    </form>
    <h1>Listagem de Pedidos</h1>

    <table border="1">
        <tr>
            <th>ID do Pedido</th>
            <th>Data do Pedido</th>

            <th>Editar status</th>
            <th>Status</th>
            <th>Valor Total</th>
        </tr>
        <c:forEach var="pedido" items="${pedidos}">
        <tr>
            <td>${pedido.id}</td>
            <td>${pedido.dataPedido}</td>
            <td>
                <form action="AlterarStatusPedidoServlet" method="post">
                    <input type="hidden" name="idPedido" value="${pedido.id}">
                    <select name="novoStatus">
                        <c:forEach var="status" items="${statusList}">
                            <option value="${status}" ${pedido.status eq status ? 'selected' : ''}>${status}</option>
                        </c:forEach>
                    </select>
                    <button type="submit">Salvar</button>

                </form>
            </td>
            <td>${pedido.status}</td>
            <td>${pedido.valorTotal}</td>
            <td>
                </c:forEach>

    </table>

</div>
<script>
    function voltarParaPrincipal() {
        window.location.href = 'http://localhost:8080/Principal.jsp';
    }
</script>

</body>
</html>
