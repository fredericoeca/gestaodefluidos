package com.gf.model.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Estado implements Serializable{

	//attributes
	private int id;
	private String estado;
	private String uf;
	
	//constructor
	public Estado(){}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	public String getUf() {
		return uf;
	}
	
	public void setUf(String uf) {
		this.uf = uf;
	}
	
}
