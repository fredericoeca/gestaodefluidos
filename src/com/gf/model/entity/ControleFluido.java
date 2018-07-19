package com.gf.model.entity;

import java.io.Serializable;
import java.sql.Date;

@SuppressWarnings("serial")
public class ControleFluido implements Serializable{

	//attributes
	private int id;
	private String codigo;
	private Equipamento equipamento;
	private Date data;
	private double concentracao;
	private double ph;
	private String contaminacaoVisual;
	private String nivelReservatorio;
	private String skimmer;
	private double conMin;
	private double conMax;
	private double phMin;
	private double phMax;
	
	//constructor
	public ControleFluido(){}

	//getters and setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getCodigo() {
		return codigo;
	}
	
	public void setCodigo(String codigo) {
		this.codigo = codigo;
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

	public double getConcentracao() {
		return concentracao;
	}

	public void setConcentracao(double concentracao) {
		this.concentracao = concentracao;
	}

	public double getPh() {
		return ph;
	}

	public void setPh(double ph) {
		this.ph = ph;
	}

	public String getContaminacaoVisual() {
		return contaminacaoVisual;
	}

	public void setContaminacaoVisual(String contaminacaoVisual) {
		this.contaminacaoVisual = contaminacaoVisual;
	}

	public String getNivelReservatorio() {
		return nivelReservatorio;
	}

	public void setNivelReservatorio(String nivelReservatorio) {
		this.nivelReservatorio = nivelReservatorio;
	}

	public String getSkimmer() {
		return skimmer;
	}
	
	public void setSkimmer(String skimmer) {
		this.skimmer = skimmer;
	}
	
	public double getConMax() {
		return conMax;
	}
	
	public void setConMax(double conMax) {
		this.conMax = conMax;
	}
	
	public double getConMin() {
		return conMin;
	}
	
	public void setConMin(double conMin) {
		this.conMin = conMin;
	}
	
	public double getPhMin() {
		return phMin;
	}
	
	public void setPhMin(double phMin) {
		this.phMin = phMin;
	}
	
	public double getPhMax() {
		return phMax;
	}
	
	public void setPhMax(double phMax) {
		this.phMax = phMax;
	}

}
