package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.ProdutoDAO;
import com.gf.model.dao.TipoProdutoDAO;
import com.gf.model.entity.Produto;

/**
 * Servlet implementation class UpdateProduto
 */
@SuppressWarnings("serial")
@WebServlet(name="UpdateProduto", urlPatterns = "/UpdateProduto")
public class UpdateProduto extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("val3");
            String produto = request.getParameter("val4");
            String fabricante = request.getParameter("val5");
            String tipo = request.getParameter("tipo");
         
            Produto p = new Produto();
			p.setId(Integer.parseInt(id));
			p.setProduto(produto);
			p.setFabricante(fabricante);	
	
			if(tipo.equals("")){
				p.setTipo(TipoProdutoDAO.getTipoProduto(ProdutoDAO.getProduto(Integer.parseInt(id)).getTipo().getId()));
			} else {
				p.setTipo(TipoProdutoDAO.getTipoProduto(Integer.parseInt(tipo)));
			}
						
			ProdutoDAO.updateProduto(p);
            
            response.sendRedirect("produtos.jsp?c=1");
			
        } catch (SQLException ex) {
            System.out.println("Error of database in UpdateProduto Servlet - " + ex);
            response.sendRedirect("produtos.jsp?c=2");
        } catch (Exception ex) { 
            System.out.println("Error generic in UpdateProduto Servlet - " + ex);
            response.sendRedirect("produtos.jsp?c=3");
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
