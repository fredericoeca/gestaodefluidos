package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.Produto;

public class ProdutoDAO {

	public static void insProduto(Produto p) throws Exception, SQLException{
		
		String query = "INSERT INTO produto(pro_tipo, pro_nome, pro_fabricante) VALUES (?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, p.getTipo().getId());
		pst.setString(2, p.getProduto());
		pst.setString(3, p.getFabricante());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			p.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static Produto getProduto(int id) throws Exception, SQLException{
		
		String query = "SELECT pro_tipo, pro_nome, pro_fabricante FROM produto WHERE pro_id = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Produto p = null;
		
		if(rs.next()) {
			p = new Produto();
			p.setId(id);
			p.setTipo(TipoProdutoDAO.getTipoProduto(rs.getInt("pro_tipo")));
			p.setProduto(rs.getString("pro_nome"));
			p.setFabricante(rs.getString("pro_fabricante"));
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return p;
	}
	
	public static ArrayList<Produto> getProdutos() throws Exception, SQLException{
		
		String query = "SELECT pro_id, pro_tipo, pro_nome, pro_fabricante FROM produto ORDER BY pro_tipo ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Produto> produtos = new ArrayList<>();
		Produto p = null;
		
		while(rs.next()) {
			p = new Produto();
			p.setId(rs.getInt("pro_id"));
			p.setTipo(TipoProdutoDAO.getTipoProduto(rs.getInt("pro_tipo")));
			p.setProduto(rs.getString("pro_nome"));
			p.setFabricante(rs.getString("pro_fabricante"));
			produtos.add(p);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return produtos;
	}
	
	public static ArrayList<Produto> getProdutosPorTipo(int id) throws Exception, SQLException{
		
		String query = "SELECT pro_id, pro_nome, pro_fabricante FROM produto WHERE pro_tipo = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Produto> produtos = new ArrayList<>();
		Produto p = null;
		
		while(rs.next()) {
			p = new Produto();
			p.setId(rs.getInt("pro_id"));
			p.setTipo(TipoProdutoDAO.getTipoProduto(id));
			p.setProduto(rs.getString("pro_nome"));
			p.setFabricante(rs.getString("pro_fabricante"));
			produtos.add(p);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return produtos;
	}
	
	public static ArrayList<Produto> searchProdutos(String busca) throws Exception, SQLException{
		
		String query = "SELECT p.pro_id, p.pro_tipo, p.pro_nome, p.pro_fabricante FROM produto AS p "
				+ " INNER JOIN tipo_produto AS t ON p.pro_tipo = t.tp_id WHERE (p.pro_nome LIKE ? "
				+ " OR t.tp_produto LIKE ? OR p.pro_fabricante LIKE ? ) ORDER BY pro_tipo ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, "%"+busca+"%");
		pst.setString(2, "%"+busca+"%");
		pst.setString(3, "%"+busca+"%");
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Produto> produtos = new ArrayList<>();
		Produto p = null;
		
		while(rs.next()) {
			p = new Produto();
			p.setId(rs.getInt("pro_id"));
			p.setTipo(TipoProdutoDAO.getTipoProduto(rs.getInt("pro_tipo")));
			p.setProduto(rs.getString("pro_nome"));
			p.setFabricante(rs.getString("pro_fabricante"));
			produtos.add(p);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return produtos;
	}
	
	public static void updateProduto(Produto p) throws Exception, SQLException {
		
		String query = "UPDATE produto SET pro_nome = ?, pro_fabricante = ?, pro_tipo = ? WHERE pro_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, p.getProduto());
		pst.setString(2, p.getFabricante());
		pst.setInt(3, p.getTipo().getId());
		pst.setInt(4, p.getId());
		pst.executeUpdate();

		con.close();
		pst.close();
	}

	public static void deleteProduto(int id) throws Exception, SQLException {

		String query = "DELETE FROM produto WHERE pro_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();

		con.close();
		pst.close();
	}
}
