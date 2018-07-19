<%@page import="com.gf.model.controller.VisitasController"%>
<%@page import="com.gf.model.controller.SetorController"%>
<%@page import="com.gf.model.entity.Setor"%>
<%@page import="com.gf.model.controller.EquipamentoController"%>
<%@page import="com.gf.model.entity.Equipamento"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.gf.model.controller.ContatoClienteController"%>
<%@page import="com.gf.model.entity.ContatoCliente"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gf.model.entity.Cliente"%>
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
	  	Usuario uLogado = (Usuario) session.getAttribute("uLogado");
	   	Cliente cliente = (Cliente) session.getAttribute("cliente");
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
   		ArrayList<Equipamento> equipamentos = EquipamentoController.getEquipamentosPorCliente(cliente.getId());
   		ArrayList<Setor> setores = SetorController.getSetoresPorCliente(cliente.getId());
   	%>
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
						<% if(uLogado.getPerfil() == 1 ) { %>
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
		       		<a class="nav-link dropdown-toggle" href="#" id="dropdown03"
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
					<a class="nav-link dropdown-toggle" href="" id="dropdown03"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Olá <%= uLogado.getNome() %></a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="usuario.jsp">Meus Dados</a>
						<a class="dropdown-item" href="LogoutServlet">Sair</a>
					</div>
				</li>
			</ul>
		</div><!-- fim navbarsExample03 -->
	</nav>

	<div class="col-sm-12 col-md-12 pt-3" role="main">
		<h5>Dados do Cliente <i class="fa fa-user-o" aria-hidden="true"></i></h5>
		<hr />
		<div class="alerta">
		<%if(cod!=null){ %>
			<% if(cod.equals("1")){ %>
				<div class="alert alert-success" role="alert" >
					<strong>Contato</strong> apagado com sucesso.
					<i class="fa fa-check" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("2")){ %>
				<div class="alert alert-danger" role="alert" >
					<strong>Erro</strong> ao apagar contato do banco de dados.
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("3")){ %>
				<div class="alert alert-danger" role="alert" >
					<strong>Erro inesperado</strong> ao apagar contato.
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("4")){ %>
				<div class="alert alert-success" role="alert" >
					<strong>Contato</strong> atualizado com sucesso.
					<i class="fa fa-check" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("5")){ %>
				<div class="alert alert-danger" role="alert" >
					<strong>Erro </strong> ao atualizar contato no banco de dados.
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("6")){ %>
				<div class="alert alert-danger" role="alert" >
					<strong>Erro inesperado</strong> ao atualizar contato.
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("7")){ %>
				<div class="alert alert-danger" role="alert" >
					<strong>Erro </strong> ao criar usuário no banco de dados
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("8")){ %>
				<div class="alert alert-danger" role="alert" >
					<strong>Erro inesperado</strong> ao criar usuário.
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("9")){ %>
				<div class="alert alert-success" role="alert" >
					<strong>Usuário</strong> criado com sucesso.
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } else if(cod.equals("10")){ %>
				<div class="alert alert-warning" role="alert" >
					<strong>Usuário</strong> já cadastrado.
					<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
					<a href="cliente.jsp" class="close">&times;</a>
				</div>
			<% } } %>
		</div><!-- fim alerta -->

		<div class="container-fluid">
			<div class="row"><!-- row 1 -->
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Nome: </div>
					<div class="div-det-bod"><%= cliente.getNome() %></div>
				</div>
			<% if(uLogado.getPerfil() == 1) { %>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Representante: </div>
					<div class="div-det-bod"><%= cliente.getUsuario().getNome() %></div>
				</div>
			<% } %>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Cidade: </div>
					<div class="div-det-bod"><%= cliente.getCidade().getCidade() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Estado: </div>
					<div class="div-det-bod"><%= cliente.getEstado().getUf() %></div>
				</div>
			</div><!-- fim row 1 -->


			<div class="row"><!-- row 2 -->
				<% if(setores.isEmpty()){
	   				ArrayList<ContatoCliente> contatos = ContatoClienteController.getContatosPorCliente(cliente.getId());
				%>
				<div class="col-sm-5">
					<div class="card card-success det-cli">
						<div class="card-header det-cli-h">Contatos <i class="fa fa-address-book-o" aria-hidden="true"></i>
							<div style="float: right">
								<a href="SelCliente?id=<%= cliente.getId() %>&op=con" class="link-box" >
									<i class="fa fa-plus" aria-hidden="true"></i> adicionar
								</a>
							</div>
						</div>
						<div class="card-block" style="max-height: 350px; overflow: auto;">
						<% if(contatos.isEmpty()) { %>
							<p>Não há contato cadastrado</p>
						<% } %>
						<% for(ContatoCliente c: contatos) { %>
							<div class="row box-cli">
								<div class="col-sm-3 id-box">Nome:</div>
								<div class="col-sm-9 dado-box"><%= c.getNome() %></div>
								<div class="col-sm-3 id-box">Cargo:</div>
								<div class="col-sm-9 dado-box"><%= c.getCargo() %></div>
								<div class="col-sm-3 id-box">Telefone:</div>
								<div class="col-sm-9 dado-box"><%= c.getTelefone() %></div>
								<div class="col-sm-3 id-box">Celular:</div>
								<div class="col-sm-9 dado-box"><%= c.getCelular() %></div>
								<div class="col-sm-3 id-box">Email:</div>
								<div class="col-sm-9 dado-box"><%= c.getEmail() %></div>
								<div class="col-sm-4 btn-box" align="center"><a href="#" class="link-box" data-toggle="modal" data-target="#updcon" onclick="setUpdCon('<%= c.getId() %>','<%= c.getNome() %>','<%= c.getCargo() %>','<%= c.getTelefone() %>','<%= c.getCelular() %>','<%= c.getEmail() %>')">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i> editar</a>
								</div>
								<div class="col-sm-4 btn-box" align="center"><a href="#" class="link-box" data-toggle="modal" data-target="#delcon" onclick="setDelCon('<%= c.getNome() %>','<%= c.getId() %>')">
									<i class="fa fa-trash-o" aria-hidden="true"></i> apagar</a>
								</div>
								<div class="col-sm-4 btn-box" align="center"><a class="link-box"
								href="InsertUsuarioCliente?cliente=<%=cliente.getId()%>&nome=<%=c.getNome()%>&telefone=<%=c.getTelefone()%>&celular=<%=c.getCelular()%>&email=<%=c.getEmail()%>">
									<i class="fa fa-user-o" aria-hidden="true"></i> criar usuário</a>
								</div>
							</div>
						<% } %>
						</div><!-- fim card-block -->
					</div><!-- fim card -->
				</div><!-- fim col-sm-5 -->

				<div class="col-sm-3">
					<div class="card card-success det-cli">
					  <div class="card-header det-cli-h">Relatórios <i class="fa fa-file-text-o" aria-hidden="true"></i>
				       </div>
				      <div class="card-block" style="max-height: 325px; overflow: auto;">

					   <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
						<div class="col-sm-12 dado-box">Equipamento por período</div>
					  </div>

					   <div class="col-sm-12" style="padding: 10px;">
				  	    <button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relper" style="font-size: 14px">
				 	 	 <img src="img/pdf.png" width="14" height="14"> Visualizar
						</button>
					   </div>

					  <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
						<div class="col-sm-12 dado-box">Produtos por período</div>
					  </div>

					   <div class="col-sm-12" style="padding: 10px;">
				  	    <button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relconsper" style="font-size: 14px">
				 	 	 <img src="img/pdf.png" width="14" height="14"> Visualizar
						</button>
					   </div>

						 <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
 						<div class="col-sm-12 dado-box">Consumo de produtos nos equipamentos</div>
 					  </div>

 					   <div class="col-sm-12" style="padding: 10px;">
 				  	    <button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relconsequ" style="font-size: 14px">
 				 	 	 <img src="img/pdf.png" width="14" height="14"> Visualizar
 						</button>
 					   </div>

					   <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
						<div class="col-sm-12 dado-box">Formulário de Controle</div>
					  </div>

					   <div class="col-sm-12" style="padding: 10px;">
				  	    <a href="docs/formulario.pdf" class="legenda btn btn-success btn-block" style="font-size: 14px">
				 	 	 <img src="img/pdf.png" width="14" height="14"> Visualizar
						</a>
					   </div>

				      </div>
				      <div class="card-footer">
				      	<div class="dado-box col-sm-12" style="color: #228B22;">
				      	 <a href="SelCliente?id=<%= cliente.getId() %>&op=eqs" class="link-box">
				      	 Tabela de Equipamentos <i class="fa fa-table" aria-hidden="true"></i></a></div>
				      </div>
					  </div><!-- fim card -->
				</div><!-- fim col-sm-3 -->

				<div class="col-sm-3" style="max-height: 400px; overflow: auto;">

					<%
						ArrayList<Integer> anos = VisitasController.getAnoVisita(cliente.getId());
						for(Integer ano: anos) {
					%>
					<div class="card card-success det-cli">
					  <div class="card-header det-cli-h">Visitas <%= ano %> <i class="fa fa-calendar" aria-hidden="true"></i>
				       </div>
				      <div class="card-block">
					  	<%
					  		ArrayList<Integer> meses = VisitasController.getMesesVisita(cliente.getId(), ano);
					  		for(Integer mes: meses) {
					  	%>
						  <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22; max-height: 350px; overflow: auto;">
							<div class="col-sm-12 dado-box">
								<% switch(mes){
									case 1: %> Janeiro <% ; break;
									case 2: %> Fevereiro <% ; break;
									case 3: %> Março <% ; break;
									case 4: %> Abril <% ; break;
									case 5: %> Maio <% ; break;
									case 6: %> Junho <% ; break;
									case 7: %> Julho <% ; break;
									case 8: %> Agosto <% ; break;
									case 9: %> Setembro <% ; break;
									case 10: %> Outubro <% ; break;
									case 11: %> Novembro <% ; break;
									case 12: %> Dezembro <% ; break;
								}
								%>
							</div>
						  </div>
						  <div class="row">
						  <%
							ArrayList<Integer> dias = VisitasController.getDiasVisita(cliente.getId(), mes);
							for(Integer dia: dias) {
				   		  %>
								<div class="alert alert-success col-sm-3 cal-dia" role="alert">
								  	<div class="col-sm-12" align="right" style="padding-right: 2px;">
								  		<strong><%= dia %></strong>
								  	</div>
								    <div class="col-sm-12" align="left">
								      <a class="link-box" href="RelatorioEquipamentosPorData?cliente=<%= cliente.getId() %>&data=<%=ano%>-<%=mes%>-<%=dia%>"
								      	title="Relatório por data">
	               					  <img src="img/pdf.png" width="16" height="16"></a>
	               					</div>
								</div>
							<% } %>
						  </div>
					  	<% } %>
				      </div>
				  	</div><!-- fim card -->
				  	<% } %>
				</div><!-- fim col-sm-3 -->


				<% } else { %>


					<div class="col-sm-5">

					<div class="card card-success det-cli">
						<div class="card-header det-cli-h">Contatos <i class="fa fa-address-book-o" aria-hidden="true"></i>
							<div style="float: right">
								<a href="SelCliente?id=<%= cliente.getId() %>&op=con" class="link-box" >
									<i class="fa fa-plus" aria-hidden="true"></i> adicionar
								</a>
							</div>
						</div>
						<div class="card-block" style="max-height: 360px; overflow: auto;">
						<% for(Setor s: setores) { %>
						<% ArrayList<ContatoCliente> contatosSetor = ContatoClienteController.getContatosPorSetor(s.getId()); %>

						<div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
							<div class="col-sm-12 dado-box" style="font-size: medium;"><%= s.getSetor() %></div>
					 	</div>

						<% if(contatosSetor.isEmpty()) { %>
							<p>Não há contato cadastrado neste setor</p>
						<% } %>

						<% for(ContatoCliente c: contatosSetor) { %>
							<div class="row box-cli">
								<div class="col-sm-3 id-box">Nome:</div>
								<div class="col-sm-9 dado-box"><%= c.getNome() %></div>
								<div class="col-sm-3 id-box">Cargo:</div>
								<div class="col-sm-9 dado-box"><%= c.getCargo() %></div>
								<div class="col-sm-3 id-box">Telefone:</div>
								<div class="col-sm-9 dado-box"><%= c.getTelefone() %></div>
								<div class="col-sm-3 id-box">Celular:</div>
								<div class="col-sm-9 dado-box"><%= c.getCelular() %></div>
								<div class="col-sm-3 id-box">Email:</div>
								<div class="col-sm-9 dado-box"><%= c.getEmail() %></div>
								<div class="col-sm-4 btn-box" align="center"><a href="#" class="link-box" data-toggle="modal" data-target="#updcon" onclick="setUpdCon('<%= c.getId() %>','<%= c.getNome() %>','<%= c.getCargo() %>','<%= c.getTelefone() %>','<%= c.getCelular() %>','<%= c.getEmail() %>')">
									<i class="fa fa-pencil-square-o" aria-hidden="true"></i> editar</a>
								</div>
								<div class="col-sm-4 btn-box" align="center"><a href="#" class="link-box" data-toggle="modal" data-target="#delcon" onclick="setDelCon('<%= c.getNome() %>','<%= c.getId() %>')">
									<i class="fa fa-trash-o" aria-hidden="true"></i> apagar</a>
								</div>
								<div class="col-sm-4 btn-box" align="center"><a class="link-box"
								href="InsertUsuarioCliente?cliente=<%=cliente.getId()%>&nome=<%=c.getNome()%>&telefone=<%=c.getTelefone()%>&celular=<%=c.getCelular()%>&email=<%=c.getEmail()%>">
									<i class="fa fa-user-o" aria-hidden="true"></i> criar usuário</a>
								</div>
							</div>
						<% } } %>
						</div><!-- fim card-block -->
					</div><!-- fim card -->
					</div><!-- fim col-sm-5 -->

				<div class="col-sm-3">
					<div class="card card-success det-cli">
					  <div class="card-header det-cli-h">Relatórios <i class="fa fa-file-text-o" aria-hidden="true"></i>
				       </div>
				      <div class="card-block" style="max-height: 325px; overflow: auto;">

					   <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
						<div class="col-sm-12 dado-box">Setor por data</div>
					  </div>

					   <div class="col-sm-12" style="padding: 10px;">
				  	    <button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relsetor" style="font-size: 14px">
				 	 	 <img src="img/pdf.png" width="14" height="14"> Visualizar
						</button>
					   </div>

					   <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
						<div class="col-sm-12 dado-box">Equipamento por período</div>
					  </div>

					   <div class="col-sm-12" style="padding: 10px;">
				  	    <button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relper" style="font-size: 14px">
				 	 	 <img src="img/pdf.png" width="14" height="14"> Visualizar
						</button>
					   </div>

						 <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
							 <div class="col-sm-12 dado-box">Consumo de produtos</div>
						</div>

						<div class="col-sm-12" style="padding: 10px;">
								<button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relconsper" style="font-size: 14px">
						 <img src="img/pdf.png" width="14" height="14"> Visualizar
						</button>
						 </div>

					<div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
 					 	<div class="col-sm-12 dado-box">Consumo de produtos nos equipamentos</div>
 					 </div>

 						<div class="col-sm-12" style="padding: 10px;">
 							 <button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relconsequ" style="font-size: 14px">
 						<img src="img/pdf.png" width="14" height="14"> Visualizar
 					 </button>
				 </div>

				 <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
					 <div class="col-sm-12 dado-box">Consumo de produtos equipamentos/setor</div>
					</div>

					 <div class="col-sm-12" style="padding: 10px;">
							<button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relconssetequ" style="font-size: 14px">
					 <img src="img/pdf.png" width="14" height="14"> Visualizar
					</button>
				</div>

						 <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
							 <div class="col-sm-12 dado-box">Consumo de produtos por setor</div>
						</div>

						 <div class="col-sm-12" style="padding: 10px;">
								<button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#relconsset" style="font-size: 14px">
						 <img src="img/pdf.png" width="14" height="14"> Visualizar
						</button>
						 </div>

					   <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
						<div class="col-sm-12 dado-box">Formulário de Controle</div>
					  </div>

					   <div class="col-sm-12" style="padding: 10px;">
				  	    <a href="docs/formulario.pdf" class="legenda btn btn-success btn-block" style="font-size: 14px">
				 	 	 <img src="img/pdf.png" width="14" height="14"> Visualizar
						</a>
					   </div>

				      </div>
				      <div class="card-footer">
				      	<div class="dado-box col-sm-12" style="color: #228B22;">
				      	 <a href="SelCliente?id=<%= cliente.getId() %>&op=eqs" class="link-box">
				      	 Tabela de Equipamentos <i class="fa fa-table" aria-hidden="true"></i></a></div>
				      </div>
					  </div><!-- fim card -->
				</div><!-- fim col-sm-3 -->

				<div class="col-sm-3" style="max-height: 500px; overflow: auto;">

					<%
						ArrayList<Integer> anos = VisitasController.getAnoVisita(cliente.getId());
						for(Integer ano: anos) {
					%>
					<div class="card card-success det-cli">
					  <div class="card-header det-cli-h">Visitas <%= ano %> <i class="fa fa-calendar" aria-hidden="true"></i>
				       </div>
				      <div class="card-block">
					  	<%
					  		ArrayList<Integer> meses = VisitasController.getMesesVisita(cliente.getId(), ano);
					  		for(Integer mes: meses) {
					  	%>
						  <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
							<div class="col-sm-12 dado-box">
								<% switch(mes){
									case 1: %> Janeiro <% ; break;
									case 2: %> Fevereiro <% ; break;
									case 3: %> Março <% ; break;
									case 4: %> Abril <% ; break;
									case 5: %> Maio <% ; break;
									case 6: %> Junho <% ; break;
									case 7: %> Julho <% ; break;
									case 8: %> Agosto <% ; break;
									case 9: %> Setembro <% ; break;
									case 10: %> Outubro <% ; break;
									case 11: %> Novembro <% ; break;
									case 12: %> Dezembro <% ; break;
								}
								%>
							</div>
						  </div>
						  <div class="row">
						  <%
							ArrayList<Integer> dias = VisitasController.getDiasVisita(cliente.getId(), mes);
							for(Integer dia: dias) {
				   		  %>
								<div class="alert alert-success col-sm-3 cal-dia" role="alert">
								  <div class="col-sm-12" align="right" style="padding-right: 2px;">
								  		<strong><%= dia %></strong>
								  	</div>
								    <div class="col-sm-12" align="left">
								      <a class="link-box" href="RelatorioEquipamentosPorData?cliente=<%= cliente.getId() %>&data=<%=ano%>-<%=mes%>-<%=dia%>"
								      	title="Relatório por data">
	               					  <img src="img/pdf.png" width="16" height="16"></a>
	               					</div>
								</div>
							<% } %>
						  </div>
					  	<% } %>
				      </div>
				  	</div><!-- fim card -->
				  	<% } %>
				</div><!-- fim col-sm-3 -->


				<% } %>

			</div><!-- fim row 2 -->
		</div><!-- fim container-fluid -->
	</div><!-- fim div main -->
	<script>
		function setDelCon(val1, val2) {
			document.getElementById('val1').value = val1;
			document.getElementById('val2').value = val2;
		}

		function setUpdCon(val3, val4, val5, val6, val7, val8) {
			document.getElementById('val3').value = val3;
			document.getElementById('val4').value = val4;
			document.getElementById('val5').value = val5;
			document.getElementById('val6').value = val6;
			document.getElementById('val7').value = val7;
			document.getElementById('email').value = val8;
		}
	</script>

	<hr />
	<div class="footer">
		<p class="rodape"> &copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
	</div>

	<!-- Modal - Editar e Apagar Contatos -->
	<div id="delcon" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Apagar Contato</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="panel-body">
						Tem certeza que deseja apagar o contato?<br />
						<output type="text" name="val1" id="val1"></output>
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-sm-6" align="center">
						<form method="post" action="DeleteContato">
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
		</div><!-- fim modal-dialog -->
	</div><!-- fim id-delcon -->

	<div id="updcon" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade" ng-controller="controllerName">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Editar Contato</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form class="form-horizontal" name="form" method="post" action="UpdateContato">
					<div class="modal-body">
						<div class="panel-body">
							<input type="hidden" name="val3" id="val3">
							<div class="form-group">
								<label class="control-label col-sm-11" for="nome">Nome: </label>
								<div class="col-sm-12">
									<input type="text" class="form-control" name="val4" id="val4" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="cargo">Cargo: </label>
								<div class="col-sm-12">
									<input type="text" class="form-control" name="val5" id="val5" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="telefone">Telefone: </label>
								<div class="col-sm-12">
									<input type="text" class="form-control" ng-model="telefone" name="val6" id="val6" ui-telefone />
								</div>
						    </div>
						    <div class="form-group">
							    <label class="control-label col-sm-11" for="celular">Celular: </label>
							    <div class="col-sm-12">
							    	<input type="text" class="form-control" ng-model="celular" name="val7" id="val7" ui-celular />
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
		    </div><!-- fim modal-content -->
	    </div><!-- fim modal-dialog -->
    </div><!-- fim id-updcon -->

	<!-- Gerar relatório por data -->

	<div id="reldata" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório por data</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="RelatorioEquipamentosPorData">
					<div class="modal-body">
						<input type="hidden" name="cliente" id="cliente"
							value=<%=cliente.getId()%>>
						<div class="form-group">
							<label class="control-label col-sm-11" for="data">Escolha
								a data: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="data" id="data" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Gerar relatório de setor por data -->

	<div id="relsetor" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório do setor por data</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="RelatorioEquipamentosPorDataSetor">
					<div class="modal-body">
						<div class="form-group">
							<div class="col-sm-12">
								<select class="form-control" name="setor">
									<option value="">Selecione o setor</option>
									<!-- Popula lista de tipos no select -->
									<%
										for (Setor s : setores) {
									%>
									<option value=<%=s.getId()%>><%=s.getSetor()%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="data">Escolha
								a data: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="data" id="data" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Gerar relatório por periodo -->

	<div id="relper" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório por período</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="RelatorioControlePorPeriodo">
					<div class="modal-body">
						<div class="form-group">
							<div class="col-sm-12">
								<select class="form-control" name="equipamento">
									<option value="">Selecione o equipamento</option>
									<!-- Popula lista de tipos no select -->
									<%
										for (Equipamento e : equipamentos) {
									%>
									<option value=<%=e.getId()%>><%=e.getTag()%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datain">Data
								inicial: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datain"
									id="datain" />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datafi">Data
								final: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datafi"
									id="datafi" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Gerar relatório consumo de produtos por periodo -->

	<div id="relconsper" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório de consumo <br />Produtos por período</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="RelProdutoPorCliente">
					<div class="modal-body">
						<div class="form-group">
							<div class="col-sm-12">
								<input type="hidden" name="cliente" id="cliente"
									value=<%=cliente.getId()%>>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datain">Data
								inicial: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datain"
									id="datain" />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datafi">Data
								final: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datafi"
									id="datafi" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Gerar relatório consumo de produtos por setor por periodo -->

	<div id="relconsset" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório de consumo <br />Produtos por setor</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="RelProdutoPorSetor">
					<div class="modal-body">
						<div class="form-group">
							<div class="col-sm-12">
								<input type="hidden" name="cliente" id="cliente"
									value=<%=cliente.getId()%>>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<select class="form-control" name="setor">
									<option value="">Selecione o setor</option>
									<!-- Popula lista de tipos no select -->
									<%
										for (Setor s : setores) {
									%>
									<option value=<%=s.getId()%>><%=s.getSetor()%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datain">Data
								inicial: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datain"
									id="datain" />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datafi">Data
								final: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datafi"
									id="datafi" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Gerar relatório consumo de produtos por equipamento setor por periodo -->

	<div id="relconssetequ" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório de consumo <br />Produtos por equipamento - setor</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="ConsumoPorSetorEquip">
					<div class="modal-body">
						<div class="form-group">
							<div class="col-sm-12">
								<input type="hidden" name="cliente" id="cliente"
									value=<%=cliente.getId()%>>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<select class="form-control" name="setor">
									<option value="">Selecione o setor</option>
									<!-- Popula lista de tipos no select -->
									<%
										for (Setor s : setores) {
									%>
									<option value=<%=s.getId()%>><%=s.getSetor()%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datain">Data
								inicial: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datain"
									id="datain" />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datafi">Data
								final: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datafi"
									id="datafi" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Gerar relatório consumo de produtos por equipamento -->

	<div id="relconsequ" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório de consumo <br />Produtos por equipamento</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="ConsumoPorEquipamento">
					<div class="modal-body">
						<div class="form-group">
							<div class="col-sm-12">
								<input type="hidden" name="cliente" id="cliente"
									value=<%=cliente.getId()%>>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datain">Data
								inicial: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datain"
									id="datain" />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-11" for="datafi">Data
								final: </label>
							<div class="col-sm-12">
								<input type="date" class="form-control" name="datafi"
									id="datafi" />
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i>
							</button>
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
