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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListarEnderecosCheckout")
public class ListarEnderecoCheckout extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cliente cliente = (Cliente) request.getSession().getAttribute("cliente");

        if (cliente == null) {
            // Se o cliente não está logado, redirecionar para a tela de login
            response.sendRedirect("LoginCliente.jsp");
            return; // Importante retornar para evitar a execução do código abaixo
        }
        Double teste = (Double) request.getSession().getAttribute("totalComFrete");
        System.out.println("Teste: no listar ende " + teste);
        int idCliente = cliente.getId();
        HttpSession session = request.getSession();
        Double totalComFrete = (Double) session.getAttribute("totalAtualizado");
        System.out.println(totalComFrete);
        // Salvar o valor total com frete na sessão
        session.setAttribute("totalComFrete", totalComFrete);
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        List<Endereco> enderecos = enderecoDAO.obterEnderecosCliente(idCliente);
        request.setAttribute("cliente" , cliente);
        request.setAttribute("enderecos2", enderecos);
        session.setAttribute("totalComFrete", teste);

        request.getRequestDispatcher("EnderecoCheckout.jsp").forward(request, response);
    }
}

