<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=0.8">
    <meta name="description" content="Gerenciamento de Usuários do Sistema">

    <title>Gerenciamento de Usuários Lista UsuariosOFC</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/ListarUsuario2.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
          rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
          crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

</head>


<body>

<div class="slideshow-container">
    <img class="slideshow-image active" src="img/Fundo2.jpg" alt="Imagem de fundo">
    <img class="slideshow-image" src="img/Fundo3.jpg" alt="Imagem de fundo">
    <img class="slideshow-image" src="img/Fundo5.jpg" alt="Imagem de fundo">
</div>
<ul class="menu">
    <li class="menu-logo">
        <img src="img/Logo de cafe.png" alt="Logo do café">
        <h1>BEM-VINDO AO BREWMASTERS CAFÉ.BACKOFFICE</h1>
    </li>

    <li><a href="Principal.jsp">Voltar </a></li>
</ul>
<title>Gerenciamento de Usuários</title>


<div class="container">
    <div class="card card-body mt-5" style="background-color:rgb(55 49 40 / 79%);">

        <div class="container">
            <h1 style="color: #c16315; display: inline-block;background-color:rgb(55 49 40 / 79%);">Gerenciamento de
                Usuários do Sistema</h1>
            <button onclick="window.location.href='CadastrarUsuarioBackOffice.jsp'" class="btn-cadastra"
                    style="float: right;">
                <i class="fas fa-user-plus"></i> Cadastrar novo usuário
            </button>


            <input id="input-busca" type="text" class="form-control mt-3 mb-3" placeholder="O que você procura?">

            <table class="table table-hover table-striped" style="background-color:white;">
                <thead class=" table-dark">
                <tr>
                    <th>#ID</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Habilitar/Desabilitar</th>
                    <th>Grupo</th>
                    <th>Editar</th>
                </tr>
                </thead>

                <tbody id="tabela-usuarios">
                <c:forEach var="UsuarioBackOffice" items="${UsuarioBackOffice}" varStatus="loop">
                    <tr class="editable-row" id="row-${loop.index}">
                        <td>
                            <text>${UsuarioBackOffice.ID}</text>
                        </td>
                        <td>
                            <text>${UsuarioBackOffice.nome}</text>
                        </td>
                        <td>
                            <text>${UsuarioBackOffice.email}</text>
                        </td>
                        <td>
                            <text>
                                    ${UsuarioBackOffice.status ? 'Ativo' : 'Inativo'}
                            </text>
                        </td>

                        <td>
                            <label class="switch">
                                <input type="checkbox"
                                    ${UsuarioBackOffice.status ? 'checked' : ''}
                                       onchange="confirmarAtualizacaoStatus(${UsuarioBackOffice.ID}, this.checked)">
                                <span class="slider round"></span>
                            </label>


                        </td>
                        <td>
                            <text>${UsuarioBackOffice.grupo}</text>
                        </td>
                        <td>
                            <a href="EditarUsuarioBackOffice.jsp?userID=${UsuarioBackOffice.ID}&nome=${UsuarioBackOffice.nome}&cpf=${UsuarioBackOffice.CPF}&grupo=${UsuarioBackOffice.grupo}"
                               class="btn btn-primary">Editar</a>
                        </td>


                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>


</div>

<script src="eventos_ofc.js"></script>
<script>
    function confirmarAtualizacaoStatus(usuarioId, novoStatus) {
        var confirmacao = confirm("Deseja realmente alterar o status do usuário?");

        if (confirmacao) {
            atualizarStatus(usuarioId, novoStatus);

            var sliderSpan = document.querySelector(`#row-${usuarioId} .slider`);
            sliderSpan.classList.toggle("green", novoStatus);
            sliderSpan.classList.toggle("red", !novoStatus);
        } else {
            var checkbox = document.querySelector(`#row-${usuarioId} input[type="checkbox"]`);
            checkbox.checked = !novoStatus;
        }
    }


    function atualizarStatus(usuarioId, novoStatus) {
        // Criação do objeto XMLHttpRequest
        var xhttp = new XMLHttpRequest();

        // Configuração da função de callback para quando a resposta for recebida
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                // Atualizar a página após a atualização do status
                window.location.reload();
            }
        };

        // Abertura da requisição POST para o servlet responsável por atualizar o status
        xhttp.open("POST", "ToggleStatusServlet?userId=" + usuarioId + "&newStatus=" + novoStatus, true);
        xhttp.send();
    }

    function alterarCorDoSwitch(usuarioId, novoStatus) {
        var switchElement = document.querySelector(`#row-${usuarioId} .slider`);
        if (novoStatus) {
            switchElement.classList.add('green');
            switchElement.classList.remove('red');
        } else {
            switchElement.classList.add('red');
            switchElement.classList.remove('green');
        }
    }

</script>

<footer>
    <p1>&copy; 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</p1>
</footer>


</body>
</html>

