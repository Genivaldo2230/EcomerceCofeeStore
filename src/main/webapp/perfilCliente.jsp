<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Perfil do Cliente</title>
</head>
<body>
    <h1>Perfil do Cliente</h1>
    <c:if test="${cliente != null}">
        <p><strong>ID:</strong> ${cliente.id}</p>
        <p><strong>Nome Completo:</strong> ${cliente.nomeCompleto}</p>
        <p><strong>Email:</strong> ${cliente.email}</p>
        <p><strong>CPF:</strong> ${cliente.cpf}</p>
        <p><strong>CEP de Faturamento:</strong> ${cliente.cepFaturamento}</p>
        <p><strong>Logradouro de Faturamento:</strong> ${cliente.logradouroFaturamento}</p>
        <p><strong>Número de Faturamento:</strong> ${cliente.numeroFaturamento}</p>
        <p><strong>Complemento de Faturamento:</strong> ${cliente.complementoFaturamento}</p>
        <p><strong>Bairro de Faturamento:</strong> ${cliente.bairroFaturamento}</p>
        <p><strong>Cidade de Faturamento:</strong> ${cliente.cidadeFaturamento}</p>
        <p><strong>UF de Faturamento:</strong> ${cliente.ufFaturamento}</p>
                <p><strong>Id endereço padrão:</strong> ${cliente.idEnderecoPadrao}</p>

        <form action="LogoutServlet" method="post">
            <input type="submit" value="Logout">
        </form>
    </c:if>




</body>
</html>
