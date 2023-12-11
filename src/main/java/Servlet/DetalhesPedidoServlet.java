package Servlet;

import DAO.PedidoDAO;
import Model.PedidoDetalhes;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/detalhesPedido")
public class DetalhesPedidoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pedidoId = Integer.parseInt(request.getParameter("pedidoId"));//resgata valor id do pedido

        PedidoDAO pedidoDAO = new PedidoDAO();
        PedidoDetalhes detalhes = pedidoDAO.obterDetalhesPedido(pedidoId);//metodo

        request.setAttribute("detalhes", detalhes);//set o objeto detalhes

        request.getRequestDispatcher("DetalhesPedido.jsp").forward(request, response);//nesse ele receber toda lista do pedido
    }
}
