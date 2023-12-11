package Servlet;
import DAO.ClienteDAO;
import DAO.EnderecoDAO;
import br.com.gymcontrol.Model.Cliente;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/AlterarStatusEndereco")
public class AlterarStatusEnderecoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0); // Proxies.

        EnderecoDAO enderecoDAO = new EnderecoDAO();
        String enderecoPadraoId = request.getParameter("enderecoPadraoId");

        if (enderecoPadraoId != null) {
            int idEnderecoPadrao = Integer.parseInt(enderecoPadraoId);
            HttpSession session = request.getSession();
            Cliente cliente = (Cliente) session.getAttribute("cliente");
            int idLogado = cliente.getId();
            boolean sucesso = enderecoDAO.atualizarIdEnderecoPadrao(idLogado, idEnderecoPadrao);
            if (sucesso) {
                // Atualiza o cliente na sessão após a alteração
                cliente.setIdEnderecoPadrao(idEnderecoPadrao);
                session.setAttribute("cliente", cliente);
            }
        }

        String[] enderecosExcluir = request.getParameterValues("excluir");
        if (enderecosExcluir != null) {
            for (String enderecoIdString : enderecosExcluir) {
                int enderecoId = Integer.parseInt(enderecoIdString);
                boolean sucesso2 = enderecoDAO.alterarStatusEndereco(enderecoId, false);

                if (!sucesso2) {
                    response.getWriter().println("Erro ao alterar o status do endereço.");
                }
            }
        }
        Cliente cliente = (Cliente) request.getSession().getAttribute("cliente");
        request.setAttribute("cliente" , cliente);
        response.sendRedirect(request.getContextPath() + "/");

    }
}