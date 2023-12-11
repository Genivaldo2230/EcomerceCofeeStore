package DAO;

import br.com.gymcontrol.Model.Produtos;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static java.lang.System.out;

public class ProdutosDAO {
    public void atualizarQuantidadeEstoque(int produtoID, int novaQuantidadeEstoque) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

            // SQL para atualizar a quantidade em estoque do produto
            String sql = "UPDATE produtos SET qtdEstoque = ? WHERE produtoID = ?";

            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, novaQuantidadeEstoque);
            stmt.setInt(2, produtoID);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Trate qualquer exceção de banco de dados apropriada aqui
        } finally {

        }
    }

    public BigDecimal obterPrecoUnitario(int produtoID) {
        String SQL = "SELECT precoProduto FROM Produtos WHERE produtoID = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, produtoID);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getBigDecimal("precoProduto");
            } else {
                return null; // Retorna null se o produto não for encontrado
            }

        } catch (SQLException e) {
            System.out.println("Erro ao obter preço unitário do produto por ID: " + e.getMessage());
            return null;
        }
    }

    public Produtos obterProdutoPorID(int produtoID) {
        String SQL = "SELECT * FROM Produtos WHERE produtoID = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, produtoID);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String nomeProduto = resultSet.getString("nomeProduto");
                boolean statusProduto = resultSet.getBoolean("statusProduto");
                double avaliacao = resultSet.getDouble("avaliacao");
                String descricaoDetalhada = resultSet.getString("descricaoDetalhada");
                double precoProduto = resultSet.getDouble("precoProduto");
                int quantidadeEstoque = resultSet.getInt("qtdEstoque");
                String imagePATH = resultSet.getString("ImagePATH");

                Produtos produto = new Produtos(produtoID, nomeProduto, statusProduto, avaliacao, descricaoDetalhada, precoProduto, quantidadeEstoque);
                produto.setImagePATH(imagePATH);

                System.out.println("Deu bom pegar os dados do produto pelo id");
                return produto;
            } else {
                return null; // Retorna null se o produto não for encontrado
            }

        } catch (SQLException e) {
            System.out.println("Erro ao obter produto por ID: " + e.getMessage());
            return null;
        }
    }


    public static List<Produtos> listarProdutosPaginados(int offset, int produtosPorPagina) {
        String SQL = "SELECT * FROM Produtos ORDER BY produtoID DESC LIMIT ? OFFSET ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, produtosPorPagina);
            preparedStatement.setInt(2, offset);

            ResultSet resultSet = preparedStatement.executeQuery();

            List<Produtos> produtos = new ArrayList<>();

            while (resultSet.next()) {

                int produtoID = resultSet.getInt("produtoID");
                String nomeProduto = resultSet.getString("nomeProduto");
                boolean statusProduto = resultSet.getBoolean("statusProduto");
                double avaliacao = resultSet.getDouble("avaliacao");
                String descricaoDetalhada = resultSet.getString("descricaoDetalhada");
                double precoProduto = resultSet.getDouble("precoProduto");
                int quantidadeEstoque = resultSet.getInt("qtdEstoque");


                Produtos produtosAdc = new Produtos(produtoID, nomeProduto, statusProduto, avaliacao, descricaoDetalhada, precoProduto, quantidadeEstoque);

                produtos.add(produtosAdc);

            }

            out.println("success in select * Produtos");

            connection.close();

            return produtos;

        } catch (SQLException e) {
            System.out.println("Erro ao buscar produtos paginados: " + e.getMessage());
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public List<String> obterUrlsImagensPorProdutoID(int produtoID) {
        List<String> imageUrls = new ArrayList<>();
        String SQL = "SELECT caminhoImagem FROM ImagensProduto WHERE idProduto = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, produtoID);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                String imageUrl = resultSet.getString("caminhoImagem");
                imageUrls.add(imageUrl);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao obter URLs das imagens: " + e.getMessage());
        }

        return imageUrls;
    }
    public void inserirCaminhoImagem2(int idProduto, String caminhoImagem) {
        String SQL = "INSERT INTO ImagensProduto (idProduto, caminhoImagem) VALUES (?, ?)";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, idProduto);
            preparedStatement.setString(2, caminhoImagem);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao inserir caminho da imagem: " + e.getMessage());
        }
    }
    public void setImagePath(int produtoID, String imageUrl) {
        String SQL = "UPDATE Produtos SET ImagePath = ? WHERE produtoID = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, imageUrl);
            preparedStatement.setInt(2, produtoID);

            int rowsUpdated = preparedStatement.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Imagem principal atualizada com sucesso.");
            } else {
                System.out.println("Nenhuma imagem principal foi atualizada.");
            }

        } catch (SQLException e) {
            System.out.println("Erro ao atualizar imagem principal: " + e.getMessage());
        }
    }

    public void deletarImagem(int produtoID, String imageUrl) {
        String SQL = "DELETE FROM ImagensProduto WHERE idProduto = ? AND caminhoImagem = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, produtoID);
            preparedStatement.setString(2, imageUrl);

            int rowsDeleted = preparedStatement.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("Imagem excluída com sucesso.");
            } else {
                System.out.println("Nenhuma imagem foi excluída.");
            }

        } catch (SQLException e) {
            System.out.println("Erro ao excluir imagem: " + e.getMessage());
        }

    }
    public void inserirCaminhoImagem(int idProduto, String caminhoImagem) {
        String SQL = "INSERT INTO ImagensProduto (idProduto, caminhoImagem) VALUES (?, ?)";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, idProduto);
            preparedStatement.setString(2, caminhoImagem);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao inserir caminho da imagem: " + e.getMessage());
        }
    }



    public void inserirProduto(Produtos novoProduto) {
        String SQL = "INSERT INTO Produtos (NomeProduto, StatusProduto, Avaliacao, DescricaoDetalhada, PrecoProduto, QtdEstoque, ImagePATH) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, novoProduto.getNomeProduto());
            preparedStatement.setBoolean(2, novoProduto.isStatusProduto());
            preparedStatement.setDouble(3, novoProduto.getAvaliacao());
            preparedStatement.setString(4, novoProduto.getDescricaoDetalhada());
            preparedStatement.setDouble(5, novoProduto.getPrecoProduto());
            preparedStatement.setInt(6, novoProduto.getQtdEstoque());
            preparedStatement.setString(7, novoProduto.getImagePATH()); // Adicione o campo ImagemPrincipal aqui

            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows == 0) {
                System.out.println("Inserção de produto falhou, nenhum registro foi adicionado.");
            } else {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int novoProdutoID = generatedKeys.getInt(1);
                    novoProduto.setProdutoID(novoProdutoID);
                    System.out.println("Produto inserido com sucesso. Novo ID do produto: " + novoProdutoID);
                } else {
                    System.out.println("Inserção de produto falhou, nenhum ID foi retornado.");
                }
            }

        } catch (SQLException e) {
            System.out.println("Erro ao inserir produto: " + e.getMessage());
        }
    }
    public void atualizarProduto(Produtos produto) {
        String SQL = "UPDATE Produtos SET NomeProduto=?, StatusProduto=?, Avaliacao=?, DescricaoDetalhada=?, PrecoProduto=?, QtdEstoque=? WHERE ProdutoID=?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, produto.getNomeProduto());
            preparedStatement.setBoolean(2, produto.isStatusProduto());
            preparedStatement.setDouble(3, produto.getAvaliacao());
            preparedStatement.setString(4, produto.getDescricaoDetalhada());
            preparedStatement.setDouble(5, produto.getPrecoProduto());
            preparedStatement.setInt(6, produto.getQtdEstoque());
            preparedStatement.setInt(7, produto.getProdutoID());

            int rowsUpdated = preparedStatement.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Produto atualizado com sucesso.");
            } else {
                System.out.println("Nenhum produto foi atualizado.");
            }
        } catch (SQLException e) {
            System.out.println("Erro ao atualizar o produto: " + e.getMessage());
        }
    }

    public static void updateStatusProduto(int produtoID, boolean novoStatus) {
        String SQL = "UPDATE Produtos SET statusProduto = ? WHERE produtoID = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setBoolean(1, novoStatus);
            preparedStatement.setInt(2, produtoID);
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected == 1) {
                System.out.println("Status do produto atualizado com sucesso.");
            } else {
                System.out.println("Nenhum produto foi atualizado.");
            }

        } catch (SQLException e) {
            System.out.println("Erro ao atualizar status do produto: " + e.getMessage());
        }
    }


    public static int calcularPageCount(int produtosPorPagina, String searchTerm) {
        String SQL = "SELECT COUNT(*) FROM Produtos";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();
            int totalProdutos = resultSet.getInt(1);
            return (int) Math.ceil((double) totalProdutos / produtosPorPagina);

        } catch (SQLException e) {
            System.out.println("Erro ao calcular pageCount: " + e.getMessage());
            return 0; // Ou outro valor padrão, se ocorrer um erro
        }
    }

    public static List<Produtos> listarTop8ProdutosAtivos() {
        String SQL = "SELECT * FROM Produtos WHERE statusProduto = TRUE ORDER BY ProdutoID DESC";
        //aqui voce escolhe a quantidade de itens que retornar na pagina principal
        List<Produtos> produtos = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int produtoID = resultSet.getInt("produtoID");
                String nomeProduto = resultSet.getString("nomeProduto");
                boolean statusProduto = resultSet.getBoolean("statusProduto");
                double avaliacao = resultSet.getDouble("avaliacao");
                String descricaoDetalhada = resultSet.getString("descricaoDetalhada");
                double precoProduto = resultSet.getDouble("precoProduto");
                int quantidadeEstoque = resultSet.getInt("qtdEstoque");

                String imagePATH = resultSet.getString("ImagePATH");

                Produtos produto = new Produtos(produtoID, nomeProduto, statusProduto, avaliacao, descricaoDetalhada, precoProduto, quantidadeEstoque);
                produto.setImagePATH(imagePATH);
                produtos.add(produto);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao obter produtos: " + e.getMessage());
        }

        return produtos;
    }


    public static List<Produtos> buscarProdutosPorTermoPaginado(String termoDeBusca, int offset, int produtosPorPagina) {
        String SQL = "SELECT * FROM Produtos WHERE nomeProduto LIKE ? LIMIT ? OFFSET ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setString(1, "%" + termoDeBusca + "%");
            preparedStatement.setInt(2, produtosPorPagina);
            preparedStatement.setInt(3, offset);

            ResultSet resultSet = preparedStatement.executeQuery();

            List<Produtos> produtos = new ArrayList<>();

            while (resultSet.next()) {
                int produtoID = resultSet.getInt("produtoID");
                String nomeProduto = resultSet.getString("nomeProduto");
                boolean statusProduto = resultSet.getBoolean("statusProduto");
                double avaliacao = resultSet.getDouble("avaliacao");
                String descricaoDetalhada = resultSet.getString("descricaoDetalhada");
                double precoProduto = resultSet.getDouble("precoProduto");
                int quantidadeEstoque = resultSet.getInt("qtdEstoque");
                String imagePATH = resultSet.getString("ImagePATH");

                Produtos produto = new Produtos(produtoID, nomeProduto, statusProduto, avaliacao, descricaoDetalhada, precoProduto, quantidadeEstoque);
                produto.setImagePATH(imagePATH);

                produtos.add(produto);
            }

            return produtos;

        } catch (SQLException e) {
            System.out.println("Erro ao buscar produtos por termo paginado: " + e.getMessage());
            return Collections.emptyList();
        }
    }

    public int obterQuantidadeDisponivel(int produtoID) {
        String SQL = "SELECT qtdEstoque FROM Produtos WHERE produtoID = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, produtoID);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int quantidadeEstoque = resultSet.getInt("qtdEstoque");
                return quantidadeEstoque;
            } else {
                return -1; // Retorna -1 se o produto não for encontrado
            }

        } catch (SQLException e) {
            System.out.println("Erro ao obter quantidade disponível do produto por ID: " + e.getMessage());
            return -1;
        }
    }

}

