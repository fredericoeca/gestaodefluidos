<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.gf.model.entity.Usuario"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="img/favicon.png">
    
    <script src="js/angular/angular.min.js"></script>
	<script src="js/lib/app.js"></script>
    
    <title>Gestão de Fluidos de Processo</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
   	<link href="css/style.css" rel="stylesheet">
	
    <!-- Custom styles for this template -->
    <link href="css/navbar.css" rel="stylesheet">
  </head>
  <%
   String cod = request.getParameter("c");
  %>	
  <body ng-app="app">    
	<div class="col-sm-12 col-md-12 pt-2" role="main" ng-controller="controllerName">
   	<div class="container log-in" >
   	<div class="col-sm-12" align="left">
   	<div class="row">
     <img src="img/favicon.png" class="img-responsive" width="40" height="40" />
     <h6 class="titulo-login">Gestão de Fluidos de Processo</h6></div>
    </div>
    <hr />
   	<div class="alerta-usuario">
      <%if(cod!=null){
       if(cod.equals("1")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Usuário ou Senha</strong> incorretos.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="index.jsp" class="close">&times;</a>
       </div>                   
      <% } else if(cod.equals("2")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> ao tentar fazer login no banco de dados.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="index.jsp" class="close">&times;</a>
       </div>                   
      <% } else if(cod.equals("3")){ %>
       <div class="alert alert-warning" role="alert" >
    	<strong>Erro inesperado</strong> ao tentar fazer login.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="index.jsp" class="close">&times;</a>
       </div>                   
      <% } else if(cod.equals("4")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Usuário inativo</strong>, favor contatar administrador do sistema.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="index.jsp" class="close">&times;</a>
       </div> 
      <% }} %>
     </div>
   	 <div class="row" style="display: flex; vertical-align: middle; justify-content: center;">
   	  <div class="col-sm-6" align="center">
   	  	   
   	  <div class="row" align="left">
   	   <h6 align="left">login <i class="fa fa-sign-in" aria-hidden="true"></i></h6></div>
       <hr />       
   	   <form class="form-horizontal" method="post" action="LoginServlet">
         <div class="form-group">
          <div class="col-sm-12">
           <div class="input-group mb-3">
            <div class="input-group-prepend">           
             <span class="input-group-text" id="basic-addon1"><i class="fa fa-user" aria-hidden="true"></i></span>
            </div>
            <input type="text" class="form-control" name="txt_email" id="txt_email" placeholder="email" required />                                           
           </div>
          </div>
         </div>
         <div class="form-group">
          <div class="col-sm-12">
           <div class="input-group mb-3">
            <div class="input-group-prepend">           
             <span class="input-group-text" id="basic-addon1"><i class="fa fa-lock" aria-hidden="true"></i></span>
            </div> 
            <input type="password" class="form-control" name="txt_senha" id="txt_senha" placeholder="senha" required />                                           
           </div>
          </div>
          <div class="col-sm-12" align="right">
          	<a href="reset_senha.jsp" class="link-box" style="text-align: right;">Esqueceu a senha?	</a>
          </div>
         </div>
     	 <div class="form-group">
     	  <div class="col-sm-12">
           <button type="submit" class="btn btn-success btn-block">entrar <i class="fa fa-sign-in" aria-hidden="true"></i></button>
           
           <a href="ins_usuario_out.jsp" class="btn btn-info btn-block">cadastrar-se <i class="fa fa-save" aria-hidden="true"></i></a>
          </div>
         </div>                        
        </form>
      </div>
   	 </div>
    </div>
    </div>
    <hr />
    <div class="footer">
     <p class="rodape">&copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
  </body>
</html>
