package com.gf.model.dao.exception;

public class UsuarioInativoException extends Exception{

	private static final long serialVersionUID = 1L;
	
	public UsuarioInativoException(){
        super("Usu�rio inativo no sistema!");
	}
}
