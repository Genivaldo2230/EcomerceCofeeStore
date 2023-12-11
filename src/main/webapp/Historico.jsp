<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Histórico de Pedidos</title>
</head>
<link rel="stylesheet" href="css/Historico.css">
<body>

<nav>
    <ul class="menu">
        <li class="menu-logo">
            <img src="img/Logo de cafe.png">
            <h1> BREWMASTERS CAFÉ</h1>
        </li>
    </ul>
</nav>
    <h2>Histórico de Pedidos</h2>
<div id="container">
    <table border="1">
        <tr>
            <th>Número</th>
            <th>Data</th>
            <th>Valor Total</th>
            <th>Status</th>
            <th>Mais Detalhes</th>
        </tr>

        <c:forEach var="pedido" items="${pedidos}">
            <tr>
                <td>${pedido.id}</td>
                <td>${pedido.dataPedido}</td>
                <td>${pedido.valorTotal}</td>
                <td>${pedido.status}</td>



             <td>   <form action="detalhesPedido" method="get">
                    <input type="hidden" name="pedidoId" value="${pedido.id}">
                    <button type="submit">Detalhes</button>
                </form>            </td>

            </tr>
        </c:forEach>


    </table>


</div>
    <footer>
        <p1>
            © 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.
        </p1>
    </footer>
</body>
</html>
