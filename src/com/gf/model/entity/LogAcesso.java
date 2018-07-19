package com.gf.model.entity;

import java.io.Serializable;
import java.sql.Timestamp;

@SuppressWarnings("serial")
public class LogAcesso implements Serializable{
	
	//attributes
	private int id;
	private Usuario usuario;
	private Timestamp data;
	
	//constructor
	public LogAcesso() {}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Timestamp getData() {
		return data;
	}
	
	public void setData(Timestamp data) {
		this.data = data;
	}
}
