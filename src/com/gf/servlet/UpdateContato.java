package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.ContatoClienteDAO;
import com.gf.model.entity.ContatoCliente;

/**
 * Servlet implementation class UpdateContato
 */
@SuppressWarnings("serial")
@WebServlet(name="UpdateContato", urlPatterns = "/UpdateContato")
public class UpdateContato extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("val3");
            String nome = request.getParameter("val4");
            String cargo = request.getParameter("val5");
            String telefone = request.getParameter("val6");
            String celular = request.getParameter("val7");
            String email = request.getParameter("email");
  
            ContatoCliente c = new ContatoCliente();
			c.setId(Integer.parseInt(id));
			c.setNome(nome);
			c.setCargo(cargo);
			c.setTelefone(telefone);
			c.setCelular(celular);
			c.setEmail(email);
			
			ContatoClienteDAO.updateContato(c);
            
			response.sendRedirect("cliente.jsp?c=4");
			
        } catch (SQLException ex) { 
            System.out.println("Error of database in UpdateContato Servlet - " + ex);
            response.sendRedirect("cliente.jsp?c=5");
        } catch (Exception ex) { 
            System.out.println("Error generic in UpdateContato Servlet - " + ex);
            response.sendRedirect("cliente.jsp?c=6");
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
