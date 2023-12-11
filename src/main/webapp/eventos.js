const INPUT_BUSCA = document.getElementById('input-busca');
const TABELA_USUARIOS = document.getElementById('tabela-usuarios');

INPUT_BUSCA.addEventListener('keyup', () => {
    let expressao = INPUT_BUSCA.value.toLowerCase();

    if (expressao.length === 1) {
        return;
    }

    let linhas = TABELA_USUARIOS.getElementsByTagName('tr');

    for (let posicao in linhas) {
        if (true === isNaN(posicao)) {
            continue;
        }

        let nome = linhas[posicao].querySelector('.editable.Nome').textContent.toLowerCase();

        if (true === nome.includes(expressao)) {
            linhas[posicao].style.display = '';
        } else {
            linhas[posicao].style.display = 'none';
        }
    }
});


const EDIT_BUTTONS = document.querySelectorAll('.edit-button');
const SAVE_BUTTONS = document.querySelectorAll('.save-button');
const EDITABLE_FIELDS = document.querySelectorAll('.editable');

for (let i = 0; i < EDIT_BUTTONS.length; i++) {
    EDIT_BUTTONS[i].addEventListener('click', () => {
        const rowId = EDIT_BUTTONS[i].closest('tr').id;
        const nomeInput = document.querySelector(`#${rowId} .editable.nome`);
        const grupoInput = document.querySelector(`#${rowId} .editable.grupo`);

        nomeInput.removeAttribute('disabled');
        grupoInput.removeAttribute('disabled');

        SAVE_BUTTONS.forEach(button => {
            button.disabled = true;
        });
        SAVE_BUTTONS[i].disabled = false;

        const form = EDIT_BUTTONS[i].parentNode.querySelector('.edit-form');
        form.querySelector('.input-nome').value = nomeInput.value;
        form.querySelector('.input-grupo').value = grupoInput.value;
    });

    SAVE_BUTTONS[i].addEventListener('click', () => {
        const rowId = EDIT_BUTTONS[i].closest('tr').id;
        const nomeInput = document.querySelector(`#${rowId} .editable.nome`);
        const grupoInput = document.querySelector(`#${rowId} .editable.grupo`);

        const form = EDIT_BUTTONS[i].parentNode.querySelector('.edit-form');
        const nomeHiddenInput = form.querySelector('.input-nome');
        const grupoHiddenInput = form.querySelector('.input-grupo');

        nomeHiddenInput.value = nomeInput.value;
        grupoHiddenInput.value = grupoInput.value;

        form.submit();
        window.location.href = "/ListarUsuarioBackOffice.jsp";
    });
}


