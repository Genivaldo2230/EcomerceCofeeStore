package Servlet;

import DAO.ProdutosDAO;
import br.com.gymcontrol.Model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/VisualizarImagemServlet")
public class VisualizarImagemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtém o ID do produto da solicitação
        int produtoID = Integer.parseInt(request.getParameter("produtoID"));

        // Carrega o objeto Produto com a lista de URLs das imagens
        ProdutosDAO produtoDAO = new ProdutosDAO();
        Produtos produto = produtoDAO.obterProdutoPorID(produtoID);

        if (produto != null) {
            // Obtém a lista de URLs das imagens com base no ID do produto
            List<String> imageUrls = produtoDAO.obterUrlsImagensPorProdutoID(produtoID);

            // Define a lista de URLs das imagens no objeto Produto
            produto.setImagens(imageUrls);

            // Define o objeto Produto como atributo da solicitação
            request.setAttribute("produto", produto);

            // Encaminha a solicitação para a página VisualizarImagem.jsp
            request.getRequestDispatcher("/VisualizarImagem.jsp").forward(request, response);
        } else {
            // Produto não encontrado, redireciona de volta para a lista de produtos
            response.sendRedirect("/ListarProdutos.jsp");
        }
    }
}
