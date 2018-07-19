package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gf.model.dao.LogAcessoDAO;
import com.gf.model.dao.UsuarioDAO;
import com.gf.model.dao.exception.UsuarioInativoException;
import com.gf.model.entity.LogAcesso;
import com.gf.model.entity.Usuario;

/**
 *
 * @author Frederico
 */
@SuppressWarnings("serial")
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");                
            PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            //Recuperar login e senha
            String email = request.getParameter("txt_email");
            String senha = request.getParameter("txt_senha");
                                   	
            Usuario u = UsuarioDAO.login(email, senha);
            if(u != null){
            	
                HttpSession sessao = request.getSession();
                sessao.setAttribute("uLogado", u);
                
                LogAcesso l = new LogAcesso();
                l.setUsuario(u);
                
                LogAcessoDAO.regLog(l);
                
                response.sendRedirect("home.jsp");
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp?c=1");
                rd.include(request, response);
            }
            out.close();
        } catch (SQLException ex){
            System.out.println(ex);
            response.sendRedirect("index.jsp?c=2");
        } catch (UsuarioInativoException ex){
            System.out.println(ex);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp?c=4");
            rd.forward(request, response);
        }catch (Exception ex){
            System.out.println(ex);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp?c=3");
            rd.forward(request, response);
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
