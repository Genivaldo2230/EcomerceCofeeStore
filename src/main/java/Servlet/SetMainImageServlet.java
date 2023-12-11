package Servlet;

import DAO.ProdutosDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet("/SetMainImageServlet")
public class SetMainImageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String imageUrl = request.getParameter("imageUrl");
        int produtoID = Integer.parseInt(request.getParameter("produtoID"));

        // Atualize o banco de dados com a nova imagem principal
        ProdutosDAO produtosDAO = new ProdutosDAO();
        produtosDAO.setImagePath(produtoID, imageUrl);

        // Responda com sucesso (200 OK)
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
