package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.TipoProduto;

public class TipoProdutoDAO {
	
	public static void insTipoProduto(TipoProduto tp) throws Exception, SQLException{
		
		String query = "INSERT INTO tipo_produto(tp_produto) VALUES (?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setString(1, tp.getTipo());
		pst.executeUpdate();
		ResultSet rs = pst.getGeneratedKeys();
		
		if(rs.next()) {
			tp.setId(rs.getInt(1));
		}		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static TipoProduto getTipoProduto(int id) throws Exception, SQLException{
		
		String query = "SELECT tp_produto FROM tipo_produto WHERE tp_id = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		TipoProduto tp = null;
		
		if(rs.next()) {
			tp = new TipoProduto();
			tp.setId(id);
			tp.setTipo(rs.getString("tp_produto"));
		}
		con.close();
		pst.close();
		rs.close();
		
		return tp;
	}
	
	public static ArrayList<TipoProduto> getTipoProdutos() throws Exception, SQLException{
		
		String query = "SELECT tp_id, tp_produto FROM tipo_produto ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<TipoProduto> tipos = new ArrayList<>();
		TipoProduto tp = null;
		
		while(rs.next()) {
			tp = new TipoProduto();
			tp.setId(rs.getInt("tp_id"));
			tp.setTipo(rs.getString("tp_produto"));
			tipos.add(tp);
		}
		con.close();
		pst.close();
		rs.close();
		
		return tipos;
	}

}
