package com.gf.model.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.dao.exception.EmailExistingException;
import com.gf.model.dao.exception.SenhaInvalidaException;
import com.gf.model.dao.exception.UsuarioInativoException;
import com.gf.model.entity.Usuario;

import sun.misc.BASE64Encoder;

public class UsuarioDAO {
	
	public static Usuario login(String email, String senha) throws Exception, SQLException{
		
		if(verifyStatus(email) == false) {
			throw new UsuarioInativoException();
		}
		
		Usuario uLogado = null;
		
		String query = "SELECT usu_id, usu_nome, usu_telefone, usu_celular, usu_email, usu_senha, usu_perfil, usu_status, "
				+ " usu_cliente FROM usuario WHERE usu_email = ? AND usu_senha = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, email);
		pst.setString(2, criptografa(senha));
		ResultSet rs = pst.executeQuery();
		
		if(rs.next()) {
			uLogado = new Usuario();
			uLogado.setId(rs.getInt("usu_id"));
			uLogado.setNome(rs.getString("usu_nome"));
			uLogado.setTelefone(rs.getString("usu_telefone"));
			uLogado.setCelular(rs.getString("usu_celular"));
			uLogado.setEmail(email);
			uLogado.setSenha(senha);
			uLogado.setPerfil(rs.getInt("usu_perfil"));
			uLogado.setStatus(rs.getBoolean("usu_status"));
			uLogado.setCliente(ClienteDAO.getCliente(rs.getInt("usu_cliente")));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return uLogado;
	}
 	
	public static boolean verifyStatus(String email) throws Exception, SQLException {
			
		String query = "SELECT usu_status FROM usuario WHERE usu_email = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, email);
		ResultSet rs = pst.executeQuery();
		
		if(rs.next()){
			if(rs.getBoolean("usu_status") == false){
				return false;
			}
		}

		con.close();
		pst.close();
		rs.close();
		
		return true;
		
	}
	
	public static boolean emailExisting(String email) throws Exception, SQLException{
		
		boolean isUsu = false;
		
		String query = "SELECT usu_id FROM usuario WHERE usu_email = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, email);
		ResultSet rs = pst.executeQuery();
		
		if(rs.next()) {
			isUsu = true;
		}
		con.close();
		pst.close();
		rs.close();
		
		return isUsu;
	}
	
	public static void insUsuario(Usuario u) throws Exception, SQLException{
		
		if(emailExisting(u.getEmail())) {
			throw new EmailExistingException();
		}
		
		String query = "INSERT INTO usuario(usu_nome, usu_telefone, usu_celular, usu_email, usu_senha, usu_perfil, "
				+ "usu_status ) VALUES (?,?,?,?,?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setString(1, u.getNome());;
		pst.setString(2, u.getTelefone());
		pst.setString(3, u.getCelular());
		pst.setString(4, u.getEmail());
		pst.setString(5, criptografa(u.getSenha()));
		pst.setInt(6, u.getPerfil());
		pst.setBoolean(7, u.isStatus());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			u.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static void insUsuarioCliente(Usuario u) throws Exception, SQLException{
		
		if(emailExisting(u.getEmail())) {
			throw new EmailExistingException();
		}
		
		String query = "INSERT INTO usuario(usu_nome, usu_telefone, usu_celular, usu_email, usu_senha, usu_perfil, "
				+ "usu_status, usu_cliente ) VALUES (?,?,?,?,?,?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setString(1, u.getNome());;
		pst.setString(2, u.getTelefone());
		pst.setString(3, u.getCelular());
		pst.setString(4, u.getEmail());
		pst.setString(5, criptografa(u.getSenha()));
		pst.setInt(6, u.getPerfil());
		pst.setBoolean(7, u.isStatus());
		pst.setInt(8, u.getCliente().getId());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			u.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static Usuario getUsuario(int id) throws Exception, SQLException{
		
		String query = "SELECT usu_nome, usu_telefone, usu_celular, usu_email, usu_senha, usu_perfil, usu_status, "
				+ " usu_cliente FROM usuario WHERE usu_id = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Usuario u = null;
		
		if(rs.next()) {
			u = new Usuario();
			u.setId(id);
			u.setNome(rs.getString("usu_nome"));
			u.setTelefone(rs.getString("usu_telefone"));
			u.setCelular(rs.getString("usu_celular"));
			u.setEmail(rs.getString("usu_email"));
			u.setSenha(rs.getString("usu_senha"));
			u.setPerfil(rs.getInt("usu_perfil"));
			u.setStatus(rs.getBoolean("usu_status"));
			u.setCliente(ClienteDAO.getCliente(rs.getInt("usu_cliente")));
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return u;
	}
	
	public static Usuario getUsuarioEmail(String email) throws Exception, SQLException{
		
		String query = "SELECT usu_id FROM usuario WHERE usu_email = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, email);
		ResultSet rs = pst.executeQuery();
		
		Usuario u = null;
		
		if(rs.next()) {
			u = new Usuario();
			u.setId(rs.getInt("usu_id"));			
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return u;
	}
	
	public static ArrayList<Usuario> getUsuarios() throws Exception, SQLException{
		
		String query = "SELECT usu_id, usu_nome, usu_telefone, usu_celular, usu_email, usu_senha, usu_perfil, usu_status,"
				+ " usu_cliente FROM usuario ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Usuario> usuarios = new ArrayList<>();
		Usuario u = null;
		
		while(rs.next()) {
			u = new Usuario();
			u.setId(rs.getInt("usu_id"));
			u.setNome(rs.getString("usu_nome"));
			u.setTelefone(rs.getString("usu_telefone"));
			u.setCelular(rs.getString("usu_celular"));
			u.setEmail(rs.getString("usu_email"));
			u.setSenha(rs.getString("usu_senha"));
			u.setPerfil(rs.getInt("usu_perfil"));
			u.setStatus(rs.getBoolean("usu_status"));
			u.setCliente(ClienteDAO.getCliente(rs.getInt("usu_cliente")));
			usuarios.add(u);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return usuarios;		
	}
	
	public static ArrayList<Usuario> searchUsuarios(String busca) throws Exception, SQLException{
		
		String query = "SELECT usu_id, usu_nome, usu_telefone, usu_celular, usu_email, usu_senha, usu_perfil, usu_status, usu_cliente "
				+ " FROM usuario WHERE (usu_nome LIKE ? OR usu_telefone LIKE ? OR usu_celular LIKE ? "
				+ " OR usu_email LIKE ?);";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, "%"+busca+"%");
		pst.setString(2, "%"+busca+"%");
		pst.setString(3, "%"+busca+"%");
		pst.setString(4, "%"+busca+"%");
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Usuario> usuarios = new ArrayList<>();
		Usuario u = null;
		
		while(rs.next()) {
			u = new Usuario();
			u.setId(rs.getInt("usu_id"));
			u.setNome(rs.getString("usu_nome"));
			u.setTelefone(rs.getString("usu_telefone"));
			u.setCelular(rs.getString("usu_celular"));
			u.setEmail(rs.getString("usu_email"));
			u.setSenha(rs.getString("usu_senha"));
			u.setPerfil(rs.getInt("usu_perfil"));
			u.setStatus(rs.getBoolean("usu_status"));
			u.setCliente(ClienteDAO.getCliente(rs.getInt("usu_cliente")));
			usuarios.add(u);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return usuarios;		
	}

	public static void updateUsuario(Usuario u) throws Exception, SQLException {

		String query = "UPDATE usuario SET usu_nome = ?, usu_telefone = ?, usu_celular = ?, usu_email = ? WHERE usu_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, u.getNome());
		pst.setString(2, u.getTelefone());
		pst.setString(3, u.getCelular());
		pst.setString(4, u.getEmail());
		pst.setInt(5, u.getId());
		pst.executeUpdate();

		con.close();
		pst.close();
	}

	public static void updateSenha(Usuario u, String novaSenha) throws Exception, SQLException {
		
		if(!verifySenha(u.getId(),u.getSenha())){
		 throw new SenhaInvalidaException();
		}		
		
		String query = "UPDATE usuario SET usu_senha = ? WHERE usu_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, criptografa(novaSenha));
		pst.setInt(2, u.getId());
		pst.executeUpdate();

		con.close();
		pst.close();
	}

	public static boolean verifySenha(int id, String senha) throws Exception, SQLException {

		boolean isSenha = false;
		String query = "SELECT 0 FROM usuario WHERE usu_id = ? AND usu_senha = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.setString(2, criptografa(senha));
		ResultSet rs = pst.executeQuery();

		if(rs.next()){
		   isSenha = true;
		}
		
		con.close();
		pst.close();
		rs.close();	

		return isSenha;
	}

	public static void updatePerfil(Usuario u) throws Exception, SQLException {

		String query = "UPDATE usuario SET usu_perfil = ? WHERE usu_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, u.getPerfil());
		pst.setInt(2, u.getId());
		pst.executeUpdate();

		con.close();
		pst.close();
	}
	
	public static void updateStatus(Usuario u) throws Exception, SQLException {

		String query = "UPDATE usuario SET usu_status = ? WHERE usu_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setBoolean(1, u.isStatus());
		pst.setInt(2, u.getId());
		pst.executeUpdate();

		con.close();
		pst.close();
	}

	public static void resetSenha(Usuario u) throws Exception, SQLException {

		String query = "UPDATE usuario SET usu_senha = ? WHERE usu_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, criptografa(u.getSenha()));
		pst.setInt(2, u.getId());
		pst.executeUpdate();

		con.close();
		pst.close();
	}

	public static void deleteUsuario(int id) throws Exception, SQLException {

		String query = "DELETE FROM usuario WHERE usu_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();

		con.close();
		pst.close();
	}
	
	public static String criptografa(String senha){
		
		try{
			MessageDigest digest = MessageDigest.getInstance("MD5");
			digest.update(senha.getBytes());
			BASE64Encoder encoder = new BASE64Encoder();
			return encoder.encode(digest.digest());
		}catch(NoSuchAlgorithmException ns){
			ns.printStackTrace();
		}
		return senha;
	}

}
