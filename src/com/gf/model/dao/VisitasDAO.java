package com.gf.model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.Visitas;

public class VisitasDAO {
	
	public static void insertVisita(Visitas r) throws SQLException, Exception{
		
		String query = "INSERT INTO registro_visitas(reg_cliente, reg_data) VALUES (?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, r.getCliente().getId());
		pst.setDate(2, r.getData());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			r.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static Visitas getVisita(int id) throws SQLException, Exception{
		
		String query = "SELECT reg_cliente, reg_data FROM registro_visitas WHERE reg_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Visitas r = null;
		
		if(rs.next()) {
			r = new Visitas();
			r.setId(id);
			r.setCliente(ClienteDAO.getCliente(rs.getInt("reg_cliente")));
			r.setData(rs.getDate("reg_data"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return r;
	}
	
	public static ArrayList<Visitas> getRegistros() throws SQLException, Exception{
		
		String query = "SELECT reg_id, reg_cliente, reg_data FROM registro_visitas ORDER BY reg_data DESC LIMIT 100 ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		Visitas r = null;
		ArrayList<Visitas> registros = new ArrayList<>();
		
		while(rs.next()) {
			r = new Visitas();
			r.setId(rs.getInt("reg_id"));
			r.setCliente(ClienteDAO.getCliente(rs.getInt("reg_cliente")));
			r.setData(rs.getDate("reg_data"));
			registros.add(r);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return registros;
	}

	public static ArrayList<Visitas> getVisitasPorCliente(int id) throws SQLException, Exception{
		
		String query = "SELECT reg_id, reg_data FROM registro_visitas WHERE reg_cliente = ? ORDER BY reg_data DESC LIMIT 15 ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Visitas r = null;
		ArrayList<Visitas> registros = new ArrayList<>();
		
		while(rs.next()) {
			r = new Visitas();
			r.setId(rs.getInt("reg_id"));
			r.setCliente(ClienteDAO.getCliente(id));
			r.setData(rs.getDate("reg_data"));
			registros.add(r);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return registros;
	}
	
	public static ArrayList<Integer> getAnoVisita(int id) throws SQLException, Exception{
		
		String query = "SELECT DISTINCT DATE_FORMAT(reg_data, \"%Y\") FROM registro_visitas WHERE reg_cliente = ? "
				+ " ORDER BY reg_data DESC ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Integer> anos = new ArrayList<>();
		
		while(rs.next()) {
			anos.add(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return anos;
	}
	
	public static ArrayList<Integer> getMesVisita(int id, int ano) throws SQLException, Exception{
		
		String query = "SELECT DISTINCT DATE_FORMAT(reg_data, \"%m\") FROM registro_visitas WHERE reg_cliente = ? "
				+ " AND DATE_FORMAT(reg_data, \"%Y\") = ? ORDER BY reg_data DESC ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.setInt(2, ano);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Integer> meses = new ArrayList<>();
		
		while(rs.next()) {
			meses.add(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return meses;
	}
	
	public static ArrayList<Integer> getDiasVisita(int id, int mes) throws SQLException, Exception{
		
		String query = "SELECT DISTINCT DATE_FORMAT(reg_data, \"%d\") FROM registro_visitas WHERE reg_cliente = ? "
				+ " AND DATE_FORMAT(reg_data, \"%m\") = ? ORDER BY reg_data ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.setInt(2, mes);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Integer> dias = new ArrayList<>();
		
		while(rs.next()) {
			dias.add(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return dias;
	}
	
	public static void deleteVisita(int id) throws Exception, SQLException {

		String query = "DELETE FROM registro_visitas WHERE reg_id = ? ";

		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();

		con.close();
		pst.close();
	}
	
	public static boolean isRegistro(int id, Date d) throws SQLException, Exception{
		
		boolean isReg = false;
		
		String query = "SELECT 0 FROM registro_visitas WHERE reg_cliente = ? AND reg_data = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.setDate(2, d);
		ResultSet rs = pst.executeQuery();
				
		if(rs.next()) {
			isReg = true;
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return isReg;
	}
	
	public static int getVisitaClienteData(int id, Date d) throws SQLException, Exception{
				
		String query = "SELECT reg_id FROM registro_visitas WHERE reg_cliente = ? AND reg_data = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.setDate(2, d);
		ResultSet rs = pst.executeQuery();
				
		int r = 0;
		
		if(rs.next()) {
			r = rs.getInt("reg_id");
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return r;
	}
}
