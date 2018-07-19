package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.ControleFluidoDAO;
import com.gf.model.dao.VisitasDAO;

/**
 * Servlet implementation class DeleteControle
 */
@SuppressWarnings("serial")
@WebServlet(name="DeleteControle", urlPatterns = "/DeleteControle")
public class DeleteControle extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("val21");
            String cliente = request.getParameter("val22");
            String data = request.getParameter("val23");
              
            ControleFluidoDAO.deleteControle(Integer.parseInt(id));
            
            
              
            if(!ControleFluidoDAO.isControle(Integer.parseInt(cliente), Date.valueOf(data))) {
            	System.out.println(!ControleFluidoDAO.isControle(Integer.parseInt(cliente), Date.valueOf(data)) +" - "+ cliente + data);
            	if(VisitasDAO.isRegistro(Integer.parseInt(cliente), Date.valueOf(data))) {
            		System.out.println(VisitasDAO.isRegistro(Integer.parseInt(cliente), Date.valueOf(data)));
            		int idVisita = VisitasDAO.getVisitaClienteData(Integer.parseInt(cliente), Date.valueOf(data));
            		System.out.println(idVisita);
            		VisitasDAO.deleteVisita(idVisita);
            	}
            }
            
            response.sendRedirect("equipamento.jsp?c=1");
			
        } catch (SQLException ex) { 
            System.out.println("Error of database in deleteControle Servlet - " + ex);
            response.sendRedirect("equipamento.jsp?c=2");
        } catch (Exception ex) { 
            System.out.println("Error generic in deleteControle Servlet - " + ex);
            response.sendRedirect("equipamento.jsp?c=3");
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
