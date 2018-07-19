package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.SetorDAO;
import com.gf.model.entity.Setor;

public class SetorController {
	
	public static Setor getSetor(int id) {
		Setor s = new Setor();
		try {
			s = SetorDAO.getSetor(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getSetor - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getSetor - " + e);
		}
		return s;
	}
	
	public static ArrayList<Setor> getSetores() {
		ArrayList<Setor> s = new ArrayList<>();
		try {
			s = SetorDAO.getSetores();
		} catch (SQLException e) {
			System.out.println("Error of database in getSetores - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getSetores - " + e);
		}
		return s;
	}
	
	public static ArrayList<Setor> getSetoresPorCliente(int id) {
		ArrayList<Setor> s = new ArrayList<>();
		try {
			s = SetorDAO.getSetoresPorCliente(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getSetoresPorCliente - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getSetoresPorCliente - " + e);
		}
		return s;
	}
	
	public static ArrayList<Setor> getSetoresPorContato(int id) {
		ArrayList<Setor> s = new ArrayList<>();
		try {
			s = SetorDAO.getSetoresPorContato(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getSetoresPorContato - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getSetoresPorContato - " + e);
		}
		return s;
	}
	
	public static Setor getSetorContato(int id) {
		Setor s = new Setor();
		try {
			s = SetorDAO.getSetorContato(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getSetorContato - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getSetorContato - " + e);
		}
		return s;
	}

}
