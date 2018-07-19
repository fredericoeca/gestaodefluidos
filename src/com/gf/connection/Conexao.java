package com.gf.connection;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Conexao {
	
	public static Connection getConnection() throws Exception{
		InitialContext context = new InitialContext();
		DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/gestao_fluido");
		try{
			return ds.getConnection();
		} catch (SQLException e) {
			throw new Exception(e.getMessage());
		}
	}
}



















