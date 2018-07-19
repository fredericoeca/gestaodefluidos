package com.gf.model.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.model.dao.ProdutoDAO;
import com.gf.model.entity.Produto;

public class ProdutoController {

	public static Produto getProduto(int id) {
		Produto p = new Produto();
		try {
			p = ProdutoDAO.getProduto(id);
		}catch (SQLException e) {
			System.out.println("Error of database in getProduto - " + e);
		}catch (Exception e) {
			System.out.println("Error generic in getProduto - " + e);
		}
		return p;
	}
	
	public static ArrayList<Produto> getProdutos(){
		ArrayList<Produto> produtos = new ArrayList<>();
		try {
			produtos = ProdutoDAO.getProdutos();
		}catch (SQLException e) {
			System.out.println("Error of database in getProdutos - " + e);
		}catch (Exception e) {
			System.out.println("Error generic in getProdutos - " + e);
		}
		return produtos;
	}
	
	public static ArrayList<Produto> searchProdutos(String busca){
		ArrayList<Produto> produtos = new ArrayList<>();
		try {
			produtos = ProdutoDAO.searchProdutos(busca);
		}catch (SQLException e) {
			System.out.println("Error of database in searchProdutos - " + e);
		}catch (Exception e) {
			System.out.println("Error generic in searchProdutos - " + e);
		}
		return produtos;
	}
	
	public static ArrayList<Produto> getProdutosPorTipo(int id){
		ArrayList<Produto> produtos = new ArrayList<>();
		try {
			produtos = ProdutoDAO.getProdutosPorTipo(id);
		}catch (SQLException e) {
			System.out.println("Error of database in getProdutosPorTipo - " + e);
		}catch (Exception e) {
			System.out.println("Error generic in getProdutosPorTipo - " + e);
		}
		return produtos;
	}
}
