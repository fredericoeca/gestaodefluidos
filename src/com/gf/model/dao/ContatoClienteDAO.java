package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.ContatoCliente;

public class ContatoClienteDAO {
	
	public static void insContato(ContatoCliente cc) throws Exception, SQLException{
		
		String query = "INSERT INTO contato_cliente(con_cliente, con_nome, con_telefone, con_celular, con_email, "
				+ " con_cargo) VALUES (?,?,?,?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, cc.getCliente().getId());
		pst.setString(2, cc.getNome());
		pst.setString(3, cc.getTelefone());
		pst.setString(4, cc.getCelular());
		pst.setString(5, cc.getEmail());
		pst.setString(6, cc.getCargo());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			cc.setId(rs.getInt(1));
		}
				
		pst.close();
		rs.close();
		con.close();
	}
	
	public static ContatoCliente getContatoCliente(int id) throws Exception, SQLException{
		
		String query = "SELECT con_cliente, con_nome, con_telefone, con_celular, con_email, con_cargo FROM contato_cliente "
				+ " WHERE con_id = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ContatoCliente cc = null;
		
		if(rs.next()) {
			cc = new ContatoCliente();
			cc.setId(id);
			cc.setCliente(ClienteDAO.getCliente(rs.getInt("con_cliente")));
			cc.setNome(rs.getString("con_nome"));
			cc.setTelefone(rs.getString("con_telefone"));
			cc.setCelular(rs.getString("con_celular"));
			cc.setEmail(rs.getString("con_email"));
			cc.setCargo(rs.getString("con_cargo"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return cc;
	}
	
	public static ArrayList<ContatoCliente> getContatosCliente() throws Exception, SQLException{
		
		String query = "SELECT con_id, con_cliente, con_nome, con_telefone, con_celular, con_email, con_cargo "
				+ " FROM contato_cliente ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<ContatoCliente> contatos = new ArrayList<>();
		ContatoCliente cc = null;
		
		while(rs.next()) {
			cc = new ContatoCliente();
			cc.setId(rs.getInt("con_id"));
			cc.setCliente(ClienteDAO.getCliente(rs.getInt("con_cliente")));
			cc.setNome(rs.getString("con_nome"));
			cc.setTelefone(rs.getString("con_telefone"));
			cc.setCelular(rs.getString("con_celular"));
			cc.setEmail(rs.getString("con_email"));
			cc.setCargo(rs.getString("con_cargo"));
			contatos.add(cc);
		}	
		
		pst.close();
		rs.close();
		con.close();
		
		return contatos;
	}
	
	public static ArrayList<ContatoCliente> getContatosPorCliente(int id) throws Exception, SQLException{
		
		String query = "SELECT con_id, con_cliente, con_nome, con_telefone, con_celular, con_email, con_cargo "
				+ " FROM contato_cliente WHERE con_cliente = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<ContatoCliente> contatos = new ArrayList<>();
		ContatoCliente cc = null;
		
		while(rs.next()) {
			cc = new ContatoCliente();
			cc.setId(rs.getInt("con_id"));
			cc.setCliente(ClienteDAO.getCliente(rs.getInt("con_cliente")));
			cc.setNome(rs.getString("con_nome"));
			cc.setTelefone(rs.getString("con_telefone"));
			cc.setCelular(rs.getString("con_celular"));
			cc.setEmail(rs.getString("con_email"));
			cc.setCargo(rs.getString("con_cargo"));
			contatos.add(cc);
		}	
		
		pst.close();
		rs.close();
		con.close();
		
		return contatos;
	}
	
	public static ArrayList<ContatoCliente> getContatosPorSetor(int id) throws Exception, SQLException{
		
		String query = "SELECT con_id, con_cliente, con_nome, con_telefone, con_celular, con_email, con_cargo "
				+ " FROM contato_cliente INNER JOIN contato_setor AS cs ON cs.cs_contato = con_id WHERE cs_setor = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<ContatoCliente> contatos = new ArrayList<>();
		ContatoCliente cc = null;
		
		while(rs.next()) {
			cc = new ContatoCliente();
			cc.setId(rs.getInt("con_id"));
			cc.setCliente(ClienteDAO.getCliente(rs.getInt("con_cliente")));
			cc.setNome(rs.getString("con_nome"));
			cc.setTelefone(rs.getString("con_telefone"));
			cc.setCelular(rs.getString("con_celular"));
			cc.setEmail(rs.getString("con_email"));
			cc.setCargo(rs.getString("con_cargo"));
			contatos.add(cc);
		}	
		
		pst.close();
		rs.close();
		con.close();
		
		return contatos;
	}
	
	public static ContatoCliente getContatoPorEmail(String email) throws Exception, SQLException{
		
		String query = "SELECT con_id, con_cliente, con_nome, con_telefone, con_celular, con_email, con_cargo "
				+ " FROM contato_cliente WHERE con_email = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, email);
		ResultSet rs = pst.executeQuery();
		
		ContatoCliente cc = null;
		
		if(rs.next()) {
			cc = new ContatoCliente();
			cc.setId(rs.getInt("con_id"));
			cc.setCliente(ClienteDAO.getCliente(rs.getInt("con_cliente")));
			cc.setNome(rs.getString("con_nome"));
			cc.setTelefone(rs.getString("con_telefone"));
			cc.setCelular(rs.getString("con_celular"));
			cc.setEmail(rs.getString("con_email"));
			cc.setCargo(rs.getString("con_cargo"));
		}	
		
		
		
		pst.close();
		rs.close();
		con.close();
		
		return cc;
	}
	
	public static void updateContato(ContatoCliente c) throws SQLException, Exception {

		String query = "UPDATE contato_cliente SET con_nome = ?, con_telefone = ?, con_celular = ?, con_email = ?, con_cargo = ? "
				+ " WHERE con_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, c.getNome());
		pst.setString(2, c.getTelefone());
		pst.setString(3, c.getCelular());
		pst.setString(4, c.getEmail());
		pst.setString(5, c.getCargo());
		pst.setInt(6, c.getId());
		pst.executeUpdate();

		con.close();
		pst.close();
	}

	public static void deleteContato(int id) throws SQLException, Exception {

		String query = "DELETE FROM contato_cliente WHERE con_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();

		con.close();
		pst.close();
	}
	
	public static void insertContatoSetor(int c, int s) throws SQLException, Exception {
		
		String query = "INSERT INTO contato_setor(cs_setor, cs_contato) VALUES (?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, s);
		pst.setInt(2, c);
		pst.executeUpdate();
			
		pst.close();
		con.close();
	}
	
	public static boolean isContCliente(int cliente) throws SQLException, Exception {
		
		boolean isReg = false;
		
		String query = "SELECT 0 FROM contato_cliente WHERE con_cliente = ? LIMIT 0, 1 ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, cliente);
		ResultSet rs = pst.executeQuery();
				
		if(rs.next()) {
			isReg = true;
		}
			
		con.close();
		pst.close();
		rs.close();
		
		return isReg;
		
	}
}
