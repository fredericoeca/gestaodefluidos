package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.CorrecaoFluidoDAO;
import com.gf.model.dao.ProdutoDAO;
import com.gf.model.entity.CorrecaoFluido;

/**
 * Servlet implementation class UpdateCorrecao
 */
@SuppressWarnings("serial")
@WebServlet(name="UpdateCorrecao", urlPatterns = "/UpdateCorrecao")
public class UpdateCorrecao extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("corid");
            String produto = request.getParameter("produto");
            String quantidade = request.getParameter("quant");
            String laudo = request.getParameter("val12");
                                   
            CorrecaoFluido c = new CorrecaoFluido();
            
            c.setId(Integer.parseInt(id));
            c.setQuantidade(Double.parseDouble(quantidade));
            c.setLaudo(laudo);
            
            if(produto.equals("")) {
            	c.setProduto(CorrecaoFluidoDAO.getCorrecaoFluido(Integer.parseInt(id)).getProduto());
            } else {
            	c.setProduto(ProdutoDAO.getProduto(Integer.parseInt(produto)));;
            }
            
            CorrecaoFluidoDAO.updateCorrecao(c);
            
			response.sendRedirect("equipamento.jsp?c=13");
			
        } catch (SQLException ex) {
            System.out.println("Error of database in UpdateControle Servlet - " + ex);
            response.sendRedirect("equipamento.jsp?c=14");
        } catch (Exception ex) { 
            System.out.println("Error generic in UpdateControle Servlet - " + ex);
            response.sendRedirect("equipamento.jsp?c=15");
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
