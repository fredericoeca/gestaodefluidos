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
import com.gf.model.entity.Usuario;

/**
 * Servlet implementation class UpdatePerfil
 */
@SuppressWarnings("serial")
@WebServlet(name="UpdatePerfil", urlPatterns = "/UpdatePerfil")
public class UpdatePerfil extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("id");
            String perfil = request.getParameter("p");
           
            Usuario u = new Usuario();
			u.setId(Integer.parseInt(id));
			u.setPerfil(Integer.parseInt(perfil));			
			
			UsuarioDAO.updatePerfil(u);
            
            response.sendRedirect("usuarios.jsp?c=4");
			
        } catch (SQLException ex) {
        	System.out.println("Error of database in UpdatePerfil Servlet - " + ex);
            response.sendRedirect("usuarios.jsp?c=5");
        } catch (Exception ex) { 
            System.out.println("Error generic in UpdatePerfil Servlet - " + ex);
            response.sendRedirect("usuarios.jsp?c=6");
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
