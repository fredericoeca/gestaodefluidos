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
 * Servlet implementation class InsertProduto
 */
@SuppressWarnings("serial")
@WebServlet(name="InsertProduto", urlPatterns = "/InsertProduto")
public class InsertProduto extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String produto = request.getParameter("produto");
            String tipo = request.getParameter("tipo");
            String fabricante = request.getParameter("fabricante");
            
            Produto p = new Produto();
            p.setProduto(produto);
            p.setTipo(TipoProdutoDAO.getTipoProduto(Integer.parseInt(tipo)));
            p.setFabricante(fabricante);
            
            ProdutoDAO.insProduto(p);
            
            response.sendRedirect("produtos.jsp");
            
        } catch (SQLException ex) { 
            System.out.println("Error of database in InsertProduto Servlet - " + ex);
            response.sendRedirect("ins_produto.jsp?c=1");
        } catch (Exception ex) { 
            System.out.println("Error generic in InsertProduto Servlet - " + ex);
            response.sendRedirect("ins_produto.jsp?c=2");
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
