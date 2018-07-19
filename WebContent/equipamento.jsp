<%@page import="com.gf.model.controller.AlteracaoParametroController"%>
<%@page import="com.gf.model.entity.AlteracaoParametro"%>
<%@page import="com.gf.model.controller.TipoProdutoController"%>
<%@page import="com.gf.model.entity.TipoProduto"%>
<%@page import="com.gf.model.entity.CorrecaoFluido"%>
<%@page import="com.gf.model.controller.CorrecaoFluidoController"%>
<%@page import="com.gf.model.controller.ProdutoController"%>
<%@page import="com.gf.model.entity.Produto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.gf.model.controller.ControleFluidoController"%>
<%@page import="com.gf.model.entity.ControleFluido"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.gf.model.entity.Equipamento"%>
<%@page import="com.gf.model.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
   Equipamento equipamento = (Equipamento) session.getAttribute("equipamento");
   SimpleDateFormat frmtData = new SimpleDateFormat("dd/MM/yyyy");
   //ArrayList<Produto> produtos = ProdutoController.getProdutos();
   ArrayList<TipoProduto> tipos = TipoProdutoController.getTiposProduto();
   String cod = request.getParameter("c");
   String controle = request.getParameter("controle");
  %>
<body>
	<% if(uLogado == null) { %>
	<h6>
		Você não tem acesso ao sistema <a href="index.jsp"
			style="color: #269abc">faça seu login.</a>
	</h6>

	<!-- Pagina inicial do Administrado e Representante -->
  	<% } else if(uLogado.getPerfil() == 1 || uLogado.getPerfil() == 2) {
  		 String setor = session.getAttribute("setor").toString();
   		ArrayList<ControleFluido> controles = new ArrayList<ControleFluido>();
   		ArrayList<CorrecaoFluido> correcoes = new ArrayList<CorrecaoFluido>();
  	%>

	<nav class="navbar navbar-expand-sm navbar-dark fixed-top bg-dark">
		<a class="navbar-brand" href="home.jsp"><img
			src="img/favicon.png" width="25" height="25" />Gestão de Fluidos de Processo</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarsExample03" aria-controls="navbarsExample03"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarsExample03">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="http://example.com"
					id="dropdown03" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">Clientes</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="ins_cliente.jsp">Inserir</a> <a
							class="dropdown-item" href="clientes.jsp">Clientes</a>
					</div></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="http://example.com"
					id="dropdown03" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">Produtos</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<% if(uLogado.getPerfil() == 1 ) { %>
					      <a class="dropdown-item" href="ins_produto.jsp">Inserir</a>
					    <% } %>
						<a class="dropdown-item" href="produtos.jsp">Produtos</a>
					</div></li>
				<% if(uLogado.getPerfil() == 1) { %>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="http://example.com"
					id="dropdown03" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">Usuários</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="ins_usuario.jsp">Novo</a> <a
							class="dropdown-item" href="usuarios.jsp">Usuários</a> <a
							class="dropdown-item" href="log_acesso.jsp">Logs de Acesso</a>
					</div></li>
				<% } %>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="http://example.com"
					id="dropdown03" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">Ajuda</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="#" data-toggle="modal"
							data-target="#sobre">Sobre</a>
						<% if(uLogado.getPerfil() != 3) { %>
						<a class="dropdown-item" href="docs/manual.pdf">Manual de Instruções</a>
						<% } %>
						<% if(uLogado.getPerfil() == 1) { %>
						<a class="dropdown-item" href="docs/control_version.pdf">Controle de Versões</a>
						<% } %>
					</div></li>
			</ul>
			<ul class="navbar-nav right">
				<li class="nav-item dropdown active"><a
					class="nav-link dropdown-toggle" href="#" id="dropdown03"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Olá
						<%= uLogado.getNome() %>
				</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="usuario.jsp">Meus Dados</a> <a
							class="dropdown-item" href="LogoutServlet">Sair</a>
					</div></li>
			</ul>
		</div>
	</nav>

	<div class="col-sm-12 col-md-12 pt-3" role="main">
		<h5>
			Detalhes do Equipamento -
			<%= equipamento.getTag() %>
			<i class="fa fa-cogs" aria-hidden="true"></i>
		</h5>
		<hr />
		<div class="alerta">
			<%if(cod!=null){ %>
			<% if(cod.equals("1")){ %>
			<div class="alert alert-success" role="alert">
				<strong>Controle de fluido</strong> apagado com sucesso. <i
					class="fa fa-check" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("2")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro</strong> ao apagar controle fluido do banco de dados. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("3")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao apagar controle de fluido. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="cliente.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("4")){ %>
			<div class="alert alert-success" role="alert">
				<strong>Controle de fluido</strong> atualizado com sucesso. <i
					class="fa fa-check" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("5")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro </strong> ao atualizar controle de fluido no banco de
				dados. <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("6")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao atualizar controle de fluido. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("7")){ %>
			<div class="alert alert-success" role="alert">
				<strong>Correção de fluido</strong> criada com sucesso. <i
					class="fa fa-check" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("8")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro </strong> ao criar correção de fluido no banco de
				dados. <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("9")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao criar correção de fluido. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("10")){ %>
			<div class="alert alert-success" role="alert">
				<strong>Correção de fluido</strong> apagada com sucesso. <i
					class="fa fa-check" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("11")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro </strong> ao apagar correção de fluido no banco de
				dados. <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("12")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao apagar correção de fluido. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("13")){ %>
			<div class="alert alert-success" role="alert">
				<strong>Correção de fluido</strong> alterada com sucesso. <i
					class="fa fa-check" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("14")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro </strong> ao alterar correção de fluido no banco de
				dados. <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
				<a href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% } else if(cod.equals("15")){ %>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao alterar correção de fluido. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="equipamento.jsp" class="close">&times;</a>
			</div>
			<% }} %>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Tipo</div>
					<div class="div-det-bod"><%= equipamento.getTipo() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Fabricante</div>
					<div class="div-det-bod"><%= equipamento.getFabricante() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Setor</div>
					<div class="div-det-bod"><%= equipamento.getSetor() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Ponto Lubrificação</div>
					<div class="div-det-bod"><%= equipamento.getPontoLubrificacao() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Produto</div>
					<div class="div-det-bod"><%= equipamento.getProduto().getProduto() %></div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Volume</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getVolume()) %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Concentração Mínima</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getConsentracaoMin())%>%
					</div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Concentração Máxima</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getConsentracaoMax()) %>%
					</div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Limite Mínimo Ph</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getLimiteMinPh()) %>%
					</div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Limite Máximo Ph</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getLimiteMaxPh()) %>%
					</div>
				</div>
			</div>

			<div class="row" style="margin-top: 20px">
		   	<div class="col-sm-4" style="padding-left: 0;">
		   	<form class="form-horizontal" method="post" action="equipamento.jsp">
		       <div class="form-group" style="margin-bottom: 0">
		        <div class="col-sm-12">
		         <div class="input-group">
		          <input type="text" class="form-control" name="busca" id="busca" placeholder="buscar controle..." required />
			<span class="input-group-addon" style="padding: 0">
				<button type="submit" class="btn btn-success btn-busca"><i class="fa fa-search" aria-hidden="true"></i></button>
			</span>
		         </div>
		        </div>
		       </div>
		      </form>
		   	</div>
		   	<div class="col-sm-1 btn-refresh">
		   		<a href="equipamento.jsp" class="link-box" title="recarregar tabela"><i class="fa fa-refresh" aria-hidden="true"></i></a>
		   	</div>
		   	<div class="col-sm-7"></div>
		   </div>

		   <%
				String busca = request.getParameter("busca");

				if(busca == null){
					controles =  ControleFluidoController.getControlesPorEquipamento(equipamento.getId());
				} else {
					controles = ControleFluidoController.searchControlesFluido(busca, equipamento.getId());
				}
			%>

			<div class="row">
				<div class="col-sm-7">
					<div class="card card-success det-cli">
						<div class="card-header det-cli-h">
							Controles de Fluido <i class="fa fa-cogs" aria-hidden="true"></i>
							<div style="float: right">
								<a href="SelEquipamento?id=<%= equipamento.getId() %>&op=con"
									class="link-box"> <i class="fa fa-plus" aria-hidden="true"></i>
									adicionar
								</a>
							</div>
						</div>
						<div class="card-block" style="max-height: 325px; overflow: auto;">
							<%
								if (controles.isEmpty()) {
									if(busca != null) {
									 %>
									 	<p>Sua pesquisa "<%=busca%>" não encontrou nenhum registro.</p>
									 <% 	} else { %>
									 	<p>Não há controles registrados para esse equipamento</p>
								     <% }} else {
							%>
							<div class="table-responsive tab">
								<table class="table table-striped tab-tab_1">
									<thead class="thead-tab-usu">
										<th>ID</th>
										<th>Data</th>
										<th>Con(%)</th>
										<th>Ph(%)</th>
										<th>Cont.</th>
										<th>Nível</th>
										<th>Ski.</th>
										<th colspan="2">Correções</th>
										<th></th>
										<th></th>
									</thead>
									<tbody class="tbody-tab-usu">
										<% for(ControleFluido c: controles) { %>
										<tr>
											<td><%= c.getCodigo() %></td>

											<!-- Coluna de Data da medição -->
											<td><%= frmtData.format(c.getData()) %></td>

											<!-- Coluna de Concentração Medida -->
											<% if(c.getConcentracao() > c.getConMax()) { %>
											<td class="res-neg"><i class="fa fa-caret-up"
												aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(c.getConcentracao()) %>
											</td>
											<% } else if(c.getConcentracao() < c.getConMin()) { %>
											<td class="res-neg"><i class="fa fa-caret-down"
												aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(c.getConcentracao()) %>
											</td>
											<% } else { %>
											<td class="res-pos"><%= NumberFormat.getNumberInstance().format(c.getConcentracao()) %></td>
											<% } %>

											<!-- Coluna de Ph Medido -->
											<% if(c.getPh() < c.getPhMin()) { %>
											<td class="res-neg"><i class="fa fa-caret-down"
												aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(c.getPh()) %>
											</td>
											<% } else if(c.getPh() > c.getPhMax()) { %>
											<td class="res-neg"><i class="fa fa-caret-up"
												aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(c.getPh()) %>
											</td>
											<% } else { %>
											<td class="res-pos"><%= NumberFormat.getNumberInstance().format(c.getPh()) %></td>
											<% } %>

											<!-- Coluna de Contaminação Visual -->
											<% if(c.getContaminacaoVisual().equals("Não")) { %>
											<td><%= c.getContaminacaoVisual() %></td>
											<% } else { %>
											<td class="res-neg"><%= c.getContaminacaoVisual() %></td>
											<% } %>

											<!-- Coluna de Nível do Reservatório -->
											<% if(c.getNivelReservatorio().equals("Mínimo")) { %>
											<td class="res-neg"><%= c.getNivelReservatorio() %></td>
											<%}  else { %>
											<td><%= c.getNivelReservatorio() %></td>
											<% } %>

											<!-- Coluna de Skimmer -->
											<% if(c.getSkimmer().equals("Off")) { %>
											<td class="res-neg"><%= c.getSkimmer() %></td>
											<%}  else { %>
											<td><%= c.getSkimmer() %></td>
											<% } %>
											<!-- Coluna de Inserir/Consultar Correção de Fluidos -->
											<% if(!CorrecaoFluidoController.isCorrecao(c.getId())) { %>
											<td><a href="#" data-toggle="modal" data-target="#modal"
												onclick="setContModal(<%= c.getId() %>)"
												title="Inserir das correções"> <i style="color: #228B22"
													class="fa fa-plus-circle" aria-hidden="true"></i>
											</a></td>
											<td></td>
											<% } else { %>
											<td><a href="#" data-toggle="modal" data-target="#modal"
												onclick="setContModal(<%= c.getId() %>)"
												title="Inserir das correções"> <i style="color: #228B22"
													class="fa fa-plus-circle" aria-hidden="true"></i>
											</a></td>
											<% if(busca == null) { %>
											<td><a href="equipamento.jsp?controle=<%= c.getId() %>"
												title="Detalhes das correções"> <i
													style="color: #CD0000" class="fa fa-info-circle"
													aria-hidden="true"></i>
											</a></td>
											<% } else { %>
											<td><a href="equipamento.jsp?controle=<%= c.getId() %>&busca=<%=busca%>"
												title="Detalhes das correções"> <i
													style="color: #CD0000" class="fa fa-info-circle"
													aria-hidden="true"></i>
											</a></td>
											<% } } %>
											<td><a href="#" class="link-box" data-toggle="modal"
												data-target="#updcon" title="Editar controle"
												onclick="setUpdCon('<%= c.getId() %>','<%= c.getConcentracao() %>','<%= c.getPh() %>')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
											</a></td>
											<td><a href="#" class="link-box" data-toggle="modal"
												data-target="#delcon" title="Apagar controle"
												onclick="setDelCon('<%= c.getCodigo() %>','<%= c.getId() %>',
												'<%= equipamento.getCliente().getId() %>','<%= c.getData() %>')">
													<i class="fa fa-trash-o" aria-hidden="true"></i>
											</a></td>
										</tr>
										<% } %>
									</tbody>
								</table>
							</div>
							<% } %>
						</div>
						<div class="card-footer">
							<div class="row">
								<div class="col-sm-8">
									<div class="row">
										<div class="col-sm-10"
											style="top: 0; bottom: 0; left: 0; right: 0; margin: auto;">
											Relatório de Controles por Período:</div>
										<div class="col-sm-2">
											<a href="#" class="legenda btn btn-success" data-toggle="modal"
												data-target="#relper" style="font-size: 14px; margin-bottom: 15px;"> <img
												src="img/pdf.png" width="14" height="14"> Visualizar
											</a>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-10"
											style="top: 0; bottom: 0; left: 0; right: 0; margin: auto;">
											Relatório de Consumo de Produtos:</div>
										<div class="col-sm-2">
											<a href="#" class="legenda btn btn-success" data-toggle="modal"
												data-target="#relcons" style="font-size: 14px"> <img
												src="img/pdf.png" width="14" height="14"> Visualizar
											</a>
										</div>
									</div>
								</div>
								<div class="col-sm-3">
								<% if(setor.equals("null")) { %>
									<a href="equipamentos.jsp"
									   class="legenda btn btn-success right" style="font-size: 14px">
									   <i class="fa fa-backward" aria-hidden="true"></i> voltar
									</a>
								<% } else { %>
									<a href="equipamentos.jsp?sid=<%=setor%>"
									   class="legenda btn btn-success right" style="font-size: 14px">
									   <i class="fa fa-backward" aria-hidden="true"></i> voltar
									</a>
								<% } %>
								</div>
							</div>
							<hr />
							<p class="legenda" align="justify">
								<b>Data:</b> Data da medição; <b>Con:</b> Concentração medida; <b>Ph:</b>
								Ph medido; <b>Cont.:</b> Contaminação visual; <b>Ski.:</b>
								Skimmer; <br />
								<b>Nivel:</b> Nível verificado no reservatório; <b>Correções:</b>
								<i class="fa fa-plus-circle" aria-hidden="true"></i> Inserir
								correção; <i class="fa fa-info-circle" aria-hidden="true"></i>
								Consultar correção; <i class="fa fa-pencil" aria-hidden="true"></i>
								Editar correção; <i class="fa fa-times" aria-hidden="true"></i>
								Apagar correção;
						</div>
					</div>
				</div>
				<div class="col-sm-5">
					<div class="col-sm-12">
						<div class="card card-success det-cli">
							<div class="card-header det-cli-h">
								Correções de
								<% if(controle == null) {%>
								Fluidos
								<% } else { %>
								<%= ControleFluidoController.getControleFluido(Integer.parseInt(controle)).getCodigo() %>
								<% } %>
								<i class="fa fa-wrench" aria-hidden="true"></i>
								<div style="float: right">
									<a href="equipamento.jsp" class="link-box"> <i
										class="fa fa-eraser" aria-hidden="true"></i> Limpar
									</a>
								</div>
							</div>
							<div class="card-block"
								style="max-height: 200px; overflow: auto;">
								<% if(controle == null) { %>
								<p>Não há correções selecionado para verificação</p>
								<% } else { %>
								<div class="table-responsive tab">
									<table class="table table-striped tab-tab_1">
										<thead class="thead-tab-usu">
											<th>Data</th>
											<th>Produto</th>
											<th>Qtde(lts)</th>
											<th>Laudo</th>
											<th></th>
											<th></th>
										</thead>
										<tbody class="tbody-tab-usu">
											<%
												correcoes = CorrecaoFluidoController.getCorrecaoPorControle(Integer.parseInt(controle));
												for(CorrecaoFluido cf: correcoes) {
											%>
											<tr>
												<td><%= frmtData.format(cf.getData()) %></td>
												<td><%= cf.getProduto().getProduto() %></td>
												<td><%= NumberFormat.getNumberInstance().format(cf.getQuantidade()) %></td>
												<td><%= cf.getLaudo() %></td>
												<td><a href="#" data-toggle="modal"
													data-target="#updcor" class="link-box"
													title="Editar correção"
													onclick="setUpdCor('<%= cf.getId() %>','<%= cf.getQuantidade() %>','<%= cf.getLaudo() %>')">
														<i class="fa fa-pencil" aria-hidden="true"></i>
												</a></td>
												<td><a href="#" data-toggle="modal"
													data-target="#delcor" class="link-box"
													title="Apagar correção"
													onclick="setDelCor(<%= cf.getId() %>)"> <i
														class="fa fa-times" aria-hidden="true"></i></a></td>
											</tr>
											<% } %>
										</tbody>
									</table>
								</div>
								<% } %>
							</div>
						</div>
					</div>
					<div class="col-sm-12" id="div">
						<div class="card card-success det-cli">
							<div class="card-header det-cli-h">Registro de Ateração de Parâmetros</div>
							<div class="card-block"
								style="max-height: 120px; overflow: auto;">
								<% ArrayList<AlteracaoParametro> alteracoes = AlteracaoParametroController.getAltParametrosPorEquipamento(equipamento.getId());
			 					if(alteracoes.isEmpty()) { %>
								<p>Não há alterações de parametros</p>
								<% } else { %>
								<div class="table-responsive tab">
									<table class="table table-striped tab-tab_1">
										<thead class="thead-tab-usu">
											<th>Data</th>
											<th>Item</th>
											<th colspan="2">Min(De - Para)</th>
											<th colspan="2">Máx(De - Para)</th>
										</thead>
										<tbody class="tbody-tab-usu">
											<%
								            	for(AlteracaoParametro a: alteracoes){
								            %>
											<tr>
												<td><%= frmtData.format(a.getData()) %></td>
												<td><%= a.getItem() %></td>
												<td><%= NumberFormat.getNumberInstance().format(a.getAltDeMinimo()) %></td>

												<% if(a.getAltDeMinimo() < a.getAltParaMinimo()) { %>
												<td class="res-med-i"><i class="fa fa-caret-up"
													aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(a.getAltParaMinimo()) %></td>
												<% } else if(a.getAltDeMinimo() > a.getAltParaMinimo()) { %>
												<td class="res-med-i"><i class="fa fa-caret-down"
													aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(a.getAltParaMinimo()) %></td>
												<% } else { %>
												<td><%= NumberFormat.getNumberInstance().format(a.getAltParaMinimo()) %></td>
												<% } %>

												<td><%= NumberFormat.getNumberInstance().format(a.getAltDeMaximo()) %></td>

												<% if(a.getAltDeMaximo() < a.getAltParaMaxima()) { %>
												<td class="res-med-i"><i class="fa fa-caret-up"
													aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(a.getAltParaMaxima()) %></td>
												<% } else if(a.getAltDeMaximo() > a.getAltParaMaxima()) { %>
												<td class="res-med-i"><i class="fa fa-caret-down"
													aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(a.getAltParaMaxima()) %></td>
												<% } else { %>
												<td><%= NumberFormat.getNumberInstance().format(a.getAltParaMaxima()) %></td>
												<% } %>

											</tr>
											<% } %>
										</tbody>
									</table>
								</div>
								<% } %>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	<hr />

	<script>
	function setContModal(id) {
	 document.getElementById('controle').value = id;
	}

	function setDelCon(val20, val21, val22, val23) {
	 document.getElementById('val20').value = val20;
	 document.getElementById('val21').value = val21;
	 document.getElementById('val22').value = val22;
	 document.getElementById('val23').value = val23;
	}

	function setUpdCon(val6, val7, val8) {
	 document.getElementById('conid').value = val6;
	 document.getElementById('concentracao').value = val7;
	 document.getElementById('ph').value = val8;
	}

	function setDelCor(val9) {
	 document.getElementById('idcor').value = val9;
	}

	function setUpdCor(val10, val11, val12) {
	 document.getElementById('corid').value = val10;
	 document.getElementById('quant').value = val11;
	 document.getElementById('val12').value = val12;
	}
   </script>

	<div class="footer">
		<p class="rodape">&copy; 2017 Sistema de Gestão de Fluidos de Processo - All
			Lubrificantes.</p>
	</div>

	<div id="modal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Correção do Fluido</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="panel-body">
						<!-- Formulário de cadastro de correções -->
						<form class="form-horizontal col-sm-12" method="post"
							action="InsertCorrecao">
							<input type="hidden" name="controle" id="controle">
							<div class="form-group">
								<label class="control-label col-sm-11" for="produto">Produto:
								</label>
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
								<label class="control-label col-sm-11" for="data">Data:
								</label>
								<div class="col-sm-12">
									<input type="date" class="form-control" name="data" id="data"
										required />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="quantidade">Quantidade:
								</label>
								<div class="col-sm-12">
									<input type="number" step="0.01" class="form-control"
										name="quantidade" id="quantidade" placeholder="Quantidade" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="laudo">Laudo:</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" name="laudo" id="laudo"
										placeholder="Número do laudo" />
								</div>
							</div>
							<div class="col-sm-1" style="width: 100%; margin-bottom: 20px">
								<button type="submit" class="btn btn-success">
									salvar <i class="fa fa-floppy-o" aria-hidden="true"></i>
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Editar e Apagar Controles -->

	<div id="delcon" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Apagar Controle</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="panel-body">
						Tem certeza que deseja apagar o Controle?<br />
						<output type="text" name="val20" id="val20"></output>
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-sm-6" align="center">
						<form method="post" action="DeleteControle">
							<input type="hidden" name="val21" id="val21">
							<input type="hidden" name="val22" id="val22">
							<input type="hidden" name="val23" id="val23">
							<button type="submit" class="btn btn-success">
								sim <i class="fa fa-check" aria-hidden="true"></i>
							</button>
						</form>
					</div>
					<div class="col-sm-6" align="center">
						<button type="button" class="btn btn-danger" data-dismiss="modal">
							não <i class="fa fa-times" aria-hidden="true"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="updcon" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade"
		ng-controller="controllerName">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Editar Controle</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form class="form-horizontal" name="form" method="post"
					action="UpdateControle">
					<div class="modal-body">
						<div class="panel-body">
							<input type="hidden" name="conid" id="conid"> <input
								type="hidden" name="equipamento" id="equipamento"
								value=<%= equipamento.getId() %>>
							<div class="form-group">
								<label class="control-label col-sm-11" for="concentracao">Concentração</label>
								<div class="col-sm-12">
									<input type="number" step="0.01" class="form-control"
										name="concentracao" id="concentracao"
										placeholder="Concentração aferida" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="ph">Ph: </label>
								<div class="col-sm-12">
									<input type="number" step="0.01" class="form-control" name="ph"
										id="ph" placeholder="Ph aferido" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="cont_visual">Contaminação
									Visual: </label>
								<div class="btn-group btn-group-horizontal"
									data-toggle="buttons">
									<label class="btn"> <input type="radio"
										name="cont_visual" id="cont_visual2" value="Não"checked">
										<i class="fa fa-circle-o fa-2x"></i><i
										class="fa fa-dot-circle-o fa-2x"></i> <span>Não</span>
									</label> <label class="btn"> <input type="radio"
										name="cont_visual" id="cont_visual1" value="Sim"checked">
										<i class="fa fa-circle-o fa-2x"></i><i
										class="fa fa-dot-circle-o fa-2x"></i> <span>Sim</span>
									</label>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="nivel">Nível
									do Reservatório: </label>
								<div class="btn-group btn-group-horizontal"
									data-toggle="buttons">
									<label class="btn"> <input type="radio" name="nivel"
										id="nivel1" value="Mínimo"checked"> <i
										class="fa fa-circle-o fa-2x"></i><i
										class="fa fa-dot-circle-o fa-2x"></i> <span>Mínimo</span>
									</label> <label class="btn"> <input type="radio" name="nivel"
										id="nivel2" value="Médio"checked"> <i
										class="fa fa-circle-o fa-2x"></i><i
										class="fa fa-dot-circle-o fa-2x"></i> <span>Médio</span>
									</label> <label class="btn"> <input type="radio" name="nivel"
										id="nivel3" value="Máximo"checked"> <i
										class="fa fa-circle-o fa-2x"></i><i
										class="fa fa-dot-circle-o fa-2x"></i> <span>Máximo</span>
									</label>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="skimmer">Skimmer:
								</label>
								<div class="btn-group btn-group-horizontal"
									data-toggle="buttons">
									<label class="btn"> <input type="radio" name="skimmer"
										id="skimmer1" value="On"checked"> <i
										class="fa fa-circle-o fa-2x"></i><i
										class="fa fa-dot-circle-o fa-2x"></i> <span>On</span>
									</label> <label class="btn"> <input type="radio" name="skimmer"
										id="skimmer2" value="Off"checked"> <i
										class="fa fa-circle-o fa-2x"></i><i
										class="fa fa-dot-circle-o fa-2x"></i> <span>Off</span>
									</label>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								atualizar <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Editar e Apagar Correção -->

	<div id="delcor" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Apagar Correção</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="panel-body">
						Tem certeza que deseja apagar o Correção?<br />
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-sm-6" align="center">
						<form method="post" action="DeleteCorrecao">
							<input type="hidden" name="idcor" id="idcor">
							<button type="submit" class="btn btn-success">
								sim <i class="fa fa-check" aria-hidden="true"></i>
							</button>
						</form>
					</div>
					<div class="col-sm-6" align="center">
						<button type="button" class="btn btn-danger" data-dismiss="modal">
							não <i class="fa fa-times" aria-hidden="true"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="updcor" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade"
		ng-controller="controllerName">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Editar Correção</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form class="form-horizontal" name="form" method="post"
					action="UpdateCorrecao">
					<div class="modal-body">
						<div class="panel-body">
							<!-- Formulário de cadastro de correções -->
							<input type="hidden" name="corid" id="corid">
							<div class="form-group">
								<label class="control-label col-sm-11" for="produto">Produto:
								</label>
								<div class="col-sm-12">
									<select class="form-control" name="produto" ng-model="produto">
										<option value="">Selecione o produto</option>
										<%
								          	ArrayList<Produto> ps = null;
								          	for(TipoProduto t:  tipos) { %>
										<optgroup label="<%= t.getTipo() %>">
											<%  ps = ProdutoController.getProdutosPorTipo(t.getId());
            									for(Produto p: ps){ %>
											<option value=<%= p.getId() %>><%= p.getProduto() %></option>
											<% } %>
										</optgroup>
										<% } %>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="quant">Quantidade:
								</label>
								<div class="col-sm-12">
									<input type="number" step="0.01" class="form-control"
										name="quant" id="quant" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-11" for="laudo">Laudo:
								</label>
								<div class="col-sm-12">
									<input type="text" class="form-control"
										name="val12" id="val12" />
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								atualizar <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
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
					<h5 class="modal-title">Gerar relatório por Período</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="RelatorioControlePorPeriodo">
					<div class="modal-body">
						<input type="hidden" name="equipamento" id="equipamento"
							value=<%= equipamento.getId() %>>
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

	<div id="relcons" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório de consumo <br />Produtos por equipamento</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="ConsumoEquip">
					<div class="modal-body">
						<div class="form-group">
							<div class="col-sm-12">
								<input type="hidden" name="equipamento" id="equipamento"
									value=<%=equipamento.getId()%>>
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

	<div id="sobre" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #696969">
					<img src="img/favicon.png" width="25" height="25" />
					<h5 class="modal-title" style="color: #FFFFFF">Gestão de
						Fluidos de Processo</h5>
				</div>
				<div class="modal-body" style="background-color: #696969">
					<p class="legenda" align="right" style="color: #FFFFFF">Versão
						1.0.0</p>
					<p class="legenda" align="justify" style="color: #CFCFCF">
						Copyright &copy; 2017 - Desenvolvido por All Lubrificantes e
						Frederico E. Cabral Araújo.<br /> Todos os direitos reservados.<br />
						Contato: frederico-cabral@hotmail.com
					</p>
				</div>
				<div class="modal-footer" align="right">
					<img src="img/logo1.png" width="180" height="56" />
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

	<!-- Pagina inicial do Administrado e Representante -->
  	<% } else if(uLogado.getPerfil() == 3) {
   		ArrayList<ControleFluido> controles = ControleFluidoController.getControlesPorEquipamento(equipamento.getId());
   		ArrayList<CorrecaoFluido> correcoes = new ArrayList<CorrecaoFluido>();
  	%>

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
		<h5>
			Detalhes do Equipamento -
			<%= equipamento.getTag() %>
			<i class="fa fa-cogs" aria-hidden="true"></i>
		</h5>
		<hr />

		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Tipo</div>
					<div class="div-det-bod"><%= equipamento.getTipo() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Fabricante</div>
					<div class="div-det-bod"><%= equipamento.getFabricante() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Setor</div>
					<div class="div-det-bod"><%= equipamento.getSetor() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Ponto Lubrificação</div>
					<div class="div-det-bod"><%= equipamento.getPontoLubrificacao() %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Produto</div>
					<div class="div-det-bod"><%= equipamento.getProduto().getProduto() %></div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Volume</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getVolume()) %></div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Concentração Mínima</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getConsentracaoMin())%>%
					</div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Concentração Máxima</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getConsentracaoMax()) %>%
					</div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Limite Mínimo Ph</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getLimiteMinPh()) %>%
					</div>
				</div>
				<div class="col-sm-2 div-det" align="center">
					<div class="div-det-hea">Limite Máximo Ph</div>
					<div class="div-det-bod"><%= NumberFormat.getNumberInstance().format(equipamento.getLimiteMaxPh()) %>%
					</div>
				</div>
			</div>

			<div class="row" style="margin-top: 20px">
		   	<div class="col-sm-4" style="padding-left: 0;">
		   	<form class="form-horizontal" method="post" action="equipamento.jsp">
		       <div class="form-group" style="margin-bottom: 0">
		        <div class="col-sm-12">
		         <div class="input-group">
		          <input type="text" class="form-control" name="busca" id="busca" placeholder="buscar controle..." required />
			<span class="input-group-addon" style="padding: 0">
				<button type="submit" class="btn btn-success btn-busca"><i class="fa fa-search" aria-hidden="true"></i></button>
			</span>
		         </div>
		        </div>
		       </div>
		      </form>
		   	</div>
		   	<div class="col-sm-1 btn-refresh">
		   		<a href="equipamento.jsp" class="link-box" title="recarregar tabela"><i class="fa fa-refresh" aria-hidden="true"></i></a>
		   	</div>
		   	<div class="col-sm-7"></div>
		   </div>

		   <%
				String busca = request.getParameter("busca");

				if(busca == null){
					controles =  ControleFluidoController.getControlesPorEquipamento(equipamento.getId());
				} else {
					controles = ControleFluidoController.searchControlesFluido(busca, equipamento.getId());
				}
			%>

			<div class="row">
				<div class="col-sm-7">
					<div class="card card-success det-cli">
						<div class="card-header det-cli-h">
							Controles de Fluido <i class="fa fa-cogs" aria-hidden="true"></i>
						</div>
						<div class="card-block" style="max-height: 325px; overflow: auto;">
							<%
								if (controles.isEmpty()) {
									if(busca != null) {
									 %>
									 	<p>Sua pesquisa "<%=busca%>" não encontrou nenhum registro.</p>
									 <% 	} else { %>
									 	<p>Não há logs de acessos registrados</p>
								     <% }} else {
							%>

							<div class="table-responsive tab">
								<table class="table table-striped tab-tab_1">
									<thead class="thead-tab-usu">
										<th>ID</th>
										<th>Data</th>
										<th>Con(%)</th>
										<th>Ph(%)</th>
										<th>Cont.</th>
										<th>Nível</th>
										<th>Ski.</th>
										<th>Correções</th>
									</thead>
									<tbody class="tbody-tab-usu">
										<% for(ControleFluido c: controles) { %>
										<tr>
											<td><%= c.getCodigo() %></td>

											<!-- Coluna de Data da medição -->
											<td><%= frmtData.format(c.getData()) %></td>

											<!-- Coluna de Concentração Medida -->
											<% if(c.getConcentracao() > c.getConMax()) { %>
											<td class="res-neg"><i class="fa fa-caret-up"
												aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(c.getConcentracao()) %>
											</td>
											<% } else if(c.getConcentracao() < c.getConMin()) { %>
											<td class="res-neg"><i class="fa fa-caret-down"
												aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(c.getConcentracao()) %>
											</td>
											<% } else { %>
											<td class="res-pos"><%= NumberFormat.getNumberInstance().format(c.getConcentracao()) %></td>
											<% } %>

											<!-- Coluna de Ph Medido -->
											<% if(c.getPh() < c.getPhMin()) { %>
											<td class="res-neg"><i class="fa fa-caret-down"
												aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(c.getPh()) %>
											</td>
											<% } else if(c.getPh() > c.getPhMax()) { %>
											<td class="res-neg"><i class="fa fa-caret-up"
												aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(c.getPh()) %>
											</td>
											<% } else { %>
											<td class="res-pos"><%= NumberFormat.getNumberInstance().format(c.getPh()) %></td>
											<% } %>

											<!-- Coluna de Contaminação Visual -->
											<% if(c.getContaminacaoVisual().equals("Não")) { %>
											<td><%= c.getContaminacaoVisual() %></td>
											<% } else { %>
											<td class="res-neg"><%= c.getContaminacaoVisual() %></td>
											<% } %>

											<!-- Coluna de Nível do Reservatório -->
											<% if(c.getNivelReservatorio().equals("Mínimo")) { %>
											<td class="res-neg"><%= c.getNivelReservatorio() %></td>
											<%}  else { %>
											<td><%= c.getNivelReservatorio() %></td>
											<% } %>

											<!-- Coluna de Skimmer -->
											<td><%= c.getSkimmer() %></td>

											<% if(!CorrecaoFluidoController.isCorrecao(c.getId())) { %>
											<td>Não há correções</td>
											<% } else { %>
											<% if(busca == null) { %>
											<td><a href="equipamento.jsp?controle=<%= c.getId() %>"
												title="Detalhes das correções"> <i
													style="color: #CD0000" class="fa fa-info-circle"
													aria-hidden="true"></i>
											</a></td>
											<% } else { %>
											<td><a href="equipamento.jsp?controle=<%= c.getId() %>&busca=<%=busca%>"
												title="Detalhes das correções"> <i
													style="color: #CD0000" class="fa fa-info-circle"
													aria-hidden="true"></i>
											</a></td>
											<% } } %>

										</tr>
										<% } %>
									</tbody>
								</table>
							</div>
							<% } %>
						</div>
						<div class="card-footer">
							<div class="row">
								<div class="col-sm-8">
									<div class="row">
										<div class="col-sm-10"
											style="top: 0; bottom: 0; left: 0; right: 0; margin: auto;">
											Relatório de Controles por Período:</div>
										<div class="col-sm-2">
											<a href="#" class="legenda btn btn-success" data-toggle="modal"
												data-target="#relper" style="font-size: 14px; margin-bottom: 15px;"> <img
												src="img/pdf.png" width="14" height="14"> Visualizar
											</a>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-10"
											style="top: 0; bottom: 0; left: 0; right: 0; margin: auto;">
											Relatório de Consumo de Produtos:</div>
										<div class="col-sm-2">
											<a href="#" class="legenda btn btn-success" data-toggle="modal"
												data-target="#relcons" style="font-size: 14px"> <img
												src="img/pdf.png" width="14" height="14"> Visualizar
											</a>
										</div>
									</div>
								</div>

								<div class="col-sm-3">
									<a
										href="SelCliente?id=<%= equipamento.getCliente().getId() %>&op=eqs"
										class="legenda btn btn-success right" style="font-size: 14px"">
										<i class="fa fa-backward" aria-hidden="true"></i> voltar
									</a>
								</div>
							</div>
							</div>
							<hr />
							<p class="legenda" align="justify">
								<b>Data:</b> Data da medição; <b>Con:</b> Concentração medida; <b>Ph:</b>
								Ph medido; <b>Cont.:</b> Contaminação visual; <b>Ski.:</b>
								Skimmer; <br />
								<b>Nivel:</b> Nível verificado no reservatório; <b>Correções:</b>
								<i class="fa fa-plus-circle" aria-hidden="true"></i> Inserir
								correção; <i class="fa fa-info-circle" aria-hidden="true"></i>
								Consultar correção; <i class="fa fa-pencil" aria-hidden="true"></i>
								Editar correção; <i class="fa fa-times" aria-hidden="true"></i>
								Apagar correção;
						</div>
					</div>
				</div>
				<div class="col-sm-5">
					<div class="col-sm-12">
						<div class="card card-success det-cli">
							<div class="card-header det-cli-h">
								Correções de
								<% if(controle == null) {%>
								Fluidos
								<% } else { %>
								<%= ControleFluidoController.getControleFluido(Integer.parseInt(controle)).getCodigo() %>
								<% } %>
								<i class="fa fa-wrench" aria-hidden="true"></i>
								<div style="float: right">
									<a href="equipamento.jsp" class="link-box"> <i
										class="fa fa-eraser" aria-hidden="true"></i> Limpar
									</a>
								</div>
							</div>
							<div class="card-block"
								style="max-height: 200px; overflow: auto;">
								<% if(controle == null) { %>
								<p>Não há controle selecionado para verificação</p>
								<% } else { %>
								<div class="table-responsive tab">
									<table class="table table-striped tab-tab_1">
										<thead class="thead-tab-usu">
											<th>Data</th>
											<th>Produto</th>
											<th>Qtde(lts)</th>
											<th>Laudo</th>
										</thead>
										<tbody class="tbody-tab-usu">
											<%
												correcoes = CorrecaoFluidoController.getCorrecaoPorControle(Integer.parseInt(controle));
												for(CorrecaoFluido cf: correcoes) {
											%>
											<tr>
												<td><%= frmtData.format(cf.getData()) %></td>
												<td><%= cf.getProduto().getProduto() %></td>
												<td><%= NumberFormat.getNumberInstance().format(cf.getQuantidade()) %></td>
												<td><%= cf.getLaudo() %></td>
											</tr>
											<% } %>
										</tbody>
									</table>
								</div>
								<% } %>
							</div>
						</div>
					</div>
					<div class="col-sm-12" id="div">
						<div class="card card-success det-cli">
							<div class="card-header det-cli-h">Registro de Ateração de Parâmetros</div>
							<div class="card-block"
								style="max-height: 120px; overflow: auto;">
								<% ArrayList<AlteracaoParametro> alteracoes = AlteracaoParametroController.getAltParametrosPorEquipamento(equipamento.getId());
			 					if(alteracoes.isEmpty()) { %>
								<p>Não há alterações de parametros</p>
								<% } else { %>
								<div class="table-responsive tab">
									<table class="table table-striped tab-tab_1">
										<thead class="thead-tab-usu">
											<th>Data</th>
											<th>Item</th>
											<th colspan="2">Min(De - Para)</th>
											<th colspan="2">Máx(De - Para)</th>
										</thead>
										<tbody class="tbody-tab-usu">
											<%
								            	for(AlteracaoParametro a: alteracoes){
								            %>
											<tr>
												<td><%= frmtData.format(a.getData()) %></td>
												<td><%= a.getItem() %></td>
												<td><%= NumberFormat.getNumberInstance().format(a.getAltDeMinimo()) %></td>

												<% if(a.getAltDeMinimo() < a.getAltParaMinimo()) { %>
												<td class="res-med-i"><i class="fa fa-caret-up"
													aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(a.getAltParaMinimo()) %></td>
												<% } else if(a.getAltDeMinimo() > a.getAltParaMinimo()) { %>
												<td class="res-med-i"><i class="fa fa-caret-down"
													aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(a.getAltParaMinimo()) %></td>
												<% } else { %>
												<td><%= NumberFormat.getNumberInstance().format(a.getAltParaMinimo()) %></td>
												<% } %>

												<td><%= NumberFormat.getNumberInstance().format(a.getAltDeMaximo()) %></td>

												<% if(a.getAltDeMaximo() < a.getAltParaMaxima()) { %>
												<td class="res-med-i"><i class="fa fa-caret-up"
													aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(a.getAltParaMaxima()) %></td>
												<% } else if(a.getAltDeMaximo() > a.getAltParaMaxima()) { %>
												<td class="res-med-i"><i class="fa fa-caret-down"
													aria-hidden="true"></i> <%= NumberFormat.getNumberInstance().format(a.getAltParaMaxima()) %></td>
												<% } else { %>
												<td><%= NumberFormat.getNumberInstance().format(a.getAltParaMaxima()) %></td>
												<% } %>

											</tr>
											<% } %>
										</tbody>
									</table>
								</div>
								<% } %>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	<hr />


	<div class="footer">
		<p class="rodape">&copy; 2017 Sistema de Gestão de Fluidos de Processo - All
			Lubrificantes.</p>
	</div>

	<!-- Gerar relatório por periodo -->

	<div id="relper" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório por Período</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="RelatorioControlePorPeriodo">
					<div class="modal-body">
						<input type="hidden" name="equipamento" id="equipamento"
							value=<%= equipamento.getId() %>>
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

	<div id="relcons" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Gerar relatório de consumo <br />Produtos por equipamento</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="ConsumoEquip">
					<div class="modal-body">
						<div class="form-group">
							<div class="col-sm-12">
								<input type="hidden" name="equipamento" id="equipamento"
									value=<%=equipamento.getId()%>>
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

	<div id="sobre" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #696969">
					<img src="img/favicon.png" width="25" height="25" />
					<h5 class="modal-title" style="color: #FFFFFF">Gestão de
						Fluidos de Processo</h5>
				</div>
				<div class="modal-body" style="background-color: #696969">
					<p class="legenda" align="right" style="color: #FFFFFF">Versão
						1.0.0</p>
					<p class="legenda" align="justify" style="color: #CFCFCF">
						Copyright &copy; 2017 - Desenvolvido por All Lubrificantes e
						Frederico E. Cabral Araújo.<br /> Todos os direitos reservados.<br />
						Contato: frederico-cabral@hotmail.com
					</p>
				</div>
				<div class="modal-footer" align="right">
					<img src="img/logo1.png" width="180" height="56" />
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
