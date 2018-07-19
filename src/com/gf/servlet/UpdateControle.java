package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.ControleFluidoDAO;
import com.gf.model.dao.EquipamentoDAO;
import com.gf.model.entity.ControleFluido;

/**
 * Servlet implementation class UpdateControle
 */
@SuppressWarnings("serial")
@WebServlet(name="UpdateControle", urlPatterns = "/UpdateControle")
public class UpdateControle extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("conid");
            String equipamento = request.getParameter("equipamento");
            String concentracao = request.getParameter("concentracao");
            String ph = request.getParameter("ph");
            String cont_visual = request.getParameter("cont_visual");
            String nivel = request.getParameter("nivel");
            String skimmer = request.getParameter("skimmer");
                       
            ControleFluido c = new ControleFluido();
            
            c.setId(Integer.parseInt(id));
            c.setEquipamento(EquipamentoDAO.getEquipamento(Integer.parseInt(equipamento)));
            c.setConcentracao(Double.parseDouble(concentracao));
            c.setPh(Double.parseDouble(ph));
            
            if(cont_visual == null) {
            	c.setContaminacaoVisual(ControleFluidoDAO.getControleFluido(Integer.parseInt(id)).getContaminacaoVisual());
            } else {
            	c.setContaminacaoVisual(cont_visual);
            }
            
            if(nivel == null) {
            	c.setNivelReservatorio(ControleFluidoDAO.getControleFluido(Integer.parseInt(id)).getNivelReservatorio());
            } else {
            	c.setNivelReservatorio(nivel);
            }
            
            if(skimmer == null) {
            	c.setSkimmer(ControleFluidoDAO.getControleFluido(Integer.parseInt(id)).getSkimmer());
            } else {
            	c.setSkimmer(skimmer);
            }
            
            ControleFluidoDAO.updateControle(c);
            
			response.sendRedirect("equipamento.jsp?c=4");
			
        } catch (SQLException ex) {
            System.out.println("Error of database in UpdateControle Servlet - " + ex);
            response.sendRedirect("equipamento.jsp?c=5");
        } catch (Exception ex) { 
            System.out.println("Error generic in UpdateControle Servlet - " + ex);
            response.sendRedirect("equipamento.jsp?c=6");
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
