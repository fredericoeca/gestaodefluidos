package com.gf.model.dao.exception;

public class RelatorioNuloException extends Exception{

	private static final long serialVersionUID = 1L;
	
	public RelatorioNuloException(){
        super("Relat�rio sem dados para esses par�metros!");
	}
}
