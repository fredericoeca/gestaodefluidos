<%@page import="com.gf.model.controller.UsuarioController"%>
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
  <%
    Usuario uLogado = (Usuario) session.getAttribute("uLogado"); 
 	String cod = request.getParameter("c");
  %>
  <body ng-app="app">
   <% if(uLogado == null) { %>
	<h6>Você não tem acesso ao sistema 
		<a href="index.jsp" style="color: #269abc">faça seu login.</a>
	</h6>
   <% } else if(uLogado.getPerfil() == 3) { %>
	<h6>Você não tem acesso a essa página 
		<a href="#" onClick="history.go(-1)">
			<i class="fa fa-backward" aria-hidden="true"></i> voltar
		</a>
	</h6>
   <% } else { 
   		Usuario u = UsuarioController.getUsuario(uLogado.getId()); %>
   <nav class="navbar navbar-expand-sm navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="home.jsp"><img src="img/favicon.png" width="25" height="25"/>Gestão de Fluidos de Processo</a>
     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample03" aria-controls="navbarsExample03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
     </button>

     <div class="collapse navbar-collapse" id="navbarsExample03">
      <ul class="navbar-nav mr-auto">
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown03" 
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Clientes</a>
         <div class="dropdown-menu" aria-labelledby="dropdown03">
         <a class="dropdown-item" href="ins_cliente.jsp">Inserir</a>
         <a class="dropdown-item" href="clientes.jsp">Clientes</a>
         </div>
       </li>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown03" 
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Produtos</a>
         <div class="dropdown-menu" aria-labelledby="dropdown03">
          <% if(uLogado.getPerfil() == 1) { %>
          <a class="dropdown-item" href="ins_produto.jsp">Inserir</a>
         <% } %> 
          <a class="dropdown-item" href="produtos.jsp">Produtos</a>
         </div>
       </li>
       <% if(uLogado.getPerfil() == 1) { %>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown03" 
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Usuários</a>
         <div class="dropdown-menu" aria-labelledby="dropdown03">
          <a class="dropdown-item" href="ins_usuario.jsp">Novo</a>
          <a class="dropdown-item" href="usuarios.jsp">Usuários</a>
          <a class="dropdown-item" href="log_acesso.jsp">Logs de Acesso</a>              
         </div>
       </li>
       <% } %>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown03" 
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Ajuda</a>
         <div class="dropdown-menu" aria-labelledby="dropdown03">
          <a class="dropdown-item" href="#" data-toggle="modal" data-target="#sobre">Sobre</a>
          <% if(uLogado.getPerfil() != 3) { %>
			<a class="dropdown-item" href="docs/manual.pdf">Manual de Instruções</a>   
			<% } %>
          <% if(uLogado.getPerfil() == 1) { %>
			<a class="dropdown-item" href="docs/control_version.pdf">Controle de Versões</a>   
			<% } %>
         </div>
       </li>
      </ul>
      <ul class="navbar-nav right">
       <li class="nav-item dropdown active">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown03" 
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Olá <%= uLogado.getNome() %>    </a>
         <div class="dropdown-menu" aria-labelledby="dropdown03">
          <a class="dropdown-item" href="usuario.jsp">Meus Dados</a>
          <a class="dropdown-item" href="LogoutServlet">Sair</a>
	     </div>
       </li>
      </ul>
     </div>
    </nav>

	<div class="col-sm-9 col-md-10 pt-3" role="main">
     <h5>Meus Dados <i class="fa fa-user-o" aria-hidden="true"></i></h5>
     <hr />
     
     <div class="alerta">
	 <%if(cod!=null){ %>
	 <% if(cod.equals("1")){ %>	  	
	  <div class="alert alert-success" role="alert" >
       <strong>Usuário</strong> atualizado com sucesso.
       <i class="fa fa-check" aria-hidden="true"></i>
       <a href="usuario.jsp" class="close">&times;</a>
      </div>
      <% } else if(cod.equals("2")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro</strong> ao alterar usuário do banco de dados.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="usuario.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("3")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro inesperado</strong> ao alterar usuário.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="usuario.jsp" class="close">&times;</a>
       </div>                  
      <% } else if(cod.equals("4")){ %>
       <div class="alert alert-success" role="alert" >
        <strong>Senha do usuário</strong> alterada com sucesso.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuario.jsp" class="close">&times;</a>
       </div>                 
      <% } else if(cod.equals("5")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Senha atual </strong> inválida, tentar novamente.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="usuario.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("6")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro </strong> ao alterar senha do usuário no banco de dados.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="usuario.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("7")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro inesperado</strong> ao alterar senha do usuário.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuario.jsp" class="close">&times;</a>
       </div>                 
      <% }} %>
      </div>
     
     <div class="container-fluid">
      <div class="row">
       <div class="col-sm-12">
    	<label class="control-label">Nome: </label>
       </div>
       <div class="col-sm-6">
        <output class="dado"><%= u.getNome()%></output>
       </div>
      </div>
      <div class="row">
       <div class="col-sm-12">
    	<label class="control-label">Telefone: </label>
       </div>
       <div class="col-sm-6">
        <output class="dado"><%= u.getTelefone() %></output>
       </div>
      </div>
      <div class="row">
       <div class="col-sm-12">
        <label class="control-label">Celular: </label>
       </div>
       <div class="col-sm-6">
        <output class="dado"><%= u.getCelular() %></output>
       </div>
      </div>
      <div class="row">
       <div class="col-sm-12">
        <label class="control-label">Email: </label>
       </div>
       <div class="col-sm-6">
        <output class="dado"><%= u.getEmail() %></output>
       </div>
      </div>
   	 </div>
   	 <div class="row"  style="margin-top: 40px">
   	  <div class="col-sm-2" style="margin-bottom: 20px">
        <button data-toggle="modal" data-target="#updusu" class="btn btn-success btn-block"
	      onclick="setUpdUsu('<%= u.getId() %>','<%= u.getNome() %>','<%= u.getTelefone() %>','<%= u.getCelular() %>','<%= u.getEmail() %>')">
         editar <i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
     </div>
   	 <div class="col-sm-2" style="margin-bottom: 20px">
        <button data-toggle="modal" data-target="#mudarsenha" class="btn btn-success btn-block" >
         mudar senha <i class="fa fa-unlock-alt" aria-hidden="true"></i></button>
     </div>
	</div>
   	</div>
   	
   	<script>		
	function setUpdUsu(val1, val2, val3, val4, val5) {		    
	 document.getElementById('val1').value = val1;
	 document.getElementById('val2').value = val2;
	 document.getElementById('val3').value = val3;
	 document.getElementById('val4').value = val4;
	 document.getElementById('email').value = val5;
	}
	
	function setDelUsu(val6, val7) {		    
	 document.getElementById('val6').value = val6;
	 document.getElementById('val7').value = val7;
	}
    </script>
   	
	<hr />
	<div class="footer">
     <p class="rodape"> &copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
    </div>
    
    <div id="updusu" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade" ng-controller="controllerName">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Editar Usuário</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>	
     <form class="form-horizontal" name="form" method="post" action="UpdateUsuario">
     <div class="modal-body">
      <div class="panel-body">
       <input type="hidden" name="val1" id="val1">
       <div class="form-group">
  		<label class="control-label col-sm-11" for="nome">Nome: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val2" id="val2" />
        </div>
       </div>
       <div class="form-group">
  		<label class="control-label col-sm-11" for="telefone">Telefone: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" ng-model="telefone" name="val3" id="val3" ui-telefone />
        </div>
       </div>
       <div class="form-group">
  		<label class="control-label col-sm-11" for="celular">Celular: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" ng-model="celular" name="val4" id="val4" ui-celular />
        </div>
       </div>
       <div class="form-group">
  		<label class="control-label col-sm-11" for="email">Email: </label>
        <div class="col-sm-12">
         <input type="email" class="form-control" name="email" id="email" ng-model="email" ng-pattern="mail" />
          <span ng-show="form.email.$error.pattern" style="color:red">Por favor, insira um email correto.</span>
        </div>
       </div>
      </div> 
     </div>
     <div class="modal-footer">
      <div class="col-sm-12" align="center">                
	    <button type="submit" class="btn btn-success">
		 atualizar <i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
	  </div>
      </div>
     </form>    
    </div>
    </div>
   </div>
   
   <div id="mudarsenha" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade" ng-controller="controllerName">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Mudar Senha</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>	
     <form class="form-horizontal" name="form" method="post" action="UpdateSenha">
     <div class="modal-body">
      <div class="panel-body">
       <input type="hidden" name="usuario" id="usuario" value=<%= u.getId() %>>
       <div class="form-group">
        <label class="control-label col-sm-12" for="senha">Senha Atual: </label>
        <div class="col-sm-12">
         <input type="password" class="form-control" name="senha" ng-model="senha"
          id="senha" placeholder="Insira sua senha atual" required />
        </div>
       </div>
       <div class="form-group">
        <label class="control-label col-sm-12" for="password">Nova Senha: </label>
        <div class="col-sm-12">
         <input type="password" class="form-control" name="password" ng-model="password" ng-pattern="re"
          id="password" placeholder="Insira a nova senha" required />
          <span ng-show="form.password.$error.pattern" style="color:red">
          A senha deve conter letras minúsculas e números - minimo 6 e máximo 14 caracteres.</span>
        </div>
       </div>
       <div class="form-group">
        <label class="control-label col-sm-12" for="confirma">Confirma Senha: </label>
        <div class="col-sm-12">
         <input type="password" class="form-control" name="confirma" ng-model="repassword" ng-pattern="re"
          ng-keyup="compare(repassword)" id="repassword" placeholder="Confirmação de senha" required />
          <span ng-show="isconfirm" style="color:red">
          A senha não corresponde.</span>
        </div>
       </div>
      </div> 
     </div>
     <div class="modal-footer">
      <div class="col-sm-12" align="center">                
	    <button type="submit" class="btn btn-success" ng-disabled="isconfirm || form.password.$error.pattern">
		 mudar senha <i class="fa fa-unlook-alt" aria-hidden="true"></i></button>
	  </div>
      </div>
     </form>    
    </div>
    </div>
   </div>
    
    <!-- Sobre o sistema --> 
     
   <div id="sobre" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-md">
    <div class="modal-content">
     <div class="modal-header" style="background-color: #696969">
      <img src="img/favicon.png" width="25" height="25"/>
	  <h5 class="modal-title" style="color: #FFFFFF">Gestão de Fluidos de Processo</h5>
     </div>     
      <div class="modal-body" style="background-color: #696969">
      	<p class="legenda" align="right" style="color: #FFFFFF">Versão 1.0.0</p>
      	<p class="legenda" align="justify" style="color: #CFCFCF">
		 Copyright &copy; 2017 - Desenvolvido por All Lubrificantes e Frederico E. Cabral Araújo.<br /> 
		 Todos os direitos reservados.<br />
		 Contato: frederico-cabral@hotmail.com		 
		</p>      	      
      </div>     
      <div class="modal-footer" align="right"> 
       <img src="img/logo1.png" width="180" height="56"/>         
      </div>   
    </div>
    </div>
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
    <% } %>
  </body>
</html>
