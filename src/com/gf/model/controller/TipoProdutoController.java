package com.gf.model.controller;

import java.util.ArrayList;

import com.gf.model.dao.TipoProdutoDAO;
import com.gf.model.entity.TipoProduto;

public class TipoProdutoController {

	public static TipoProduto getTipoProduto(int id) {
		TipoProduto tp = new TipoProduto();
		try {
			tp = TipoProdutoDAO.getTipoProduto(id);
		}catch (Exception e) {
			System.out.println("Error generic in getTipoProduto - " + e);
		}
		return tp;
	}
	
	public static ArrayList<TipoProduto> getTiposProduto(){
		ArrayList<TipoProduto> tipos = new ArrayList<>();
		try {
			tipos = TipoProdutoDAO.getTipoProdutos();
		}catch (Exception e) {
			System.out.println("Error generic in getTiposProduto - " + e);
		}
		return tipos;
	}
}
