package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.AlteracaoParametroDAO;
import com.gf.model.entity.AlteracaoParametro;

public class AlteracaoParametroController {
	
	public static AlteracaoParametro getAltParametro(int id) {
		AlteracaoParametro a = new AlteracaoParametro();
		try {
			a = AlteracaoParametroDAO.getAltParametro(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getAltParametro - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getAltParametro - " + e);
		} 
		return a;
	}
	
	public static ArrayList<AlteracaoParametro> getAltParametros() {
		ArrayList<AlteracaoParametro> alteracoes = new ArrayList<>();
		try {
			alteracoes = AlteracaoParametroDAO.getAltParametros();
		} catch (SQLException e) {
			System.out.println("Error of database in getAltParametros - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getAltParametros - " + e);
		} 
		return alteracoes;
	}
	
	public static ArrayList<AlteracaoParametro> getAltParametrosPorEquipamento(int id) {
		ArrayList<AlteracaoParametro> alteracoes = new ArrayList<>();
		try {
			alteracoes = AlteracaoParametroDAO.getAltParametrosPorEquipamento(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getAltParametrosPorEquipamento - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getAltParametrosPorEquipamento - " + e);
		} 
		return alteracoes;
	}
	
	

}
