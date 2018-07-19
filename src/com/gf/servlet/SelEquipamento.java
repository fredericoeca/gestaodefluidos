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

import com.gf.model.dao.EquipamentoDAO;
import com.gf.model.entity.Equipamento;

/**
 * Servlet implementation class SelEquipamento
 */
@SuppressWarnings("serial")
@WebServlet(name = "SelEquipamento", urlPatterns = {"/SelEquipamento"})
public class SelEquipamento extends HttpServlet {
	@SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String idEquipamento = request.getParameter("id");
            String op = request.getParameter("op");
            String s = request.getParameter("sid");
            
            int id = 0;
            if(idEquipamento != null){
                id = Integer.parseInt(idEquipamento);
            }
            
            Equipamento e = EquipamentoDAO.getEquipamento(id);
            
            if(e != null){
                HttpSession session = request.getSession();
                session.setAttribute("equipamento", e);
                if(op.equals("con")) {
            		response.sendRedirect("ins_controle.jsp");
                } else if(op.equals("det")) {
                	if(s != null) {
                		session.setAttribute("setor", s);
                	}
                	response.sendRedirect("equipamento.jsp");
                }
            }
            
        } catch (SQLException ex) {
            System.out.println("Error of database in SelEquipamento Servlet - " + ex);
        } catch (Exception ex) {
            System.out.println("Error generic in SelEquipamento Servlet - " + ex);
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