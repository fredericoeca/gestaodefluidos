package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.Equipamento;

public class EquipamentoDAO {
	
public static void insEquipamento(Equipamento e) throws Exception, SQLException{
		
		String query = "INSERT INTO equipamento(equ_cliente, equ_tipo, equ_fabricante, equ_tag, equ_setor, equ_modelo, "
				+ "equ_ponto_lubrificacao, equ_produto, equ_volume, equ_con_minima, equ_con_maxima, equ_limite_max_ph, "
				+ "equ_limite_min_ph) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, e.getCliente().getId());
		pst.setString(2, e.getTipo());
		pst.setString(3, e.getFabricante());
		pst.setString(4, e.getTag());
		pst.setString(5, e.getSetor());
		pst.setString(6, e.getModelo());
		pst.setString(7, e.getPontoLubrificacao());
		pst.setInt(8, e.getProduto().getId());
		pst.setDouble(9, e.getVolume());
		pst.setDouble(10, e.getConsentracaoMin());
		pst.setDouble(11, e.getConsentracaoMax());
		pst.setDouble(12, e.getLimiteMaxPh());
		pst.setDouble(13, e.getLimiteMinPh());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			e.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static Equipamento getEquipamento(int id) throws Exception, SQLException{
		
		String query = "SELECT equ_cliente, equ_tipo, equ_fabricante, equ_tag, equ_setor, equ_modelo, equ_ponto_lubrificacao, "
				+ "equ_produto, equ_volume, equ_con_minima, equ_con_maxima, equ_limite_max_ph, equ_limite_min_ph "
				+ " FROM equipamento WHERE equ_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Equipamento e = null;
		
		if(rs.next()) {
			e = new Equipamento();
			e.setId(id);
			e.setCliente(ClienteDAO.getCliente(rs.getInt("equ_cliente")));
			e.setTipo(rs.getString("equ_tipo"));
			e.setFabricante(rs.getString("equ_fabricante"));
			e.setTag(rs.getString("equ_tag"));
			e.setSetor(rs.getString("equ_setor"));
			e.setModelo(rs.getString("equ_modelo"));
			e.setPontoLubrificacao(rs.getString("equ_ponto_lubrificacao"));
			e.setProduto(ProdutoDAO.getProduto(rs.getInt("equ_produto")));
			e.setVolume(rs.getDouble("equ_volume"));
			e.setConsentracaoMin(rs.getDouble("equ_con_minima"));
			e.setConsentracaoMax(rs.getDouble("equ_con_maxima"));
			e.setLimiteMaxPh(rs.getDouble("equ_limite_max_ph"));
			e.setLimiteMinPh(rs.getDouble("equ_limite_min_ph"));
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return e;
	}
	
	public static ArrayList<Equipamento> getEquipamentos() throws Exception, SQLException{
		
		String query = "SELECT equ_id, equ_cliente, equ_tipo, equ_fabricante, equ_tag, equ_setor, equ_modelo, equ_ponto_lubrificacao, "
				+ "equ_produto, equ_volume, equ_con_minima, equ_con_maxima, equ_limite_max_ph, equ_limite_min_ph "
				+ " FROM equipamento ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		Equipamento e = null;
		
		while(rs.next()) {
			e = new Equipamento();
			e.setId(rs.getInt("equ_id"));
			e.setCliente(ClienteDAO.getCliente(rs.getInt("equ_cliente")));
			e.setTipo(rs.getString("equ_tipo"));
			e.setFabricante(rs.getString("equ_fabricante"));
			e.setTag(rs.getString("equ_tag"));
			e.setSetor(rs.getString("equ_setor"));
			e.setModelo(rs.getString("equ_modelo"));
			e.setPontoLubrificacao(rs.getString("equ_ponto_lubrificacao"));
			e.setProduto(ProdutoDAO.getProduto(rs.getInt("equ_produto")));
			e.setVolume(rs.getDouble("equ_volume"));
			e.setConsentracaoMin(rs.getDouble("equ_con_minima"));
			e.setConsentracaoMax(rs.getDouble("equ_con_maxima"));
			e.setLimiteMaxPh(rs.getDouble("equ_limite_max_ph"));
			e.setLimiteMinPh(rs.getDouble("equ_limite_min_ph"));
			equipamentos.add(e);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return equipamentos;
	}
	
	public static ArrayList<Equipamento> getEquipamentosPorCliente(int id) throws Exception, SQLException{
		
		String query = "SELECT equ_id, equ_cliente, equ_tipo, equ_fabricante, equ_tag, equ_setor, equ_modelo, equ_ponto_lubrificacao, "
				+ "equ_produto, equ_volume, equ_con_minima, equ_con_maxima, equ_limite_max_ph, equ_limite_min_ph "
				+ " FROM equipamento WHERE equ_cliente = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		Equipamento e = null;
		
		while(rs.next()) {
			e = new Equipamento();
			e.setId(rs.getInt("equ_id"));
			e.setCliente(ClienteDAO.getCliente(rs.getInt("equ_cliente")));
			e.setTipo(rs.getString("equ_tipo"));
			e.setFabricante(rs.getString("equ_fabricante"));
			e.setTag(rs.getString("equ_tag"));
			e.setSetor(rs.getString("equ_setor"));
			e.setModelo(rs.getString("equ_modelo"));
			e.setPontoLubrificacao(rs.getString("equ_ponto_lubrificacao"));
			e.setProduto(ProdutoDAO.getProduto(rs.getInt("equ_produto")));
			e.setVolume(rs.getDouble("equ_volume"));
			e.setConsentracaoMin(rs.getDouble("equ_con_minima"));
			e.setConsentracaoMax(rs.getDouble("equ_con_maxima"));
			e.setLimiteMaxPh(rs.getDouble("equ_limite_max_ph"));
			e.setLimiteMinPh(rs.getDouble("equ_limite_min_ph"));
			equipamentos.add(e);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return equipamentos;
	}
	
	public static ArrayList<Equipamento> getEquipamentosPorSetor(int id) throws Exception, SQLException{
		
		String query = "SELECT equ_id, equ_cliente, equ_tipo, equ_fabricante, equ_tag, equ_setor, equ_modelo, equ_ponto_lubrificacao, "
				+ "equ_produto, equ_volume, equ_con_minima, equ_con_maxima, equ_limite_max_ph, equ_limite_min_ph "
				+ " FROM equipamento INNER JOIN equipamento_setor AS es ON equ_id = es.es_equipamento WHERE es.es_setor = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		Equipamento e = null;
		
		while(rs.next()) {
			e = new Equipamento();
			e.setId(rs.getInt("equ_id"));
			e.setCliente(ClienteDAO.getCliente(rs.getInt("equ_cliente")));
			e.setTipo(rs.getString("equ_tipo"));
			e.setFabricante(rs.getString("equ_fabricante"));
			e.setTag(rs.getString("equ_tag"));
			e.setSetor(rs.getString("equ_setor"));
			e.setModelo(rs.getString("equ_modelo"));
			e.setPontoLubrificacao(rs.getString("equ_ponto_lubrificacao"));
			e.setProduto(ProdutoDAO.getProduto(rs.getInt("equ_produto")));
			e.setVolume(rs.getDouble("equ_volume"));
			e.setConsentracaoMin(rs.getDouble("equ_con_minima"));
			e.setConsentracaoMax(rs.getDouble("equ_con_maxima"));
			e.setLimiteMaxPh(rs.getDouble("equ_limite_max_ph"));
			e.setLimiteMinPh(rs.getDouble("equ_limite_min_ph"));
			equipamentos.add(e);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return equipamentos;
	}
	
	public static ArrayList<Equipamento> searchEquipamentos(String busca, int id) throws Exception, SQLException{
		
		String query = "SELECT equ_id, equ_cliente, equ_tipo, equ_fabricante, equ_tag, equ_setor, equ_modelo, equ_ponto_lubrificacao, "
				+ " equ_produto, equ_volume, equ_con_minima, equ_con_maxima, equ_limite_max_ph, equ_limite_min_ph "
				+ " FROM equipamento INNER JOIN produto AS p ON equ_produto = p.pro_id WHERE ( equ_tag LIKE ? "
				+ "OR equ_tipo LIKE ? OR equ_setor LIKE ? OR equ_fabricante LIKE ? OR p.pro_nome LIKE ? )" 
				+ " AND equ_cliente = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, "%"+busca+"%");
		pst.setString(2, "%"+busca+"%");
		pst.setString(3, "%"+busca+"%");
		pst.setString(4, "%"+busca+"%");
		pst.setString(5, "%"+busca+"%");
		pst.setInt(6, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		Equipamento e = null;
		
		while(rs.next()) {
			e = new Equipamento();
			e.setId(rs.getInt("equ_id"));
			e.setCliente(ClienteDAO.getCliente(rs.getInt("equ_cliente")));
			e.setTipo(rs.getString("equ_tipo"));
			e.setFabricante(rs.getString("equ_fabricante"));
			e.setTag(rs.getString("equ_tag"));
			e.setSetor(rs.getString("equ_setor"));
			e.setModelo(rs.getString("equ_modelo"));
			e.setPontoLubrificacao(rs.getString("equ_ponto_lubrificacao"));
			e.setProduto(ProdutoDAO.getProduto(rs.getInt("equ_produto")));
			e.setVolume(rs.getDouble("equ_volume"));
			e.setConsentracaoMin(rs.getDouble("equ_con_minima"));
			e.setConsentracaoMax(rs.getDouble("equ_con_maxima"));
			e.setLimiteMaxPh(rs.getDouble("equ_limite_max_ph"));
			e.setLimiteMinPh(rs.getDouble("equ_limite_min_ph"));
			equipamentos.add(e);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return equipamentos;
	}
	
	public static ArrayList<Equipamento> searchEquipamentosSetor(String busca, int id) throws Exception, SQLException{
		
		String query = "SELECT equ_id, equ_cliente, equ_tipo, equ_fabricante, equ_tag, equ_setor, equ_modelo, equ_ponto_lubrificacao, "
				+ " equ_produto, equ_volume, equ_con_minima, equ_con_maxima, equ_limite_max_ph, equ_limite_min_ph "
				+ " FROM equipamento INNER JOIN produto AS p ON equ_produto = p.pro_id INNER JOIN equipamento_setor AS es ON "
				+ " equ_id = es.es_equipamento WHERE ( equ_tag LIKE ? OR equ_modelo LIKE "
				+ " OR equ_tipo LIKE ? OR equ_setor LIKE ? OR equ_fabricante LIKE ? OR p.pro_nome LIKE ? )" 
				+ " AND es.es_setor = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, "%"+busca+"%");
		pst.setString(2, "%"+busca+"%");
		pst.setString(3, "%"+busca+"%");
		pst.setString(4, "%"+busca+"%");
		pst.setString(5, "%"+busca+"%");
		pst.setInt(6, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		Equipamento e = null;
		
		while(rs.next()) {
			e = new Equipamento();
			e.setId(rs.getInt("equ_id"));
			e.setCliente(ClienteDAO.getCliente(rs.getInt("equ_cliente")));
			e.setTipo(rs.getString("equ_tipo"));
			e.setFabricante(rs.getString("equ_fabricante"));
			e.setTag(rs.getString("equ_tag"));
			e.setSetor(rs.getString("equ_setor"));
			e.setModelo(rs.getString("equ_modelo"));
			e.setPontoLubrificacao(rs.getString("equ_ponto_lubrificacao"));
			e.setProduto(ProdutoDAO.getProduto(rs.getInt("equ_produto")));
			e.setVolume(rs.getDouble("equ_volume"));
			e.setConsentracaoMin(rs.getDouble("equ_con_minima"));
			e.setConsentracaoMax(rs.getDouble("equ_con_maxima"));
			e.setLimiteMaxPh(rs.getDouble("equ_limite_max_ph"));
			e.setLimiteMinPh(rs.getDouble("equ_limite_min_ph"));
			equipamentos.add(e);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return equipamentos;
	}
	
	public static void updateEquipamento(Equipamento e) throws Exception, SQLException {
		
		String query = "UPDATE equipamento SET equ_cliente = ?, equ_tipo = ?, equ_fabricante = ?, equ_tag = ?, equ_setor = ?,"
				+ " equ_ponto_lubrificacao = ?, equ_produto = ?, equ_volume = ?, equ_con_minima = ?, equ_con_maxima = ?, "
				+ " equ_limite_max_ph = ?, equ_limite_min_ph = ?, equ_modelo = ? WHERE equ_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, e.getCliente().getId());
		pst.setString(2, e.getTipo());
		pst.setString(3, e.getFabricante());
		pst.setString(4, e.getTag());
		pst.setString(5, e.getSetor());
		pst.setString(6, e.getPontoLubrificacao());
		pst.setInt(7, e.getProduto().getId());
		pst.setDouble(8, e.getVolume());
		pst.setDouble(9, e.getConsentracaoMin());
		pst.setDouble(10, e.getConsentracaoMax());
		pst.setDouble(11, e.getLimiteMaxPh());
		pst.setDouble(12, e.getLimiteMinPh());
		pst.setString(13, e.getModelo());
		pst.setInt(14, e.getId());
		pst.executeUpdate();
		
		con.close();
		pst.close();
	}
	
	public static void deleteEquipamento(int id) throws Exception, SQLException {
		
		String query = "DELETE FROM equipamento WHERE equ_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();
		
		con.close();
		pst.close();
	}
	
	public static void insertEquipamentoSetor(int e, int s) throws SQLException, Exception {
		
		String query = "INSERT INTO equipamento_setor(es_setor, es_equipamento) VALUES (?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, s);
		pst.setInt(2, e);
		pst.executeUpdate();
			
		pst.close();
		con.close();
	}
	
	public static boolean isEquipSetor(int e, int s) throws SQLException, Exception{
		
		boolean isReg = false;
		
		String query = "SELECT 0 FROM equipamento_setor WHERE es_equipamento = ? AND es_setor = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, e);
		pst.setInt(2, s);
		ResultSet rs = pst.executeQuery();
				
		if(rs.next()) {
			isReg = true;
		}
			
		con.close();
		pst.close();
		rs.close();
		
		return isReg;
	}
	
	public static boolean isEquipCliente(int cliente) throws SQLException, Exception {
		
		boolean isReg = false;
		
		String query = "SELECT 0 FROM equipamento WHERE equ_cliente = ? LIMIT 0, 1 ";
		
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
