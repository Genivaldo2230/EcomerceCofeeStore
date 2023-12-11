package Servlet;

import DAO.UsuarioBackOfficeDAO;
import br.com.gymcontrol.Model.UsuarioBackOffice;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;


@WebServlet("/Login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        UsuarioBackOffice usuario = UsuarioBackOfficeDAO.buscarUsuarioPorEmail(email);

        if (usuario != null && BCrypt.checkpw(senha, usuario.getSenha())) {
            if(usuario.getStatus()==true) {
                request.getSession().setAttribute("usuario", usuario);
                response.sendRedirect("Principal.jsp");
            } else {
                response.sendRedirect("Login.jsp?error2=true");
            }
        } else {
            response.sendRedirect("Login.jsp?error=true");
        }
    }

}
