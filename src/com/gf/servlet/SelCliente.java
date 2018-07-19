package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gf.model.controller.EquipamentoController;
import com.gf.model.dao.ClienteDAO;
import com.gf.model.entity.Cliente;
import com.gf.model.entity.Equipamento;

/**
 * Servlet implementation class SelCliente
 */
@SuppressWarnings("serial")
@WebServlet(name = "SelCliente", urlPatterns = {"/SelCliente"})
public class SelCliente extends HttpServlet {
	@SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String idCliente = request.getParameter("id");
            String op = request.getParameter("op");
            String sid = request.getParameter("sid");
            
            int id = 0;
            if(idCliente != null){
                id = Integer.parseInt(idCliente);
            }
            
            Cliente c = ClienteDAO.getCliente(id);
            
            if(c != null){
                HttpSession session = request.getSession();
                session.setAttribute("cliente", c);
                if(op.equals("con"))
            		response.sendRedirect("ins_contato.jsp");
                else if(op.equals("det"))
                	response.sendRedirect("cliente.jsp");
                else if(op.equals("equ"))
                	response.sendRedirect("ins_equipamento.jsp");
                else if(op.equals("eqs")) {
                	
                	ArrayList<Equipamento> eqs = new ArrayList<>();
            		HttpSession ss = request.getSession();            		                	
            		
                	if(sid == null) {
                		eqs = EquipamentoController.getEquipamentosPorCliente(c.getId());  
                		ss.setAttribute("equips", eqs);
                		response.sendRedirect("equipamentos.jsp");
                	} else {                		
                		eqs = EquipamentoController.getEquipamentosPorSetor(Integer.parseInt(sid));  
                		ss.setAttribute("equips", eqs);
                		response.sendRedirect("equipamentos.jsp");
                	}
                }
            }
            
        } catch (SQLException ex) {
            System.out.println("Error of database in SelCliente Servlet - " + ex);
        } catch (Exception ex) {
            System.out.println("Error generic in SelCliente Servlet - " + ex);
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