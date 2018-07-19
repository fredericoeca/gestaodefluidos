package com.gf.model.entity;

import java.io.Serializable;
import java.sql.Date;

@SuppressWarnings("serial")
public class AlteracaoParametro implements Serializable{
	
	//attributes
	private int id;
	private Equipamento equipamento;
	private Date data;
	private String item;
	private double altDeMinimo;
	private double altParaMinimo;
	private double altDeMaximo;
	private double altParaMaxima;
	
	//constructor
	public AlteracaoParametro() {
		// TODO Auto-generated constructor stub
	}
	
	//getters and setters
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public Equipamento getEquipamento() {
		return equipamento;
	}
	
	public void setEquipamento(Equipamento equipamento) {
		this.equipamento = equipamento;
	}
	
	public Date getData() {
		return data;
	}
	
	public void setData(Date data) {
		this.data = data;
	}
	
	public String getItem() {
		return item;
	}
	
	public void setItem(String item) {
		this.item = item;
	}
	
	public double getAltDeMinimo() {
		return altDeMinimo;
	}
	
	public void setAltDeMinimo(double altDeMinimo) {
		this.altDeMinimo = altDeMinimo;
	}
	
	public double getAltParaMinimo() {
		return altParaMinimo;
	}
	
	public void setAltParaMinimo(double altParaMinimo) {
		this.altParaMinimo = altParaMinimo;
	}
	
	public double getAltDeMaximo() {
		return altDeMaximo;
	}

	public void setAltDeMaximo(double altDeMaximo) {
		this.altDeMaximo = altDeMaximo;
	}
	
	public double getAltParaMaxima() {
		return altParaMaxima;
	}
	
	public void setAltParaMaxima(double altParaMaxima) {
		this.altParaMaxima = altParaMaxima;
	}
}
