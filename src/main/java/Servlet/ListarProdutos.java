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

@WebServlet("/ListarProdutos_2")
public class ListarProdutos extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        int produtosPorPagina = 10;
        int paginaAtual = 1;

        String paginaParam = request.getParameter("page");
        if (paginaParam != null && !paginaParam.isEmpty()) {
            paginaAtual = Integer.parseInt(paginaParam);
        }

        int offset = (paginaAtual - 1) * produtosPorPagina;
        List<Produtos> produtos;

        if (searchTerm != null && !searchTerm.isEmpty()) {
            produtos = ProdutosDAO.buscarProdutosPorTermoPaginado(searchTerm, offset, produtosPorPagina);
        } else {
            produtos = ProdutosDAO.listarProdutosPaginados(offset, produtosPorPagina);
        }

        int pageCount = ProdutosDAO.calcularPageCount(produtosPorPagina, searchTerm);

        request.setAttribute("produtos", produtos);
        request.setAttribute("pageCount", pageCount);
        request.setAttribute("paginaAtual", paginaAtual);
        request.setAttribute("searchTerm", searchTerm);

        request.getRequestDispatcher("ListarProdutos.jsp").forward(request, response);
    }
}

