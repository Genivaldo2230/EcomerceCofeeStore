package Servlet;

import DAO.ProdutosDAO;
import br.com.gymcontrol.Model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.*;
import java.util.List;

@WebServlet("/ListarTop8Produtos")
public class ListarTop8ProdutosServlet extends HttpServlet {

            protected void doGet(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {

                ProdutosDAO produtoDAO = new ProdutosDAO();
                List<Produtos> produtos = produtoDAO.listarTop8ProdutosAtivos();

                    request.setAttribute("Produtos", produtos);

                    request.getRequestDispatcher("PrincipalCliente.jsp").forward(request, response);
        }

    }
