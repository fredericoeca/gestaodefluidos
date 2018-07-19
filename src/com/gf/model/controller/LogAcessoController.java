package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.LogAcessoDAO;
import com.gf.model.entity.LogAcesso;

public class LogAcessoController {
	
	public static LogAcesso getLog(int id) {
		LogAcesso log = new LogAcesso();
		try {
			log = LogAcessoDAO.getLog(id);
		}catch (Exception e) {
			System.out.println("Error generic in getLog - " + e);
		}
		return log;
	}
	
	public static ArrayList<LogAcesso> getLogs(){
		ArrayList<LogAcesso> logs = new ArrayList<>();
		try {
			logs = LogAcessoDAO.getLogs();
		}catch (Exception e) {
			System.out.println("Error generic in getLogs - " + e);
		}
		return logs;
	}
	
	public static ArrayList<LogAcesso> searchUsuarioLog(String email){
		ArrayList<LogAcesso> logs = new ArrayList<LogAcesso>();
		try {
			logs = LogAcessoDAO.serchLogUsuario(email);
		}catch (SQLException e) {
			System.out.println("Error SQL in seachUsuLogs - " + e);
		}catch (Exception e) {
			System.out.println("Error generic in seachUsuLogs - " + e);
		}
		return logs;
	}
}
