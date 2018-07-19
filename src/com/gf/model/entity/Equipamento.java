package com.gf.model.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Equipamento implements Serializable {

	//attributes
	private int id;
	private Cliente cliente;
	private String tipo;
	private String modelo;
	private String fabricante;
	private String tag;
	private String setor;
	private String pontoLubrificacao;
	private Produto produto;
	private double volume;
	private double consentracaoMax;
	private double consentracaoMin;
	private double limiteMaxPh;
	private double limiteMinPh;
	
	//constructor
	public Equipamento(){}

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

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	public String getModelo() {
		return modelo;
	}
	
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public String getFabricante() {
		return fabricante;
	}

	public void setFabricante(String fabricante) {
		this.fabricante = fabricante;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getSetor() {
		return setor;
	}

	public void setSetor(String setor) {
		this.setor = setor;
	}

	public String getPontoLubrificacao() {
		return pontoLubrificacao;
	}

	public void setPontoLubrificacao(String pontoLubrificacao) {
		this.pontoLubrificacao = pontoLubrificacao;
	}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}

	public double getVolume() {
		return volume;
	}

	public void setVolume(double volume) {
		this.volume = volume;
	}

	public double getConsentracaoMax() {
		return consentracaoMax;
	}

	public void setConsentracaoMax(double consentracaoMax) {
		this.consentracaoMax = consentracaoMax;
	}

	public double getConsentracaoMin() {
		return consentracaoMin;
	}

	public void setConsentracaoMin(double consentracaoMin) {
		this.consentracaoMin = consentracaoMin;
	}

	public double getLimiteMaxPh() {
		return limiteMaxPh;
	}

	public void setLimiteMaxPh(double limiteMaxPh) {
		this.limiteMaxPh = limiteMaxPh;
	}

	public double getLimiteMinPh() {
		return limiteMinPh;
	}

	public void setLimiteMinPh(double limiteMinPh) {
		this.limiteMinPh = limiteMinPh;
	}
	
		
}
