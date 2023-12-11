 function irParaPagina(pagina) {
                var novaURL = window.location.href.split('?')[0] + '?page=' + pagina;
                window.location.href = novaURL;
            }


 function confirmarAtualizacaoStatus(produtoId, novoStatus) {
     var confirmacao = confirm("Deseja realmente alterar o status do produto?");

     if (confirmacao) {
         atualizarStatusProduto(produtoId, novoStatus);

         var switchElement = document.querySelector(`#row-${produtoId} .slider`);
         switchElement.classList.toggle("green", novoStatus);
         switchElement.classList.toggle("red", !novoStatus);
     } else {
         var checkbox = document.querySelector(`#row-${produtoId} input[type="checkbox"]`);
         checkbox.checked = !novoStatus;
     }
 }


    function atualizarStatusProduto(produtoId, novoStatus) {
        // Criação do objeto XMLHttpRequest
        var xhttp = new XMLHttpRequest();

        // Configuração da função de callback para quando a resposta for recebida
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                // Atualizar a página após a atualização do status
                window.location.reload();
            }
        };

        // Abertura da requisição POST para o servlet responsável por atualizar o status do produto
        xhttp.open("POST", "AtualizaStatusProdutoServlet?produtoId=" + produtoId + "&novoStatus=" + novoStatus, true);
        xhttp.send();
    }

    const modal = document.querySelector('.modal-container')

    function openModal() {
      modal.classList.add('active')
    }

    function closeModal() {
      modal.classList.remove('active')
    }
