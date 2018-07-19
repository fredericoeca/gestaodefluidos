package com.gf.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.UsuarioDAO;
import com.gf.model.dao.exception.EmailExistingException;
import com.gf.model.entity.Usuario;

/**
 * Servlet implementation class InsertUsuarioInLogin
 */
@SuppressWarnings("serial")
@WebServlet(name = "InsertUsuarioInLogin", urlPatterns = {"/InsertUsuarioInLogin"})
public class InsertUsuarioInLogin extends HttpServlet {
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");                
            
        response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
                       
            String nome = request.getParameter("nome");
            String telefone = request.getParameter("telefone");
            String celular = request.getParameter("celular");
            String email = request.getParameter("email");
            String senha = request.getParameter("password");          
            
            Usuario u = new Usuario();
            u.setNome(nome);
            u.setTelefone(telefone);
            u.setCelular(celular);
            u.setEmail(email);
            u.setSenha(senha);
            u.setPerfil(2);
            u.setStatus(false);
            
            UsuarioDAO.insUsuario(u);
            
            response.sendRedirect("index.jsp");
            
        } catch (SQLException ex) {
            System.out.println(ex);
            response.sendRedirect("ins_usuario_out.jsp?c=1");
        } catch (EmailExistingException ex) {
            System.out.println(ex);
            response.sendRedirect("ins_usuario_out.jsp?c=2");
        } catch(Exception ex){
            System.out.println(ex);
            response.sendRedirect("ins_usuario_out.jsp?c=3");
        }
    }

               // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
