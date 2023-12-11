package DAO;

import br.com.gymcontrol.Model.UsuarioBackOffice;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;


import static java.lang.System.out;

public class UsuarioBackOfficeDAO {
    public static List<br.com.gymcontrol.Model.UsuarioBackOffice> listarUsuarios() {
        String SQL = "SELECT * FROM UsuarioBackOffice";

        try {

            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

            out.println("success in database connection");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);

            ResultSet resultSet = preparedStatement.executeQuery();

            List<br.com.gymcontrol.Model.UsuarioBackOffice> usuarioSistema = new ArrayList<>();

            while (resultSet.next()) {

                int userSistemID = resultSet.getInt("id");
                String userSistemNome = resultSet.getString("nome");
                String userSistemEmail = resultSet.getString("email");
                String userSistemSenha = resultSet.getString("senha");
                String userSistemGrupo = resultSet.getString("grupo");
                boolean userStatus = resultSet.getBoolean("status");
                String userSistemCPF = resultSet.getString("CPF");


                br.com.gymcontrol.Model.UsuarioBackOffice userSistema = new br.com.gymcontrol.Model.UsuarioBackOffice(userSistemID, userSistemNome, userSistemEmail, userSistemSenha, userSistemGrupo, userStatus, userSistemCPF);

                usuarioSistema.add(userSistema);

            }

            out.println("success in select * UsuarioBackOffice");

            connection.close();

            return usuarioSistema;

        } catch (Exception e) {

            out.println("fail in database connection no select");

            return Collections.emptyList();

        }


    }

    public static br.com.gymcontrol.Model.UsuarioBackOffice buscarUsuarioPorEmail(String email) {
        String SQL = "SELECT * FROM UsuarioBackOffice WHERE email = ?";

        try {
            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, email);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int userSistemID = resultSet.getInt("id");
                String userSistemNome = resultSet.getString("nome");
                String userSistemEmail = resultSet.getString("email");
                String userSistemSenha = resultSet.getString("senha");
                String userSistemGrupo = resultSet.getString("grupo");
                boolean userStatus = resultSet.getBoolean("status");
                String userSistemCPF = resultSet.getString("CPF");

                return new br.com.gymcontrol.Model.UsuarioBackOffice(userSistemID, userSistemNome, userSistemEmail, userSistemSenha, userSistemGrupo, userStatus, userSistemCPF);
            } else {
                return null;
            }

        } catch (Exception e) {
            out.println("Erro ao buscar usuário por email: " + e.getMessage());
            return null;
        }
    }

    public void updateUsuarioBackOffice(br.com.gymcontrol.Model.UsuarioBackOffice UsuarioBackOffice) {

        String SQL = "UPDATE UsuarioBackOffice SET nome = ?, grupo = ? WHERE id = ?";

        try {

            Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

            out.println("success in database connection");

            PreparedStatement preparedStatement = connection.prepareStatement(SQL);

            preparedStatement.setString(1, (UsuarioBackOffice.getNome()));
            preparedStatement.setString(2, UsuarioBackOffice.getGrupo());

            preparedStatement.setInt(3, UsuarioBackOffice.getID());
            preparedStatement.execute();

            out.println(UsuarioBackOffice.getNome() + "valor que estou pegando");
            out.println(UsuarioBackOffice.getGrupo());
            out.println(UsuarioBackOffice.getID());


            connection.close();

        } catch (Exception e) {

            out.println("fail in database connection");
            out.println("Error: " + e.getMessage());

        }

    }


    public static void updateUsuarioStatus(int userID, boolean novoStatus) {
        String SQL = "UPDATE UsuarioBackOffice SET status = ? WHERE id = ?";

        try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setBoolean(1, novoStatus);
            preparedStatement.setInt(2, userID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Erro ao atualizar status do usuário: " + e.getMessage());
        }
    }

    public static UsuarioBackOffice obterUsuarioPorID(int userID) {
        Connection conexao = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        UsuarioBackOffice usuario = new UsuarioBackOffice();
        try {
            conexao = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

                    String query = "SELECT * FROM usuarios WHERE id = ?";
            stmt = conexao.prepareStatement(query);
            stmt.setInt(1, userID);

            rs = stmt.executeQuery();

            if (rs.next()) {

                usuario.setID(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setCPF(rs.getString("cpf"));
                usuario.setGrupo(rs.getString("grupo"));
                usuario.setSenha(rs.getString("senha"));

                return usuario;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Fechar recursos
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conexao != null) {
                try {
                    conexao.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return usuario;
    }

    public static boolean isEmailCadastrado(String email) {
        String SQL = "SELECT COUNT(*) FROM UsuarioBackOffice WHERE email = ?";

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



    public boolean CadastrarUsuarioBackOffice(UsuarioBackOffice CadastrarUsuario) {
        String SQL = "INSERT INTO USUARIOBACKOFFICE (Nome, Email, Senha, Grupo, Status, CPF) VALUES (?, ?, ?, ?, ?, ?)";

        try {
            String email = CadastrarUsuario.getEmail();

            if (isEmailCadastrado(email)) {
                return false; // Indica que o e-mail já está cadastrado
            }

            boolean status = true;

            try (Connection connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");
                 PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
                String hashedSenha = BCrypt.hashpw(CadastrarUsuario.getSenha(), BCrypt.gensalt());
                preparedStatement.setString(1, CadastrarUsuario.getNome());
                preparedStatement.setString(2, email);
                preparedStatement.setString(3, hashedSenha);
                preparedStatement.setString(4, CadastrarUsuario.getGrupo());
                preparedStatement.setBoolean(5, status);
                preparedStatement.setString(6, CadastrarUsuario.getCPF());

                preparedStatement.execute();

                return true; // Indica que o cadastro foi bem-sucedido

            } catch (Exception e) {
                System.out.println("Erro ao cadastrar o usuário: " + e.getMessage());
                return false;
            }
        } catch (Exception e) {
            System.out.println("Erro ao verificar e-mail cadastrado: " + e.getMessage());
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
        String SQL = "SELECT COUNT(*) FROM UsuarioBackOffice WHERE CPF = ?";

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

    public static void atualizarUsuario(int userID, String nome, String cpf, String grupo, String senha) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;



        try {
            connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");

            String hashedSenha = BCrypt.hashpw(senha, BCrypt.gensalt());
                    String query = "UPDATE UsuarioBackOffice SET Nome=?, CPF=?, Grupo=?, Senha=? WHERE ID=?";

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, cpf);
            preparedStatement.setString(3, grupo);
            preparedStatement.setString(4, hashedSenha);
            preparedStatement.setInt(5, userID);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {

            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void atualizarUsuario2(int userID, String nome, String cpf, String grupo) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;



        try {
            connection = DriverManager.getConnection("jdbc:h2:~/test", "sa", "sa");


            String query = "UPDATE UsuarioBackOffice SET Nome=?, CPF=?, Grupo=? WHERE ID=?";

            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, cpf);
            preparedStatement.setString(3, grupo);
            preparedStatement.setInt(4, userID);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {

            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

