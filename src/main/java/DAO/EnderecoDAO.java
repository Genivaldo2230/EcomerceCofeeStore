package DAO;
import br.com.gymcontrol.Model.Endereco;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
public class EnderecoDAO {
    public int pegaIdEndereçoPadrão(int idCliente) {
        int idPadrão = -1;
        String SQL = "SELECT id FROM Endereco WHERE idCliente = ?;";
        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, idCliente);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                idPadrão = resultSet.getInt("id");
            } else {
                System.out.println("Nenhum resultado encontrado para o cliente com ID: " + idCliente);
            }
            return idPadrão;
        } catch (Exception e) {
            System.out.println("Erro ao pegar o endereço principal : " + e.getMessage());
        }
        return idPadrão;
    }
    public void inserirEnderecoInicial(String cepFaturamento, String logradouroFaturamento, int numeroFaturamento, String complementoFaturamento, String bairroFaturamento, String cidadeFaturamento, String ufFaturamento, int idCliente) {
        String SQL = "INSERT INTO Endereco (cep, logradouro, numero, complemento, bairro, cidade, uf, enderecoAtivo, idCliente) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        System.out.println("essa é a id do cliente" + idCliente);
        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setString(1, cepFaturamento);
            preparedStatement.setString(2, logradouroFaturamento);
            preparedStatement.setInt(3, numeroFaturamento);
            preparedStatement.setString(4, complementoFaturamento);
            preparedStatement.setString(5, bairroFaturamento);
            preparedStatement.setString(6, cidadeFaturamento);
            preparedStatement.setString(7, ufFaturamento);
            preparedStatement.setBoolean(8, true);
            preparedStatement.setInt(9, idCliente);
            preparedStatement.executeUpdate();  // Usar executeUpdate em vez de executeBatch
            System.out.println("sucesso cadastrando o endereço inicial/principal");
        } catch (Exception e) {
            System.out.println("Erro ao cadastrar o endereço inicial principal: " + e.getMessage());
        }
    }
    public boolean atualizarIdEnderecoPadrao(int clienteId, int novoIdEnderecoPadrao) {
        String updateQuery = "UPDATE Cliente SET idEnderecoPadrao = ? WHERE id = ?";
        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa")){
            PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
            preparedStatement.setInt(1, novoIdEnderecoPadrao);
            preparedStatement.setInt(2, clienteId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Lide com exceções apropriadamente
        }
        return false;
    }
    public boolean inserirEnderecos(List<Endereco> enderecos) {
        String SQL = "INSERT INTO Endereco (cep, logradouro, numero, complemento, bairro, cidade, uf, enderecoAtivo, idCliente) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            for (Endereco endereco : enderecos) {
                preparedStatement.setString(1, endereco.getCep());
                preparedStatement.setString(2, endereco.getLogradouro());
                preparedStatement.setInt(3, endereco.getNumero());
                preparedStatement.setString(4, endereco.getComplemento());
                preparedStatement.setString(5, endereco.getBairro());
                preparedStatement.setString(6, endereco.getCidade());
                preparedStatement.setString(7, endereco.getUf());
                preparedStatement.setBoolean(8, true);
                preparedStatement.setInt(9, endereco.getIdCliente());
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
            return true;
        } catch (Exception e) {
            System.out.println("Erro ao cadastrar os endereços: " + e.getMessage());
            return false;
        }
    }
    public static List<Endereco> obterEnderecosCliente(int IdCliente) {
        String sql = "SELECT * FROM Endereco WHERE IdCliente = ? AND enderecoAtivo = true";
        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, IdCliente);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Endereco> enderecos = new ArrayList<>();
            while (resultSet.next()) {
                int idEndereco = resultSet.getInt("id");
                String cep = resultSet.getString("cep");
                String logradouro = resultSet.getString("logradouro");
                int numero = resultSet.getInt("numero");
                String complemento = resultSet.getString("complemento");
                String bairro = resultSet.getString("bairro");
                String cidade = resultSet.getString("cidade");
                String uf = resultSet.getString("uf");
                boolean enderecoAtivo = resultSet.getBoolean("enderecoAtivo");
                int idCliente = resultSet.getInt("IdCliente");
                Endereco enderecos_envio = new Endereco(idEndereco, cep, logradouro, numero, complemento, bairro, cidade, uf, enderecoAtivo, idCliente);
                enderecos.add(enderecos_envio);
            }
            System.out.println("success in select * Produtos");
            connection.close();
            return enderecos;
        } catch (SQLException e) {
            System.out.println("Erro ao buscar produtos paginados: " + e.getMessage());
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public boolean alterarStatusEndereco(int enderecoId, boolean novoStatus) {
        String sql = "UPDATE Endereco SET enderecoAtivo = false WHERE id = ?";
        System.out.println("entrou no DAO" + enderecoId);
        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            System.out.println("aqui está a id na parte da DAO" + enderecoId);
            preparedStatement.setInt(1, enderecoId);
            int linhasAfetadas = preparedStatement.executeUpdate();
            return linhasAfetadas > 0;
        } catch (SQLException e) {
            System.out.println("Erro ao alterar status do endereço: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    public static Endereco obterEnderecoPeloId(String enderecoId) {
        // Lógica para consultar o banco de dados e retornar o endereço com base no ID
        // Use a classe PreparedStatement para evitar SQL injection

        // Exemplo:
        String sql = "SELECT * FROM Endereco WHERE id = ?";
        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, enderecoId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Mapear os dados do ResultSet para um objeto Endereco
                Endereco endereco = new Endereco();
                endereco.setId(resultSet.getInt("id"));
                endereco.setCep(resultSet.getString("cep"));
                endereco.setLogradouro(resultSet.getString("logradouro"));
                endereco.setNumero(resultSet.getInt("numero"));
                endereco.setComplemento(resultSet.getString("complemento"));
                endereco.setBairro(resultSet.getString("bairro"));
                endereco.setCidade(resultSet.getString("cidade"));
                endereco.setUf(resultSet.getString("uf"));
                endereco.setEnderecoAtivo(resultSet.getBoolean("enderecoAtivo"));
                endereco.setIdCliente(resultSet.getInt("idCliente"));

                return endereco;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // Se não encontrar o endereço
    }

    public boolean adicionarEnderecos(int clienteId, List<Endereco> enderecos) {
        PreparedStatement preparedStatement = null;
        try { Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
            // Crie uma instrução SQL para inserir um endereço
            String sql = "INSERT INTO endereco (cliente_id, cep, logradouro, numero, complemento, bairro, cidade, uf) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            for (Endereco endereco : enderecos) {
                preparedStatement.setInt(1, clienteId);
                preparedStatement.setString(2, endereco.getCep());
                preparedStatement.setString(3, endereco.getLogradouro());
                preparedStatement.setInt(4, endereco.getNumero());
                preparedStatement.setString(5, endereco.getComplemento());
                preparedStatement.setString(6, endereco.getBairro());
                preparedStatement.setString(7, endereco.getCidade());
                preparedStatement.setString(8, endereco.getUf());
                preparedStatement.addBatch(); // Adicione a instrução à batch
            }
            // Execute a batch de inserção
            preparedStatement.executeBatch();
            return true; // Sucesso
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Falha
        } finally {
            // Feche a conexão e o preparedStatement
            // Lide com exceções, se necessário
        }
    }
    public void adicionarEndereco(int clienteId, Endereco endereco) {
        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa")){
            String sql = "INSERT INTO Endereco (cep, logradouro, numero, complemento, bairro, cidade, uf, enderecoAtivo, idCliente) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, endereco.getCep());
            preparedStatement.setString(2, endereco.getLogradouro());
            preparedStatement.setInt(3, endereco.getNumero());
            preparedStatement.setString(4, endereco.getComplemento());
            preparedStatement.setString(5, endereco.getBairro());
            preparedStatement.setString(6, endereco.getCidade());
            preparedStatement.setString(7, endereco.getUf());
            preparedStatement.setBoolean(8, true); // Defina o valor apropriado para "enderecoAtivo"
            preparedStatement.setInt(9, clienteId);
            preparedStatement.executeUpdate();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}