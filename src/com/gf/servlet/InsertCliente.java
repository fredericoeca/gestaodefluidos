package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gf.model.dao.CidadeDAO;
import com.gf.model.dao.ClienteDAO;
import com.gf.model.dao.EstadoDAO;
import com.gf.model.dao.UsuarioDAO;
import com.gf.model.entity.Cliente;

/**
 * Servlet implementation class InsertCliente
 */
@SuppressWarnings("serial")
@WebServlet(name="InsertCliente", urlPatterns = "/InsertCliente")
public class InsertCliente extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String cliente = request.getParameter("cliente");
            String usuario = request.getParameter("usuario");
            String cidade = request.getParameter("cidade");
            String estado = request.getParameter("estado");
  
            Cliente c = new Cliente();
            c.setNome(cliente);
            c.setUsuario(UsuarioDAO.getUsuario(Integer.parseInt(usuario)));
            c.setCidade(CidadeDAO.getCidade(Integer.parseInt(cidade)));
            c.setEstado(EstadoDAO.getEstado(Integer.parseInt(estado)));
            
            ClienteDAO.insCliente(c);
            
            if(c != null) {
            	HttpSession session = request.getSession();
                session.setAttribute("cliente", c);
            }
            
            response.sendRedirect("cliente.jsp");
        } catch (SQLException e) {
			System.out.println("Error of database in InsertCliente Servlet - " + e);
			response.sendRedirect("ins_cliente.jsp?c=1");
		} catch (Exception e) { 
            System.out.println("Error generic in InsertCliente Servlet - " + e);
            response.sendRedirect("ins_cliente.jsp?c=2");
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
