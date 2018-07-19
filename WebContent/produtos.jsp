<%@page import="com.gf.model.controller.TipoProdutoController"%>
<%@page import="com.gf.model.entity.TipoProduto"%>
<%@page import="com.gf.model.controller.ProdutoController"%>
<%@page import="com.gf.model.entity.Produto"%>
<%@page import="java.util.ArrayList"%>
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
   ArrayList<Produto> produtos = new ArrayList<Produto>();
   ArrayList<TipoProduto> tipos = TipoProdutoController.getTiposProduto();
   String cod = request.getParameter("c");
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
        <a class="nav-link dropdown-toggle" href="#" id="dropdown03" 
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Clientes</a>
         <div class="dropdown-menu" aria-labelledby="dropdown03">
         <a class="dropdown-item" href="ins_cliente.jsp">Inserir</a>
         <a class="dropdown-item" href="clientes.jsp">Clientes</a>
         </div>
       </li>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown03" 
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
        <a class="nav-link dropdown-toggle" href="#" id="dropdown03" 
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
     <h5>Produtos <i class="fa fa-tint" aria-hidden="true"></i></h5>
     <hr />
	 <div class="alerta">
	 <%if(cod!=null){ %>
	 <% if(cod.equals("1")){ %>	  	
	  <div class="alert alert-success" role="alert" >
       <strong>Produto</strong> atualizado com sucesso.
       <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
       <a href="produtos.jsp" class="close">&times;</a>
      </div>
      <% } else if(cod.equals("2")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro SQL!</strong> ao atualizar Produto no banco de dados.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="produtos.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("3")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro Genérico!</strong> ao atualizar Produto.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="produtos.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("4")){ %>	  	
	  <div class="alert alert-success" role="alert" >
       <strong>Produto</strong> apagado com sucesso.
       <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
       <a href="produtos.jsp" class="close">&times;</a>
      </div>
      <% } else if(cod.equals("5")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro SQL!</strong> ao apagar Produto no banco de dados.
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
        <a href="produtos.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("6")){ %>
       <div class="alert alert-danger" role="alert" >
        <strong>Erro Genérico!</strong> ao apagar Produto.
        <i class="fa fa-check" aria-hidden="true"></i>
        <a href="produtos.jsp" class="close">&times;</a>
       </div>                                                              
      <% }} %>
	 </div>   
    <div class="container">
    <div class="row">
	  <div class="col-sm-4" style="padding-left: 0">
	   	<form class="form-horizontal" method="post" action="produtos.jsp">
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
	   		<a href="produtos.jsp" class="link-box" title="recarregar tabela"><i class="fa fa-refresh" aria-hidden="true"></i></a>
	   	</div>
	   	<div class="col-sm-7"></div>
	   </div>
	   
	   <%
			String busca = request.getParameter("busca");
	     
			if(busca == null){
				produtos = ProdutoController.getProdutos();
			} else {
				produtos = ProdutoController.searchProdutos(busca);
			}			
		%>
	   
     <div class="row">
      <div class="col-sm-12">
	   <div class="card card-success det-cli">
		<div class="card-header det-cli-h">Lista de Produtos
		<% if(uLogado.getPerfil() == 1) { %>
		 <div style="float: right">
		  <a href="ins_produto.jsp" class="link-box" >
		   <i class="fa fa-plus" aria-hidden="true"></i> adicionar
          </a>
		 </div>
		 <% } %>
		</div>
		<div class="card-block" style="max-height: 310px; overflow: auto;">
		 <% if(produtos.isEmpty()) { 
			 if(busca != null) {
		 %>		 
		 	<p>Sua pesquisa "<%=busca%>" não encontrou nenhum registro.</p>
		 <% 	} else { %>	
		 	<p>Não há logs de acessos registrados</p>
	     <% } } else { %>		
	      <div class="table-responsive">
		   <table class="table table-striped tab-tab">
		    <thead class="thead-tab-usu">
			 <th>Produto</th>		  			
			 <th>Tipo</th>
			 <th>Fabricante</th>
			 <% if(uLogado.getPerfil() == 1) { %>
		     <th>Editar</th>
		     <th>Apagar</th>
		     <% } %>
			</thead>
			<tbody class="tbody-tab-usu">
			 <% for(Produto p: produtos) { %>
			  <tr>			  	
			   <td><%= p.getProduto() %></td>			  		
			   <td><%= p.getTipo().getTipo() %></td>
			   <td><%= p.getFabricante() %></td>
			   <% if(uLogado.getPerfil() == 1) { %>
			   <td>
	          	<a href="#" data-toggle="modal" data-target="#updpro" class="link-box" 
	          	 onclick="setUpdPro('<%= p.getId() %>','<%= p.getProduto() %>','<%= p.getFabricante() %>')">
	          	<i class="fa fa-pencil-square-o" aria-hidden="true"></i></a></td>
               <td>
              	<a href="#" data-toggle="modal" data-target="#delpro" class="link-box" 
              	 onclick="setDelPro('<%= p.getProduto() %>','<%= p.getId() %>')">
              	<i class="fa fa-trash-o" aria-hidden="true"></i></a></td>
              	<% } %>
			  </tr>		  	
			 <% } %>
			</tbody>
		   </table>
		  </div>
         </div>
	    <% } %>
	    <div class="card-footer">
  		<div class="row">
  		   <div class="col-sm-2">	  	   
			<a href="#" class="legenda btn btn-success" onClick="history.go(-1)"  style="font-size: 14px"> 
				<i class="fa fa-backward" aria-hidden="true"></i> voltar </a> 
			</div>	
			<div class="col-sm-10" align="right"><b><%= produtos.size() %> </b> 
			<% if(produtos.size() != 1) %> produtos registrados.<% else %> produto registrado. 
			
			</div>
	  	 </div>
	    </div>
       </div>
      </div>
	 </div>
	</div>
	</div>
	
	<script>		
	function setDelPro(val1, val2) {		    
	 document.getElementById('val1').value = val1;
	 document.getElementById('val2').value = val2;
	}
	
	function setUpdPro(val3, val4, val5) {		    
	 document.getElementById('val3').value = val3;
	 document.getElementById('val4').value = val4;
	 document.getElementById('val5').value = val5;
	}
   </script>
	
	<hr />
	<div class="footer">
     <p class="rodape"> &copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
    </div>
    
    <div id="delpro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Apagar Produto</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>	
     <div class="modal-body">
      <div class="panel-body">
       Tem certeza que deseja apagar o produto?<br />  
       <output type="text" name="val1" id="val1"></output>
      </div> 
     </div>
     <div class="modal-footer">
      <div class="col-sm-6" align="center">
       <form method="post" action="DeleteProduto">
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
   
   <div id="updpro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Editar Produto</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>	
     <form class="form-horizontal" method="post" action="UpdateProduto">
     <div class="modal-body">
      <div class="panel-body">
       <input type="hidden" name="val3" id="val3">
       <div class="form-group">
  		<label class="control-label col-sm-11" for="produto">Produto: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val4" id="val4" />
        </div>
       </div>
       <div class="form-group">
  		<label class="control-label col-sm-11" for="fabricante">Fabricante: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val5" id="val5" />
        </div>
       </div>
       <div class="form-group">
       <label class="control-label col-sm-4" for="tipo">Tipo Produto: </label>
       <div class="col-sm-12">
        <select class="form-control" name="tipo">
         <option value="">Selecione o Tipo do produto</option>
         <!-- Popula lista de produtos no select -->
         <% for(TipoProduto t: tipos){ %>
          <option value=<%= t.getId() %>><%= t.getTipo() %></option>                           
         <% } %>
        </select>
       </div>
      </div>
      </div> 
     </div>
     <div class="modal-footer">
      <div class="col-sm-12" align="center">                
	    <button type="submit" class="btn btn-success" >
		 atualizar <i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
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
