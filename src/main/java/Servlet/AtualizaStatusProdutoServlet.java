package Servlet;

import DAO.ProdutosDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AtualizaStatusProdutoServlet")

public class AtualizaStatusProdutoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)  {
        int produtoId = Integer.parseInt(request.getParameter("produtoId"));
        boolean novoStatus = Boolean.parseBoolean(request.getParameter("novoStatus"));

        ProdutosDAO.updateStatusProduto(produtoId, novoStatus);

        // Enviar uma resposta de sucesso
        response.setStatus(HttpServletResponse.SC_OK);
    }
}


