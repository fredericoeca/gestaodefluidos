package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.ControleFluidoDAO;
import com.gf.model.entity.ControleFluido;

public class ControleFluidoController {

	public static ControleFluido getControleFluido(int id) {
		ControleFluido cf = new ControleFluido();
		try {
			cf = ControleFluidoDAO.getControleFluido(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getControleFluido - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getControleFluido - " + e);
		}
		return cf;
	}
	
	public static ArrayList<ControleFluido> getControlesFluido(){
		ArrayList<ControleFluido> controles = new ArrayList<>();
		try {
			controles = ControleFluidoDAO.getControlesFluido();
		} catch (SQLException e) {
			System.out.println("Error of database in getControlesFluido - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getControlesFluido - " + e);
		}
		return controles;
	}
	
	public static ArrayList<ControleFluido> getControlesPorEquipamento(int id){
		ArrayList<ControleFluido> controles = new ArrayList<>();
		try {
			controles = ControleFluidoDAO.getControlesPorEquipamento(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getControlesPorEquipamento - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getControlesPorEquipamento - " + e);
		}
		return controles;
	}
	
	public static ArrayList<ControleFluido> searchControlesFluido(String busca, int id){
		ArrayList<ControleFluido> controles = new ArrayList<>();
		try {
			controles = ControleFluidoDAO.searchControlesFluido(busca, id);
		} catch (SQLException e) {
			System.out.println("Error of database in searchControlesFluido - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in searchControlesFluido - " + e);
		}
		return controles;
	}
	
	public static ArrayList<ControleFluido> getControleForIndex(int id) {
		ArrayList<ControleFluido> controles = new ArrayList<>();
		try {
			controles = ControleFluidoDAO.getControleForIndex(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getControlesPorIndex - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getControlesPorIndex - " + e);
		}
		return controles;
	}
	
	public static double[] difControleAnterior(double conc, double ph, int cliente, int equipamento) {
		ControleFluido cf = new ControleFluido();
		double[] dif = new double[2];
		try {
			cf = ControleFluidoDAO.getControlePenultimo(cliente, equipamento);
			dif[0] = conc - cf.getConcentracao();
			dif[1] = ph - cf.getPh();			
		} catch (SQLException e) {
			System.out.println("Error of database in getControleFluido - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getControleFluido - " + e);
		}
		return dif;
	}
		
}
