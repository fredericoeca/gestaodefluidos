<%@page import="com.gf.model.controller.SetorController"%>
<%@page import="com.gf.model.entity.Setor"%>
<%@page import="com.gf.model.controller.TipoProdutoController"%>
<%@page import="com.gf.model.entity.TipoProduto"%>
<%@page import="com.gf.model.controller.ProdutoController"%>
<%@page import="com.gf.model.entity.Produto"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.gf.model.controller.EquipamentoController"%>
<%@page import="com.gf.model.entity.Equipamento"%>
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
 	ArrayList<TipoProduto> tipos = TipoProdutoController.getTiposProduto();
   	String cod = request.getParameter("c");
   	
	String sid = request.getParameter("sid");
   	
   	ArrayList<Equipamento> equipamentos = new ArrayList<Equipamento>();
  %>
  <body ng-app="app">
   <% if(uLogado == null) { %>
	<h6>Você não tem acesso ao sistema <a href="index.jsp" style="color: #269abc">faça seu login.</a></h6>
   <% } else if(uLogado.getPerfil() == 1 || uLogado.getPerfil() == 2) { 
   
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
        <a class="nav-link dropdown-toggle" href="" id="dropdown03" 
         data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Clientes</a>
         <div class="dropdown-menu" aria-labelledby="dropdown03">
         <a class="dropdown-item" href="ins_cliente.jsp">Inserir</a>
         <a class="dropdown-item" href="clientes.jsp">Clientes</a>
         </div>
       </li>
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="" id="dropdown03" 
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
        <a class="nav-link dropdown-toggle" href="" id="dropdown03" 
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
        <a class="nav-link dropdown-toggle" href="" id="dropdown03" 
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
     <h5>Equpamentos do <%= cliente.getNome() %> </h5>
     <hr />
     
    <div class="alerta">
	 <%if(cod!=null){ %>
 		<%if(cod!=null){ %>
		<% } if(cod.equals("1")){ %>
			<div class="alert alert-success" role="alert" >
				<strong>Equipamento</strong> apagado com sucesso.
				<i class="fa fa-check" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>
		<% } else if(cod.equals("2")){ %>
			<div class="alert alert-danger" role="alert" >
				<strong>Erro </strong> ao apagar equipamento no banco de dados.
				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>
		<% } else if(cod.equals("3")){ %>
			<div class="alert alert-danger" role="alert" >
				<strong>Erro inesperado</strong> ao apagar equipamento.
				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>
		<% } else if(cod.equals("4")){ %>
			<div class="alert alert-success" role="alert" >
				<strong>Equipamento</strong> atualizado com sucesso.
				<i class="fa fa-check" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>
		<% } else if(cod.equals("5")){ %>
			<div class="alert alert-danger" role="alert" >
				<strong>Erro </strong> ao atualizar equipamento no banco de dados.
				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>
		<% } else if(cod.equals("6")){ %>
			<div class="alert alert-danger" role="alert" >
				<strong>Erro inesperado</strong> ao atualizar equipamento.
				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>  
		<% } else if(cod.equals("7")){ %>
			<div class="alert alert-danger" role="alert" >
				<strong>Erro </strong> ao inserir controle no banco de dados.
				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>
		<% } else if(cod.equals("8")){ %>
			<div class="alert alert-danger" role="alert" >
				<strong>Erro </strong> ao selecionar opção do controle.
				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>
		<% } else if(cod.equals("9")){ %>
			<div class="alert alert-danger" role="alert" >
				<strong>Erro </strong> genérico ao inserir o controle.
				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>
		<% } else if(cod.equals("10")){ %>
			<div class="alert alert-success" role="alert" >
				<strong>Controle </strong> criado com sucesso.
				<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamentos.jsp" class="close">&times;</a>
			</div>			                                            
      <% }} %>
	 </div>   
	 
	 <div class="container-fluid">
     
      <div class="row">
	   	<div class="col-sm-4" style="padding-left: 0">
	   	<form class="form-horizontal" method="post" action="equipamentos.jsp">
	       <div class="form-group" style="margin-bottom: 0">
	        <div class="col-sm-12">
	        <% if(sid != null) { %>
	        	<input type="hidden" class="form-control" name="sid" id="sid" value=<%= sid %> required /> 
	        <% } %>
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
	   		<a href="equipamentos.jsp" class="link-box" title="recarregar tabela"><i class="fa fa-refresh" aria-hidden="true"></i></a>
	   	</div>
	   	<div class="col-sm-7">
	   	<% if(!setores.isEmpty()) { %>
	   	<div class="col-sm-6">
        <select class="form-control" name="setor" id="selecao">
         <option value="">Selecione o Setor</option>
         <!-- Popula lista de representantes no select -->
         <% for(Setor s: setores){ %>         	
          	<option value="equipamentos.jsp?sid=<%= s.getId() %>"><%= s.getSetor() %></option>                      
         <% } %>
        </select>
        </div>
	   	<% } %>
	   	</div>
	   </div>	   
	   
	   <script>
		$('#selecao').change(function() {
		    window.location = $(this).val();
		});
       </script>     
	   
      <div class="row">
      <%      	
      	String busca = request.getParameter("busca");
      
      	if(sid == null) {
    		if(busca == null){
    			equipamentos = EquipamentoController.getEquipamentosPorCliente(cliente.getId());
    		} else {
    			equipamentos = EquipamentoController.searchEquipamentos(busca, cliente.getId());
    		}	
      	} else {
      		if(busca == null){
      			equipamentos = EquipamentoController.getEquipamentosPorSetor(Integer.parseInt(sid));
    		} else {
    			equipamentos = EquipamentoController.searchEquipamentosSetor(busca, Integer.parseInt(sid));
    		}	      		
      	}
      %>
      
	   <div class="col-sm-12">
 	    <div class="card card-success det-cli">
 	     <div class="card-header det-cli-h">Equipamentos <% if(sid != null){ %>
 	     			- <%= SetorController.getSetor(Integer.parseInt(sid)).getSetor() %>
 	     			<% } %>
					<i class="fa fa-cogs" aria-hidden="true"></i>
 		  <% if(uLogado.getPerfil() != 3) { %>
 		  <div style="float: right">
           <a href="SelCliente?id=<%= cliente.getId() %>&op=equ" class="link-box" >
		    <i class="fa fa-plus" aria-hidden="true"></i> adicionar
		   </a>
          </div>
          <% } %>
         </div>
         <div class="card-block" style="max-height: 220px; overflow: auto;">
        
         <%
			if (equipamentos.isEmpty()) {
				if(busca != null) {
				 %>		 
				 	<p>Sua pesquisa "<%=busca%>" não encontrou nenhum registro.</p>
				 <% 	} else { %>	
				 	<p>Não há equipamentos registrados</p>
			     <% }} else {
		%>	
		
		<div class="table-responsive tab">
           <table class="table table-striped tab-tab_1">
            <thead class="thead-tab-usu">             
             <th>TAG</th>
             <% if(sid == null){ %>
             <th>Setor</th>
             <% } %>
             <th>Tipo</th> 
             <th>Modelo</th>
             <th>Fabricante</th>
             <th>Ponto</th>
             <th>Produto</th>
             <th>Cap(Lts)</th>
             <th>CMin</th>
             <th>CMax</th>
             <th>PhMin</th>             
             <th>PhMax</th>
             <% if(uLogado.getPerfil() != 3) { %>
             <th></th>
             <th></th>
             <th></th>
             <th></th>
             <% } %>
            </thead>
            <tbody class="tbody-tab-usu">
            <% for(Equipamento e: equipamentos) { %>                    
             <tr>
          	  <td><a id="link" href="SelEquipamento?id=<%= e.getId() %>&op=det&sid=<%= sid %>"><b><%= e.getTag() %></b></a></td>
          	  <% if(sid == null){ %>
          	  <td><%= e.getSetor() %></td>
          	  <% } %>
              <td><%= e.getTipo() %></td>
              <td><%= e.getModelo() %></td>
              <td><%= e.getFabricante() %></td>				                            
              <td><%= e.getPontoLubrificacao() %></td>
              <td><%= e.getProduto().getProduto() %></td>
              <td><%= NumberFormat.getNumberInstance().format(e.getVolume()) %></td>
              <td><%= NumberFormat.getNumberInstance().format(e.getConsentracaoMin()) %>%</td>
              <td><%= NumberFormat.getNumberInstance().format(e.getConsentracaoMax()) %>%</td>
              <td><%= NumberFormat.getNumberInstance().format(e.getLimiteMinPh()) %>%</td>
           	  <td><%= NumberFormat.getNumberInstance().format(e.getLimiteMaxPh()) %>%</td>
                   	  
           	  <% if(uLogado.getPerfil() != 3) { %>
           	  
           	  <td><a href="#" class="link-box" data-toggle="modal" data-target="#insCon"
	      			onclick="setInsCon('<%= e.getTag() %>','<%= e.getId() %>','<%= sid %>')"
	      			title="Inserir controle de fluido no equipamentos">
	      			<i class="fa fa-plus-square"></i></a></td>
         
           	  <td><a href="#" class="link-box" data-toggle="modal" data-target="#dupequ"
	      			onclick="setDupEqu('<%= e.getCliente().getId() %>','<%= e.getTipo() %>','<%= e.getFabricante() %>','<%= e.getModelo() %>',
	      			'<%= e.getPontoLubrificacao() %>','<%= e.getVolume() %>','<%= e.getConsentracaoMin() %>',
	      			'<%= e.getConsentracaoMax() %>','<%= e.getLimiteMinPh() %>','<%= e.getLimiteMaxPh() %>')"
	      			title="Duplicar registro de equipamento">
              	  <i class="fa fa-clone"></i></a></td>
              
              <td><a href="#" class="link-box" data-toggle="modal" data-target="#updequ"
	      			onclick="setUpdEqu('<%= e.getId() %>','<%= e.getTipo() %>','<%= e.getFabricante() %>','<%= e.getTag() %>',
	      			'<%= e.getModelo() %>','<%= e.getSetor() %>','<%= e.getPontoLubrificacao() %>','<%= e.getVolume() %>',
	      			'<%= e.getConsentracaoMin() %>','<%= e.getConsentracaoMax() %>','<%= e.getLimiteMinPh() %>',
	      			'<%= e.getLimiteMaxPh() %>','<%= e.getCliente().getId() %>')"
	      			title="Editar dados do equipamento">
              	  <i class="fa fa-pencil-square-o" aria-hidden="true"></i></a></td>
              	  
              <td><a href="#" class="link-box" data-toggle="modal" data-target="#delequ"
	      			onclick="setDelEqu('<%= e.getTag() %>','<%= e.getId() %>')"
	      			title="Apagar equipamento">
                  <i class="fa fa-trash-o" aria-hidden="true"></i></a></td>
                  
             <% } %>
             </tr>                   
            <% } %>
           </tbody>
          </table>
         </div>
        <% } %>
	    </div>
	  	<div class="card-footer">
	  	 <div class="row">
	  	 
	  	 	<div class="col-sm-2">	  	   
			<a href="#" class="legenda btn btn-success" onClick="history.go(-1)"  style="font-size: 14px"> 
				<i class="fa fa-backward" aria-hidden="true"></i> voltar </a> 
			</div>	
			<div class="col-sm-10" align="right"><b><%= equipamentos.size() %> </b> 
			<% if(equipamentos.size() != 1) %> equipamentos registrados.<% else %> equipamento registrado. 
			
			</div>
		 
	  	 </div>	  	 
	  	 <hr />
	  	  <p class="legenda" align="justify"><b>Tipo:</b> Tipo de Equipamento; <b>TAG:</b> Identificador do equipamento; <b>Ponto:</b> Ponto de Lubrificação; 
	  	  <b>Cap:</b> Capacidade do reservatório; <b>CMax:</b> Concentração máxima; <b>CMin:</b> Concentração mínima; 
	  	  <b>PhMax:</b> Ph máximo; <b>PhMin:</b> Ph mínimo; <b><i class="fa fa-plus-square"></i></b> Adicionar controle de fluido do equipamento;
	  	  <b><i class="fa fa-clone"></i></b> Duplicar registro do equipamento; <b><i class="fa fa-pencil-square-o" aria-hidden="true"></i></b>
	  	  Editar dados do equipamento; <b><i class="fa fa-trash-o" aria-hidden="true"></i></b> Apagar equipamento.</p> 
	  	  
	  	</div>
	   </div>
	  </div>
     </div>
  
     </div>     
  	</div>
  
  <script>
  
	function setInsCon(val41, val42, val43) {		    
 	 document.getElementById('val41').value = val41;
 	 document.getElementById('val42').value = val42;
 	 document.getElementById('val43').value = val43;
 	} 
  
  	function setDelEqu(val17, val18) {		    
 	 document.getElementById('equ_tag').value = val17;
 	 document.getElementById('id_equ').value = val18;
 	}
 	 	
 	function setUpdEqu(val19, val20, val21, val22, val23, val24, val25, val26, val27, val28, val29, val30, val44) {		    
 	 document.getElementById('val19').value = val19;
 	 document.getElementById('val20').value = val20;
 	 document.getElementById('val21').value = val21;
 	 document.getElementById('val22').value = val22;
 	 document.getElementById('val23').value = val23;
 	 document.getElementById('val24').value = val24;
 	 document.getElementById('val25').value = val25;
 	 document.getElementById('val26').value = val26;
 	 document.getElementById('val27').value = val27;
 	 document.getElementById('val28').value = val28;
 	 document.getElementById('val29').value = val29;
 	 document.getElementById('val30').value = val30;
 	 document.getElementById('val44').value = val44;
 	}
 	
 	function setDupEqu(val31, val32, val33, val34, val35, val36, val37, val38, val39, val40) {		    
 	 document.getElementById('cliente').value = val31;
 	 document.getElementById('tipo').value = val32;
 	 document.getElementById('fabricante').value = val33;
 	 document.getElementById('modelo').value = val34;
 	 document.getElementById('ponto').value = val35;
 	 document.getElementById('volume').value = val36;
 	 document.getElementById('conmin').value = val37;
 	 document.getElementById('conmax').value = val38;
 	 document.getElementById('phmin').value = val39;
 	 document.getElementById('phmax').value = val40;
 	}
    </script>
  
  <hr />
  <div class="footer">
   <p class="rodape"> &copy; 2017 Sistema de Gestão de Fluidos de Processo - All Lubrificantes.</p>
  </div>
  
  <!-- Inserir controle no Equipamentos --> 
    
  <div id="insCon" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Inserir controle de fluido no <output type="text" name="val41" id="val41"></output></h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>
     
          <!-- Formulário de cadastro de Controles -->
     <form class="form-horizontal col-sm-12" method="post" action="InsertControleForEquip">
	  <div class="modal-body">
       <div class="panel-body">
       
       <input type="hidden" name="val42" id="val42" />
       <input type="hidden" name="val43" id="val43" />
	  
     <div class="form-group col-sm-12">
   	  <label class="control-label col-sm-12" for="data">Data: </label>
      <div class="col-sm-11">
       <input type="date" class="form-control" name="data" id="data" required/>
      </div>
     </div>
     
     <div class="form-group col-sm-12">	
      <label class="control-label col-sm-12" for="concentracao">Concentração</label>
      <div class="col-sm-11">
       <input type="number" step="0.01" class="form-control" name="concentracao" id="concentracao" 
        placeholder="Concentração aferida" />
      </div>
     </div>
     
     <div class="form-group col-sm-12">
   	  <label class="control-label col-sm-12" for="ph">Ph: </label>
      <div class="col-sm-11">
       <input type="number" step="0.01"  class="form-control" name="ph" id="ph" placeholder="Ph aferido" />
      </div>
     </div>
     
     <div class="form-group col-sm-12">
      <label class="control-label col-sm-11" for="cont_visual">Contaminação Visual: </label>
      <div class="row">
      <div class="col-sm-3">
      <div class="custom-control custom-radio">	                	
       <input type="radio" name="cont_visual" id="cont_visual2" value="Não" class="custom-control-input">
        <label class="custom-control-label" for="cont_visual2">Não</label>
      </div></div>
      <div class="col-sm-3">
	  <div class="custom-control custom-radio">	
        <input type="radio" name="cont_visual" id="cont_visual1" value="Sim" class="custom-control-input">
        <label class="custom-control-label" for="cont_visual1">Sim</label>	
	   </div></div>
     </div></div>
     
     <div class="form-group col-sm-12">
      <label class="control-label col-sm-12" for="nivel">Nível do Reservatório: </label>
      <div class="row">
      <div class="col-sm-4">
      <div class="custom-control custom-radio">
        <input type="radio" name="nivel" id="nivel1" value="Mínimo" class="custom-control-input">
    	<label class="custom-control-label" for="nivel1">Mínimo</label>
       </div></div>
       <div class="col-sm-4"> 
       <div class="custom-control custom-radio">
        <input type="radio" name="nivel" id="nivel2" value="Médio" class="custom-control-input">
    	<label class="custom-control-label" for="nivel2">Médio</label>
       </div></div>
       <div class="col-sm-4">	 
       <div class="custom-control custom-radio">
        <input type="radio" name="nivel" id="nivel3" value="Máximo" class="custom-control-input">
    	<label class="custom-control-label" for="nivel3">Máximo</label>
       </div></div>
      </div></div>
     
     <div class="form-group col-sm-12">
      <label class="control-label col-sm-11" for="skimmer">Skimmer: </label>
      <div class="row">
      <div class="col-sm-3">
      <div class="custom-control custom-radio">	                	
    	<input type="radio" name="skimmer" id="skimmer1" value="On" class="custom-control-input">
    	<label class="custom-control-label" for="skimmer1">On</label>
      </div></div>
      <div class="col-sm-3">
      <div class="custom-control custom-radio">
       <input type="radio" name="skimmer" id="skimmer2" value="Off" class="custom-control-input">
       <label class="custom-control-label" for="skimmer2">Off</label>	
      </div></div>
      </div>             
     </div>
     
     </div>
     </div>
     
     <div class="modal-footer">
      <div class="col-sm-12" align="center">
     
     <div class="row">       
       <div class="col-sm-12" style="width: 100%; margin-bottom: 20px">
        <button type="submit" class="btn btn-success btn-block" style="border-left-color: #EE4000; border-left-width: 8px;">
         salvar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
       </div>
      </div>
       
	  
      </div>      
    </div>
     
    </form>
    </div>      
    </div>
   </div>
  
    
   <!-- Editar e Apagar Equipamentos --> 
    
  <div id="delequ" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Apagar Equipamento</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>	
     <div class="modal-body">
      <div class="panel-body">
       Tem certeza que deseja apagar o equipamento?<br />  
       <output type="text" name="equ_tag" id="equ_tag"></output>
      </div> 
     </div>
     <div class="modal-footer">
      <div class="col-sm-6" align="center">
       <form method="post" action="DeleteEquipamento">
        <input type="hidden" name="id_equ" id="id_equ">           
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
   
   <div id="updequ" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade" ng-controller="controllerName">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Editar Equipamento</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>	
     <form class="form-horizontal" name="form" method="post" action="UpdateEquipamento">
     <div class="modal-body">
      <div class="panel-body">
       <input type="hidden" name="val19" id="val19">
       <input type="hidden" name="val44" id="val44">
       <div class="form-group">
       	<label class="control-label col-sm-11" for="tipo">Tipo: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val20" id="val20" placeholder="Insira o tipo de equipamento" />
        </div>
       </div>
       <div class="form-group">	
        <label class="control-label col-sm-11" for="fabricante">Fabricante:</label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val21" id="val21" placeholder="Insira o fabricante do equipamento" />
        </div>
       </div>
       <div class="form-group">
       	<label class="control-label col-sm-11" for="tag">TAG: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val22" ng-model="tag" id="val22" placeholder="Inserir o TAG do equipamento" required/>
        </div>
       </div>
       <div class="form-group">
       	<label class="control-label col-sm-11" for="modelo">Modelo: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val23" ng-model="modelo" id="val23" placeholder="Inserir o modelo do equipamento" required/>
        </div>
       </div>
       <div class="form-group">
        <label class="control-label col-sm-11" for="setor">Setor: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val24" id="val24" placeholder="Insira o setor do equipamento" />
        </div>
       </div>
       <div class="form-group">
        <label class="control-label col-sm-11" for="ponto">Ponto de Lubrificação: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="val25" id="val25" placeholder="Insira o ponto de lubrificação" />
        </div>
       </div>
       <div class="form-group">
       <div class="alert alert-info" role="alert">
  		 <small>Para alterar do <strong>produto utilizado</strong> basta seleciona-lo na caixa abaixo. Não selecionando um novo produto, o atual será mantido.</small>
	   </div>
        <label class="control-label col-sm-11" for="produto">Produto: </label>
        <div class="col-sm-12">
         <select class="form-control" name="produto" ng-model="produto">
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
       <div class="form-group">
        <label class="control-label col-sm-11" for="volume">Capacidade: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="val26" id="val26" placeholder="Insira capacidade do reservatório" />
        </div>
       </div>
       <div class="form-group">
       	<label class="control-label col-sm-11" for="conmin">Concentração Mínima: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="val27" id="val27" placeholder="Concentração mínima" ng-model="conMin" />
        </div>
       </div>
       <div class="form-group">
       	<label class="control-label col-sm-11" for="conmax">Concentração Máxima: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="val28" id="val28" placeholder="Concentração máxima" ng-model="conMax" />
        </div>
        <span style="color:red" ng-show="conMin >= conMax">
         A concentração máxima deve ser maior que a concentração mínima!		
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>		
		</span>
       </div>            
       <div class="form-group">
        <label class="control-label col-sm-11" for="phmin">Ph Mínimo: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="val29" ng-model="phMin" id="val29" placeholder="Limite mínimo Ph" />
        </div>                
       </div>
       <div class="form-group">
        <label class="control-label col-sm-11" for="phmax">Ph Máximo: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="val30" ng-model="phMax" id="val30" placeholder="Limite máximo Ph" />
        </div>
        <span style="color:red" ng-show="phMin >= phMax">        	
         O limite máximo do Ph deve ser maior que o limite mínimo do Ph!	
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>			
		</span>
       </div>
       </div>
       </div>
     <div class="modal-footer">
      <div class="col-sm-12" align="center">                
	    <button type="submit" class="btn btn-success">
		 salvar <i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
	  </div>
      </div>
     </form>    
    </div>
    </div>
   </div>
   
   <div id="dupequ" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade" ng-controller="controllerName">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Duplicar Registro do Equipamento</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>	
     <form class="form-horizontal" name="form" method="post" action="InsertEquipamento">
     <div class="modal-body">
      <div class="panel-body">  
      <div class="alert alert-warning" role="alert">
      	* Campos de preenchimento obrigatório<br />
      	- TAG<br />
      	- Setor<br />
      	- Produto
      	
      </div>     
       <input type="hidden" name="cliente" id="cliente">
       <div class="form-group">
       	<label class="control-label col-sm-11" for="tipo">Tipo: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="tipo" id="tipo" placeholder="Insira o tipo de equipamento" />
        </div>
       </div>
       <div class="form-group">	
        <label class="control-label col-sm-11" for="fabricante">Fabricante:</label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="fabricante" id="fabricante" placeholder="Insira o fabricante do equipamento" />
        </div>
       </div>
       <div class="form-group">
       	<label class="control-label col-sm-11" for="tag">TAG: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="tag" ng-model="tag" id="tag" placeholder="Inserir o TAG do equipamento" required/>
        </div>
       </div>
       <div class="form-group">
       	<label class="control-label col-sm-11" for="modelo">Modelo: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="modelo" ng-model="modelo" id="modelo" placeholder="Inserir o modelo do equipamento" required/>
        </div>
       </div>
       <% if(!setores.isEmpty()) { %>
       	<div class="form-group">	
        <label class="control-label col-sm-11" for="id_setor">Setor:</label>
        <div class="col-sm-12">
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
       <div class="form-group">
        <label class="control-label col-sm-11" for="setor">Setor: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="setor" id="setor" placeholder="Insira o setor do equipamento" required />
        </div>
       </div>
       <% } %>
       <div class="form-group">
        <label class="control-label col-sm-11" for="ponto">Ponto de Lubrificação: </label>
        <div class="col-sm-12">
         <input type="text" class="form-control" name="ponto" id="ponto" placeholder="Insira o ponto de lubrificação" />
        </div>
       </div>
       <div class="form-group">
        <label class="control-label col-sm-11" for="produto">Produto: </label>
        <div class="col-sm-12">
         <select class="form-control" name="produto" ng-model="produto" required>
          <option value="">Selecione o produto</option>
          <% 
          	produtos = null;
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
       <div class="form-group">
        <label class="control-label col-sm-11" for="volume">Capacidade: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="volume" id="volume" placeholder="Insira capacidade do reservatório" />
        </div>
       </div>
       <div class="form-group">
       	<label class="control-label col-sm-11" for="conmin">Concentração Mínima: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="conmin" id="conmin" placeholder="Concentração mínima" ng-model="conMin" />
        </div>
       </div>
       <div class="form-group">
       	<label class="control-label col-sm-11" for="conmax">Concentração Máxima: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="conmax" id="conmax" placeholder="Concentração máxima" ng-model="conMax" />
        </div>
        <span style="color:red" ng-show="conMin >= conMax">
         A concentração máxima deve ser maior que a concentração mínima!		
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>		
		</span>
       </div>            
       <div class="form-group">
        <label class="control-label col-sm-11" for="phmin">Ph Mínimo: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="phmin" ng-model="phMin" id="phmin" placeholder="Limite mínimo Ph" />
        </div>                
       </div>
       <div class="form-group">
        <label class="control-label col-sm-11" for="phmax">Ph Máximo: </label>
        <div class="col-sm-12">
         <input type="number" step="0.01" class="form-control" name="phmax" ng-model="phMax" id="phmax" placeholder="Limite máximo Ph" />
        </div>
        <span style="color:red" ng-show="phMin >= phMax">        	
         O limite máximo do Ph deve ser maior que o limite mínimo do Ph!	
         <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>			
		</span>
       </div>
       </div>
       </div>
     <div class="modal-footer">
      <div class="col-sm-12" align="center">                
	    <button type="submit" class="btn btn-success">
		 salvar <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
	  </div>
      </div>
     </form>    
    </div>
    </div>
   </div>
  
   <!-- Gerar relatório por data --> 
     
   <div id="reldata" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
    <div class="modal-dialog modal-md">
    <div class="modal-content col-sm-10">
     <div class="modal-header">
	  <h5 class="modal-title">Gerar relatório por data</h5>
	  <button type="button" class="close" data-dismiss="modal">&times;</button>
     </div>     
      <form method="post" action="RelatorioEquipamentosPorData">
      <div class="modal-body">
        <input type="hidden" name="cliente" id="cliente" value=<%= cliente.getId() %>>        
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
          data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Olá <%= uLogado.getNome() %>    </a>
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
    
    <div class="col-sm-12 col-md-12 pt-3" role="main">
     <h5>Equpamentos do <%= cliente.getNome() %> <i class="fa fa-user-o" aria-hidden="true"></i></h5>
     <hr />

	 <div class="container-fluid">

      <div class="row">
	   	<div class="col-sm-4" style="padding-left: 0">
	   	<form class="form-horizontal" method="post" action="equipamentos.jsp">
	       <div class="form-group" style="margin-bottom: 0">
	        <div class="col-sm-12">
	        <% if(sid != null) { %>
	        	<input type="hidden" class="form-control" name="sid" id="sid" value=<%= sid %> required /> 
	        <% } %>
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
	   		<a href="equipamentos.jsp" class="link-box" title="recarregar tabela"><i class="fa fa-refresh" aria-hidden="true"></i></a>
	   	</div>

	   	<div class="col-sm-7"></div>

	   </div>	   	      
	   
      <div class="row">
      <%
      	
      	String busca = request.getParameter("busca");
      	
  		if(busca == null){
  			equipamentos = (ArrayList<Equipamento>) session.getAttribute("equips");	
  		} else {
  			equipamentos = EquipamentoController.searchEquipamentos(busca, cliente.getId());
  		}	
      %>
      
	   <div class="col-sm-12">
 	    <div class="card card-success det-cli">
 	     <div class="card-header det-cli-h">Equipamentos <i class="fa fa-cogs" aria-hidden="true"></i>
 		  <% if(uLogado.getPerfil() != 3) { %>
 		  <div style="float: right">
           <a href="SelCliente?id=<%= cliente.getId() %>&op=equ" class="link-box" >
		    <i class="fa fa-plus" aria-hidden="true"></i> adicionar
		   </a>
          </div>
          <% } %>
         </div>
         <div class="card-block" style="max-height: 220px; overflow: auto;">
        
         <%
			if (equipamentos.isEmpty()) {
				if(busca != null) {
				 %>		 
				 	<p>Sua pesquisa "<%=busca%>" não encontrou nenhum registro.</p>
				 <% 	} else { %>	
				 	<p>Não há equipamentos registrados</p>
			     <% }} else {
		%>	
		
		<div class="table-responsive tab">
           <table class="table table-striped tab-tab_1">
            <thead class="thead-tab-usu">             
             <th>TAG</th>
             <th>Setor</th>
             <th>Tipo</th> 
             <th>Modelo</th>
             <th>Fabricante</th>
             <th>Ponto</th>
             <th>Produto</th>
             <th>Cap(Lts)</th>
             <th>CMin(%)</th>
             <th>CMax(%)</th>
             <th>PhMin(%)</th>             
             <th>PhMax(%)</th>
             <% if(uLogado.getPerfil() != 3) { %>
             <th>Editar</th>
             <th>Apagar</th>
             <% } %>
            </thead>
            <tbody class="tbody-tab-usu">
            <% for(Equipamento e: equipamentos) { %>                    
             <tr>
          	  <td><a id="link" href="SelEquipamento?id=<%= e.getId() %>&op=det"><b><%= e.getTag() %></b></a></td>
          	  <td><%= e.getSetor() %></td>
              <td><%= e.getTipo() %></td>
              <td><%= e.getModelo() %></td>
              <td><%= e.getFabricante() %></td>				                            
              <td><%= e.getPontoLubrificacao() %></td>
              <td><%= e.getProduto().getProduto() %></td>
              <td><%= NumberFormat.getNumberInstance().format(e.getVolume()) %></td>
              <td><%= NumberFormat.getNumberInstance().format(e.getConsentracaoMin()) %></td>
              <td><%= NumberFormat.getNumberInstance().format(e.getConsentracaoMax()) %></td>
              <td><%= NumberFormat.getNumberInstance().format(e.getLimiteMinPh()) %></td>
           	  <td><%= NumberFormat.getNumberInstance().format(e.getLimiteMaxPh()) %></td>
           	            	  
             </tr>                   
            <% } %>
           </tbody>
          </table>
         </div>
        <% } %>
	    </div>
	  	<div class="card-footer">
	  	 <div class="row">
	  	   <a href="#" class="legenda btn btn-success right" onClick="history.go(-1)"  style="font-size: 14px"> 
				<i class="fa fa-backward" aria-hidden="true"></i> voltar </a>
		 </div>	  	 
	  	 <hr />
	  	  <p class="legenda" align="justify"><b>Tipo:</b> Tipo de Equipamento; <b>TAG:</b> Identificador do equipamento; <b>Ponto:</b> Ponto de Lubrificação; 
	  	  <b>Cap:</b> Capacidade do reservatório; <b>CMax:</b> Concentração máxima; <b>CMin:</b> Concentração mínima; 
	  	  <b>PhMax:</b> Ph máximo; <b>PhMin:</b> Ph mínimo; <b>Controle: </b> Adicionar controle de fluido.</p>
	  	</div>
	   </div>
	  </div>
     </div>
  
     </div>     
  	</div>
     
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
     <form method="post" action="RelatorioEquipamentosPorData">
      <div class="modal-body">
        <input type="hidden" name="cliente" id="cliente" value=<%= cliente.getId() %>>        
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