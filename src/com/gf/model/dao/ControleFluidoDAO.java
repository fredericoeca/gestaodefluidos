package com.gf.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.dao.exception.RadioSelectedException;
import com.gf.model.entity.ControleFluido;

public class ControleFluidoDAO {
	
	public static void insControleFluido(ControleFluido cf) throws Exception, SQLException{
		
		if(cf.getContaminacaoVisual() == null || cf.getNivelReservatorio() == null || cf.getSkimmer() == null) {
        	throw new RadioSelectedException(); 
        }
		
		String query = "INSERT INTO controle_fluido(ctr_equipamento, ctr_data, ctr_concentracao, ctr_ph, "
				+ "ctr_contaminacao_visual, ctr_nivel_reservatorio, ctr_skimmer, ctr_conmin, ctr_conmax, "
				+ "ctr_phmin, ctr_phmax, ctr_codigo) VALUES (?,?,?,?,?,?,?,?,?,?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, cf.getEquipamento().getId());
		pst.setDate(2, cf.getData());
		pst.setDouble(3, cf.getConcentracao());
		pst.setDouble(4, cf.getPh());
		pst.setString(5, cf.getContaminacaoVisual());
		pst.setString(6, cf.getNivelReservatorio());
		pst.setString(7, cf.getSkimmer());
		pst.setDouble(8, cf.getConMin());
		pst.setDouble(9, cf.getConMax());
		pst.setDouble(10, cf.getPhMin());
		pst.setDouble(11, cf.getPhMax());
		pst.setString(12, cf.getCodigo());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			cf.setId(rs.getInt(1));
		}
				
