package Servlet;

import DAO.ProdutosDAO;
import br.com.gymcontrol.Model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

    @WebServlet("/AvaliacaoServlet")
    public class AvaliacaoServlet extends HttpServlet {

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            int produtoID = Integer.parseInt(request.getParameter("produtoID"));

            ProdutosDAO produtoDAO = new ProdutosDAO();
            Produtos produto = produtoDAO.obterProdutoPorID(produtoID);

            double avaliacao = produto.getAvaliacao();

            // Redirecionar para a página de agradecimento
            response.sendRedirect("VisualizarImagem.jsp");
        }
}
