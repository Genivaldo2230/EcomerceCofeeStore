package Servlet;

import com.azure.core.util.BinaryData;
import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;
import DAO.ProdutosDAO;
import br.com.gymcontrol.Model.Produtos;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/CadastroProdutoServlet")
@MultipartConfig
public class CadastroProdutoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String storageConnectionString = "DefaultEndpointsProtocol=https;"
            + "AccountName=pi4senac;"
            + "AccountKey=uQk8tRzdibr2QdYRM8O8T9Xw88YzcWNhEoXg6BeWGN9+6UaEUtFktOBCtAWxNBuKtjEuVuHK96P4+AStNVP/vA==;"
            + "EndpointSuffix=core.windows.net";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        // Obtenha os dados do formulário
        Produtos produto = new Produtos();
        produto.setNomeProduto(request.getParameter("nomeProduto"));
        String statusStr = request.getParameter("status");
        boolean statusProduto = statusStr != null && statusStr.equals("1");
        produto.setStatusProduto(statusProduto);
        produto.setAvaliacao(Double.parseDouble(request.getParameter("avaliacao")));
        produto.setDescricaoDetalhada(request.getParameter("descricaoDetalhada"));
        produto.setPrecoProduto(Double.parseDouble(request.getParameter("precoProduto")));
        produto.setQtdEstoque(Integer.parseInt(request.getParameter("qtdEstoque")));

        // Processar o upload das imagens adicionais
        List<String> imagePaths = new ArrayList<>();

        for (Part filePart : request.getParts()) {
            String fieldName = filePart.getName();
            if (fieldName.startsWith("imagemProduto")) {
                String uploadedFileName = filePart.getName();
                if (uploadedFileName != null && !uploadedFileName.isEmpty()) {
                    String imageBlobName = UUID.randomUUID().toString() + "_" + uploadedFileName;

                    try {
                        // Crie um diretório temporário no contexto da sua aplicação web
                        String uploadDirPath = getServletContext().getRealPath("/tempUploads");
                        File uploadDir = new File(uploadDirPath);
                        uploadDir.mkdirs();

                        // Salve a imagem temporariamente no servidor
                        File file = new File(uploadDir, uploadedFileName);
                        try (InputStream fileContent = filePart.getInputStream()) {
                            Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                        }

                        // Realize o upload da imagem para o Azure Blob Storage
                        BlobServiceClient blobServiceClient = new BlobServiceClientBuilder().connectionString(storageConnectionString).buildClient();
                        String containerName = "pi4imagens";
                        BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);
                        containerClient.createIfNotExists();
                        BlobClient blobClient = containerClient.getBlobClient(imageBlobName);
                        blobClient.upload(BinaryData.fromFile(file.toPath()));

                        // Adicione o URL do Blob à lista de caminhos
                        imagePaths.add(blobClient.getBlobUrl());

                        // Apague o arquivo temporário no servidor
                        file.delete();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }

        // Defina os caminhos das imagens no objeto do produto
        produto.setImagens(imagePaths);

        // Processar a seleção da imagem principal
        String imagemPrincipalSelecionada = request.getParameter("imagemPrincipalRadio");
        if (imagemPrincipalSelecionada != null && !imagemPrincipalSelecionada.isEmpty()) {
            try {
                int index = Integer.parseInt(imagemPrincipalSelecionada) - 1;
                if (index >= 0 && index < imagePaths.size()) {
                    produto.setImagePATH(imagePaths.get(index));
                } else {
                    // Lógica para lidar com um índice fora dos limites da lista de imagens
                    // Neste exemplo, definimos a primeira imagem como a imagem principal por padrão
                    if (!imagePaths.isEmpty()) {
                        produto.setImagePATH(imagePaths.get(0));
                    }
                }
            } catch (NumberFormatException e) {
                // Lógica para lidar com o caso em que o valor não é um número
                // Neste exemplo, definimos a primeira imagem como a imagem principal por padrão
                if (!imagePaths.isEmpty()) {
                    produto.setImagePATH(imagePaths.get(0));
                }
            }
        } else {
            // Lógica para lidar com o caso em que nenhuma imagem principal é selecionada
            // Neste exemplo, definimos a primeira imagem como a imagem principal por padrão
            if (!imagePaths.isEmpty()) {
                produto.setImagePATH(imagePaths.get(0));
            }
        }

        // Insira o produto no banco de dados
        try {
            // Insira o produto no banco de dados
            ProdutosDAO produtoDAO = new ProdutosDAO();
            produtoDAO.inserirProduto(produto);

            // Obtenha o ID do produto após a inserção
            int idProdutoInserido = produto.getProdutoID();

            // Salve os caminhos das imagens na tabela ImagensProduto
            for (String imagePath : imagePaths) {
                produtoDAO.inserirCaminhoImagem(idProdutoInserido, imagePath);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        response.sendRedirect("/ListarProdutos_2");
    }

}
