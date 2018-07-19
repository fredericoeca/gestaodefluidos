package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.VisitasDAO;
import com.gf.model.entity.Visitas;


public class VisitasController {
	
	public static Visitas getVisita(int id) {
		Visitas r = new Visitas();
		try {
			r = VisitasDAO.getVisita(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getRegistro - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getRegistro - " + e);
		}
		return r;
	}

	public static ArrayList<Visitas> getRegistros() {
		ArrayList<Visitas> registros = new ArrayList<>();
		try {
			registros = VisitasDAO.getRegistros();
		} catch (SQLException e) {
			System.out.println("Error of database in getRegistros - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getRegistros - " + e);
		}
		return registros;
	}
	
	public static ArrayList<Visitas> getRegistrosPorCliente(int id) {
		ArrayList<Visitas> registros = new ArrayList<>();
		try {
			registros = VisitasDAO.getVisitasPorCliente(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getRegistroPorCliente - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getRegistroPorCliente - " + e);
		}
		return registros;
	}
	
	public static ArrayList<Integer> getAnoVisita(int id) {					
		ArrayList<Integer> anos = new ArrayList<>();		
		try {
			anos = VisitasDAO.getAnoVisita(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getAnosVisitas - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getAnosVisitas - " + e);
		}
		return anos;
	}
	
	public static ArrayList<Integer> getMesesVisita(int id, int ano) {					
		ArrayList<Integer> meses = new ArrayList<>();		
		try {
			meses = VisitasDAO.getMesVisita(id, ano);
		} catch (SQLException e) {
			System.out.println("Error of database in getMesesVisita - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getMesesVisita - " + e);
		}
		return meses;
	}
	
	public static ArrayList<Integer> getDiasVisita(int id, int mes) {					
		ArrayList<Integer> dias = new ArrayList<>();		
		try {
			dias = VisitasDAO.getDiasVisita(id, mes);
		} catch (SQLException e) {
			System.out.println("Error of database in getDiasVisita - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getDiasVisita - " + e);
		}
		return dias;
	}
	
}
