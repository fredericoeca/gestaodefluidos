package com.gf.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.connection.Conexao;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

/**
 * Servlet implementation class RelatorioEquipamentosPorDataSetor
 */
@SuppressWarnings("serial")
@WebServlet(name="RelatorioEquipamentosPorDataSetor", urlPatterns = "/RelatorioEquipamentosPorDataSetor")
public class RelatorioEquipamentosPorDataSetor extends HttpServlet {
	
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	OutputStream out = null;
    	    	
        try {          
        
        	request.setCharacterEncoding("UTF-8");
            
            String setor = request.getParameter("setor");
            String data = request.getParameter("data");
            
            int id = Integer.parseInt(setor);
            Date d = Date.valueOf(data);
            
            InputStream inputStream = getServletContext().getResourceAsStream("/WEB-INF/reports/repContDataSetor.jasper");
            InputStream logo = getServletContext().getResourceAsStream("/WEB-INF/reports/logo1.png");
            //InputStream subReport = getServletContext().getResourceAsStream("/WEB-INF/reports/repControlePorData_subreport1.jasper");
            String subReport = getServletContext().getResource("/WEB-INF/reports/").toString(); 
            
            Map<String, Object> parametros = new HashMap<String, Object>();
            parametros.put("data", d);
            parametros.put("setor", id);
            parametros.put("logo", logo);
            parametros.put("SUBREPORT_DIR", subReport);
                        
            Connection con = Conexao.getConnection();
        	
            response.setContentType("application/pdf");
            out = response.getOutputStream();
    		
    		JasperReport report = (JasperReport) JRLoader.loadObject(inputStream);
    		JasperPrint jasperPrint = JasperFillManager.fillReport(report, parametros, con);
    		    		
    		JasperExportManager.exportReportToPdfStream(jasperPrint, out);
    	
    		/*JasperViewer jrviewer = new JasperViewer(jasperPrint, false);
            jrviewer.setVisible(true);*/
    		    		
        } catch ( SQLException exc ) {
            exc.printStackTrace();
            System.out.println(exc.getMessage());
        } catch ( JRException exc ) {
            exc.printStackTrace();
            System.out.println(exc.getMessage());
        } catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} finally {
     
            // se não aconteceu nenhum problema, fecha o output stream
            if ( out != null ) {
                out.close();
            }
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
