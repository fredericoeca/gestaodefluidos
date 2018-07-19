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

import com.gf.model.dao.ClienteDAO;
import com.gf.model.dao.ControleFluidoDAO;
import com.gf.model.dao.EquipamentoDAO;
import com.gf.model.dao.VisitasDAO;
import com.gf.model.dao.exception.RadioSelectedException;
import com.gf.model.entity.ControleFluido;
import com.gf.model.entity.Equipamento;
import com.gf.model.entity.Visitas;

/**
 * Servlet implementation class InsertControle
 */
@SuppressWarnings("serial")
@WebServlet(name="InsertControle", urlPatterns = "/InsertControle")
public class InsertControle extends HttpServlet {
	@SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String equipamento = request.getParameter("equipamento");
            String data = request.getParameter("data");
            String concentracao = request.getParameter("concentracao");
            String ph = request.getParameter("ph");
            String cont_visual = request.getParameter("cont_visual");
            String nivel = request.getParameter("nivel");
            String skimmer = request.getParameter("skimmer");
                      
            ControleFluido c = new ControleFluido();
            
            c.setEquipamento(EquipamentoDAO.getEquipamento(Integer.parseInt(equipamento)));
            c.setData(Date.valueOf(data));
            c.setConcentracao(Double.parseDouble(concentracao));
            c.setPh(Double.parseDouble(ph));
            c.setContaminacaoVisual(cont_visual);
            c.setNivelReservatorio(nivel);
            c.setSkimmer(skimmer);
            
            c.setConMax(c.getEquipamento().getConsentracaoMax());
            c.setConMin(c.getEquipamento().getConsentracaoMin());
            c.setPhMax(c.getEquipamento().getLimiteMaxPh());
            c.setPhMin(c.getEquipamento().getLimiteMinPh());
            
            int nControle = ControleFluidoDAO.countControlePorEquipamento(c.getEquipamento().getId());
            int equip = c.getEquipamento().getId();
            
            String codigo = "";
            
            if(equip <= 9) {
            	codigo += "00" + equip; 
            } else if(equip >= 10 && equip < 100) {
            	codigo += "0" + equip;
            } else {
            	codigo += equip;
            }
            
            if(nControle <= 9) {
            	codigo  += "00" + nControle; 
            } else if(nControle >= 10 && nControle < 100) {
            	codigo += "0" + nControle;
            } else {
            	codigo += nControle;
            }
            
            c.setCodigo(codigo);
            
            ControleFluidoDAO.insControleFluido(c);
            
            Equipamento e = EquipamentoDAO.getEquipamento(Integer.parseInt(equipamento));
            Visitas r = new Visitas();
            
            if(!VisitasDAO.isRegistro(e.getCliente().getId(), Date.valueOf(data))) {
            	r.setCliente(ClienteDAO.getCliente(e.getCliente().getId()));
            	r.setData(Date.valueOf(data));
            	VisitasDAO.insertVisita(r);
            }
            
            response.sendRedirect("equipamento.jsp?id=" + equipamento + "&op=det");
            
        } catch (SQLException e) {
			System.out.println("Error of database in InsertControle Servlet - " + e);
			response.sendRedirect("ins_controle.jsp?c=1");
		} catch (RadioSelectedException e) {
			System.out.println("Error of RadioButtonSelected in InsertControle Servlet - " + e);
			response.sendRedirect("ins_controle.jsp?c=3");
		}  catch (Exception e) { 
            System.out.println("Error generic em InsertControle Servlet - " + e);
            response.sendRedirect("ins_controle.jsp?c=2");
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
