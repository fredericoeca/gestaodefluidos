<%@page import="com.gf.model.entity.Cliente"%>
<%@page import="com.gf.model.controller.ClienteController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.gf.model.controller.UsuarioController"%>
<%@page import="java.util.ArrayList"%>
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
   ArrayList<Usuario> lstUsuarios = new ArrayList<Usuario>();
   String cod = request.getParameter("c");
  %>
  <body ng-app="app">
   <% if(uLogado == null || uLogado.getPerfil() != 1) { %>
	<h6>Você não é um administrador do sistema 
		<a href="LogoutServlet" style="color: #269abc">entrar como administrador.</a>
	</h6>
	<h6>
		<a href="#" onClick="history.go(-1)">
			<i class="fa fa-backward" aria-hidden="true"></i> voltar
		</a>
	</h6>
   <% } else { %>
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
          <a class="dropdown-item" href="ins_produto.jsp">Inserir</a>
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
          <a class="dropdown-item" href="docs/control_version.pdf">Controle de Versões</a>
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
	
	<div class="col-sm-12 col-md-12 pt-3" role="main">
	 <h5>Usuários <i class="fa fa-user" aria-hidden="true"></i></h5>
     <hr />
     <%if(cod!=null){ %>
	  <% if(cod.equals("1")){ %>
       <div class="alert alert-success" role="alert" >
        <strong>Usuário</strong> apagado com sucesso.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div>                 
      <% } else if(cod.equals("2")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro SQL!</strong> ao apagar Usuário no banco de dados.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("3")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro Genérico!</strong> ao apagar Usuário.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("4")){ %>
       <div class="alert alert-success" role="alert" >
        <strong>Perfil do Usuário</strong> alterado com sucesso.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div>                 
      <% } else if(cod.equals("5")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro SQL!</strong> ao alterar perfil do Usuário no banco de dados.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("6")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro Genérico!</strong> ao alterar perfil Usuário.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div>
       <% } else if(cod.equals("7")){ %>
       <div class="alert alert-success" role="alert" >
        <strong>Usuário</strong> criado com sucesso.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div> 
       <% } else if(cod.equals("8")){ %>
       <div class="alert alert-success" role="alert" >
        <strong>Senha</strong> resetada com sucesso.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div> 
       <% } else if(cod.equals("9")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro SQL!</strong> ao resetar senha do Usuário.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div> 
       <% } else if(cod.equals("10")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro Genérico!</strong> ao resetar senha do Usuário.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div>            
       <% } else if(cod.equals("11")){ %>
       <div class="alert alert-success" role="alert" >
        <strong>Status</strong> alterado com sucesso.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div> 
       <% } else if(cod.equals("12")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro</strong> ao ativar Usuário no banco de dados.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div> 
       <% } else if(cod.equals("13")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro inesperado!</strong> ao ativar o Usuário.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="usuarios.jsp" class="close">&times;</a>
       </div>                            
       <% } else if(cod.equals("14")){ %>
       <div class="alert alert-success" role="alert" >
    	<strong>Senha restaurada</strong>, favor verificar em seu email.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="usuarios.jsp" class="close">&times;</a>
       </div>                   
      <% } else if(cod.equals("15")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> ao enviar restauração de senha.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="usuarios.jsp" class="close">&times;</a>
       </div>                            
      <% }} %>
	<div class="col-sm-12">
	<div class="row">
	   <div class="col-sm-4" style="padding-left: 0">
	   	<form class="form-horizontal" method="post" action="usuarios.jsp">
	       <div class="form-group" style="margin-bottom: 0">
	        <div class="col-sm-12">
	         <div class="input-group">                        
	          <input type="text" class="form-control" name="busca" id="busca" placeholder="busca..." required />                                           
		<span class="input-group-addon" style="padding: 0">
			<button type="submit" class="btn btn-success btn-busca"><i class="fa fa-search" aria-hidden="true"></i></button>
		</span>           
	         </div>
	        </div>
	       </div>         
	      </form>     		
	   	</div>
	   	<div class="col-sm-1 btn-refresh">
	   		<a href="usuarios.jsp" class="link-box" title="recarregar tabela"><i class="fa fa-refresh" aria-hidden="true"></i></a>
	   	</div>
	   	<div class="col-sm-7"></div>
	   </div>
	   
	   <%
			String busca = request.getParameter("busca");
	     
			if(busca == null){
				lstUsuarios = UsuarioController.getUsuarios();
			} else {
				lstUsuarios = UsuarioController.searchUsuarios(busca);
			}			
		%>
	   
     <div class="row">
      <div class="col-sm-12">
	   <div class="card card-success det-cli">
		<div class="card-header det-cli-h">Lista de Usuários
		 <div style="float: right">
		  <a href="ins_usuario.jsp" class="link-box" >
		   <i class="fa fa-plus" aria-hidden="true"></i> adicionar
		  </a>
		 </div>
	  	</div>
		<div class="card-block" style="max-height: 360px; overflow: auto;">
		 <% if(lstUsuarios.isEmpty()) {
			if(busca != null) {
			 %>		 
			 	<p>Sua pesquisa "<%=busca%>" não encontrou nenhum registro.</p>
			 <% 	} else { %>	
			 	<p>Não há logs de acessos registrados</p>
	     <% } } else { %>		
	      <div class="table-responsive tab">
		   <table class="table table-striped tab-tab">
		    <thead class="thead-tab-usu">             
		     <th>ID</th>         
		     <th>Nome</th>
		     <th>Telefone</th>
		     <th>Celular</th>
		     <th>Email</th>
		     <th>Cliente</th>
		     <th>Perfil</th>
		     <th>Status</th>
		     <th>Senha</th>
		     <th>Apagar</th>
		    </thead>
		    <tbody class="tbody-tab-usu">
		     <% for(Usuario u : lstUsuarios) { %>                    
		      <tr>
		       <td><%= u.getId() %></td>
		       <td><%= u.getNome() %></td>
		       <td><%= u.getTelefone() %></td>
		       <td><%= u.getCelular() %></td>
		       <td><%= u.getEmail() %></td>
		       <% if(u.getCliente() == null) { %>
		       	<td></td>
		       <% } else { %>
		       	<td><%= u.getCliente().getNome() %></td>
		       <% } %>		
		       <% if(u.getPerfil() == 1) { %>
		       	<td><a href="UpdatePerfil?id=<%= u.getId() %>&p=2" class="link-box" title="Perfil Administrador">
		       		<i class="fa fa-user-plus" aria-hidden="true"></i></a></td>
		       <% } else if(u.getPerfil() == 2) { %>
		        <td><a href="UpdatePerfil?id=<%= u.getId() %>&p=1" class="link-box" title="Perfil Representante">
		        	<i class="fa fa-user" aria-hidden="true"></i></a></td>
		       <% } else if(u.getPerfil() == 3) { %>
		        <td><a href="#" class="link-box" title="Perfil Cliente">
		        	<i class="fa fa-user-o" aria-hidden="true"></i></a></td>
		       <% } %>
		       <% if(u.isStatus()) { %>
		        <td><a href="UpdateStatus?id=<%= u.getId() %>&s=0">
		        	<i class="fa fa-check" aria-hidden="true" style="color: green;"></i></a></td>
		       <% } else { %>
		       	<td><a href="UpdateStatus?id=<%= u.getId() %>&s=1">
		       		<i class="fa fa-times" aria-hidden="true" style="color: red;"></i></a></td>
		       <% } %>
		       <td><a href="ResetSenha?email=<%= u.getEmail() %>" class="link-box">
		       	   <i class="fa fa-unlock" aria-hidden="true"></i></a></td>	
		       <td>
		       	<a href="#" data-toggle="modal" data-target="#delusu" class="link-box" 
	          	 onclick="setDelUsu('<%= u.getNome() %>','<%= u.getId() %>')">
		       	<i class="fa fa-trash-o" aria-hidden="true"></i></a></td>
		      </tr>                   
		     <% } %>
		    </tbody>
		   </table>
		  </div>
		 </div>
		<% } %>
		<div class="card-footer">
  		<div class="row">
  		<div class="col-sm-10">  		
  		 <p class="legenda" align="justify"><b>Senha:</b> Reset da senha; <b>Perfil:</b> Modificar perfil do usuário;
  		 <b>Status:</b> Modificar status do usuário. </p></div>
  		 <div class="col-sm-2">
			<a href="#" class="legenda btn btn-success" onClick="history.go(-1)"  style="font-size: 14px"> 
				<i class="fa fa-backward" aria-hidden="true"></i> voltar </a>
		   </div>
	  	 </div>
  		</div>
 	   </div>
	  </div>
	 </div>
	</div>	
	</div>
	<script>		
	function setDelUsu(val1, val2) {		    
	 document.getElementById('val1').value = val1;
	 document.getElementById('val2').value = val2;
	}
   </script>
	
   <hr />
   <div class="footer">
    <p class="rodape"> &copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
   </div>
    
   <div id="delusu" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Apagar Usuário</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>	
     <div class="modal-body">
      <div class="panel-body">
       Tem certeza que deseja apagar o usuario?<br />  
       <output type="text" name="val1" id="val1"></output>
      </div> 
     </div>
     <div class="modal-footer">
      <div class="col-sm-6" align="center">
       <form method="post" action="DeleteUsuario">
        <input type="hidden" name="val2" id="val2">           
	    <button type="submit" class="btn btn-success" >
		 sim <i class="fa fa-check" aria-hidden="true"></i></button>
	   </form>
	  </div> 
	  <div class="col-sm-6" align="center">	
		<button type="button" class="btn btn-danger" data-dismiss="modal" >
		 não <i class="fa fa-times" aria-hidden="true"></i></button>	 
	  </div> 
      </div>      
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
