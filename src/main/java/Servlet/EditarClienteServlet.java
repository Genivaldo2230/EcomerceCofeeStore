package Servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.EnderecoDAO;
import br.com.gymcontrol.Model.Cliente;
import DAO.ClienteDAO;
import br.com.gymcontrol.Model.Endereco;

@WebServlet("/EditarClienteServlet")
public class EditarClienteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cliente cliente = (Cliente) session.getAttribute("cliente");

        request.setAttribute("cliente", cliente);
        request.getRequestDispatcher("AlterarDadosCliente.jsp").forward(request, response);
        System.out.println("Cliente na sessão: " + cliente);

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nomeCompleto = request.getParameter("nomeCompleto");
        String dataNascimentoStr = request.getParameter("dataNascimento");
        java.sql.Date sqlDate = java.sql.Date.valueOf(dataNascimentoStr);
        String genero = request.getParameter("genero");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmarSenha");

        HttpSession session = request.getSession();
        Cliente cliente = (Cliente) session.getAttribute("cliente");
        cliente.setNomeCompleto(nomeCompleto);
        cliente.setDataNascimento(sqlDate);
        cliente.setGenero(genero);

        ClienteDAO clienteDAO = new ClienteDAO();

        try {
            if (senha.isEmpty()) {
                // Atualizar sem a senha
                clienteDAO.atualizarCliente2(cliente);
            } else if (senha.equals(confirmarSenha)) {
                // Senhas coincidem, atualizar com a nova senha
                cliente.setSenha(senha);
                clienteDAO.atualizarCliente(cliente);
            } else {
                // Senhas não coincidem
                request.setAttribute("error", "As senhas não coincidem.");
                request.getRequestDispatcher("AlterarDadosCliente.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Trate outras exceções aqui, se necessário
        }

        response.sendRedirect(request.getContextPath() + "/");
    }


}