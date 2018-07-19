package com.gf.model.dao.exception;

public class EmailExistingException extends Exception{
	
	private static final long serialVersionUID = 1L;
	
	public EmailExistingException(){
        super("Email já cadastrado no sistema!");
	}
}
