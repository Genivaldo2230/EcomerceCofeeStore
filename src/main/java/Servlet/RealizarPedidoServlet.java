package Servlet;


import DAO.PedidoDAO;
import Model.Pedido;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RealizarPedidoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Coletar dados do pedido (itens, valor total, status, cliente, etc.)
        // Calcular o valor total do pedido
        // Criar uma instância de Pedido com os dados
        Pedido pedido = new Pedido();
        // Definir os valores do pedido

        // Usar o PedidoDAO para inserir o pedido no banco de dados
        PedidoDAO pedidoDAO = new PedidoDAO();
        pedidoDAO.salvarPedido(pedido);

        // Mostrar uma mensagem na tela com o número do pedido e informações
        // Redirecionar para a página de confirmação do pedido
    }
}
