package com.gf.model.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class TipoProduto implements Serializable{

	//attributes
	private int id;
	private String tipo;
	
	//constructor
	public TipoProduto(){}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
}
