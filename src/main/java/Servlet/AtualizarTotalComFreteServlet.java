package Servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/atualizarTotalComFrete")
public class AtualizarTotalComFreteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Obtenha o valor total com frete do parâmetro da solicitação
            String totalComFreteStr = request.getParameter("totalComFrete");

            // Verifique se o parâmetro não é nulo e não está vazio
            if (totalComFreteStr != null && !totalComFreteStr.isEmpty()) {
                Double totalComFrete = Double.parseDouble(totalComFreteStr);

                // Atualize a sessão com o valor total com frete
                HttpSession session = request.getSession();
                session.setAttribute("totalComFrete", totalComFrete);
                System.out.println(totalComFrete);

                // Responda à solicitação com sucesso
                response.getWriter().write("Sessão atualizada com sucesso");
                System.out.println("deu bom");

            } else {
                // Caso o parâmetro seja nulo ou vazio, retorne uma mensagem de erro
                response.getWriter().write("Erro: Parâmetro 'totalComFrete' inválido.");
            }

        } catch (NumberFormatException e) {
            // Trate a exceção se a conversão para Double falhar
            e.printStackTrace();
            response.getWriter().write("Erro ao converter 'totalComFrete' para Double.");
        }
    }
}
