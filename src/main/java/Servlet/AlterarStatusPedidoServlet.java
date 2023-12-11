package Servlet;

import DAO.PedidoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AlterarStatusPedidoServlet")
public class AlterarStatusPedidoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idPedido = Integer.parseInt(request.getParameter("idPedido"));
        String novoStatus = request.getParameter("novoStatus");

        PedidoDAO pedidoDAO = new PedidoDAO();
        pedidoDAO.atualizarStatus(idPedido, novoStatus);

        // Redireciona de volta para a página de listagem de pedidos
        response.sendRedirect("/listarPedidos");
    }
}
