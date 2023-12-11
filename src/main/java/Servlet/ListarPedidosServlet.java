package Servlet;

import DAO.PedidoDAO;
import Model.Pedido;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/listarPedidos")
public class ListarPedidosServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PedidoDAO pedidoDAO = new PedidoDAO();
        List<Pedido> pedidos = pedidoDAO.listarPedidos();


        request.setAttribute("pedidos", pedidos);
        request.setAttribute("statusList", Arrays.asList("Aguardando Pagamento", "Pagamento Rejeitado", "Pagamento com Sucesso", "Aguardando Retirada", "Em Trânsito", "Entregue"));
        request.getRequestDispatcher("ListarPedidos.jsp").forward(request, response);
    }

}
