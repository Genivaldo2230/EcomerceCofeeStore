package Servlet;

import DAO.PedidoDAO;
import Model.Pedido;
import br.com.gymcontrol.Model.Cliente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/pedidos")
public class MeusPedidosServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("carrinho");

        Cliente cliente = (Cliente) session.getAttribute("cliente");

        // Verificar se o cliente está autenticado
        if (cliente != null) {
            int clienteId = cliente.getId();

            // Obter a lista de pedidos para o cliente específico
            List<Pedido> pedidos = new PedidoDAO(/* Sua conexão com o banco de dados */).getPedidosByClienteId(clienteId);

            if (pedidos != null && !pedidos.isEmpty()) {
                // Adicionar a lista ao escopo da requisição
                request.setAttribute("pedidos", pedidos);

                for (Pedido pedido : pedidos) {
                    System.out.println("ID do Pedido: " + pedido.getId());
                }

                // Encaminhar para o JSP
                request.getRequestDispatcher("/Historico.jsp").forward(request, response);
            } else {
                // Adicionar uma mensagem de erro ao escopo da requisição
                request.setAttribute("mensagem", "Nenhum pedido encontrado para este cliente.");

                // Encaminhar para o JSP
                request.getRequestDispatcher("/Historico.jsp").forward(request, response);
            }

        } else {
            // Redirecionar para a página de login se o cliente não estiver autenticado
            response.sendRedirect("LoginCliente.jsp");
        }
    }
}
