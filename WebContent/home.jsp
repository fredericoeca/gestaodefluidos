<%@page import="java.util.Locale"%>
<%@page import="com.gf.model.controller.SetorController"%>
<%@page import="com.gf.model.entity.Setor"%>
<%@page import="com.sun.org.apache.xerces.internal.impl.dv.xs.DecimalDV"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.gf.model.controller.ContatoClienteController"%>
<%@page import="com.gf.model.entity.ContatoCliente"%>
<%@page import="com.gf.model.controller.UsuarioController"%>
<%@page import="com.gf.model.controller.VisitasController"%>
<%@page import="com.gf.model.entity.Visitas"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.gf.model.controller.ControleFluidoController"%>
<%@page import="com.gf.model.entity.ControleFluido"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.gf.model.controller.EquipamentoController"%>
<%@page import="com.gf.model.entity.Equipamento"%>
<%@page import="com.gf.model.controller.ClienteController"%>
<%@page import="com.gf.model.entity.Cliente"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
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
   ArrayList<Cliente> clientes = new ArrayList<Cliente>();
   Locale.setDefault(new Locale("pt", "BR"));
   SimpleDateFormat frmtData = new SimpleDateFormat("dd/MM/yyyy");
   String cod = request.getParameter("c");
   String uid = request.getParameter("uid");
   String cli = request.getParameter("cli");
  %>
  <body ng-app="app">
  <% if(uLogado == null) { %>
   <h6>Você não tem acesso ao sistema <a href="index.jsp" style="color: #269abc">faça seu login.</a></h6>

   <!-- Pagina inicial do Administrado e Representante -->
  <% } else if(uLogado.getPerfil() == 1 || uLogado.getPerfil() == 2) { %>

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
          <% if(uLogado.getPerfil() == 1 ) { %>
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

    <div class="col-sm-12 col-md-12 pt-3" role="main">
    <div class="container-fluid">
     <div class="row">

 	  <div class="col-sm-5">
 	  	<%
	 	  	if(uid == null){
		   		clientes = ClienteController.getClientesPorUsuario(uLogado.getId());
		   	} else {
		   		clientes = ClienteController.getClientesPorUsuario(Integer.parseInt(uid));
		   	}
 	  	%>
 	   <div class="alert alert-success" role="alert">
        <h5 class="alert-heading">Olá <%= UsuarioController.getUsuario(uLogado.getId()).getNome() %>!</h5>
        <p>Seja bem vindo ao Sistema de Gestão de Fluidos de Processo da All Lubrificantes.</p>
       </div>

       <% if(uLogado.getPerfil() == 1) { %>
       <div class="card" style="margin-bottom: 16px">
	   <div class="card-header">
	    <b style="color: #828282">Selecione o representante</b>
	   </div>
	   <div class="card-block" style="padding-top: 5px; padding-bottom: 5px;">
	   <%
	   	ArrayList<Usuario> usuarios = UsuarioController.getUsuarios();
	   %>
      <div class="col-sm-12">
        <select class="form-control" name="usuario" id="selecao">
         <option value="">Selecione o Representante</option>
         <!-- Popula lista de representantes no select -->
         <% for(Usuario u: usuarios){ %>
         	<% if(u.getPerfil() != 3) { %>
          		<option value="home.jsp?uid=<%= u.getId() %>"><%= u.getNome() %></option>
          	<% } %>
         <% } %>
        </select>
       </div>
	   </div>
	   </div>
	  <% } %>

	  <script>
		$('#selecao').change(function() {
		    window.location = $(this).val();
		});
      </script>

      <div class="card" style="max-height: 330px; overflow: auto;">
	   <div class="card-header">
	   	<% if(uid == null) { %>
	    <b style="color: #828282">Clientes do <%= uLogado.getNome() %></b>
	    <% } else { %>
	    <b style="color: #828282">Clientes do <%= UsuarioController.getUsuario(Integer.parseInt(uid)).getNome() %></b>
	    <% } %>
	   </div>
	   <div class="card-block" style="padding-top: 5px; padding-bottom: 5px;">

	    <div class="row">
	    <div class="col-sm-12">
	    <div class="card" style="border-radius: 0;">
		  <div class="card-block">
           <% for(Cliente c: clientes) { %>
            <details>
			  <summary><a href="home.jsp?<% if(uid != null){ %>uid=<%=uid%>&<% } %>cli=<%=c.getId()%>"
			  			id="link"><%= c.getNome() %></a></summary>

			  	<details style="padding-left: 20px;">
			  		<summary><a id="link" href="SelCliente?id=<%=c.getId()%>&op=det">Página do Cliente</a></summary>
				</details>

				<details style="padding-left: 20px;">
			  		<summary><a id="link" href="SelCliente?id=<%=c.getId()%>&op=eqs">Equipamentos</a></summary>
				</details>

			</details>
           <% } %>
		  </div>
		</div>
		</div>
		</div>
	   </div>
	  </div>
	 </div>
 	    <% if(cli == null){ %>
 	    	<div class="col-sm-4" style="max-height: 600px; overflow: auto;">
		  	  <div class="alert alert-warning" role="alert" align="justify" style="font-size: 14px">
		        <strong>Clique</strong> no nome do cliente para exibir detalhes de suas visitas e comparativos de controles.
		       </div>
		    </div>
 	    <% } else { %>
  	  <div class="col-sm-3" style="max-height: 600px; overflow: auto;">
  	  <div class="alert alert-info" role="alert" align="justify" style="font-size: 12px">
        <strong>Calendário de Visitas </strong>exibe os dias em que o cliente foi visitado com o link do relatório referênte
        ao dia.
       </div>

		<%
			Cliente cliente = ClienteController.getCliente(Integer.parseInt(cli));
			ArrayList<Integer> anos = VisitasController.getAnoVisita(cliente.getId());
		%>

		<% if(anos.isEmpty()) { %>
      		<div class="alert alert-danger" role="alert" align="justify" style="font-size: 12px">
	        <strong>Cliente </strong>ainda não tem visitas registradas.
	       	</div>
      	<% } %>

		<%
			for(Integer ano: anos) {
		%>
		<div class="card card-success det-cli">
		  <div class="card-header det-cli-h"><%= ano %> <i class="fa fa-calendar" aria-hidden="true"></i></div>
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
					<div class="alert alert-success col-sm-2 cal-dia" role="alert">
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
	  	<% }  %>

  	  </div>

  	  <div class="col-sm-4" style="max-height: 600px; overflow: auto;">
  	   <div class="alert alert-info" role="alert" align="justify" style="font-size: 12px">
        <strong>As Tabelas </strong>desta coluna comparam os dados aferidos na última visita da Concentração e Ph com a medição anterior, mostrando a diferença entre as duas.
       </div>


  	   <div class="card text-center">
		  <div class="card-header" id="index-card-f">
		    <b style="color: #828282"><%= cliente.getNome() %></b>
		 </div>
		  <%
			ArrayList<ControleFluido> controles = ControleFluidoController.getControleForIndex(cliente.getId());
		  %>
		  <div class="card-body" style="padding: 0;">
		 <% if(controles.isEmpty()) { %>
          <p>Não há controles cadastrado</p>
         <% } else { %>
            <div class="table-responsive tab">
            <table class="table table-striped tab-tab_1">
             <thead class="thead-tab-usu" align="left">
              <th>Equip</th>
              <th>Con(%)</th>
              <th>Dif</th>
              <th>Ph(%)</th>
			  <th>Dif</th>
              </thead>
             <tbody class="tbody-tab-usu" style="text-align: left; font-size: 12px;">
             <%
             	for(ControleFluido cf: controles) {
             		double[] dif = ControleFluidoController.difControleAnterior(cf.getConcentracao(), cf.getPh(),
             				cf.getEquipamento().getCliente().getId(), cf.getEquipamento().getId());
             %>
             <tr>
               <!-- Coluna de Data da medição -->

               <td>
               		<a id="link" href="SelEquipamento?id=<%= cf.getEquipamento().getId() %>&op=det&sid=null">
               		<b><%= cf.getEquipamento().getTag() %></b></a></td>

               <!-- Coluna de Concentração Medida -->
               <% if(cf.getConcentracao() > cf.getEquipamento().getConsentracaoMax()) { %>
                <td class="res-pos-i" align="left">
	             <i class="fa fa-caret-up" aria-hidden="true"></i>
	             <%= DecimalFormat.getNumberInstance().format(cf.getConcentracao()) %>
                </td>
               <% } else if(cf.getConcentracao() < cf.getEquipamento().getConsentracaoMin()) { %>
                <td class="res-neg-i">
       	         <i class="fa fa-caret-down" aria-hidden="true"></i>
	             <%= DecimalFormat.getNumberInstance().format(cf.getConcentracao()) %>
                </td>
               <% } else { %>
                <td class="res-pos-i"><%= DecimalFormat.getNumberInstance().format(cf.getConcentracao()) %></td>
               <% } %>

				<% if(dif[0] > 0) { %>
				 <td class="res-pos-i" align="left">
	              <i class="fa fa-caret-up" aria-hidden="true"></i>
	              <%= DecimalFormat.getNumberInstance().format(dif[0]) %></td>
                 <% } else if(dif[0] < 0) { %>
                 <td class="res-neg-i">
                   <i class="fa fa-caret-down" aria-hidden="true"></i>
                   <%= DecimalFormat.getNumberInstance().format(dif[0]*(-1)) %></td>
              	 <% } else { %>
                 <td class="res-med-i">
                  <%= DecimalFormat.getNumberInstance().format(dif[0]) %></td>
                 <% } %>

				<!-- Coluna de Ph Medido -->
				<% if(cf.getPh() < cf.getEquipamento().getLimiteMinPh()) { %>
				 <td class="res-neg-i">
				  <i class="fa fa-caret-down" aria-hidden="true"></i>
				  <%= NumberFormat.getNumberInstance().format(cf.getPh()) %>
				 </td>
				<% } else if(cf.getPh() > cf.getEquipamento().getLimiteMaxPh()) { %>
				 <td class="res-neg-i">
				  <i class="fa fa-caret-up" aria-hidden="true"></i>
				  <%= NumberFormat.getNumberInstance().format(cf.getPh()) %>
				 </td>
				<% } else { %>
				 <td class="res-pos-i"><%= NumberFormat.getNumberInstance().format(cf.getPh()) %></td>
				<% } %>

				<% if(dif[1] > 0) { %>
				 <td class="res-pos-i" align="left">
	              <i class="fa fa-caret-up" aria-hidden="true"></i>
	              <%= NumberFormat.getNumberInstance().format(dif[1]) %></td>
                <% } else if(dif[1] < 0) { %>
                 <td class="res-neg-i">
                  <i class="fa fa-caret-down" aria-hidden="true"></i>
                  <%= NumberFormat.getNumberInstance().format(dif[1]*(-1)) %></td>
                <% } else { %>
                 <td class="res-med-i">
                  <%= NumberFormat.getNumberInstance().format(dif[1]) %></td>
                <% } %>
                </tr>
              <% } %>
             </tbody>
            </table>
           </div>
          <% } %>
          </div>
		  <div class="card-footer text-muted">
		    <div class="row">
	    	<div class="col-sm-4">
	    		<a href="SelCliente?id=<%= cliente.getId() %>&op=det" class="link-box">
	    		<i class="fa fa-info-circle" aria-hidden="true" title="Detalhes do <%=cliente.getNome()%>"></i></a></div>
	    	<div class="col-sm-4">
	    		<a href="SelCliente?id=<%= cliente.getId() %>&op=equ" class="link-box" >
	    		<i class="fa fa-cogs" aria-hidden="true" title="Inserir equipamento"></i></a></div>
	    	<div class="col-sm-4">
	    		<a href="SelCliente?id=<%= cliente.getId() %>&op=con" class="link-box" >
	    		<i class="fa fa-address-book-o" aria-hidden="true" title="Inserir contato"></i></a></div>
		    </div>
		  </div>
		</div><br />
  	    <% } %>
  	  </div>
     </div>
	</div>
	</div>
	<hr />
	<div class="footer">
   	 <p class="rodape"> &copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
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

   <!-- Página inicial do cliente -->
   <% } else if(uLogado.getPerfil() == 3) { %>

   <nav class="navbar navbar-expand-sm navbar-dark fixed-top bg-dark">
    <a class="navbar-brand" href="home.jsp"><img src="img/favicon.png" width="25" height="25"/>Gestão de Fluidos de Processo</a>
     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample03" aria-controls="navbarsExample03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
     </button>

     <div class="collapse navbar-collapse" id="navbarsExample03">
      <ul class="navbar-nav mr-auto">
       </ul>
       <ul class="navbar-nav right">
        <li class="nav-item dropdown active">
         <a class="nav-link dropdown-toggle" href="#" id="dropdown03"
          data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Olá <%= uLogado.getNome() %>   </a>
          <div class="dropdown-menu" aria-labelledby="dropdown03">
           <a class="dropdown-item" href="LogoutServlet">Sair</a>
	      </div>
        </li>
        <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown03"
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Ajuda</a>
         <div class="dropdown-menu" aria-labelledby="dropdown03">
          <a class="dropdown-item" href="#" data-toggle="modal" data-target="#sobre">Sobre</a>
         </div>
       </li>
       </ul>
     </div>
    </nav>

   <div class="col-sm-12 col-md-12 pt-3" role="main" >
    <div class="container">
     <div class="row">
 	  <div class="col-sm-3">

 	  <div class="alerta-usuario">
      <%if(cod!=null){
       if(cod.equals("1")){ %>
       <div class="alert alert-success" role="alert" >
    	<strong>Senha</strong> alterada.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="home.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("2")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Senha</strong> inválida.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="home.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("3")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> no banco.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="home.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("4")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> inesperado.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="home.jsp" class="close">&times;</a>
       </div>
       <% } else if(cod.equals("5")){ %>
       <div class="alert alert-success" role="alert" >
    	<strong>Usuário</strong> alterado.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="home.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("6")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> no banco.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="home.jsp" class="close">&times;</a>
       </div>
      <% } else if(cod.equals("7")){ %>
       <div class="alert alert-danger" role="alert" >
    	<strong>Erro</strong> inesperado.
    	 <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
    	 <a href="home.jsp" class="close">&times;</a>
       </div>
      <% }} %>
     </div>

 	  <div class="card">
 	  <%
 	  	Usuario usu = UsuarioController.getUsuario(uLogado.getId());
 	  	ContatoCliente contato = new ContatoCliente();
 	  	contato = ContatoClienteController.getContatoEmail(usu.getEmail());
 	  	Setor setor = SetorController.getSetorContato(contato.getId());
 	  %>

 	  <div class="card-header" align="center">
	   	<b style="color: #828282"><%= usu.getNome() %></b>
	   </div>
 	   <div class="row box-cli" style="padding-top: 0">
         <div class="col-sm-12 dado-box-i center-top"><%= usu.getTelefone() %></div>
         <div class="col-sm-12 dado-box-i center-top"><%= usu.getCelular() %></div>
         <div class="col-sm-12 dado-box-i center-top"><%= usu.getEmail() %></div>
	     <div class="col-sm-12 btn-box" align="center"><a href="#" class="link-box" data-toggle="modal" data-target="#updusu"
	      onclick="setUpdUsu('<%= usu.getId() %>','<%= usu.getNome() %>','<%= usu.getTelefone() %>','<%= usu.getCelular() %>','<%= usu.getEmail() %>')">
	      <i class="fa fa-pencil-square-o" aria-hidden="true"></i> editar</a></div>
	     <div class="col-sm-12 btn-box" align="center"><a href="#" class="link-box" data-toggle="modal" data-target="#mudarsenha">
	      <i class="fa fa-unlock-alt" aria-hidden="true"></i> mudar senha</a></div>
        </div>
      </div><br />

      <div class="card" style="max-height: 280px; overflow: auto;">
	   <div class="card-header">
	   <b style="color: #828282"><%= uLogado.getCliente().getNome() %></b><br />
	   </div>
	   <div class="card-block" style="padding-top: 5px; padding-bottom: 5px;">
	   <%
	   	ArrayList<Equipamento> equipamentos = new ArrayList<Equipamento>();
	   	ArrayList<ContatoCliente> contatos = new ArrayList<ContatoCliente>();

	   	if(setor == null) {
	    	equipamentos = EquipamentoController.getEquipamentosPorCliente(uLogado.getCliente().getId());
	   	} else {
	   		equipamentos = EquipamentoController.getEquipamentosPorSetor(setor.getId());
	   	}
	   %>

	   <details style="padding-left: 20px;">
		<summary>Equipamentos</summary>
		 <% for(Equipamento e: equipamentos) { %>
		  <a id="link" href="SelEquipamento?id=<%= e.getId() %>&op=det" style="padding-left: 20px;">
		  <b><%= e.getTag() %> - <%= e.getTipo() %> <%= e.getFabricante() %></b></a><br />
		 <% } %>
	   </details>
	   </div>
	   </div><br />

	   </div>

	  <div class="col-sm-3">

	  <div class="card text-center">
		  <div class="card-header" id="index-card-f">
		    <b style="color: #828282">Controle de Visitas</b>
		 </div>
		 <%
         	ArrayList<Visitas> lstVisitas = new ArrayList<Visitas>();
         	lstVisitas = VisitasController.getRegistrosPorCliente(uLogado.getCliente().getId());
         %>
		 <div class="card-body" style="padding: 0; max-height: 150px; overflow: auto;">
		  <% if(lstVisitas.isEmpty()) { %>
          <p>Não há registros de visitas</p>
         <% } else { %>
		 	<div class="table-responsive tab">
            <table class="table table-striped tab-tab_1">
             <thead class="thead-tab-usu">
              <th>Ultimas Visitas</th>
              <th>Relatórios</th>
             </thead>
             <tbody class="tbody-tab-usu" style="text-align: left; font-size: 12px;">
              <% for(Visitas v: lstVisitas) { %>
              <tr>
               <td><%= frmtData.format(v.getData()) %></td>
               <% if(setor == null) { %>
               <td><a class="link-box" href="RelatorioEquipamentosPorData?cliente=<%= uLogado.getCliente().getId() %>&data=<%= v.getData() %>" >
               		<img src="img/pdf.png" width="16" height="16"></img></a></td>
               	<% } else { %>
               	<td><a class="link-box" href="RelatorioEquipamentosPorDataSetor?setor=<%= setor.getId() %>&data=<%= v.getData() %>" >
               		<img src="img/pdf.png" width="16" height="16"></img></a></td>
               	<% } %>
               </tr>
              <% } %>
             </tbody>
            </table>
           </div>
           <% } %>
		 </div>
		</div><br />


	  <div class="card card-success">
	  <div class="card-header det-cli-h">Relatórios <i class="fa fa-file-text-o" aria-hidden="true"></i>
       </div>
      <div class="card-block">
	  <div class="row box-cli" style="background-color: #E8E8E8; color: #228B22;">
		<div class="col-sm-12 dado-box">Cliente por data</div>
	  </div>

  	   <div class="col-sm-12" style="padding: 10px;">
  	    <button href="#" class="legenda btn btn-success btn-block" data-toggle="modal" data-target="#reldata" style="font-size: 14px">
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
		<div class="col-sm-12 dado-box">Formulário de Controle</div>
	  </div>

	   <div class="col-sm-12" style="padding: 10px;">
  	    <a href="docs/formulario.pdf" class="legenda btn btn-success btn-block" style="font-size: 14px">
 	 	 <img src="img/pdf.png" width="14" height="14"> Visualizar
		</a>
	   </div>

      </div>
	  </div>

  	  </div>

  	  <div class="col-sm-5" style="max-height: 520px; overflow: auto;">
  	   <div class="alert alert-info" role="alert" align="justify" style="font-size: 12px">
        <strong>As Tabelas </strong>desta coluna comparam os dados aferidos na última visita da Concentração e Ph com a medição anterior, mostrando a diferença entre as duas.
       </div>
  	   <div class="card text-center">
		  <div class="card-header" id="index-card-f">
		    <b style="color: #828282">Comparativo de medições</b>
		 </div>
		  <%
			ArrayList<ControleFluido> controles = ControleFluidoController.getControleForIndex(uLogado.getCliente().getId());
		  %>
		  <div class="card-body" style="padding: 0; max-height: 400px; overflow: auto;">
		 <% if(controles.isEmpty()) { %>
          <p>Não há controles cadastrado</p>
         <% } else { %>
            <div class="table-responsive tab" >
            <table class="table table-striped tab-tab_1">
             <thead class="thead-tab-usu" align="left">
              <th>Equip</th>
              <th>Con(%)</th>
              <th>Dif</th>
              <th>Ph(%)</th>
			  <th>Dif</th>
              </thead>
             <tbody class="tbody-tab-usu" style="text-align: left; font-size: 12px;">
             <%
             	for(ControleFluido cf: controles) {
             	if(setor == null) {
             		double[] dif = ControleFluidoController.difControleAnterior(cf.getConcentracao(), cf.getPh(),
             				cf.getEquipamento().getCliente().getId(), cf.getEquipamento().getId());
             %>
              <tr>
               <!-- Coluna de Data da medição -->

               <td>
               		<a id="link" href="SelEquipamento?id=<%= cf.getEquipamento().getId() %>&op=det">
               		<b><%= cf.getEquipamento().getTag() %></b></a></td>

               <!-- Coluna de Concentração Medida -->
               <% if(cf.getConcentracao() > cf.getEquipamento().getConsentracaoMax()) { %>
                <td class="res-pos-i" align="left">
	             <i class="fa fa-caret-up" aria-hidden="true"></i>
	             <%= NumberFormat.getNumberInstance().format(cf.getConcentracao()) %>
                </td>
               <% } else if(cf.getConcentracao() < cf.getEquipamento().getConsentracaoMin()) { %>
                <td class="res-neg-i">
       	         <i class="fa fa-caret-down" aria-hidden="true"></i>
	             <%= NumberFormat.getNumberInstance().format(cf.getConcentracao()) %>
                </td>
               <% } else { %>
                <td class="res-pos-i"><%= NumberFormat.getNumberInstance().format(cf.getConcentracao()) %></td>
               <% } %>

				<% if(dif[0] > 0) { %>
				 <td class="res-pos-i" align="left">
	              <i class="fa fa-caret-up" aria-hidden="true"></i>
	              <%= NumberFormat.getNumberInstance().format(dif[0]) %></td>
                 <% } else if(dif[0] < 0) { %>
                 <td class="res-neg-i">
                   <i class="fa fa-caret-down" aria-hidden="true"></i>
                   <%= NumberFormat.getNumberInstance().format(dif[0]*(-1)) %></td>
              	 <% } else { %>
                 <td class="res-med-i">
                  <%= NumberFormat.getNumberInstance().format(dif[0]) %></td>
                 <% } %>

				<!-- Coluna de Ph Medido -->
				<% if(cf.getPh() < cf.getEquipamento().getLimiteMinPh()) { %>
				 <td class="res-neg-i">
				  <i class="fa fa-caret-down" aria-hidden="true"></i>
				  <%= NumberFormat.getNumberInstance().format(cf.getPh()) %>
				 </td>
				<% } else if(cf.getPh() > cf.getEquipamento().getLimiteMaxPh()) { %>
				 <td class="res-neg-i">
				  <i class="fa fa-caret-up" aria-hidden="true"></i>
				  <%= NumberFormat.getNumberInstance().format(cf.getPh()) %>
				 </td>
				<% } else { %>
				 <td class="res-pos-i"><%= NumberFormat.getNumberInstance().format(cf.getPh()) %></td>
				<% } %>

				<% if(dif[1] > 0) { %>
				 <td class="res-pos-i" align="left">
	              <i class="fa fa-caret-up" aria-hidden="true"></i>
	              <%= NumberFormat.getNumberInstance().format(dif[1]) %></td>
                <% } else if(dif[1] < 0) { %>
                 <td class="res-neg-i">
                  <i class="fa fa-caret-down" aria-hidden="true"></i>
                  <%= NumberFormat.getNumberInstance().format(dif[1]*(-1)) %></td>
                <% } else { %>
                 <td class="res-med-i">
                  <%= NumberFormat.getNumberInstance().format(dif[1]) %></td>
                <% } %>
                </tr>
              <% } else {

            	  if(EquipamentoController.isEquSetor(cf.getEquipamento().getId(), setor.getId())) {
            	  double[] dif = ControleFluidoController.difControleAnterior(cf.getConcentracao(), cf.getPh(),
           				cf.getEquipamento().getCliente().getId(), cf.getEquipamento().getId());
           %>
            <tr>
             <!-- Coluna de Data da medição -->

             <td>
             		<a id="link" href="SelEquipamento?id=<%= cf.getEquipamento().getId() %>&op=det">
             		<b><%= cf.getEquipamento().getTag() %></b></a></td>

             <!-- Coluna de Concentração Medida -->
             <% if(cf.getConcentracao() > cf.getEquipamento().getConsentracaoMax()) { %>
              <td class="res-pos-i" align="left">
	             <i class="fa fa-caret-up" aria-hidden="true"></i>
	             <%= NumberFormat.getNumberInstance().format(cf.getConcentracao()) %>
              </td>
             <% } else if(cf.getConcentracao() < cf.getEquipamento().getConsentracaoMin()) { %>
              <td class="res-neg-i">
     	         <i class="fa fa-caret-down" aria-hidden="true"></i>
	             <%= NumberFormat.getNumberInstance().format(cf.getConcentracao()) %>
              </td>
             <% } else { %>
              <td class="res-pos-i"><%= NumberFormat.getNumberInstance().format(cf.getConcentracao()) %></td>
             <% } %>

				<% if(dif[0] > 0) { %>
				 <td class="res-pos-i" align="left">
	              <i class="fa fa-caret-up" aria-hidden="true"></i>
	              <%= NumberFormat.getNumberInstance().format(dif[0]) %></td>
               <% } else if(dif[0] < 0) { %>
               <td class="res-neg-i">
                 <i class="fa fa-caret-down" aria-hidden="true"></i>
                 <%= NumberFormat.getNumberInstance().format(dif[0]*(-1)) %></td>
            	 <% } else { %>
               <td class="res-med-i">
                <%= NumberFormat.getNumberInstance().format(dif[0]) %></td>
               <% } %>

				<!-- Coluna de Ph Medido -->
				<% if(cf.getPh() < cf.getEquipamento().getLimiteMinPh()) { %>
				 <td class="res-neg-i">
				  <i class="fa fa-caret-down" aria-hidden="true"></i>
				  <%= NumberFormat.getNumberInstance().format(cf.getPh()) %>
				 </td>
				<% } else if(cf.getPh() > cf.getEquipamento().getLimiteMaxPh()) { %>
				 <td class="res-neg-i">
				  <i class="fa fa-caret-up" aria-hidden="true"></i>
				  <%= NumberFormat.getNumberInstance().format(cf.getPh()) %>
				 </td>
				<% } else { %>
				 <td class="res-pos-i"><%= NumberFormat.getNumberInstance().format(cf.getPh()) %></td>
				<% } %>

				<% if(dif[1] > 0) { %>
				 <td class="res-pos-i" align="left">
	              <i class="fa fa-caret-up" aria-hidden="true"></i>
	              <%= NumberFormat.getNumberInstance().format(dif[1]) %></td>
              <% } else if(dif[1] < 0) { %>
               <td class="res-neg-i">
                <i class="fa fa-caret-down" aria-hidden="true"></i>
                <%= NumberFormat.getNumberInstance().format(dif[1]*(-1)) %></td>
              <% } else { %>
               <td class="res-med-i">
                <%= NumberFormat.getNumberInstance().format(dif[1]) %></td>
              <% } %>
              </tr>
              <% } } } %>
             </tbody>
            </table>
           </div>
          <% } %>
          </div>
          <div class="card-footer">
          <% if(setor != null) { %>
	  	   	<a href="SelCliente?id=<%= uLogado.getCliente().getId() %>&op=eqs&sid=<%= setor.getId() %>" class="link-box" >
	  	   		<i class="fa fa-table" aria-hidden="true"></i> Tabela de equipamentos
			</a>
	  	  <% } else { %>
	  	  	<a href="SelCliente?id=<%= uLogado.getCliente().getId() %>&op=eqs" class="link-box" >
	  	  		<i class="fa fa-table" aria-hidden="true"></i> Tabela de equipamentos
			</a>
	  	  <% } %>
	  	   </div>
		</div>

  	  </div>

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

    <!-- Gerar relatório por data -->

   <div id="reldata" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Gerar relatório por data</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>
      <% if(setor == null) { %>
      <form method="post" action="RelatorioEquipamentosPorData">
      <div class="modal-body">
        <input type="hidden" name="cliente" id="cliente" value=<%= uLogado.getCliente().getId() %>>
        <div class="form-group">
        <label class="control-label col-sm-11" for="data">Escolha a data: </label>
        <div class="col-sm-12">
         <input type="date" class="form-control" name="data" id="data" />
        </div>
       </div>
      </div>
	  <div class="modal-footer">
		<div class="col-sm-12" align="center">
	    <button type="submit" class="btn btn-success" >
		 gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i></button>
	  </div>
      </div>
      </form>
      <% } else { %>
      <form method="post" action="RelatorioEquipamentosPorDataSetor">
      <div class="modal-body">
        <input type="hidden" name="setor" id="setor" value=<%= setor.getId() %>>
        <div class="form-group">
        <label class="control-label col-sm-11" for="data">Escolha a data: </label>
        <div class="col-sm-12">
         <input type="date" class="form-control" name="data" id="data" />
        </div>
       </div>
      </div>
	  <div class="modal-footer">
		<div class="col-sm-12" align="center">
	    <button type="submit" class="btn btn-success" >
		 gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i></button>
	  </div>
      </div>
      </form>
      <% } %>
    </div>
    </div>
   </div>

   <!-- Gerar relatório por periodo -->

   <div id="relper" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
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
           <% for(Equipamento e: equipamentos){ %>
            <option value=<%= e.getId() %>><%= e.getTag() %></option>
           <% } %>
          </select>
         </div>
        </div>
        <div class="form-group">
        <label class="control-label col-sm-11" for="datain">Data inicial: </label>
        <div class="col-sm-12">
         <input type="date" class="form-control" name="datain" id="datain" />
        </div>
       </div>
       <div class="form-group">
        <label class="control-label col-sm-11" for="datafi">Data final: </label>
        <div class="col-sm-12">
         <input type="date" class="form-control" name="datafi" id="datafi" />
        </div>
       </div>
      </div>
	  <div class="modal-footer">
		<div class="col-sm-12" align="center">
	    <button type="submit" class="btn btn-success" >
		 gerar relatório <i class="fa fa-file-text-o" aria-hidden="true"></i></button>
	  </div>
      </div>
      </form>
    </div>
    </div>
   </div>

    <div id="updusu" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade" ng-controller="controllerName">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Editar Usuário</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>
     <form class="form-horizontal" name="form" method="post" action="UpdateUsuarioCliente">
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
     <form class="form-horizontal" name="form" method="post" action="UpdateSenhaCliente">
     <div class="modal-body">
      <div class="panel-body">
       <input type="hidden" name="usuario" id="usuario" value=<%= uLogado.getId() %>>
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
