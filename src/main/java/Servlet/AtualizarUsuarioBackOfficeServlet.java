package Servlet;

import DAO.UsuarioBackOfficeDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

    @WebServlet("/atualizarUsuarioBackOffice")
    public class AtualizarUsuarioBackOfficeServlet extends HttpServlet {
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws IOException {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String grupo = request.getParameter("grupo");



            br.com.gymcontrol.Model.UsuarioBackOffice usuarioBackOffice = new br.com.gymcontrol.Model.UsuarioBackOffice(id, nome, grupo);
            UsuarioBackOfficeDAO usuarioBackOfficeDAO = new UsuarioBackOfficeDAO();
            try {
                usuarioBackOfficeDAO.updateUsuarioBackOffice(usuarioBackOffice);
            } catch (Exception e) {
                System.out.println("Não consegui atualizar");            }

            response.sendRedirect(request.getContextPath() + "/ListarUsuarioBackOffice");
        }
    }



