package com.gf.model.controller;

import java.util.ArrayList;

import com.gf.model.dao.UsuarioDAO;
import com.gf.model.entity.Usuario;

public class UsuarioController {
	
	public static Usuario getUsuario(int id) {
		Usuario u = new Usuario();
		try {
			u = UsuarioDAO.getUsuario(id);
		}catch (Exception e) {
			System.out.println("Error generic in getUsuario - " + e);
		}
		return u;
	}
	
	public static ArrayList<Usuario> getUsuarios(){
		ArrayList<Usuario> usuarios = new ArrayList<>();
		try {
			usuarios = UsuarioDAO.getUsuarios();
		}catch (Exception e) {
			System.out.println("Error generic in getUsuarios - " + e);
		}
		return usuarios;
	}

	public static ArrayList<Usuario> searchUsuarios(String busca){
		ArrayList<Usuario> usuarios = new ArrayList<>();
		try {
			usuarios = UsuarioDAO.searchUsuarios(busca);
		}catch (Exception e) {
			System.out.println("Error generic in getUsuarios - " + e);
		}
		return usuarios;
	}
	
}
