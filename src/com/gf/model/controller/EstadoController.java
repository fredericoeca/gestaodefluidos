package com.gf.model.controller;

import java.util.ArrayList;

import com.gf.model.dao.EstadoDAO;
import com.gf.model.entity.Estado;

public class EstadoController {
	
	public static Estado getEstado(int id) {
		Estado e = new Estado();
		try {
			e = EstadoDAO.getEstado(id);
		}catch (Exception ex) {
			System.out.println("Error generic in getEstado - " + ex);
		}
		return e;
	}

	public static ArrayList<Estado> getEstados(){
		ArrayList<Estado> estados = new ArrayList<>();
		try {
			estados = EstadoDAO.getEstados();
		}catch (Exception ex) {
			System.out.println("Error generic in getEstados - " + ex);
		}
		return estados;
	}
	
	public static ArrayList<Estado> getEstadosIfCidade(){
		ArrayList<Estado> estados = new ArrayList<>();
		try {
			estados = EstadoDAO.getEstadosIfCidade();
		}catch (Exception ex) {
			System.out.println("Error generic in getEstadosIfCidade - " + ex);
		}
		return estados;
	}
}
