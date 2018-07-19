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
    
    <!-- AngularJS -->
		<script src="js/angular/angular.min.js"></script>
		<script src="js/lib/app.js"></script>
    
    	<title>Gestão de Fluidos de Processo</title>

    	<!-- Bootstrap core CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
   		<link href="css/style.css" rel="stylesheet">

   		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>

	
    <!-- Custom styles for this template -->
    <link href="css/navbar.css" rel="stylesheet">
  </head>
  <% String cod = request.getParameter("c"); %>
  <body ng-app="app">      
    <div class="col-sm-9 col-md-10 pt-4" role="main">
     <h5>Restaurar Senha <i class="fa fa-unlock-alt" aria-hidden="true"></i></h5>
     <hr />
     
     <%if(cod!=null){
       if(cod.equals("1")){ %>
       <div class="alert alert-success" role="alert" >
    	<strong>Senha restaurada</strong>, favor verificar em seu email.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="index.jsp" class="close">&times;</a>
       </div>                   
      <% } else if(cod.equals("2")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> ao enviar restauração de senha.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="reset_senha.jsp" class="close">&times;</a>
       </div> 
       <% } else if(cod.equals("3")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> ao tentar restauração de senha no banco.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="reset_senha.jsp" class="close">&times;</a>
       </div> 
       <% } else if(cod.equals("4")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> inesperado na restauração de senha.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="reset_senha.jsp" class="close">&times;</a>
       </div>  
       <% }} %>
     
     <form class="form-horizontal" name="form" action="EmailResetSenha" method="post" ng-controller="controllerName">
		
		<div class="form-group">
        <div class="col-sm-4">
        <div class="input-group mb-3">
            <div class="input-group-prepend">           
             <span class="input-group-text" id="basic-addon1"><i class="fa fa-at" aria-hidden="true"></i></span>
            </div>
         <input type="email" class="form-control" name="email" id="email" ng-model="email" ng-pattern="mail"
          placeholder="email" required />          
        </div>
        <span ng-show="form.email.$error.pattern" style="color:red">Por favor, insira um email correto.</span>
        </div>
       </div>
       	<div class="col-sm-4">       
         <button type="submit" class="btn btn-success btn-block" ng-disabled="isconfirm || form.password.$error.pattern || form.email.$error.pattern">
          restaurar <i class="fa fa-unlock" aria-hidden="true"></i></button>
        </div>
     </form>
    </div>
    
    <hr />
	<div class="footer">
   	 <p class="rodape"> &copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
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
