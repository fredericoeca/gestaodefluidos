package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.AlteracaoParametro;

public class AlteracaoParametroDAO {
	
	public static void insertAltParametro(AlteracaoParametro a) throws Exception, SQLException {
		
		String query = "INSERT INTO alteracao_parametro(alt_equipamento, alt_data, alt_item, alt_min_de, alt_min_para,"
				+ " alt_max_de, alt_max_para) VALUES (?,NOW(),?,?,?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, a.getEquipamento().getId());
		pst.setString(2, a.getItem());
		pst.setDouble(3, a.getAltDeMinimo());
		pst.setDouble(4, a.getAltParaMinimo());
		pst.setDouble(5, a.getAltDeMaximo());
		pst.setDouble(6, a.getAltParaMaxima());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			a.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static AlteracaoParametro getAltParametro(int id) throws Exception, SQLException {
		
		String query = "SELECT alt_equipamento, alt_data, alt_item, alt_min_de, alt_min_para, alt_max_de, alt_max_para "
				+ " FROM alteracao_parametro WHERE alt_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		AlteracaoParametro a = null;
		
		if(rs.next()) {
			a = new AlteracaoParametro();
			a.setId(id);
			a.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("alt_equipamento")));
			a.setData(rs.getDate("alt_data"));
			a.setItem(rs.getString("alt_item"));
			a.setAltDeMinimo(rs.getDouble("alt_min_de"));
			a.setAltParaMinimo(rs.getDouble("alt_min_para"));
			a.setAltDeMaximo(rs.getDouble("alt_max_de"));
			a.setAltParaMaxima(rs.getDouble("alt_max_para"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return a;
	}
	
	public static ArrayList<AlteracaoParametro> getAltParametros() throws Exception, SQLException {
		
		String query = "SELECT alt_id, alt_equipamento, alt_data, alt_item, alt_min_de, alt_min_para, "
				+ "alt_max_de, alt_max_para FROM alteracao_parametro ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		AlteracaoParametro a = null;
		ArrayList<AlteracaoParametro> alteracoes = new ArrayList<AlteracaoParametro>();
		
		while(rs.next()) {
			a = new AlteracaoParametro();
			a.setId(rs.getInt("alt_id"));
			a.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("alt_equipamento")));
			a.setData(rs.getDate("alt_data"));
			a.setItem(rs.getString("alt_item"));
			a.setAltDeMinimo(rs.getDouble("alt_min_de"));
			a.setAltParaMinimo(rs.getDouble("alt_min_para"));
			a.setAltDeMaximo(rs.getDouble("alt_max_de"));
			a.setAltParaMaxima(rs.getDouble("alt_max_para"));
			alteracoes.add(a);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return alteracoes;
	}
	
	public static ArrayList<AlteracaoParametro> getAltParametrosPorEquipamento(int id) throws Exception, SQLException {
		
		String query = "SELECT alt_id, alt_equipamento, alt_data, alt_item, alt_min_de, alt_min_para, "
				+ "alt_max_de, alt_max_para FROM alteracao_parametro WHERE alt_equipamento = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		AlteracaoParametro a = null;
		ArrayList<AlteracaoParametro> alteracoes = new ArrayList<AlteracaoParametro>();
		
		while(rs.next()) {
			a = new AlteracaoParametro();
			a.setId(rs.getInt("alt_id"));
			a.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("alt_equipamento")));
			a.setData(rs.getDate("alt_data"));
			a.setItem(rs.getString("alt_item"));
			a.setAltDeMinimo(rs.getDouble("alt_min_de"));
			a.setAltParaMinimo(rs.getDouble("alt_min_para"));
			a.setAltDeMaximo(rs.getDouble("alt_max_de"));
			a.setAltParaMaxima(rs.getDouble("alt_max_para"));
			alteracoes.add(a);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return alteracoes;
	}

}
