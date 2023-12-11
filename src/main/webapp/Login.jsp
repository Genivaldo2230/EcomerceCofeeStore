<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="css/Login.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <title>Login</title>
</head>

<body>
<div id="container">
    <div id="logo">
        <h1><i> BREWMASTERS CAFÉ.</i></h1>
    </div>
    <section class="stark-login">
        <form action="Login" method="post">
            <div id="fade-box">
                <input type="text" name="email" id="email" placeholder="Username" required>
                <div class="password-container">
                    <input type="password" id="senha" name="senha" placeholder="Password" required>
                    <label for="showPassword" id="showPasswordLabel">
                        <input type="checkbox" id="showPassword">
                        <span class="show-password-icon"><i class="far fa-eye"></i></span>
                    </label>
                </div>
    <form action="/ListarTop8Produtos" method="GET">
    <button type="submit">Login</button>
    </form>
    </div>
        </form>
        <div id="circle1">
            <div id="inner-cirlce1">
                <h1></h1>
            </div>
        </div>

        <div id="error-popup" class="error-popup">
            <div class="error-popup-content">
                <span id="error-message"></span>
                <button id="close-error-popup">Fechar</button>
            </div>
        </div>
        <script>
            <% if (request.getParameter("error") != null) { %>
            // Erro de credenciais inválidas
            var errorMessage = "Credenciais inválidas. Tente novamente.";
            showErrorPopup(errorMessage);
            <% } %>

            <% if (request.getParameter("error2") != null) { %>
            // Erro de usuário inativo
            var errorMessage = "Usuário inativo, contacte um administrador.";
            showErrorPopup(errorMessage);
            <% } %>

            function showErrorPopup(message) {
                document.getElementById("error-message").textContent = message;
                document.getElementById("error-popup").style.display = "block";
            }

            document.getElementById("close-error-popup").addEventListener("click", function () {
                document.getElementById("error-popup").style.display = "none";
            });
        </script>

        <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </section>



<footer>
    <p1>&copy; 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</p1>
</footer>
</div>
<script>
    const pwd = document.getElementById("senha");
    const showPasswordCheckbox = document.getElementById("showPassword");
    showPasswordCheckbox.addEventListener("change", function () {
        pwd.type = showPasswordCheckbox.checked ? "text" : "password";
    });
</script>

</body>
</html>
