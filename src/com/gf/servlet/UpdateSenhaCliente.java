package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.UsuarioDAO;
import com.gf.model.dao.exception.SenhaInvalidaException;
import com.gf.model.entity.Usuario;

/**
 * Servlet implementation class UpdateSenhaCliente
 */
@SuppressWarnings("serial")
@WebServlet(name="UpdateSenhaCliente", urlPatterns = "/UpdateSenhaCliente")
public class UpdateSenhaCliente extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("usuario");
            String senhaAtual = request.getParameter("senha");
            String novaSenha = request.getParameter("password");
                                            
            Usuario u = new Usuario();
			u.setId(Integer.parseInt(id));
			u.setSenha(senhaAtual);			
			
			UsuarioDAO.updateSenha(u, novaSenha);
		            
            response.sendRedirect("home.jsp?c=1");
			
        } catch (SenhaInvalidaException ex) {
            System.out.println("Error Senha Invalida in UpdateSenha Servlet - " + ex);
            response.sendRedirect("home.jsp?c=2");
        } catch (SQLException ex) { 
            System.out.println("Error of database in UpdateSenha Servlet - " + ex);
            response.sendRedirect("home.jsp?c=3");
        } catch (Exception ex) { 
            System.out.println("Error generic in UpdateSenha Servlet - " + ex);
            response.sendRedirect("home.jsp?c=4");
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
