package com.gf.model.entity;

import java.io.Serializable;
import java.sql.Date;

@SuppressWarnings("serial")
public class CorrecaoFluido implements Serializable{

	//attributes
	private int id;
	private ControleFluido controleFluido;
	private Produto produto;
	private Date data;
	private double quantidade;
	private String laudo;
	
	//constructor
	public CorrecaoFluido(){}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public ControleFluido getControleFluido() {
		return controleFluido;
	}

	public void setControleFluido(ControleFluido controleFluido) {
		this.controleFluido = controleFluido;
	}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}
	
	public Date getData() {
		return data;
	}
	
	public void setData(Date data) {
		this.data = data;
	}

	public double getQuantidade() {
		return quantidade;
	}
	
	public void setQuantidade(double quantidade) {
		this.quantidade = quantidade;
	}
	
	public String getLaudo() {
		return laudo;
	}
	
	public void setLaudo(String laudo) {
		this.laudo = laudo;
	}
}
