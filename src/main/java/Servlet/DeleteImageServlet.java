package Servlet;

import DAO.ProdutosDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/DeleteImageServlet")
public class DeleteImageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String imageUrl = request.getParameter("imageUrl");
        int produtoID = Integer.parseInt(request.getParameter("produtoID"));

        // Chame o método para deletar a imagem no banco de dados
        ProdutosDAO produtosDAO = new ProdutosDAO();
        produtosDAO.deletarImagem(produtoID, imageUrl);

        // Responda com sucesso (200 OK)
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
