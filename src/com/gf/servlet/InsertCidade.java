package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.CidadeDAO;
import com.gf.model.dao.EstadoDAO;
import com.gf.model.dao.exception.CidadeExistingException;
import com.gf.model.entity.Cidade;

/**
 * Servlet implementation class InsertCidade
 */
@SuppressWarnings("serial")
@WebServlet(name="InsertCidade", urlPatterns = "/InsertCidade")
public class InsertCidade extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String estado = request.getParameter("estado");
            String cidade = request.getParameter("cidade");
  
            Cidade c = new Cidade();
            c.setEstado(EstadoDAO.getEstado(Integer.parseInt(estado)));
            c.setCidade(cidade);
            
            CidadeDAO.insertCidade(c);
                      
            response.sendRedirect("ins_cliente.jsp");
            
        } catch (SQLException ex) {
        	System.out.println(ex);
            response.sendRedirect("ins_cliente.jsp?c=4");
        } catch (CidadeExistingException ex) {
        	System.out.println(ex);
            response.sendRedirect("ins_cliente.jsp?c=3");
        } catch (Exception ex) { 
            System.out.println("Error generic em InsCidadeServlet - " + ex);
            response.sendRedirect("ins_endereco.jsp?c=5");
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
