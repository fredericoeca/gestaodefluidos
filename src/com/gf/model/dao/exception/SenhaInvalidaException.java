package com.gf.model.dao.exception;

public class SenhaInvalidaException extends Exception{

	private static final long serialVersionUID = 1L;
	
	public SenhaInvalidaException() {
		super("Senha inv�lida!");
	}
}
