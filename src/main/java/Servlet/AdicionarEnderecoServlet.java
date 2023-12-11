package Servlet;

import DAO.EnderecoDAO;
import br.com.gymcontrol.Model.Endereco;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;@WebServlet("/AdicionarEnderecoServlet")
public class AdicionarEnderecoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupere os parâmetros do request para cada endereço adicionado
        String[] ceps = request.getParameterValues("cepAdicional");
        String[] logradouros = request.getParameterValues("logradouroAdicional");
        String[] numeros = request.getParameterValues("numeroAdicional");
        String[] complementos = request.getParameterValues("complementoAdicional");
        String[] bairros = request.getParameterValues("bairroAdicional");
        String[] cidades = request.getParameterValues("cidadeAdicional");
        String[] ufs = request.getParameterValues("ufAdicional");

        // Recupere o ID do cliente da sessão ou de onde quer que ele venha
        int clienteId = Integer.parseInt(request.getParameter("clienteId"));

        // Instancie a classe DAO
        EnderecoDAO enderecoDAO = new EnderecoDAO();

        // Para cada endereço adicionado, crie um objeto Endereco e insira no banco de dados
        for (int i = 0; i < ceps.length; i++) {
            String cepsSemMascara = ceps[i].replaceAll("\\D", "");
            Endereco endereco = new Endereco();
            endereco.setCep(cepsSemMascara);
            endereco.setLogradouro(logradouros[i]);
            endereco.setNumero(Integer.parseInt(numeros[i]));
            endereco.setComplemento(complementos[i]);
            endereco.setBairro(bairros[i]);
            endereco.setCidade(cidades[i]);
            endereco.setUf(ufs[i]);
            endereco.setIdCliente(clienteId);

            // Chame o método da DAO para inserir o endereço no banco de dados
            enderecoDAO.adicionarEndereco(clienteId, endereco);
        }

        // Redirecione para a página de sucesso ou outra página apropriada
        response.sendRedirect(request.getContextPath() + "/");
    }
}