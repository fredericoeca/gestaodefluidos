package com.gf.model.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Setor implements Serializable{
	
	//attributes
	private int id;
	private Cliente cliente;
	private String setor;
	
	//constructor
	public Setor() {}
	
	//getters and setters
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return id;
	}
	
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	
	public Cliente getCliente() {
		return cliente;
	}
	
	public void setSetor(String setor) {
		this.setor = setor;
	}
	
	public String getSetor() {
		return setor;
	}
}
