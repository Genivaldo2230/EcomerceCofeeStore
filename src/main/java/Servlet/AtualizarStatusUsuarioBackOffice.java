package Servlet;

import DAO.UsuarioBackOfficeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

    @WebServlet("/ToggleStatusServlet")
    public class AtualizarStatusUsuarioBackOffice extends HttpServlet {
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean newStatus = Boolean.parseBoolean(request.getParameter("newStatus"));

            UsuarioBackOfficeDAO.updateUsuarioStatus(userId, newStatus);

            // Enviar uma resposta de sucesso
            response.setStatus(HttpServletResponse.SC_OK);
        }


}
