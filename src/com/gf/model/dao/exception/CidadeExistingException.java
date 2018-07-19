package com.gf.model.dao.exception;

public class CidadeExistingException extends Exception{
	
	private static final long serialVersionUID = 1L;
	
	public CidadeExistingException(){
        super("Cidade já cadastrado no sistema!");
	}

}
