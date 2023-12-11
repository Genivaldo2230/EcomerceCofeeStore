package Servlet;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.gymcontrol.Model.ItemCarrinho;

@WebServlet("/atualizarQuantidade")
public class AtualizarQuantidadeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int produtoID = Integer.parseInt(request.getParameter("produtoID"));
        int novaQuantidade = Integer.parseInt(request.getParameter("novaQuantidade"));

        ArrayList<ItemCarrinho> carrinho = (ArrayList<ItemCarrinho>) request.getSession().getAttribute("carrinho");

        for (ItemCarrinho item : carrinho) {
            if (item.getProduto().getProdutoID() == produtoID) {
                item.setQuantidade(novaQuantidade);
                break;
            }
        }

        request.getSession().setAttribute("carrinho", carrinho);
        response.getWriter().write("Quantidade atualizada com sucesso!");
    }
}
