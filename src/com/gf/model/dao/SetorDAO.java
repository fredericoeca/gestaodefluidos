package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.Setor;

public class SetorDAO {
	
	public static void insSetor(Setor s) throws Exception, SQLException {
		
		String query = "INSERT INTO setor(set_cliente, set_setor) VALUES (?,?) ";
				
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, s.getCliente().getId());
		pst.setString(2, s.getSetor());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			s.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static Setor getSetor(int id) throws Exception, SQLException {
		
		String query = "SELECT set_cliente, set_setor FROM setor WHERE set_id = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Setor s = null;
		
		if(rs.next()) {
			s = new Setor();
			s.setId(id);
			s.setCliente(ClienteDAO.getCliente(rs.getInt("set_cliente")));
			s.setSetor(rs.getString("set_setor"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return s;
	}
	
	public static ArrayList<Setor> getSetores() throws Exception, SQLException {
		
		String query = "SELECT set_id, set_cliente, set_setor FROM setor ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Setor> setores = new ArrayList<>();
		Setor s = null;
		
		while(rs.next()) {
			s = new Setor();
			s.setId(rs.getInt("set_id"));
			s.setCliente(ClienteDAO.getCliente(rs.getInt("set_cliente")));
			s.setSetor(rs.getString("set_setor"));
			setores.add(s);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return setores;
	}
	
	public static ArrayList<Setor> getSetoresPorCliente(int id) throws Exception, SQLException {
		
		String query = "SELECT set_id, set_cliente, set_setor FROM setor WHERE set_cliente = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Setor> setores = new ArrayList<>();
		Setor s = null;
		
		while(rs.next()) {
			s = new Setor();
			s.setId(rs.getInt("set_id"));
			s.setCliente(ClienteDAO.getCliente(rs.getInt("set_cliente")));
			s.setSetor(rs.getString("set_setor"));
			setores.add(s);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return setores;
	}
	
	public static ArrayList<Setor> getSetoresPorContato(int id) throws Exception, SQLException {
		
		String query = "SELECT set_id, set_cliente, set_setor FROM setor INNER JOIN contato_setor AS cs ON "
				+ " cs.cs_setor = set_id WHERE cs.cs_contato = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Setor> setores = new ArrayList<>();
		Setor s = null;
		
		while(rs.next()) {
			s = new Setor();
			s.setId(rs.getInt("set_id"));
			s.setCliente(ClienteDAO.getCliente(rs.getInt(id)));
			s.setSetor(rs.getString("set_setor"));
			setores.add(s);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return setores;
	}
	
	public static Setor getSetorContato(int id) throws Exception, SQLException {
		
		String query = "SELECT set_id, set_cliente, set_setor FROM setor INNER JOIN contato_setor AS cs ON "
				+ " cs.cs_setor = set_id WHERE cs.cs_contato = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Setor s = null;
		
		if(rs.next()) {
			s = new Setor();
			s.setId(rs.getInt("set_id"));
			s.setCliente(ClienteDAO.getCliente(rs.getInt("set_cliente")));
			s.setSetor(rs.getString("set_setor"));			
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return s;
	}
	
	public static void updateSetor(Setor s) throws Exception, SQLException {
		
		String query = "UPDATE setor SET set_setor = ? WHERE set_id = ? ";
		
		System.out.println(s.getSetor() + s.getId());
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, s.getSetor());
		pst.setInt(2, s.getId());
		pst.executeUpdate();

		con.close();
		pst.close();
	}

	public static void deleteSetor(int id) throws Exception, SQLException {

		String query = "DELETE FROM setor WHERE set_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();

		con.close();
		pst.close();
	}
	
}
