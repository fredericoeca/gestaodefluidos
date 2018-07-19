package com.gf.model.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Cliente implements Serializable{
	
	//attributes
	private int id;
	private String nome;
	private Usuario usuario;
	private Cidade cidade;
	private Estado estado;
	
	//constructor
	public Cliente(){}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}	
	
	public Cidade getCidade() {
		return cidade;
	}
	
	public void setCidade(Cidade cidade) {
		this.cidade = cidade;
	}
	
	public Estado getEstado() {
		return estado;
	}
	
	public void setEstado(Estado estado) {
		this.estado = estado;
	}
}
