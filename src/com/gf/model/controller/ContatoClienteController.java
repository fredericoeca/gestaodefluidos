package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.ContatoClienteDAO;
import com.gf.model.entity.ContatoCliente;

public class ContatoClienteController {

	public static ContatoCliente getContato(int id) {
		ContatoCliente cc = new ContatoCliente();
		try {
			cc = ContatoClienteDAO.getContatoCliente(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getContato - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getContato - " + e);
		}
		return cc;
	}
	
	public static ContatoCliente getContatoEmail(String email) {
		ContatoCliente cc = new ContatoCliente();
		try {
			cc = ContatoClienteDAO.getContatoPorEmail(email);
		} catch (SQLException e) {
			System.out.println("Error of database in getContatoEmail - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getContatoEmail - " + e);
		}
		return cc;
	}
	
	public static boolean isContCliente(int cliente) {
		boolean b = false;
		try {
			b = ContatoClienteDAO.isContCliente(cliente);
		}catch (Exception ex) {
			System.out.println("Error generic in isContatoCliente - " + ex);
		}
		return b;
	}
	
	public static ArrayList<ContatoCliente> getContatos(){
		ArrayList<ContatoCliente> contatos = new ArrayList<>();;
		try {
			contatos = ContatoClienteDAO.getContatosCliente();
		} catch (SQLException e) {
			System.out.println("Error of database in getContatos - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getContatos - " + e);
		}
		return contatos;
	}
	
	public static ArrayList<ContatoCliente> getContatosPorCliente(int id){
		ArrayList<ContatoCliente> contatos = new ArrayList<>();;
		try {
			contatos = ContatoClienteDAO.getContatosPorCliente(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getContatosPorCliente - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getContatosPorCliente - " + e);
		}
		return contatos;
	}
	
	public static ArrayList<ContatoCliente> getContatosPorSetor(int id){
		ArrayList<ContatoCliente> contatos = new ArrayList<>();;
		try {
			contatos = ContatoClienteDAO.getContatosPorSetor(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getContatosPorSetor - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getContatosPorSetor - " + e);
		}
		return contatos;
	}
}
