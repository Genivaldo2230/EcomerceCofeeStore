package DAO;

import br.com.gymcontrol.Model.Cliente;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.text.SimpleDateFormat;

public class ClienteDAO {
    public static boolean isEmailCadastrado(String email) {
        String SQL = "SELECT COUNT(*) FROM CLIENTE WHERE email = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, email);

            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);

            return count > 0;

        } catch (Exception e) {
            System.out.println("Erro ao verificar e-mail cadastrado: " + e.getMessage());
            return false;
        }
    }

    public boolean CadastrarCliente(Cliente CadastrarCliente) {
        String SQL = "INSERT INTO Cliente (nomeCompleto, email, dataNascimento, genero, cpf, senha, cepFaturamento, logradouroFaturamento, numeroFaturamento, complementoFaturamento, bairroFaturamento, cidadeFaturamento, ufFaturamento) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";


        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {


            String email = CadastrarCliente.getEmail();

            if (isEmailCadastrado(email)) {
                return false; // Indica que o e-mail já está cadastrado
            }
            String hashedSenha = BCrypt.hashpw(CadastrarCliente.getSenha(), BCrypt.gensalt());
            preparedStatement.setString(1, CadastrarCliente.getNomeCompleto());
            preparedStatement.setString(2, CadastrarCliente.getEmail());

            preparedStatement.setDate(3, CadastrarCliente.getDataNascimento());

            preparedStatement.setString(4, CadastrarCliente.getGenero());

            preparedStatement.setString(5, CadastrarCliente.getCpf());
            preparedStatement.setString(6, hashedSenha);
            preparedStatement.setString(7, CadastrarCliente.getCepFaturamento());
            preparedStatement.setString(8, CadastrarCliente.getLogradouroFaturamento());
            preparedStatement.setInt(9, CadastrarCliente.getNumeroFaturamento());
            preparedStatement.setString(10, CadastrarCliente.getComplementoFaturamento());
            preparedStatement.setString(11, CadastrarCliente.getBairroFaturamento());
            preparedStatement.setString(12, CadastrarCliente.getCidadeFaturamento());
            preparedStatement.setString(13, CadastrarCliente.getUfFaturamento());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Falha ao cadastrar o cliente, nenhum registro foi alterado.");
            }

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int idCliente = generatedKeys.getInt(1);
                    CadastrarCliente.setId(idCliente);
                } else {
                    throw new SQLException("Falha ao obter o ID do cliente, nenhum ID foi gerado.");
                }
            }

            return true; // Indica que o cadastro foi bem-sucedido

        } catch (Exception e) {
            System.out.println("Erro ao cadastrar o usuário: " + e.getMessage());
            return false;

        }
    }

    public static boolean validarCPF(String cpf) {
// Remova caracteres não numéricos do CPF
        cpf = cpf.replaceAll("[^0-9]", "");

        // Verifique se o CPF tem 11 dígitos
        if (cpf.length() != 11) {
            return false;
        }

        // Verifique se todos os dígitos são iguais (CPF inválido)
        boolean todosDigitosIguais = true;
        for (int i = 1; i < 11; i++) {
            if (cpf.charAt(i) != cpf.charAt(0)) {
                todosDigitosIguais = false;
                break;
            }
        }
        if (todosDigitosIguais) {
            return false;
        }

        // Cálculo dos dígitos verificadores
        int soma = 0;
        for (int i = 0; i < 9; i++) {
            soma += (10 - i) * (cpf.charAt(i) - '0');
        }
        int primeiroDigitoVerificador = 11 - (soma % 11);
        if (primeiroDigitoVerificador >= 10) {
            primeiroDigitoVerificador = 0;
        }

        soma = 0;
        for (int i = 0; i < 10; i++) {
            soma += (11 - i) * (cpf.charAt(i) - '0');
        }
        int segundoDigitoVerificador = 11 - (soma % 11);
        if (segundoDigitoVerificador >= 10) {
            segundoDigitoVerificador = 0;
        }

        // Verifique se os dígitos verificadores calculados correspondem aos dígitos do CPF
        return primeiroDigitoVerificador == (cpf.charAt(9) - '0')
                && segundoDigitoVerificador == (cpf.charAt(10) - '0');
    }

    public static boolean cpfExistente(String cpf) {
        String SQL = "SELECT COUNT(*) FROM Cliente WHERE CPF = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, cpf);

            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);

            return count > 0;

        } catch (Exception e) {
            System.out.println("Erro ao verificar e-o cpf cadastrado: " + e.getMessage());
            return false;
        }
    }

    public Cliente getClienteByEmail(String email) {
        String SQL = "SELECT * FROM Cliente WHERE email = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, email);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String nomeCompleto = resultSet.getString("nomeCompleto");
                String cpf = resultSet.getString("cpf");
                Date dataNascimento = resultSet.getDate("dataNascimento");
                String genero = resultSet.getString("genero");


                String senha = resultSet.getString("senha");
                String cepFaturamento = resultSet.getString("cepFaturamento");
                String logradouroFaturamento = resultSet.getString("logradouroFaturamento");
                int numeroFaturamento = resultSet.getInt("numeroFaturamento");
                String complementoFaturamento = resultSet.getString("complementoFaturamento");
                String bairroFaturamento = resultSet.getString("bairroFaturamento");
                String cidadeFaturamento = resultSet.getString("cidadeFaturamento");
                String ufFaturamento = resultSet.getString("ufFaturamento");
                int idEnderecoPadrao = resultSet.getInt("idEnderecoPadrao");



                return new Cliente(id, nomeCompleto, email, dataNascimento, genero, cpf, senha, cepFaturamento, logradouroFaturamento, numeroFaturamento, complementoFaturamento, bairroFaturamento, cidadeFaturamento, ufFaturamento, idEnderecoPadrao);
            }

        } catch (Exception e) {
            System.out.println("Erro ao buscar cliente por email: " + e.getMessage());
        }

        return null;
    }

    public boolean atualizarCliente(Cliente cliente) {
        String hashedSenha = BCrypt.hashpw(cliente.getSenha(), BCrypt.gensalt());

        String SQL = "UPDATE Cliente SET nomeCompleto=?, genero=?, senha=?,  dataNascimento=? WHERE id=?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, cliente.getNomeCompleto());
            preparedStatement.setString(2, cliente.getGenero());
            preparedStatement.setString(3, hashedSenha);

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            preparedStatement.setDate(4, cliente.getDataNascimento());

            preparedStatement.setInt(5, cliente.getId());

            int affectedRows = preparedStatement.executeUpdate();

            return affectedRows > 0;
        } catch (Exception e) {
            System.out.println("Erro ao atualizar o cliente: " + e.getMessage());
            return false;
        }
    }

    public boolean atualizarCliente2(Cliente cliente) {
        String hashedSenha = BCrypt.hashpw(cliente.getSenha(), BCrypt.gensalt());

        String SQL = "UPDATE Cliente SET nomeCompleto=?, genero=?, dataNascimento=? WHERE id=?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, cliente.getNomeCompleto());
            preparedStatement.setString(2, cliente.getGenero());

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            preparedStatement.setDate(3, cliente.getDataNascimento());

            preparedStatement.setInt(4, cliente.getId());

            int affectedRows = preparedStatement.executeUpdate();

            return affectedRows > 0;
        } catch (Exception e) {
            System.out.println("Erro ao atualizar o cliente: " + e.getMessage());
            return false;
        }
    }

    public static Cliente obterClientePorID(int idCliente) {
        String SQL = "SELECT * FROM Cliente WHERE id = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, idCliente);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setId(resultSet.getInt("id"));
                    cliente.setNomeCompleto(resultSet.getString("idEnderecoPadrao"));

                    return cliente;
                }
            }

        } catch (Exception e) {
            System.out.println("Erro ao obter cliente por ID: " + e.getMessage());
        }

        return null; // Retorna null caso não encontre o cliente com o ID especificado
    }
}
