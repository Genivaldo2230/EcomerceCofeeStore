package Servlet;

import DAO.EnderecoDAO;
import DAO.ProdutosDAO;
import br.com.gymcontrol.Model.Cliente;
import br.com.gymcontrol.Model.Endereco;
import br.com.gymcontrol.Model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListarEnderecosCliente")
public class EnderecosClienteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cliente cliente = (Cliente) request.getSession().getAttribute("cliente");

        if (cliente == null) {
            // Se o cliente não está logado, redirecionar para a tela de login
            response.sendRedirect("LoginCliente.jsp");
            return; // Importante retornar para evitar a execução do código abaixo
        }

        int idCliente = cliente.getId();


        EnderecoDAO enderecoDAO = new EnderecoDAO();
        List<Endereco> enderecos = enderecoDAO.obterEnderecosCliente(idCliente);
        request.setAttribute("cliente" , cliente);
        request.setAttribute("enderecos2", enderecos);

        request.getRequestDispatcher("ListarEnderecosCliente.jsp").forward(request, response);
    }
}