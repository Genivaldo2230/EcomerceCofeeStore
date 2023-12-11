package Servlet;

import br.com.gymcontrol.Model.ItemCarrinho;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/removerDoCarrinho")
public class RemoverDoCarrinhoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int produtoID = Integer.parseInt(request.getParameter("produtoID"));

        ArrayList<ItemCarrinho> carrinho = (ArrayList<ItemCarrinho>) request.getSession().getAttribute("carrinho");

        if (carrinho != null) {
            // Encontra o item correspondente e remove do carrinho
            for (int i = 0; i < carrinho.size(); i++) {
                if (carrinho.get(i).getProduto().getProdutoID() == produtoID) {
                    carrinho.remove(i);
                    break;
                }
            }
        }

        response.sendRedirect("Carrinho.jsp");
    }
}
