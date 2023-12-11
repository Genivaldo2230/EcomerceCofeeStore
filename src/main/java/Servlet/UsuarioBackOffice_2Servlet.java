package Servlet;


import DAO.UsuarioBackOfficeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListarUsuarioBackOffice_2")

public class UsuarioBackOffice_2Servlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<br.com.gymcontrol.Model.UsuarioBackOffice> usuarios = UsuarioBackOfficeDAO.listarUsuarios();
        request.setAttribute("UsuarioBackOffice", usuarios);
        request.getRequestDispatcher("ListarUsuarioOFC.jsp").forward(request, response);

    }



}