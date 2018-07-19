package com.gf.model.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Produto implements Serializable{
	
	//attributes
	private int id;
	private TipoProduto tipo;
	private String produto;
	private String fabricante;
	
	//constructor
	public Produto(){}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public TipoProduto getTipo() {
		return tipo;
	}
	
	public void setTipo(TipoProduto tipo) {
		this.tipo = tipo;
	}

	public String getProduto() {
		return produto;
	}

	public void setProduto(String produto) {
		this.produto = produto;
	}

	public String getFabricante() {
		return fabricante;
	}

	public void setFabricante(String fabricante) {
		this.fabricante = fabricante;
	}
	
}
