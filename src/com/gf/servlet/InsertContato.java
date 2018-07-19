package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.ClienteDAO;
import com.gf.model.dao.ContatoClienteDAO;
import com.gf.model.entity.ContatoCliente;

/**
 * Servlet implementation class InsertContato
 */
@SuppressWarnings("serial")
@WebServlet(name="InsertContato", urlPatterns = "/InsertContato")
public class InsertContato extends HttpServlet {
	@SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String cliente = request.getParameter("cliente");
            String nome = request.getParameter("nome");
            String cargo = request.getParameter("cargo");
            String telefone = request.getParameter("telefone");
            String celular = request.getParameter("celular");
            String email = request.getParameter("email");
            String setor = request.getParameter("setor");
            
            int id = 0;
            if(cliente != null) {
            	id = Integer.parseInt(cliente);
            }
  
            ContatoCliente c = new ContatoCliente();
            c.setCliente(ClienteDAO.getCliente(id));
            c.setNome(nome);
            c.setCargo(cargo);
            c.setTelefone(telefone);
            c.setCelular(celular);
            c.setEmail(email);
                      
            ContatoClienteDAO.insContato(c);
            
            if(setor != null) {
            	ContatoClienteDAO.insertContatoSetor(c.getId(), Integer.parseInt(setor));
            }
                                 
            response.sendRedirect("cliente.jsp?id=" + cliente + "&op=det");
        
        } catch (SQLException e) {
			System.out.println("Error of database in InsertCliente Servlet - " + e);
			response.sendRedirect("ins_contato.jsp?c=1");
		} catch (Exception ex) { 
            System.out.println("Error generic in InsertCliente Servlet - " + ex);
            response.sendRedirect("ins_contato.jsp?c=2");
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
