<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" %>
<head>
    <style>
        body {
            width: 100vw;
            height: 100vh;
            margin: 0;
            padding: 0;
        }

        #container {
            width: 100%;
            height: 55em;
            margin: 0px;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.38);
            overflow: hidden;
        }

        a {
            display: block;
            height: 56px;
            width: 233px;
            margin: -15em auto;
            text-align: center;
            padding: 10px;
            background-color: #07ff00;
            color: #270606;
            text-decoration: none;
            border-radius: 49px;
            z-index: 1;
            font-size: 1.8em;
            font-family: monospace;
            font-weight: 700;
        }

        a:hover {
            background-color: #0056b3;
        }

        #counter {
            font-size: 36px;
            margin-top: 50px;
        }

        #buttons {
            margin-top: 20px;
        }


        #video-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        #overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background-color: rgb(0 0 0 / 73%); /* Cor preta com opacidade de 0.5 */
        }
h1{
    display: grid;
    margin-top: 0;
    font-size: 3.5em;
    font-weight: 600;
    font-family: cursive;
    font-size: 36px;
    color: #fff;
    align-content: center;
}

        h2 {
            font-size: 36px;
            color: #fff;
            z-index: 1;
            display: block;
            font-size: 3.5em;
            margin-block-start: 0.67em;
            margin-block-end: 0.67em;
            margin-inline-start: 0;
            margin-inline-end: 0em;
            font-weight: 600;
            font-family: cursive;
        }

        #countdown {
            font-size: 24px;
            color: #007bff;
        }
        p {
            display: block;
            color: #ffffff;
            font-family: "Cabin", helvetica, arial, sans-serif;
            font-size: 0.8em;
            font-weight: 600;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
        }
        footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            text-align: center;
            background-color: #3b1e0a;
        }


    </style>
</head>
<body>
<div id="container">
    <h2>Site em Construção</h2>
</div>

<div class="content">
    <h1>BREWMASTERS CAFÉ</h1>


    <div id="countdown"></div>
    <a href="Login.jsp">Acesso Develop Contrutor</a>
    <!--<a href="ListaDeUsuario.jsp">Link para a página principal</a>-->


<video autoplay muted loop id="video-background">
    <source src="img/videoIndex/fundoIdex.mp4" type="video/mp4">
    Seu navegador não suporta vídeos em HTML5.
</video>

</div>
<footer>
    <p>&copy; 2023 BREWMASTERS CAFÉ. Todos os direitos reservados.</p>
</footer>
</body>
</html>



