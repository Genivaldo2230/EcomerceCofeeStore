package Servlet;

import DAO.EnderecoDAO;
import br.com.gymcontrol.Model.Cliente;
import DAO.ClienteDAO;
import br.com.gymcontrol.Model.Endereco;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static DAO.ClienteDAO.isEmailCadastrado;
import static DAO.ClienteDAO.validarCPF;
@WebServlet("/CadastrarClienteServlet")
public class CadastrarClienteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cliente cliente = new Cliente();
        EnderecoDAO enderecoDAO = new EnderecoDAO();

        String nomeCompleto = request.getParameter("nomeCompleto");
        String email = request.getParameter("email");

        if (ClienteDAO.isEmailCadastrado(email)) {
            request.setAttribute("mensagemAlertaEmail", "E-mail já cadastrado. Por favor, escolha outro e-mail.");
            request.getRequestDispatcher("CadastrarCliente.jsp").forward(request, response);

            return; // Encerra o processo se o e-mail já estiver cadastrado
        }
        String dataNascimentoStr = request.getParameter("dataNascimento");

        java.sql.Date sqlDate = java.sql.Date.valueOf(dataNascimentoStr);


        String genero = request.getParameter("genero");


        String cpfComMascara = request.getParameter("cpf");
        String senha = request.getParameter("senha");


        String cepComMascara = request.getParameter("cepFaturamento");
        String cepSemMascara = cepComMascara.replaceAll("\\D", ""); // Remove todos os caracteres não numéricos

        if (cepSemMascara.length() != 8) {
            // Trate o erro aqui, por exemplo, enviando uma mensagem de erro para o cliente
            response.getWriter().write("Erro: O CEP deve conter exatamente 8 dígitos.");
            return;
        }
        String logradouroFaturamento = request.getParameter("logradouroFaturamento");
        int numeroFaturamento = Integer.parseInt(request.getParameter("numeroFaturamento"));
        String complementoFaturamento = request.getParameter("complementoFaturamento");
        String bairroFaturamento = request.getParameter("bairroFaturamento");
        String cidadeFaturamento = request.getParameter("cidadeFaturamento");
        String ufFaturamento = request.getParameter("ufFaturamento");

        String cpfSemMascara = cpfComMascara.replaceAll("\\D", "");

        String confirmarSenha = request.getParameter("confirmarSenha");

        if (!senha.equals(confirmarSenha)) {
            request.setAttribute("mensagemAlerta", "As senhas não coincidem. Por favor, verifique novamente.");
            request.getRequestDispatcher("CadastrarCliente.jsp").forward(request, response);
            return;
        }

        if (!validarCPF(cpfSemMascara)) {
            request.setAttribute("mensagemAlerta", "CPF inválido. Por favor, insira um CPF válido.");
            request.getRequestDispatcher("CadastrarCliente.jsp").forward(request, response);
            return;
        }


        if (ClienteDAO.cpfExistente(cpfSemMascara)) {
            request.setAttribute("mensagemAlerta", "CPF já cadastrado.");
            request.getRequestDispatcher("CadastrarCliente.jsp").forward(request, response);
            return;
        }


        cliente.setNomeCompleto(nomeCompleto);
        cliente.setEmail(email);
        cliente.setCpf(cpfSemMascara);
        cliente.setDataNascimento(sqlDate);
        cliente.setGenero(genero);
        cliente.setSenha(senha);
        cliente.setCepFaturamento(cepSemMascara);
        cliente.setLogradouroFaturamento(logradouroFaturamento);
        cliente.setNumeroFaturamento(numeroFaturamento);
        cliente.setComplementoFaturamento(complementoFaturamento);
        cliente.setBairroFaturamento(bairroFaturamento);
        cliente.setCidadeFaturamento(cidadeFaturamento);
        cliente.setBairroFaturamento(bairroFaturamento);
        cliente.setUfFaturamento(ufFaturamento);

        ClienteDAO clienteDAO = new ClienteDAO();
        boolean cadastroSucesso = clienteDAO.CadastrarCliente(cliente);
        int idCliente = cliente.getId();
//        Endereco enderecoPadrao = new Endereco(cepFaturamento, logradouroFaturamento, numeroFaturamento, complementoFaturamento, bairroFaturamento, cidadeFaturamento, ufFaturamento, 0, idCliente);
        if (cadastroSucesso) {
            enderecoDAO.inserirEnderecoInicial(cepSemMascara, logradouroFaturamento, numeroFaturamento, complementoFaturamento, bairroFaturamento, cidadeFaturamento, ufFaturamento, idCliente);

            int idEnderecoPadrao = enderecoDAO.pegaIdEndereçoPadrão(cliente.getId());
            enderecoDAO.atualizarIdEnderecoPadrao(idCliente, idEnderecoPadrao);


        }

        if (cadastroSucesso) {
            List<Endereco> enderecosAdicionais = new ArrayList<>();

            String[] cepsAdicionais = request.getParameterValues("cepAdicional");
            String[] logradourosAdicionais = request.getParameterValues("logradouroAdicional");
            String[] numerosAdicionais = request.getParameterValues("numeroAdicional");
            String[] complementosAdicionais = request.getParameterValues("complementoAdicional");
            String[] bairrosAdicionais = request.getParameterValues("bairroAdicional");
            String[] cidadesAdicionais = request.getParameterValues("cidadeAdicional");
            String[] ufsAdicionais = request.getParameterValues("ufAdicional");

            if (cepsAdicionais != null) {
                for (int i = 0; i < cepsAdicionais.length; i++) {
                    Endereco endereco = new Endereco();

                    // Remover caracteres especiais do CEP
                    String cepAdicionalSemMascara = cepsAdicionais[i].replaceAll("\\D", "");
                    if (cepAdicionalSemMascara.length() != 8) {
                        request.setAttribute("mensagemAlerta", "Erro: O CEP deve conter exatamente 8 dígitos.");
                        request.getRequestDispatcher("CadastrarCliente.jsp").forward(request, response);
                        return;
                    }

                    endereco.setCep(cepAdicionalSemMascara);
                    endereco.setLogradouro(logradourosAdicionais[i]);
                    endereco.setNumero(Integer.parseInt(numerosAdicionais[i]));
                    endereco.setComplemento(complementosAdicionais[i]);
                    endereco.setBairro(bairrosAdicionais[i]);
                    endereco.setCidade(cidadesAdicionais[i]);
                    endereco.setUf(ufsAdicionais[i]);
                    endereco.setEnderecoAtivo(true);
                    // Adicione o ID do cliente aos endereços adicionais
                    endereco.setIdCliente(cliente.getId());

                    // Adicione o endereço à lista
                    enderecosAdicionais.add(endereco);
                }

                boolean sucessoEnderecos = enderecoDAO.inserirEnderecos(enderecosAdicionais);

                if (sucessoEnderecos) {
                    request.getRequestDispatcher("LoginCliente.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensagemAlerta", "Erro ao cadastrar os endereços.");
                    request.getRequestDispatcher("CadastrarCliente.jsp").forward(request, response);
                }
            } else {
                request.getRequestDispatcher("LoginCliente.jsp").forward(request, response);
            }
        }
    }
}