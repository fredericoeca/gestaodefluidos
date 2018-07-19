package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gf.model.dao.UsuarioDAO;
import com.gf.model.entity.Usuario;

/**
 * Servlet implementation class ResetSenha
 */
@SuppressWarnings("serial")
@WebServlet(name="ResetSenha", urlPatterns = "/ResetSenha")
public class ResetSenha extends HttpServlet {
	
    @SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
request.setCharacterEncoding("UTF-8");
            
            String to = request.getParameter("email");
            String senhaAleatoria = "";
            
            Random gerador = new Random();
            for (int i = 0; i < 6; i++) {
    	    	senhaAleatoria += gerador.nextInt(10);
    		}
            
            Usuario u = new Usuario();
			u.setId(UsuarioDAO.getUsuarioEmail(to).getId());
			u.setSenha(senhaAleatoria);
					
			UsuarioDAO.resetSenha(u);          
            String assunto = "Restaura��o de senha";
            String comenta = "Ol�, " + to
            		+ ",\n\nsua senha �: " + senhaAleatoria + "\n\nAo acessar o sistema, recomendamos altera-la."
            		+ "\n\nacesse: gestaodefluidos.com.br"
            		+ "\n\n\nSistema Gest�o de Fluidos\nAll Lubrificantes.\n\n*Email autom�tico, n�o responder.";
            
            Properties props = new Properties();
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gestaodefluidos.com.br");
        	props.put("mail.smtp.auth", "true");
        	//props.put("mail.debug", "true");
        	props.put("mail.smtp.port", "587");
        	props.put("mail.smtp.socketFactory.port", "465");
        	props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
                 
            Session session = Session.getDefaultInstance(props,
                    new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() 
                {
                      return new PasswordAuthentication("contato@gestaodefluidos.com.br", "Alle2017");
                }
            });
            
            //session.setDebug(true);
             
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("contato@gestaodefluidos.com.br"));
             
            Address toAddress = new InternetAddress(to);
            message.addRecipient(Message.RecipientType.TO, toAddress);
            message.setSubject(assunto);
             
            BodyPart corpoPartes = new MimeBodyPart();
            corpoPartes.setText(comenta);
              
            Multipart variasPartes = new MimeMultipart();
            variasPartes.addBodyPart(corpoPartes);
             
            message.setContent(variasPartes);
            Transport.send(message);
            
            response.sendRedirect("usuarios.jsp?c=14");
            
            } catch (MessagingException e) {
            	System.out.println("Email nao pode ser enviado! " + e.getMessage());
            	response.sendRedirect("usuarios.jsp?c=15");
            } catch (SQLException e) {
            	System.out.println("Error SQL in EmailResetSenha Servlet! " + e.getMessage());
            	response.sendRedirect("usuarios.jsp?c=16");
			} catch (Exception e) {
            	System.out.println("Error generic in EmailResetSenha Servlet! " + e.getMessage());
            	response.sendRedirect("usuarios.jsp?c=17");
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
