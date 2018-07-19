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
import javax.servlet.http.HttpSession;

import com.gf.model.dao.ControleFluidoDAO;
import com.gf.model.dao.CorrecaoFluidoDAO;
import com.gf.model.dao.ProdutoDAO;
import com.gf.model.entity.CorrecaoFluido;
import com.gf.model.entity.Equipamento;

/**
 * Servlet implementation class InsertCorrecao
 */
@SuppressWarnings("serial")
@WebServlet(name="InsertCorrecao", urlPatterns = "/InsertCorrecao")
public class InsertCorrecao extends HttpServlet {
	@SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            HttpSession session = request.getSession();
            Equipamento e = (Equipamento) session.getAttribute("equipamento");
            
            String controle = request.getParameter("controle");
            String produto = request.getParameter("produto");
            String data  = request.getParameter("data");
            String quantidade = request.getParameter("quantidade");
            String laudo = request.getParameter("laudo");
            
            CorrecaoFluido c = new CorrecaoFluido();
                        
            c.setControleFluido(ControleFluidoDAO.getControleFluido(Integer.parseInt(controle)));
            c.setProduto(ProdutoDAO.getProduto(Integer.parseInt(produto)));
            c.setData(Date.valueOf(data));
            c.setQuantidade(Double.parseDouble(quantidade));
            
            if(laudo == null)
            	c.setLaudo("");
            else
            	c.setLaudo(laudo);
            
            CorrecaoFluidoDAO.insCorrecaoFluido(c);
            
            response.sendRedirect("equipamento.jsp?c=7");
        
        } catch (SQLException ex) { 
            System.out.println("Error in database in InsertCorreção Servlet - " + ex);
            response.sendRedirect("equipamento.jsp?c=8");
        } catch (Exception ex) { 
            System.out.println("Error generic em InsertCorreção Servlet - " + ex);
            response.sendRedirect("equipamento.jsp?c=9");
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
