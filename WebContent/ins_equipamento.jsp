<%@page import="com.gf.model.controller.SetorController"%>
<%@page import="com.gf.model.entity.Setor"%>
<%@page import="com.gf.model.controller.TipoProdutoController"%>
<%@page import="com.gf.model.entity.TipoProduto"%>
<%@page import="com.gf.model.controller.ProdutoController"%>
<%@page import="com.gf.model.entity.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.gf.model.entity.Cliente"%>
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
   String cod = request.getParameter("c");
   Usuario uLogado = (Usuario) session.getAttribute("uLogado");
   Cliente cliente = (Cliente) session.getAttribute("cliente");
   ArrayList<TipoProduto> tipos = TipoProdutoController.getTiposProduto();
   ArrayList<Setor> setores = SetorController.getSetoresPorCliente(cliente.getId());
   //ArrayList<Produto> produtos = ProdutoController.getProdutos();
  %>
  <body ng-app="">
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
     <h5>Inserir Equipamento - <%= cliente.getNome() %> <i class="fa fa-cogs" aria-hidden="true"></i></h5>
     <hr />
     <div class="alerta">
	  <%if(cod!=null){
       if(cod.equals("1")){ %>
  	   <div class="alert alert-danger" role="alert" >
        <strong>Erro!</strong> Falha ao cadastrar Equipamento no banco de dados.
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
       </div>  
       <% } else if(cod.equals("2")){ %>
        <div class="alert alert-danger" role="alert" >
         <strong>Erro!</strong> Falha genérica ao cadastrar Equipamento.
          <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        </div>                    
       <% }} %>
	  </div>
      <section class="row text-center placeholders">
      <!-- Formulário de cadastro de equipamentos -->
	  <form class="form-horizontal col-sm-10" method="post" action="InsertEquipamento">
       <div class="form-group col-sm-6">
        <div class="col-sm-5">
         <input type="hidden" class="form-control" name="cliente" id="cliente" value=<%= cliente.getId() %> required />
        </div>
       </div>
       <div class="form-group col-sm-6">
       	<label class="control-label col-sm-11" for="tipo">Tipo: </label>
        <div class="col-sm-11">
         <input type="text" class="form-control" name="tipo" id="tipo" placeholder="Insira o tipo de equipamento" />
        </div>
       </div>
       <div class="form-group col-sm-6">
       	<label class="control-label col-sm-11" for="modelo">Modelo: </label>
        <div class="col-sm-11">
         <input type="text" class="form-control" name="modelo" id="modelo" placeholder="Insira o modelo de equipamento" />
        </div>
       </div>
       <div class="form-group col-sm-6">	
        <label class="control-label col-sm-11" for="fabricante">Fabricante:</label>
        <div class="col-sm-11">
         <input type="text" class="form-control" name="fabricante" id="fabricante" placeholder="Insira o fabricante do equipamento" />
        </div>
       </div>
       <div class="form-group col-sm-6">
       	<label class="control-label col-sm-11" for="tag">TAG: </label>
        <div class="col-sm-11">
         <input type="text" class="form-control" name="tag" ng-model="tag" id="tag" placeholder="Inserir o TAG do equipamento" required/>
        </div>
       </div>
       <% if(!setores.isEmpty()) { %>
       	<div class="form-group col-sm-6">	
        <label class="control-label col-sm-11" for="id_setor">Setor:</label>
        <div class="col-sm-11">
         <select class="form-control" name="id_setor" required>
          <option value="">Selecione o setor do contato</option>
          <!-- Popula lista de setores no select -->
           <% for(Setor s: setores){ %>
            <option value=<%= s.getId() %>><%= s.getSetor() %></option>                           
           <% } %>
          </select>
        </div>
       </div>
       <% } else { %>
       <div class="form-group col-sm-6">
        <label class="control-label col-sm-11" for="setor">Setor: </label>
        <div class="col-sm-11">
         <input type="text" class="form-control" name="setor" id="setor" placeholder="Insira o setor do equipamento" />
        </div>
       </div>
       <% } %>
       <div class="form-group col-sm-6">
        <label class="control-label col-sm-11" for="ponto">Ponto de Lubrificação: </label>
        <div class="col-sm-11">
         <input type="text" class="form-control" name="ponto" id="ponto" placeholder="Insira o ponto de lubrificação" />
        </div>
       </div>
       <div class="form-group col-sm-6">
        <label class="control-label col-sm-11" for="produto">Produto: </label>
        <div class="col-sm-11">
         <select class="form-control" name="produto" ng-model="produto" required>
          <option value="">Selecione o produto</option>
          <% 
          	ArrayList<Produto> produtos = null;
          	for(TipoProduto t:  tipos) { %>
           <optgroup label="<%= t.getTipo() %>">
            <%  produtos = ProdutoController.getProdutosPorTipo(t.getId());
            	for(Produto p: produtos){ %>
             <option value=<%= p.getId() %>><%= p.getProduto() %></option>
    	    <% } %>
    	   </optgroup>         
          <% } %>          
         </select>
        </div>
       </div>
       <div class="form-group col-sm-6">
        <label class="control-label col-sm-11" for="volume">Capacidade: </label>
        <div class="col-sm-11">
         <input type="number" step="0.01" class="form-control" name="volume" id="volume" placeholder="Insira capacidade do reservatório" />
        </div>
       </div>
       <div class="form-group col-sm-6">
       	<label class="control-label col-sm-11" for="conmin">Concentração Mínima: </label>
        <div class="col-sm-11">
         <input type="number" step="0.01" class="form-control" name="conmin" id="conmin" placeholder="Concentração mínima" ng-model="conMin" />
        </div>
       </div>
       <div class="form-group col-sm-6">
       	<label class="control-label col-sm-11" for="conmax">Concentração Máxima: </label>
        <div class="col-sm-11">
         <input type="number" step="0.01" class="form-control" name="conmax" id="conmax" placeholder="Concentração máxima" ng-model="conMax" />
        </div>
        <span style="color:red" ng-show="conMin >= conMax">
         A concentração máxima deve ser maior que a concentração mínima!		
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>		
		</span>
       </div>            
       <div class="form-group col-sm-6">
        <label class="control-label col-sm-11" for="phmin">Ph Mínimo: </label>
        <div class="col-sm-11">
         <input type="number" step="0.01" class="form-control" name="phmin" ng-model="phMin" id="phmin" placeholder="Limite mínimo Ph" />
        </div>                
       </div>
       <div class="form-group col-sm-6">
        <label class="control-label col-sm-11" for="phmax">Ph Máximo: </label>
        <div class="col-sm-11">
         <input type="number" step="0.01" class="form-control" name="phmax" ng-model="phMax" id="phmax" placeholder="Limite máximo Ph" />
        </div>
        <span style="color:red" ng-show="phMin >= phMax">        	
         O limite máximo do Ph deve ser maior que o limite mínimo do Ph!	
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>			
		</span>
       </div>
       <div class="form-group col-sm-12">
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
