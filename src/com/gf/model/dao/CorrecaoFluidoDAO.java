package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.CorrecaoFluido;

public class CorrecaoFluidoDAO {
	
	public static void insCorrecaoFluido(CorrecaoFluido cf) throws Exception, SQLException{
		
		String query = "INSERT INTO correcao_fluido(cor_controle_fluido, cor_produto, cor_quantidade, cor_data, cor_laudo) "
				+ "VALUES (?,?,?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, cf.getControleFluido().getId());
		pst.setInt(2, cf.getProduto().getId());
		pst.setDouble(3, cf.getQuantidade());
		pst.setDate(4, cf.getData());
		pst.setString(5, cf.getLaudo());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			cf.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static CorrecaoFluido getCorrecaoFluido(int id) throws Exception, SQLException{
		
		String query = "SELECT cor_controle_fluido, cor_produto, cor_quantidade, cor_data, cor_laudo FROM correcao_fluido "
				+ "WHERE cor_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		CorrecaoFluido cf = null;
		
		if(rs.next()) {
			cf = new CorrecaoFluido();
			cf.setId(id);
			cf.setControleFluido(ControleFluidoDAO.getControleFluido(rs.getInt("cor_controle_fluido")));
			cf.setProduto(ProdutoDAO.getProduto(rs.getInt("cor_produto")));
			cf.setQuantidade(rs.getDouble("cor_quantidade"));
			cf.setData(rs.getDate("cor_data"));
			cf.setLaudo(rs.getString("cor_laudo"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return cf;
	}
	
	public static ArrayList<CorrecaoFluido> getCorrecaoPorControle(int id) throws Exception, SQLException{
		
		String query = "SELECT cor_id, cor_controle_fluido, cor_produto, cor_quantidade, cor_data, cor_laudo FROM correcao_fluido "
				+ " WHERE cor_controle_fluido = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<CorrecaoFluido> correcoes = new ArrayList<>();
		CorrecaoFluido cf = null;
		
		while(rs.next()) {
			cf = new CorrecaoFluido();
			cf.setId(rs.getInt("cor_id"));
			cf.setControleFluido(ControleFluidoDAO.getControleFluido(rs.getInt("cor_controle_fluido")));
			cf.setProduto(ProdutoDAO.getProduto(rs.getInt("cor_produto")));
			cf.setQuantidade(rs.getDouble("cor_quantidade"));
			cf.setData(rs.getDate("cor_data"));
			cf.setLaudo(rs.getString("cor_laudo"));
			correcoes.add(cf);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return correcoes;
	}
	
	public static ArrayList<CorrecaoFluido> getCorrecoesFluido() throws Exception, SQLException{
		
		String query = "SELECT cor_id, cor_controle_fluido, cor_produto, cor_quantidade, cor_data, cor_laudo "
				+ " FROM correcao_fluido";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<CorrecaoFluido> correcoes = new ArrayList<>();
		CorrecaoFluido cf = null;
		
		while(rs.next()) {
			cf = new CorrecaoFluido();
			cf.setId(rs.getInt("cor_id"));
			cf.setControleFluido(ControleFluidoDAO.getControleFluido(rs.getInt("cor_controle_fluido")));
			cf.setProduto(ProdutoDAO.getProduto(rs.getInt("cor_produto")));
			cf.setQuantidade(rs.getDouble("cor_quantidade"));
			cf.setData(rs.getDate("cor_data"));
			cf.setLaudo(rs.getString("cor_laudo"));
			correcoes.add(cf);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return correcoes;
	}
	
	public static boolean isCorrecao(int id) throws Exception, SQLException {
		
		String query = "SELECT cor_id FROM correcao_fluido WHERE cor_controle_fluido = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		boolean isCor = rs.next();
		
		con.close();
		pst.close();
		rs.close();
		
		return isCor;
	}
	
	public static void updateCorrecao(CorrecaoFluido c) throws Exception, SQLException {
		
		String query = "UPDATE correcao_fluido SET cor_produto = ?, cor_quantidade = ?, "
				+ " cor_laudo = ? WHERE cor_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, c.getProduto().getId());
		pst.setDouble(2, c.getQuantidade());
		pst.setString(3, c.getLaudo());
		pst.setInt(4, c.getId());
		pst.executeUpdate();
		
		con.close();
		pst.close();		
	}
	
	public static void deleteCorrecao(int id) throws Exception, SQLException {
		
		String query = "DELETE FROM correcao_fluido WHERE cor_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();
		
		con.close();
		pst.close();	
	}
}
