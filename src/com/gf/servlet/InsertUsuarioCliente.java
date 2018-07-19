package com.gf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Message;
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

import com.gf.model.dao.ClienteDAO;
import com.gf.model.dao.UsuarioDAO;
import com.gf.model.dao.exception.EmailExistingException;
import com.gf.model.entity.Cliente;
import com.gf.model.entity.Usuario;

/**
 * Servlet implementation class InsertUsuarioCliente
 */
@SuppressWarnings("serial")
@WebServlet(name="InsertUsuarioCliente", urlPatterns = "/InsertUsuarioCliente")
public class InsertUsuarioCliente extends HttpServlet {
	@SuppressWarnings("unused")
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            request.setCharacterEncoding("UTF-8");
            
            String cliente = request.getParameter("cliente");
            String nome = request.getParameter("nome");
            String telefone = request.getParameter("telefone");
            String celular = request.getParameter("celular");
            String email = request.getParameter("email");
            
            Cliente c = ClienteDAO.getCliente(Integer.parseInt(cliente));
                       
            Usuario u = new Usuario();
            u.setNome(nome);
            u.setTelefone(telefone);
            u.setCelular(celular);
            u.setEmail(email);
            
            String senha = "";
            Random gerador = new Random();
            for (int i = 0; i < 6; i++) {
    	    	senha += gerador.nextInt(10);
    		}
                  
            u.setSenha(senha);
            u.setPerfil(3);
            u.setStatus(true); 
            u.setCliente(c);
            
            UsuarioDAO.insUsuarioCliente(u);
            
            String assunto = "Bem vindo ao Sistema de Gestão de Fluidos";
            String comenta = "Olá, " + nome + ".\n\nSeja bem vindo ao Sistema de Gestão de Fluidos da All Lubrificante.\n\n" + 
            					"Seu acesso é\n\nemail: " + email + "\nsenha: " + senha 
            					+ "\n\nAo acessar o sistema, recomendamos a alteração da senha."
            					+ "\n\nacesse: gestaodefluidos.com.br"
            					+ "\n\n\nSistema Gestão de Fluidos\nAll Lubrificantes.\n\n*Email automático, "
            					+ "favor não responder.";
            
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
             
            Address toAddress = new InternetAddress(email);
            message.addRecipient(Message.RecipientType.TO, toAddress);
            message.setSubject(assunto);
             
            BodyPart corpoPartes = new MimeBodyPart();
            corpoPartes.setText(comenta);
              
            Multipart variasPartes = new MimeMultipart();
            variasPartes.addBodyPart(corpoPartes);
             
            message.setContent(variasPartes);
            Transport.send(message);
            
            response.sendRedirect("cliente.jsp?id=" + cliente + "&op=det&c=9");
        
        } catch (SQLException e) {
			System.out.println("Error of database in InsertUsuarioCliente Servlet - " + e);
			response.sendRedirect("cliente.jsp?c=7");
        } catch (EmailExistingException ex) {
	            System.out.println(ex);
	            response.sendRedirect("cliente.jsp?c=10"); 
		} catch (Exception ex) { 
            System.out.println("Error generic in InsertUsuarioCliente Servlet - " + ex);
            response.sendRedirect("cliente.jsp?c=8");
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
