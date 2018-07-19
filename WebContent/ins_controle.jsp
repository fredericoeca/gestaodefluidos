<%@page import="com.gf.model.entity.Equipamento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gf.model.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
   String cod = request.getParameter("c");
   Usuario uLogado = (Usuario) session.getAttribute("uLogado"); 
   Equipamento equipamento = (Equipamento) session.getAttribute("equipamento");
  %>
  <body>
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
     <h5>Inserir Controle de Fluido - <%= equipamento.getTag() %> <i class="fa fa-cogs" aria-hidden="true"></i></h5>
     <hr />
     <div class="alerta">
     <%if(cod!=null){
    	 if(cod.equals("1")){ %>
  	      <div class="alert alert-danger" role="alert" >
          <strong>Erro</strong> ao cadastrar controle no banco de dados.
          <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
          <a href="ins_controle.jsp" class="close">&times;</a>
         </div>  
        <% } else if(cod.equals("2")){ %>
         <div class="alert alert-danger" role="alert" >
          <strong>Erro inesperado</strong> ao cadastrar controle.
          <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
          <a href="ins_controle.jsp" class="close">&times;</a>
         </div>
         <% } else if(cod.equals("3")){ %>
         <div class="alert alert-danger" role="alert" >
          <strong>Opção nula!</strong> Favor selecionar pelo menos uma opção de cada um dos itens (Contaminação visual, Nivel e Skimmer).
          <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
          <a href="ins_controle.jsp" class="close">&times;</a>
         </div>                    
      <% }} %>
     </div>
     
     <section class="row text-center placeholders">
     
     <!-- Formulário de cadastro de Controles -->
     <form class="form-horizontal col-sm-10" method="post" action="InsertControle">
      
      <div class="form-group col-sm-6">
       <div class="col-sm-5">
        <input type="hidden" class="form-control" name="equipamento" 
         id="equipamento" value=<%= equipamento.getId() %> required />
       </div>
	  </div>
	  
     <div class="form-group col-sm-6">
   	  <label class="control-label col-sm-11" for="data">Data: </label>
      <div class="col-sm-11">
       <input type="date" class="form-control" name="data" id="data" required/>
      </div>
     </div>
     
     <div class="form-group col-sm-6">	
      <label class="control-label col-sm-11" for="concentracao">Concentração</label>
      <div class="col-sm-11">
       <input type="number" step="0.01" class="form-control" name="concentracao" id="concentracao" 
        placeholder="Concentração aferida" />
      </div>
     </div>
     
     <div class="form-group col-sm-6">
   	  <label class="control-label col-sm-11" for="ph">Ph: </label>
      <div class="col-sm-11">
       <input type="number" step="0.01"  class="form-control" name="ph" id="ph" placeholder="Ph aferido" />
      </div>
     </div>
     
     <div class="form-group col-sm-6">
      <label class="control-label col-sm-11" for="cont_visual">Contaminação Visual: </label>
      <div class="custom-control custom-radio" style="margin-left: 20px">	                	
       <input type="radio" name="cont_visual" id="cont_visual2" value="Não" class="custom-control-input">
        <label class="custom-control-label" for="cont_visual2">Não</label>
      </div>
	  <div class="custom-control custom-radio" style="margin-left: 20px">	
        <input type="radio" name="cont_visual" id="cont_visual1" value="Sim" class="custom-control-input">
        <label class="custom-control-label" for="cont_visual1">Sim</label>	
	   </div>
     </div>
     
     <div class="form-group col-sm-6">
      <label class="control-label col-sm-11" for="nivel">Nível do Reservatório: </label>
      <div class="custom-control custom-radio" style="margin-left: 20px">
        <input type="radio" name="nivel" id="nivel1" value="Mínimo" class="custom-control-input">
    	<label class="custom-control-label" for="nivel1">Mínimo</label>
       </div> 
       <div class="custom-control custom-radio" style="margin-left: 20px">
        <input type="radio" name="nivel" id="nivel2" value="Médio" class="custom-control-input">
    	<label class="custom-control-label" for="nivel2">Médio</label>
       </div>	 
       <div class="custom-control custom-radio" style="margin-left: 20px">
        <input type="radio" name="nivel" id="nivel3" value="Máximo" class="custom-control-input">
    	<label class="custom-control-label" for="nivel3">Máximo</label>
       </div>
      </div>
     
     <div class="form-group col-sm-6">
      <label class="control-label col-sm-11" for="skimmer">Skimmer: </label>
      <div class="custom-control custom-radio" style="margin-left: 20px">	                	
    	<input type="radio" name="skimmer" id="skimmer1" value="On" class="custom-control-input">
    	<label class="custom-control-label" for="skimmer1">On</label>
      </div>	
      <div class="custom-control custom-radio" style="margin-left: 20px">
       <input type="radio" name="skimmer" id="skimmer2" value="Off" class="custom-control-input">
       <label class="custom-control-label" for="skimmer2">Off</label>	
      </div>              
     </div>
     
     <div class="row">
       <div class="col-sm-2" style="width: 100%; margin-bottom: 20px">
        <button onClick="history.go(-1)" class="btn btn-success btn-block">
         <i class="fa fa-backward" aria-hidden="true"></i> voltar</button>
       </div>
       <div class="col-sm-3" style="width: 100%; margin-bottom: 20px">
        <button type="submit" class="btn btn-success btn-block" style="border-left-color: #EE4000; border-left-width: 8px;">
         salvar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
       </div>
      </div>
    </form>
    
    </section>
   </div>
   <hr />
   <div class="footer">
    <p class="rodape">&copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
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
