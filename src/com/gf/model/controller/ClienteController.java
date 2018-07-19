package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.ClienteDAO;
import com.gf.model.entity.Cliente;

public class ClienteController {
	
	public static Cliente getCliente(int id) {
		Cliente c = new Cliente();
		try {
			c = ClienteDAO.getCliente(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getCliente - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getCliente - " + e);
		} 
		return c;
	}
	
	public static ArrayList<Cliente> getClientes() {
		ArrayList<Cliente> clientes = new ArrayList<>();
		try {
			clientes = ClienteDAO.getClientes();
		} catch (SQLException e) {
			System.out.println("Error of database in getClientes - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getClientes - " + e);
		} 
		return clientes;
	}
	
	public static ArrayList<Cliente> getClientesPorUsuario(int id) {
		ArrayList<Cliente> clientes = new ArrayList<>();
		try {
			clientes = ClienteDAO.getClientesPorUsuario(id);
		} catch (SQLException e) {
			System.out.println("Error of database in getClientePorUsuario - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in getClientesPorUsuario - " + e);
		} 
		return clientes;
	}
	
	public static ArrayList<Cliente> searchClientes(String busca) {
		ArrayList<Cliente> clientes = new ArrayList<>();
		try {
			clientes = ClienteDAO.searchClientes(busca);
		} catch (SQLException e) {
			System.out.println("Error of database in searchClientes - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in searchClientes - " + e);
		} 
		return clientes;
	}
	
	public static ArrayList<Cliente> searchClientesPorUsuario(String busca, int id) {
		ArrayList<Cliente> clientes = new ArrayList<>();
		try {
			clientes = ClienteDAO.searchClientesPorUsuario(busca, id);
		} catch (SQLException e) {
			System.out.println("Error of database in searchClientesPorUsuario - " + e);
		} catch (Exception e) {
			System.out.println("Error generic in searchClientesPorUsuario - " + e);
		} 
		return clientes;
	}
	
}
