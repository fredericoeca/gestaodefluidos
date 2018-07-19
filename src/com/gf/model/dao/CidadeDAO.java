package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.dao.exception.CidadeExistingException;
import com.gf.model.entity.Cidade;

public class CidadeDAO {
	
	public static void insertCidade(Cidade c) throws Exception, SQLException{
		
		if(existCidade(c.getCidade())) {
			throw new CidadeExistingException();
		}
		
		String query = "INSERT INTO cidade(cid_estado, cid_nome) VALUES (?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, c.getEstado().getId());
		pst.setString(2, c.getCidade());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			c.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
 	
	public static Cidade getCidade(int id) throws Exception, SQLException{
		
		String query = "SELECT cid_estado, cid_nome FROM cidade WHERE cid_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Cidade c = null;
		if(rs.next()){
			c = new Cidade();
			c.setId(id);
			c.setEstado(EstadoDAO.getEstado(rs.getInt("cid_estado")));
			c.setCidade(rs.getString("cid_nome"));			
		}
		
		con.close();
		pst.close();
		rs.close();		
		
		return c;
	}
	
	public static ArrayList<Cidade> getCidades() throws Exception, SQLException{
		
		String query = "SELECT cid_id, cid_estado, cid_nome FROM cidade ORDER BY cid_nome ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Cidade> cidades = new ArrayList<>();
		Cidade c = null;
		while(rs.next()){
			c = new Cidade();
			c.setId(rs.getInt("cid_id"));
			c.setEstado(EstadoDAO.getEstado(rs.getInt("cid_estado")));
			c.setCidade(rs.getString("cid_nome"));		
			cidades.add(c);
		}
		
		con.close();
		rs.close();
		pst.close();
		
		return cidades;
	}
	
	public static ArrayList<Cidade> getCidadesPorEstado(int id) throws Exception, SQLException{
		
		String query = "SELECT cid_id, cid_estado, cid_nome FROM cidade WHERE cid_estado = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Cidade> cidades = new ArrayList<>();
		Cidade c = null;
		while(rs.next()){
			c = new Cidade();
			c.setId(rs.getInt("cid_id"));
			c.setEstado(EstadoDAO.getEstado(rs.getInt("cid_estado")));
			c.setCidade(rs.getString("cid_nome"));		
			cidades.add(c);
		}
		
		con.close();
		rs.close();
		pst.close();
		
		return cidades;
	}
	
	public static boolean isEstadoCidade(int id) throws Exception, SQLException{
		
		boolean isEstado = false;
		String query = "SELECT 0 FROM cidade WHERE cid_estado = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		if(rs.next()) {
			isEstado = true;
		}
		
		con.close();
		pst.close();
		rs.close();
		return isEstado;
	}
	
	public static boolean existCidade(String cidade) throws Exception, SQLException{
		
		boolean isCidade = false;
		String query = "SELECT 0 FROM cidade WHERE cid_nome = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, cidade);
		ResultSet rs = pst.executeQuery();
		
		if(rs.next()) {
			isCidade = true;
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return isCidade;
	}
	
}
