package Servlet;

import DAO.UsuarioBackOfficeDAO;
import br.com.gymcontrol.Model.UsuarioBackOffice;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static DAO.UsuarioBackOfficeDAO.validarCPF;

@WebServlet("/CadastrarUsuarioBackOffice")
public class CadastrarUsuarioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String grupo = request.getParameter("grupo");
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        String cpfComMascara = request.getParameter("CPF");

        // Remover caracteres não numéricos do CPF
        String cpfSemMascara = cpfComMascara.replaceAll("\\D", "");


        String confirmarSenha = request.getParameter("confirmarSenha");

        if (!senha.equals(confirmarSenha)) {
            request.setAttribute("mensagemAlerta", "As senhas não coincidem. Por favor, verifique novamente.");
            request.getRequestDispatcher("CadastrarUsuarioBackOffice.jsp").forward(request, response);
            return;
        }
        // Validação do CPF
        if (!validarCPF(cpfSemMascara)) {
            request.setAttribute("mensagemAlerta", "CPF inválido. Por favor, insira um CPF válido.");
            request.getRequestDispatcher("CadastrarUsuarioBackOffice.jsp").forward(request, response);
            return;
        }

        if (UsuarioBackOfficeDAO.cpfExistente(cpfSemMascara)) {
            request.setAttribute("mensagemAlerta", "CPF já cadastrado.");
            request.getRequestDispatcher("CadastrarUsuarioBackOffice.jsp").forward(request, response);
            return;
        }

        UsuarioBackOffice userBackOffice = new UsuarioBackOffice();
        userBackOffice.setNome(nome);
        userBackOffice.setEmail(email);
        userBackOffice.setSenha(senha);
        userBackOffice.setGrupo(grupo);
        userBackOffice.setStatus(status);
        userBackOffice.setCPF(cpfSemMascara);

        UsuarioBackOfficeDAO usuarioDAO = new UsuarioBackOfficeDAO();
        boolean cadastroSucesso = usuarioDAO.CadastrarUsuarioBackOffice(userBackOffice);

        if (cadastroSucesso) {
            request.setAttribute("mensagemSucesso", "Usuário cadastrado com sucesso!");
        } else {
            request.setAttribute("mensagemAlerta", "E-mail já cadastrado. Por favor, escolha outro e-mail.");
        }

        request.getRequestDispatcher("CadastrarUsuarioBackOffice.jsp").forward(request, response);
    }
}
