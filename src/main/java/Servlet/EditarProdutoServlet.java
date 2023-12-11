package Servlet;

import com.azure.core.util.BinaryData;
import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;
import DAO.ProdutosDAO;
import br.com.gymcontrol.Model.Produtos;
import br.com.gymcontrol.Model.UsuarioBackOffice;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/EditarProdutoServlet")
@MultipartConfig
public class EditarProdutoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String storageConnectionString = "DefaultEndpointsProtocol=https;"
            + "AccountName=pi4senac;"
            + "AccountKey=uQk8tRzdibr2QdYRM8O8T9Xw88YzcWNhEoXg6BeWGN9+6UaEUtFktOBCtAWxNBuKtjEuVuHK96P4+AStNVP/vA==;"
            + "EndpointSuffix=core.windows.net";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int produtoID = Integer.parseInt(request.getParameter("produtoID"));

        ProdutosDAO produtoDAO = new ProdutosDAO();
        Produtos produto = produtoDAO.obterProdutoPorID(produtoID);

        // Obtenha as URLs das imagens do produto, tanto existentes quanto novas
        List<String> imagensExistentes = produtoDAO.obterUrlsImagensPorProdutoID(produtoID);
        List<String> imagensNovas = new ArrayList<>();

        // Defina o objeto produto e as URLs das imagens como atributos de solicitação
        request.setAttribute("produto", produto);
        request.setAttribute("imagensExistentes", imagensExistentes);
        request.setAttribute("imagensNovas", imagensNovas);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/EditarProduto.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UsuarioBackOffice usuarioSessao = (UsuarioBackOffice) session.getAttribute("usuario");

        System.out.println(usuarioSessao.getGrupo());
        // Verifique se o usuário da sessão tem permissão de administrador
        if (usuarioSessao != null && "Admin Group".equals(usuarioSessao.getGrupo())) {
            // Usuário é um administrador, permita a atualização completa do produto
            int produtoID = Integer.parseInt(request.getParameter("produtoID"));
            String nomeProduto = request.getParameter("nomeProduto");
            boolean statusProduto = request.getParameter("status") != null;
            double avaliacao = Double.parseDouble(request.getParameter("avaliacao"));
            String descricaoDetalhada = request.getParameter("descricaoDetalhada");
            double precoProduto = Double.parseDouble(request.getParameter("precoProduto"));
            int qtdEstoque = Integer.parseInt(request.getParameter("qtdEstoque"));

            // Crie um objeto Produtos com os valores atualizados
            Produtos produto = new Produtos(produtoID, nomeProduto, statusProduto, avaliacao, descricaoDetalhada, precoProduto, qtdEstoque);

            // Atualize o produto no banco de dados
            ProdutosDAO produtoDAO = new ProdutosDAO();
            produtoDAO.atualizarProduto(produto);

            // Processar o upload das novas imagens adicionais
            List<String> novasImagens = new ArrayList<>();

            for (Part filePart : request.getParts()) {
                String fieldName = filePart.getName();
                if (fieldName.startsWith("novaImagem")) {
                    String novaImagemFileName = filePart.getName();
                    if (novaImagemFileName != null && !novaImagemFileName.isEmpty()) {
                        String novaImagemBlobName = UUID.randomUUID().toString() + "_" + novaImagemFileName;

                        try {
                            // Crie um diretório temporário no contexto da sua aplicação web
                            String uploadDirPath = getServletContext().getRealPath("/tempUploads");
                            File uploadDir = new File(uploadDirPath);
                            uploadDir.mkdirs();

                            // Salve a nova imagem temporariamente no servidor
                            File file = new File(uploadDir, novaImagemFileName);
                            try (InputStream fileContent = filePart.getInputStream()) {
                                Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                            }

                            // Realize o upload da nova imagem para o Azure Blob Storage
                            BlobServiceClient blobServiceClient = new BlobServiceClientBuilder().connectionString(storageConnectionString).buildClient();
                            String containerName = "pi4imagens";
                            BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);
                            containerClient.createIfNotExists();
                            BlobClient blobClient = containerClient.getBlobClient(novaImagemBlobName);
                            blobClient.upload(BinaryData.fromFile(file.toPath()));

                            // Adicione o URL do Blob à lista de caminhos
                            novasImagens.add(blobClient.getBlobUrl());

                            // Apague o arquivo temporário no servidor
                            file.delete();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }

            // Adicione as novas imagens ao banco de dados
            for (String novaImagemPath : novasImagens) {
                produtoDAO.inserirCaminhoImagem(produtoID, novaImagemPath);
            }

            // Redirecione de volta para a página de detalhes do produto ou outra página de sua escolha
            response.sendRedirect("/ListarProdutos_2");
        } else {
            // Usuário não é um administrador, permita apenas a atualização da quantidade em estoque
            int produtoID = Integer.parseInt(request.getParameter("produtoID"));
            int qtdEstoque = Integer.parseInt(request.getParameter("qtdEstoque"));

            // Atualize apenas a quantidade em estoque do produto no banco de dados
            ProdutosDAO produtoDAO = new ProdutosDAO();
            produtoDAO.atualizarQuantidadeEstoque(produtoID, qtdEstoque);

            // Redirecione de volta para a página de detalhes do produto ou outra página de sua escolha
            response.sendRedirect("/ListarProdutos_2");
        }
    }
}
