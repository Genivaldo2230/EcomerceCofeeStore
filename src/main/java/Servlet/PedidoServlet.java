package Servlet;

import DAO.PedidoDAO;
import DAO.ProdutosDAO; // Certifique-se de importar a classe ProdutoDAO
import Model.ItemPedido;
import Model.Pedido;
import br.com.gymcontrol.Model.Cliente;
import br.com.gymcontrol.Model.ItemCarrinho;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/PedidoServlet")
public class PedidoServlet extends HttpServlet {
    private static final String TOTAL_COM_FRETE_ATTR = "totalComFrete";
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Recupera os parâmetros do pedido do request
            HttpSession session = request.getSession();
            Cliente cliente = (Cliente) session.getAttribute("cliente");
            int clienteId = cliente.getId();
            String status = request.getParameter("status");
            Double teste = (Double) session.getAttribute(TOTAL_COM_FRETE_ATTR);

// Cria um BigDecimal a partir do valor Double, tratando o caso em que teste é null
            BigDecimal valorTotal = teste != null ? new BigDecimal(teste.toString()) : BigDecimal.ZERO;
            System.out.println(teste);

            String enderecoDeEntrega = (String) session.getAttribute("enderecoSelecionadoId");
            System.out.println("Sem converter "+ enderecoDeEntrega);
            int enderecoEntregaId = Integer.parseInt(enderecoDeEntrega);
            System.out.println("Sem converter "+enderecoDeEntrega);
            System.out.println("convertido "+enderecoEntregaId);
            String formaPagamento = (String) session.getAttribute("formaDePagamento");

            // Crie uma instância de Pedido com os parâmetros recuperados
            Pedido pedido = new Pedido(clienteId, status, valorTotal, enderecoEntregaId, formaPagamento);

            // Recupera os itens do pedido do carrinho (sessão)
            ArrayList<ItemCarrinho> itensCarrinho = (ArrayList<ItemCarrinho>) session.getAttribute("carrinho");

            // Adiciona os itens do pedido à instância de Pedido
            pedido.setItensPedido(itensCarrinho);

            // Crie uma instância do seu DAO (PedidoDAO) e chame um método para salvar o pedido no banco de dados
            PedidoDAO pedidoDAO = new PedidoDAO();
            int pedidoId = pedidoDAO.salvarPedido(pedido);

            // Atualiza o pedido no banco de dados com os itens
            pedidoDAO.atualizarItensPedido(pedido);

            // Redireciona para a página de confirmação ou outra página desejada
            response.sendRedirect("/pedidos");
        } catch (Exception e) {
            e.printStackTrace();
            // Trate a exceção conforme necessário e redirecione para uma página de erro
            response.sendRedirect("erro.jsp");
        }
    }
}
