package com.gf.model.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Usuario implements Serializable{

	//attributes
	private int id;
	private String nome;
	private String telefone;
	private String celular;
	private String email;
	private String senha;
	private int perfil;
	private boolean status;
	private Cliente cliente;
	
	//constructor
	public Usuario(){}

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

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getCelular() {
		return celular;
	}

	public void setCelular(String celular) {
		this.celular = celular;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public int getPerfil() {
		return perfil;
	}
	
	public void setPerfil(int perfil) {
		this.perfil = perfil;
	}

	public boolean isStatus() {
		return status;
	}
	
	public void setStatus(boolean status) {
		this.status = status;
	}
	
	public Cliente getCliente() {
		return cliente;
	}
	
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
}
