package com.gf.model.entity;

import java.io.Serializable;
import java.sql.Date;

@SuppressWarnings("serial")
public class Visitas implements Serializable{
	
	//attributes
	private int id;
	private Cliente cliente;
	private Date data;
	
	//constructor
	public Visitas() {}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}
}
