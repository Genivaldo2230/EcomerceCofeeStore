package Servlet;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.EnderecoDAO;
import DAO.ProdutosDAO;
import br.com.gymcontrol.Model.Endereco;
import br.com.gymcontrol.Model.ItemCarrinho;
import br.com.gymcontrol.Model.Produtos;

@WebServlet("/ResumoPedidoServlet")
public class ResumoPedidoServlet extends HttpServlet {
    private static final String TOTAL_COM_FRETE_ATTR = "totalComFrete";
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Coletar os detalhes do pedido, produtos, quantidades, valores, endereço de entrega, forma de pagamento, etc.
        // Normalmente, esses dados podem ser obtidos da sessão ou do banco de dados, dependendo de como você gerencia os pedidos.

        // Exemplo de coleta de dados da sessão (ajuste conforme sua implementação):
        HttpSession session = request.getSession();
        ArrayList<ItemCarrinho> carrinho = (ArrayList<ItemCarrinho>) session.getAttribute("carrinho");
        String enderecoDeEntrega = (String) session.getAttribute("enderecoDeEntrega");
        String formaDePagamento = (String) session.getAttribute("formaDePagamento");
        String formaPagamento = request.getParameter("formaPagamento");

        // Salvando a forma de pagamento na sessão
        session = request.getSession();
        session.setAttribute("formaDePagamento", formaPagamento);

        // Recuperar o valor total com frete da sessão usando a constante
        Double totalComFrete = (Double) session.getAttribute(TOTAL_COM_FRETE_ATTR);

        // Imprimir o valor para verificar se está correto
        System.out.println("Valor total com frete: " + totalComFrete);
        String enderecoSelecionadoId = request.getParameter("enderecoSelecionadoId");
        System.out.println("id do endereço selecionado:" + enderecoSelecionadoId);
        Endereco enderecoSelecionado = EnderecoDAO.obterEnderecoPeloId(enderecoSelecionadoId);

// Adicionar o endereço à solicitação para que possa ser acessado no JSP
        request.setAttribute("enderecoSelecionado", enderecoSelecionado);
        // ... Coletar outras informações relevantes

        // Verificar se o carrinho não está vazio
        if (carrinho == null || carrinho.isEmpty()) {
            // Lidar com um carrinho vazio, talvez redirecionando para uma página de erro
            response.sendRedirect("CarrinhoVazio.jsp");
            return;
        }

        // Realizar cálculos necessários, como somar os totais
        double totalGeral = calcularTotalGeral(carrinho);

        // Definir os atributos na solicitação para que a página JSP possa acessar esses dados
        request.setAttribute("itensDoPedido", carrinho);
        request.setAttribute("totalGeral", totalGeral);
        request.setAttribute("enderecoDeEntrega", enderecoDeEntrega);
        request.setAttribute("formaDePagamento", formaDePagamento);
        request.setAttribute("itensCarrinho", carrinho); // Adicione esta linha



        // Encaminhar para a página de resumo do pedido
        request.getRequestDispatcher("ResumoPedido.jsp").forward(request, response);

    }

    // Método para calcular o total geral do pedido
    private double calcularTotalGeral(ArrayList<ItemCarrinho> carrinho) {
        double total = 0.0;

        for (ItemCarrinho item : carrinho) {
            total += item.getSubtotal();
        }

        // Adicione o cálculo do frete e outros custos, se aplicável
        // total += calcularFrete(enderecoDeEntrega);
        // total += calcularCustosExtras(formaDePagamento);

        return total;
    }
}
