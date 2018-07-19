package com.gf.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.ClienteDAO;
import com.gf.model.dao.SetorDAO;
import com.gf.model.entity.Setor;

/**
 * Servlet implementation class InsertSetor
 */
@SuppressWarnings("serial")
@WebServlet(name = "InsertSetor", urlPatterns = {"/InsertSetor"})
public class InsertSetor extends HttpServlet {
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");                
            
        response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
                       
            String cliente = request.getParameter("val5");
            String setor = request.getParameter("setor");          
                          
            Setor s = new Setor();
            s.setCliente(ClienteDAO.getCliente(Integer.parseInt(cliente)));
            s.setSetor(setor);
            
            SetorDAO.insSetor(s);
            
            response.sendRedirect("clientes.jsp?c=7");
            
        } catch (SQLException ex) {
            System.out.println(ex);
            response.sendRedirect("clientes.jsp?c=8");
        } catch(Exception ex){
            System.out.println(ex);
            response.sendRedirect("clientes.jsp?c=9");
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
