package com.gf.model.controller;

import java.util.ArrayList;

import com.gf.model.dao.EquipamentoDAO;
import com.gf.model.entity.Equipamento;

public class EquipamentoController {
	
	public static Equipamento getEquipamento(int id) {
		Equipamento e = new Equipamento();
		try {
			e = EquipamentoDAO.getEquipamento(id);
		}catch (Exception ex) {
			System.out.println("Error generic in getEquipamento - " + ex);
		}
		return e;
	}
	
	public static boolean isEquSetor(int e, int s) {
		boolean b = false;
		try {
			b = EquipamentoDAO.isEquipSetor(e, s);
		}catch (Exception ex) {
			System.out.println("Error generic in isEquipamentoSetor - " + ex);
		}
		return b;
	}
	
	public static boolean isEquipCliente(int cliente) {
		boolean b = false;
		try {
			b = EquipamentoDAO.isEquipCliente(cliente);
		}catch (Exception ex) {
			System.out.println("Error generic in isEquipamentoCliente - " + ex);
		}
		return b;
	}
	
	public static ArrayList<Equipamento> getEquipamentos(){
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		try {
			equipamentos = EquipamentoDAO.getEquipamentos();
		}catch (Exception e) {
			System.out.println("Error generic in getEquipamentos - " + e);
		}
		return equipamentos;
	}
	
	public static ArrayList<Equipamento> getEquipamentosPorCliente(int id){
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		try {
			equipamentos = EquipamentoDAO.getEquipamentosPorCliente(id);
		}catch (Exception e) {
			System.out.println("Error generic in getEquipamentosPorCliente - " + e);
		}
		return equipamentos;
	}
	
	public static ArrayList<Equipamento> getEquipamentosPorSetor(int id){
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		try {
			equipamentos = EquipamentoDAO.getEquipamentosPorSetor(id);
		}catch (Exception e) {
			System.out.println("Error generic in getEquipamentosPorSetor - " + e);
		}
		return equipamentos;
	}
	
	public static ArrayList<Equipamento> searchEquipamentos(String busca, int id){
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		try {
			equipamentos = EquipamentoDAO.searchEquipamentos(busca, id);
		}catch (Exception e) {
			System.out.println("Error generic in searchEquipamentosPorCliente - " + e);
		}
		return equipamentos;
	}
	
	public static ArrayList<Equipamento> searchEquipamentosSetor(String busca, int id){
		ArrayList<Equipamento> equipamentos = new ArrayList<>();
		try {
			equipamentos = EquipamentoDAO.searchEquipamentosSetor(busca, id);
		}catch (Exception e) {
			System.out.println("Error generic in searchEquipamentosPorSetor - " + e);
		}
		return equipamentos;
	}

}
