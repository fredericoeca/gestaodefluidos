package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.LogAcesso;

public class LogAcessoDAO {
	
	public static void regLog(LogAcesso la) throws Exception, SQLException{
		
		String query = "INSERT INTO log_acesso(log_usuario, log_data) VALUES (?, NOW()) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setInt(1, la.getUsuario().getId());
		pst.executeUpdate();
		ResultSet rs = pst.getGeneratedKeys();
		
		if(rs.next()) {
			la.setId(rs.getInt(1));
		}		
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static LogAcesso getLog(int id) throws Exception, SQLException{
		
		String query = "SELECT log_usuario, log_data FROM log_acesso WHERE log_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		LogAcesso la = null;
		
		if(rs.next()) {
			la = new LogAcesso();
			la.setId(id);
			la.setUsuario(UsuarioDAO.getUsuario(rs.getInt("log_usuario")));
			la.setData(rs.getTimestamp("log_data"));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return la;
	}

	public static ArrayList<LogAcesso> getLogs() throws Exception, SQLException{
		
		String query = "SELECT log_id, log_usuario, log_data FROM log_acesso ORDER BY log_id DESC ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<LogAcesso> logs = new ArrayList<>();
		LogAcesso la = null;
		
		while(rs.next()) {
			la = new LogAcesso();
			la.setId(rs.getInt("log_id"));
			la.setUsuario(UsuarioDAO.getUsuario(rs.getInt("log_usuario")));
			la.setData(rs.getTimestamp("log_data"));
			logs.add(la);
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return logs;
	}
	
	public static ArrayList<LogAcesso> serchLogUsuario(String email) throws Exception, SQLException{
		
		String query = "SELECT l.log_id, l.log_usuario, l.log_data FROM log_acesso AS l "
				+ "INNER JOIN usuario AS u ON l.log_usuario = u.usu_id " 
				+ "WHERE u.usu_email LIKE ? ORDER BY log_id DESC ";
				
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, "%"+email+"%");
		ResultSet rs = pst.executeQuery();
		
		ArrayList<LogAcesso> logs = new ArrayList<>();
		LogAcesso la = null;
		
		while(rs.next()) {
			la = new LogAcesso();
			la.setId(rs.getInt("log_id"));
			la.setUsuario(UsuarioDAO.getUsuario(rs.getInt("log_usuario")));
			la.setData(rs.getTimestamp("log_data"));
			logs.add(la);
		}

		con.close();
		pst.close();
		rs.close();
		
		return logs;
	}
	
}
