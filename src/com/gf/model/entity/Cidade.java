package com.gf.model.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Cidade implements Serializable{
	
	//attributes
	private int id;
	private Estado estado;
	private String cidade;
	
	//constructor
	public Cidade(){}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Estado getEstado() {
		return estado;
	}

	public void setEstado(Estado estado) {
		this.estado = estado;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	
	
}
