package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.Estado;

public class EstadoDAO {
	
	public static Estado getEstado(int id) throws Exception, SQLException{
		
		String query = "SELECT est_nome, est_uf FROM estado WHERE est_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Estado e = null;
		if(rs.next()){
			e = new Estado();
			e.setId(id);
			e.setEstado(rs.getString("est_nome"));
			e.setUf(rs.getString("est_uf"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return e;
	}
	
	public static ArrayList<Estado> getEstados() throws Exception, SQLException{
		
		String query = "SELECT est_id, est_nome, est_uf FROM estado ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Estado> estados = new ArrayList<>();
		Estado e = null;
		while(rs.next()){
			e = new Estado();
			e.setId(rs.getInt("est_id"));
			e.setEstado(rs.getString("est_nome"));
			e.setUf(rs.getString("est_uf"));
			estados.add(e);
		}
		
		con.close();
		rs.close();
		pst.close();
		
		return estados;
		
	}
	
	public static ArrayList<Estado> getEstadosIfCidade() throws Exception, SQLException{
		
		String query = "SELECT est_id, est_nome, est_uf FROM estado ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Estado> estados = new ArrayList<>();
		Estado e = null;
		
		while(rs.next()){
			
				e = new Estado();
				e.setId(rs.getInt("est_id"));
				e.setEstado(rs.getString("est_nome"));
				e.setUf(rs.getString("est_uf"));
			if(CidadeDAO.isEstadoCidade(e.getId())) {
				estados.add(e);
			}
		}
		
		con.close();
		rs.close();
		pst.close();
		
		return estados;
		
	}

}
