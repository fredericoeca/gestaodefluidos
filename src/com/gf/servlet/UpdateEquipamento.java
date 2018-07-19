package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.AlteracaoParametroDAO;
import com.gf.model.dao.ClienteDAO;
import com.gf.model.dao.EquipamentoDAO;
import com.gf.model.dao.ProdutoDAO;
import com.gf.model.entity.AlteracaoParametro;
import com.gf.model.entity.Equipamento;

/**
 * Servlet implementation class UpdateEquipamento
 */
@SuppressWarnings("serial")
@WebServlet(name="UpdateEquipamento", urlPatterns = "/UpdateEquipamento")
public class UpdateEquipamento extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String id = request.getParameter("val19");
            String cliente = request.getParameter("val44");
            String tipo = request.getParameter("val20");
            String fabricante = request.getParameter("val21");
            String tag = request.getParameter("val22");
            String modelo = request.getParameter("val23");
            String setor = request.getParameter("val24");
            String ponto = request.getParameter("val25");
            String produto = request.getParameter("produto");
            String volume = request.getParameter("val26");
            String conmin = request.getParameter("val27");
            String conmax = request.getParameter("val28");
            String phmin = request.getParameter("val29");
            String phmax = request.getParameter("val30");
                        
            Equipamento e = new Equipamento();
            
            e.setId(Integer.parseInt(id));
            e.setCliente(ClienteDAO.getCliente(Integer.parseInt(cliente)));
            e.setTipo(tipo);            
            e.setFabricante(fabricante);
            e.setTag(tag);
            e.setModelo(modelo);
            e.setSetor(setor);
            e.setPontoLubrificacao(ponto);
            e.setVolume(Double.parseDouble(volume));
            e.setConsentracaoMax(Double.parseDouble(conmax));
            e.setConsentracaoMin(Double.parseDouble(conmin));
            e.setLimiteMaxPh(Double.parseDouble(phmax));
            e.setLimiteMinPh(Double.parseDouble(phmin));
            
            if(produto.equals("")) {
            	e.setProduto(ProdutoDAO.getProduto(EquipamentoDAO.getEquipamento(Integer.parseInt(id)).getProduto().getId()));
            } else {
            	e.setProduto(ProdutoDAO.getProduto(Integer.parseInt(produto)));
            }
			
            Equipamento equipamento = EquipamentoDAO.getEquipamento(Integer.parseInt(id));
            if(equipamento.getConsentracaoMin() != Double.parseDouble(conmin)
            		|| equipamento.getConsentracaoMax() != Double.parseDouble(conmax)) {
            	AlteracaoParametro a = new AlteracaoParametro();
            	a.setEquipamento(equipamento);
            	a.setItem("Concentração");
            	a.setAltDeMinimo(equipamento.getConsentracaoMin());
            	a.setAltParaMinimo(Double.parseDouble(conmin));
            	a.setAltDeMaximo(equipamento.getConsentracaoMax());
            	a.setAltParaMaxima(Double.parseDouble(conmax));
            	AlteracaoParametroDAO.insertAltParametro(a);
            }
            
            if(equipamento.getLimiteMinPh() != Double.parseDouble(phmin)
            		|| equipamento.getLimiteMaxPh() != Double.parseDouble(phmax)) {
            	AlteracaoParametro a = new AlteracaoParametro();
            	a.setEquipamento(equipamento);
            	a.setItem("Ph");
            	a.setAltDeMinimo(equipamento.getLimiteMinPh());
            	a.setAltParaMinimo(Double.parseDouble(phmin));
            	a.setAltDeMaximo(equipamento.getLimiteMaxPh());
            	a.setAltParaMaxima(Double.parseDouble(phmax)); 
            	AlteracaoParametroDAO.insertAltParametro(a);
            }
            
			EquipamentoDAO.updateEquipamento(e);
					
			response.sendRedirect("equipamentos.jsp?c=4");
			
        } catch (SQLException ex) {
            System.out.println("Error of database in UpdateEquipamento Servlet - " + ex);
            response.sendRedirect("equipamentos.jsp?c=5");
        } catch (Exception ex) { 
            System.out.println("Error generic in UpdateEquipamento Servlet - " + ex);
            response.sendRedirect("equipamentos.jsp?c=6");
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
