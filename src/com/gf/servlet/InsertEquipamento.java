package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.ClienteDAO;
import com.gf.model.dao.EquipamentoDAO;
import com.gf.model.dao.ProdutoDAO;
import com.gf.model.dao.SetorDAO;
import com.gf.model.entity.Equipamento;
import com.gf.model.entity.Setor;

/**
 * Servlet implementation class InsertEquipamento
 */
@SuppressWarnings("serial")
@WebServlet(name="InsertEquipamento", urlPatterns = "/InsertEquipamento")
public class InsertEquipamento extends HttpServlet {
	@SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String cliente = request.getParameter("cliente");
            String tipo = request.getParameter("tipo");
            String fabricante = request.getParameter("fabricante");
            String tag = request.getParameter("tag");            
            String modelo = request.getParameter("modelo");
            String ponto = request.getParameter("ponto");
            String produto = request.getParameter("produto");
            String volume = request.getParameter("volume");
            String conmin = request.getParameter("conmin");
            String conmax = request.getParameter("conmax");
            String phmin = request.getParameter("phmin");
            String phmax = request.getParameter("phmax");
            String setor = request.getParameter("setor");
            String idSetor = request.getParameter("id_setor");
            
            Equipamento e = new Equipamento();
                       
            e.setCliente(ClienteDAO.getCliente(Integer.parseInt(cliente)));
            e.setTipo(tipo);            
            e.setFabricante(fabricante);
            e.setTag(tag);
            e.setModelo(modelo);
            
            if(idSetor != null) {
            	Setor s = SetorDAO.getSetor(Integer.parseInt(idSetor));
            	e.setSetor(s.getSetor());
            } else {
            	e.setSetor(setor);
            }
            
            e.setPontoLubrificacao(ponto);
            e.setProduto(ProdutoDAO.getProduto(Integer.parseInt(produto)));
            e.setVolume(Double.parseDouble(volume));
            e.setConsentracaoMax(Double.parseDouble(conmax));
            e.setConsentracaoMin(Double.parseDouble(conmin));
            e.setLimiteMaxPh(Double.parseDouble(phmax));
            e.setLimiteMinPh(Double.parseDouble(phmin));
            
        	EquipamentoDAO.insEquipamento(e);
        	
        	if(idSetor != null) {
            	EquipamentoDAO.insertEquipamentoSetor(e.getId(), Integer.parseInt(idSetor));
            } 
            
            response.sendRedirect("equipamentos.jsp");
        } catch (SQLException ex) { 
            System.out.println("Error of database in InsertEquipamento Servlet - " + ex);
            response.sendRedirect("ins_equipamento.jsp?c=1");
        } catch (Exception ex) { 
            System.out.println("Error generic in InsertEquipamento Servlet - " + ex);
            response.sendRedirect("ins_equipamento.jsp?c=2");
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
