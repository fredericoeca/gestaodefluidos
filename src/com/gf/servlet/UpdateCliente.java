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
import com.gf.model.dao.ClienteDAO;
import com.gf.model.dao.EstadoDAO;
import com.gf.model.dao.UsuarioDAO;
import com.gf.model.entity.Cliente;

/**
 * Servlet implementation class UpdateCliente
 */
@SuppressWarnings("serial")
@WebServlet(name="UpdateCliente", urlPatterns = "/UpdateCliente")
public class UpdateCliente extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("val3");
            String cliente = request.getParameter("val4");
            String usuario = request.getParameter("usuario");
            String cidade = request.getParameter("cidade");
            String estado = request.getParameter("estado");
            
            Cliente c = new Cliente();
            c.setId(Integer.parseInt(id));
            c.setNome(cliente);           
            
            if(usuario.equals("")) {
            	c.setUsuario(ClienteDAO.getCliente(Integer.parseInt(id)).getUsuario());
            } else {
            	c.setUsuario(UsuarioDAO.getUsuario(Integer.parseInt(usuario)));
            }
            
            if(cidade.equals("")) {
            	c.setCidade(ClienteDAO.getCliente(Integer.parseInt(id)).getCidade());
            } else {
            	c.setCidade(CidadeDAO.getCidade(Integer.parseInt(cidade)));
            }
			
			if(estado.equals("")) {
				c.setEstado(ClienteDAO.getCliente(Integer.parseInt(id)).getEstado());
			} else {
				c.setEstado(EstadoDAO.getEstado(Integer.parseInt(estado)));
			}
            
            ClienteDAO.updateNomeCliente(c);
            
            response.sendRedirect("clientes.jsp?c=4");
        
        } catch (SQLException e) {
			System.out.println("Error of database in UpdateCliente Servlet - " + e);
			response.sendRedirect("clientes.jsp?c=5");
		} catch (Exception e) { 
            System.out.println("Error generic in UpdateCliente Servlet - " + e);
            response.sendRedirect("clientes.jsp?c=6");
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