		con.close();
		pst.close();
		rs.close();
	}
	
	public static ControleFluido getControleFluido(int id) throws Exception, SQLException{
		
		String query = "SELECT ctr_equipamento, ctr_data, ctr_concentracao, ctr_ph, ctr_contaminacao_visual, "
				+ "ctr_nivel_reservatorio, ctr_skimmer, ctr_conmin, ctr_conmax, ctr_phmin, ctr_phmax, ctr_codigo "
				+ " FROM controle_fluido WHERE ctr_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ControleFluido cf = null;
		
		if(rs.next()) {
			cf = new ControleFluido();
			cf.setId(id);
			cf.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("ctr_equipamento")));
			cf.setData(rs.getDate("ctr_data"));
			cf.setConcentracao(rs.getDouble("ctr_concentracao"));
			cf.setPh(rs.getDouble("ctr_ph"));
			cf.setContaminacaoVisual(rs.getString("ctr_contaminacao_visual"));
			cf.setNivelReservatorio(rs.getString("ctr_nivel_reservatorio"));
			cf.setSkimmer(rs.getString("ctr_skimmer"));
			cf.setConMin(rs.getDouble("ctr_conmin"));
			cf.setConMax(rs.getDouble("ctr_conmax"));
			cf.setPhMin(rs.getDouble("ctr_phmin"));
			cf.setPhMax(rs.getDouble("ctr_phmax"));
			cf.setCodigo(rs.getString("ctr_codigo"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return cf;
	}
	
	public static ArrayList<ControleFluido> getControlesFluido() throws Exception, SQLException{
		
		String query = "SELECT ctr_id, ctr_equipamento, ctr_data, ctr_concentracao, ctr_ph, ctr_contaminacao_visual, "
				+ "ctr_nivel_reservatorio, ctr_skimmer, ctr_conmin, ctr_conmax, ctr_phmin, ctr_phmax, ctr_codigo "
				+ " FROM controle_fluido ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<ControleFluido> controles = new ArrayList<>();
		ControleFluido cf = null;
		
		while(rs.next()) {
			cf = new ControleFluido();
			cf.setId(rs.getInt("ctr_id"));
			cf.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("ctr_equipamento")));
			cf.setData(rs.getDate("ctr_data"));
			cf.setConcentracao(rs.getDouble("ctr_concentracao"));
			cf.setPh(rs.getDouble("ctr_ph"));
			cf.setContaminacaoVisual(rs.getString("ctr_contaminacao_visual"));
			cf.setNivelReservatorio(rs.getString("ctr_nivel_reservatorio"));
			cf.setSkimmer(rs.getString("ctr_skimmer"));
			cf.setConMin(rs.getDouble("ctr_conmin"));
			cf.setConMax(rs.getDouble("ctr_conmax"));
			cf.setPhMin(rs.getDouble("ctr_phmin"));
			cf.setPhMax(rs.getDouble("ctr_phmax"));
			cf.setCodigo(rs.getString("ctr_codigo"));
			controles.add(cf);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return controles;
	}
	
	public static ArrayList<ControleFluido> getControlesPorEquipamento(int id) throws Exception, SQLException{
		
		String query = "SELECT ctr_id, ctr_equipamento, ctr_data, ctr_concentracao, ctr_ph, ctr_contaminacao_visual, "
				+ "ctr_nivel_reservatorio, ctr_skimmer, ctr_conmin, ctr_conmax, ctr_phmin, ctr_phmax, ctr_codigo "
				+ " FROM controle_fluido WHERE ctr_equipamento = ? ORDER BY ctr_data DESC ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<ControleFluido> controles = new ArrayList<>();
		ControleFluido cf = null;
		
		while(rs.next()) {
			cf = new ControleFluido();
			cf.setId(rs.getInt("ctr_id"));
			cf.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("ctr_equipamento")));
			cf.setData(rs.getDate("ctr_data"));
			cf.setConcentracao(rs.getDouble("ctr_concentracao"));
			cf.setPh(rs.getDouble("ctr_ph"));
			cf.setContaminacaoVisual(rs.getString("ctr_contaminacao_visual"));
			cf.setNivelReservatorio(rs.getString("ctr_nivel_reservatorio"));
			cf.setSkimmer(rs.getString("ctr_skimmer"));
			cf.setConMin(rs.getDouble("ctr_conmin"));
			cf.setConMax(rs.getDouble("ctr_conmax"));
			cf.setPhMin(rs.getDouble("ctr_phmin"));
			cf.setPhMax(rs.getDouble("ctr_phmax"));
			cf.setCodigo(rs.getString("ctr_codigo"));
			controles.add(cf);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return controles;
	}
	
	public static ArrayList<ControleFluido> searchControlesFluido(String busca, int id) throws Exception, SQLException{
		
		String query = "SELECT ctr_id, ctr_equipamento, ctr_data, ctr_concentracao, ctr_ph, ctr_contaminacao_visual, "
				+ " ctr_nivel_reservatorio, ctr_skimmer, ctr_conmin, ctr_conmax, ctr_phmin, ctr_phmax, ctr_codigo "
				+ " FROM controle_fluido WHERE (ctr_codigo LIKE ? OR ctr_data LIKE ? ) AND ctr_equipamento = ? ORDER BY ctr_data DESC ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, "%"+busca+"%");
		pst.setString(2, "%"+busca+"%");
		pst.setInt(3, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<ControleFluido> controles = new ArrayList<>();
		ControleFluido cf = null;
		
		while(rs.next()) {
			cf = new ControleFluido();
			cf.setId(rs.getInt("ctr_id"));
			cf.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("ctr_equipamento")));
			cf.setData(rs.getDate("ctr_data"));
			cf.setConcentracao(rs.getDouble("ctr_concentracao"));
			cf.setPh(rs.getDouble("ctr_ph"));
			cf.setContaminacaoVisual(rs.getString("ctr_contaminacao_visual"));
			cf.setNivelReservatorio(rs.getString("ctr_nivel_reservatorio"));
			cf.setSkimmer(rs.getString("ctr_skimmer"));
			cf.setConMin(rs.getDouble("ctr_conmin"));
			cf.setConMax(rs.getDouble("ctr_conmax"));
			cf.setPhMin(rs.getDouble("ctr_phmin"));
			cf.setPhMax(rs.getDouble("ctr_phmax"));
			cf.setCodigo(rs.getString("ctr_codigo"));
			controles.add(cf);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return controles;
	}
	
	public static void updateControle(ControleFluido c) throws Exception, SQLException{
		
		String query = "UPDATE controle_fluido SET ctr_equipamento = ?, ctr_concentracao = ?, ctr_ph = ?, "
				+ " ctr_contaminacao_visual = ?, ctr_nivel_reservatorio = ?, ctr_skimmer = ? WHERE ctr_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, c.getEquipamento().getId());
		pst.setDouble(2, c.getConcentracao());
		pst.setDouble(3, c.getPh());
		pst.setString(4, c.getContaminacaoVisual());
		pst.setString(5, c.getNivelReservatorio());
		pst.setString(6, c.getSkimmer());
		pst.setInt(7, c.getId());
		pst.executeUpdate();
		
		con.close();
		pst.close();
	}
	
	public static void deleteControle(int id) throws Exception, SQLException {
		
		String query = "DELETE FROM controle_fluido WHERE ctr_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();
		
		con.close();
		pst.close();		
	}
	
	public static ArrayList<ControleFluido> getControleForIndex(int id) throws Exception, SQLException {
		
		String query = "SELECT ctr_id, e.equ_cliente, ctr_equipamento, c.cli_id, ctr_data, ctr_concentracao, ctr_ph, "
				+ "ctr_contaminacao_visual, ctr_nivel_reservatorio, ctr_skimmer, ctr_conmin, ctr_conmax, ctr_phmin, ctr_phmax, ctr_codigo "
				+ " FROM controle_fluido INNER JOIN equipamento AS e ON e.equ_id = ctr_equipamento INNER JOIN cliente "
				+ "AS c ON c.cli_id = e.equ_cliente WHERE ctr_data = (SELECT MAX(reg_data) FROM "
				+ "registro_visitas WHERE reg_cliente = ?) "  
				+ "AND c.cli_id = ?; ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.setInt(2, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<ControleFluido> controles = new ArrayList<>();
		ControleFluido cf = null;
		
		while(rs.next()) {
			cf = new ControleFluido();
			cf.setId(rs.getInt("ctr_id"));
			cf.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("ctr_equipamento")));
			cf.setData(rs.getDate("ctr_data"));
			cf.setConcentracao(rs.getDouble("ctr_concentracao"));
			cf.setPh(rs.getDouble("ctr_ph"));
			cf.setContaminacaoVisual(rs.getString("ctr_contaminacao_visual"));
			cf.setNivelReservatorio(rs.getString("ctr_nivel_reservatorio"));
			cf.setSkimmer(rs.getString("ctr_skimmer"));
			cf.setSkimmer(rs.getString("ctr_skimmer"));
			cf.setConMin(rs.getDouble("ctr_conmin"));
			cf.setConMax(rs.getDouble("ctr_conmax"));
			cf.setPhMin(rs.getDouble("ctr_phmin"));
			cf.setPhMax(rs.getDouble("ctr_phmax"));
			cf.setCodigo(rs.getString("ctr_codigo"));
			controles.add(cf);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return controles;
	}
	
	public static ControleFluido getControlePenultimo(int cliente, int equipamento) throws Exception, SQLException {
		
		String query = "SELECT ctr_id, e.equ_cliente, c.cli_id, ctr_data, ctr_concentracao, ctr_ph, ctr_contaminacao_visual, "
				+ "ctr_nivel_reservatorio, ctr_skimmer, ctr_equipamento, ctr_data, ctr_codigo FROM controle_fluido "
				+ "INNER JOIN equipamento AS e ON e.equ_id = ctr_equipamento INNER JOIN cliente AS c ON "
				+ "c.cli_id = e.equ_cliente WHERE ctr_data < (SELECT MAX(reg_data) FROM registro_visitas "
				+ "WHERE reg_cliente = ?) AND ctr_equipamento = ? ORDER BY ctr_data DESC LIMIT 1 "; 
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, cliente);
		pst.setInt(2, equipamento);
		ResultSet rs = pst.executeQuery();
		
		ControleFluido cf = null;
		
		if(rs.next()) {
			cf = new ControleFluido();
			cf.setId(rs.getInt("ctr_id"));
			cf.setEquipamento(EquipamentoDAO.getEquipamento(rs.getInt("ctr_equipamento")));
			cf.setData(rs.getDate("ctr_data"));
			cf.setConcentracao(rs.getDouble("ctr_concentracao"));
			cf.setPh(rs.getDouble("ctr_ph"));
			cf.setContaminacaoVisual(rs.getString("ctr_contaminacao_visual"));
			cf.setNivelReservatorio(rs.getString("ctr_nivel_reservatorio"));
			cf.setSkimmer(rs.getString("ctr_skimmer"));
			cf.setCodigo(rs.getString("ctr_codigo"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return cf;		
	}	
	
	public static boolean isControle(int id, Date data) throws Exception, SQLException {
		
		boolean is = false;
		String query = "SELECT 0 FROM controle_fluido AS c INNER JOIN equipamento AS e ON c.ctr_equipamento = e.equ_id "
				+ " WHERE e.equ_cliente = ? AND c.ctr_data = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.setDate(2, data);
		ResultSet rs = pst.executeQuery();
		
		if(rs.next()) {
			is = true;
		}
		
		con.close();
		pst.close();
		rs.close();
				
		return is;
	}
	
	public static int countControlePorEquipamento(int id) throws Exception, SQLException {
		
		String query = "SELECT COUNT(ctr_id) FROM controle_fluido WHERE ctr_equipamento = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		
		ResultSet rs = pst.executeQuery();
		int n = 0;
		
		if(rs.next()) {
			n = rs.getInt(1);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return n;
	}
	
}
