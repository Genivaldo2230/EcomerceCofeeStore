<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/ListarEnderecoCliente.css">
    <title>Endereços do Cliente</title>
</head>
<body>
    <div class="center-box">
        <li class="menu-logo">
            <img src="img/Logo de cafe.png">
            <h1>BREWMASTERS O SHOPPING DO CAFE</h1>
        </li>
        <hr>
        <h1>Endereços do Cliente</h1>
        <form action="AlterarStatusEndereco" method="post">
            <c:forEach var="endereco" items="${enderecos2}">
                <p><strong>ID:</strong> ${endereco.id}</p>
                <p><strong>CEP:</strong> ${endereco.cep}</p>
               <c:choose>
                   <c:when test="${endereco.id == cliente.idEnderecoPadrao}">
                       <input type="radio" name="enderecoPadraoId" value="${endereco.id}" checked="checked"> Tornar Padrão
                   </c:when>
                   <c:otherwise>
                       <input type="radio" name="enderecoPadraoId" value="${endereco.id}"> Tornar Padrão
                   </c:otherwise>
               </c:choose>

                <label for="logradouro">Logradouro:</label>
                <input type="text" id="logradouro" name="logradouro" value="${endereco.logradouro}">
                <br>
                <label for="numero">Número:</label>
                <input type="text" id="numero" name="numero" value="${endereco.numero}">
                <br>
                <label for="complemento">Complemento:</label>
                <input type="text" id="complemento" name="complemento" value="${endereco.complemento}">
                <br>
                <label for="bairro">Bairro:</label>
                <input type="text" id="bairro" name="bairro" value="${endereco.bairro}">
                <br>
                <label for="cidade">Cidade:</label>
                <input type="text" id="cidade" name="cidade" value="${endereco.cidade}">
                <br>
                <label for="uf">UF:</label>
                <input type="text" id="uf" name="uf" value="${endereco.uf}">
                
                <p><button class="custom-button" type="submit" name="excluir" value="${endereco.id}">Excluir</button></p>
                
                
                <hr>
            </c:forEach>
            <input type="submit" value="Enviar" class="styled-button">
        </form>
    </div>
</body>
</html>
