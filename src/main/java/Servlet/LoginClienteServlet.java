package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import br.com.gymcontrol.Model.Cliente;
import DAO.ClienteDAO;
import org.mindrot.jbcrypt.BCrypt;
@WebServlet("/LoginClienteServlet")
public class LoginClienteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        ClienteDAO clienteDAO = new ClienteDAO();
        Cliente cliente = clienteDAO.getClienteByEmail(email);

        if (cliente != null && BCrypt.checkpw(senha, cliente.getSenha())) {
            // Login bem-sucedido
            HttpSession session = request.getSession();
            session.setAttribute("cliente", cliente);

            // Redirecionar para a página de perfil do cliente ou qualquer outra página desejada
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Login falhou, redirecionar de volta para a página de login com uma mensagem de erro
            request.setAttribute("mensagemErro", "Credenciais inválidas. não localizamos o usuário e/ou senha. Tente novamente.");
            request.getRequestDispatcher("LoginCliente.jsp").forward(request, response);
        }
    }
}
