package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.CorrecaoFluidoDAO;
import com.gf.model.entity.CorrecaoFluido;

public class CorrecaoFluidoController {

	public static CorrecaoFluido getCorrecaoFluido(int id) {
		CorrecaoFluido cf = new CorrecaoFluido();
		try {
			cf = CorrecaoFluidoDAO.getCorrecaoFluido(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getCorrecaoFluido - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getCorrecaoFluido - " + e);
		}
		return cf;
	}
	
	public static ArrayList<CorrecaoFluido> getCorrecaoPorControle(int id) {
		ArrayList<CorrecaoFluido> correcoes = new ArrayList<>();
		try {
			correcoes = CorrecaoFluidoDAO.getCorrecaoPorControle(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getCorrecoesFluidoPorControle - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getCorrecoesFluidoPorControle - " + e);
		}
		return correcoes;
	}
	
	public static ArrayList<CorrecaoFluido> getCorrecoesFluido(){
		ArrayList<CorrecaoFluido> correcoes = new ArrayList<>();
		try {
			correcoes = CorrecaoFluidoDAO.getCorrecoesFluido();
		} catch (SQLException e) {
			System.out.println("Error of database in getCorrecoesFluido - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getCorrecoesFluido - " + e);
		}
		return correcoes;
	}
	
	public static boolean isCorrecao(int id) {
		boolean isCor = false;
		try {
			isCor = CorrecaoFluidoDAO.isCorrecao(id);
		} catch (SQLException e) {
			System.out.println("Error of database in isCorrecao - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in isCorrecao - " + e);
		}
		return isCor;
	}
}
