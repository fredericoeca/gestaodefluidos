package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.CidadeDAO;
import com.gf.model.entity.Cidade;

public class CidadeController {
	
	public static Cidade getCidade(int id) {
		Cidade c = new Cidade();
		try {
			c = CidadeDAO.getCidade(id);
		} catch(SQLException e) {
			System.out.println("Error SQL in getCidade" + e);
		} catch(Exception ex) {
			System.out.println("Error generic in getCidade" + ex);
		}		
		return c;
	}
	
	public static ArrayList<Cidade> getCidades(){
		ArrayList<Cidade> cidades = new ArrayList<>();
		try {
			cidades = CidadeDAO.getCidades();
		} catch(SQLException e) {
			System.out.println("Error SQL in getCidades" + e);
		} catch(Exception ex) {
			System.out.println("Error generic in getCidades" + ex);
		}		
		return cidades;
	}
	
	public static ArrayList<Cidade> getCidadesPorEstado(int id){
		ArrayList<Cidade> cidades = new ArrayList<>();
		try {
			cidades = CidadeDAO.getCidadesPorEstado(id);
		} catch(SQLException e) {
			System.out.println("Error SQL in getCidades" + e);
		} catch(Exception ex) {
			System.out.println("Error generic in getCidades" + ex);
		}		
		return cidades;
	}

}
