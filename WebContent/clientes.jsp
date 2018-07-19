<%@page import="com.gf.model.controller.EquipamentoController"%>
<%@page import="com.gf.model.entity.Equipamento"%>
<%@page import="com.gf.model.entity.ContatoCliente"%>
<%@page import="com.gf.model.controller.ContatoClienteController"%>
<%@page import="com.gf.model.dao.ContatoClienteDAO"%>
<%@page import="com.gf.model.controller.SetorController"%>
<%@page import="com.gf.model.entity.Setor"%>
<%@page import="com.gf.model.controller.CidadeController"%>
<%@page import="com.gf.model.controller.EstadoController"%>
<%@page import="com.gf.model.entity.Cidade"%>
<%@page import="com.gf.model.entity.Estado"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.gf.model.controller.UsuarioController"%>
<%@page import="com.gf.model.controller.ClienteController"%>
<%@page import="com.gf.model.entity.Cliente"%>
<%@page import="java.util.ArrayList"%>
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
	ArrayList<Cliente> clientes = new ArrayList<Cliente>();
	ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
	String cod = request.getParameter("c");	
%>
<body>
	<%
		if (uLogado == null) {
	%>
	<h6>
		Você não tem acesso ao sistema <a href="index.jsp"
			style="color: #269abc">faça seu login.</a>
	</h6>
	<%
		} else if (uLogado.getPerfil() == 3) {
	%>
	<h6>
		Você não tem acesso a essa página <a href="#" onClick="history.go(-1)">
			<i class="fa fa-backward" aria-hidden="true"></i> voltar
		</a>
	</h6>
	<%
		} else {			
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
					class="nav-link dropdown-toggle" href="#" id="dropdown03"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Clientes</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="ins_cliente.jsp">Inserir</a> <a
							class="dropdown-item" href="clientes.jsp">Clientes</a>
					</div></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="dropdown03"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Produtos</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<% if(uLogado.getPerfil() == 1 ) { %>
				          <a class="dropdown-item" href="ins_produto.jsp">Inserir</a>
				         <% } %>
						<a class="dropdown-item" href="produtos.jsp">Produtos</a>
					</div></li>
				<%
					if (uLogado.getPerfil() == 1) {
				%>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="dropdown03"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Usuários</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="ins_usuario.jsp">Novo</a> <a
							class="dropdown-item" href="usuarios.jsp">Usuários</a> <a
							class="dropdown-item" href="log_acesso.jsp">Logs de Acesso</a>
					</div></li>
				<%
					}
				%>
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
						<%=uLogado.getNome()%>
				</a>
					<div class="dropdown-menu" aria-labelledby="dropdown03">
						<a class="dropdown-item" href="usuario.jsp">Meus Dados</a> <a
							class="dropdown-item" href="LogoutServlet">Sair</a>
					</div></li>
			</ul>
		</div>
	</nav><!-- fim nav -->

	<div class="col-sm-9 col-md-10 pt-3" role="main">
		<h5>
			Clientes <i class="fa fa-users" aria-hidden="true"></i>
		</h5>
		<hr />
		<div class="alerta">
			<%
				if (cod != null) {
			%>
			<%
				if (cod.equals("1")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro</strong> ao apagar Cliente no banco de dados. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> 
					<a href="clientes.jsp" class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("2")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao apagar Cliente. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("3")) {
			%>
			<div class="alert alert-success" role="alert">
				<strong>Cliente</strong> apagado com sucesso! <i class="fa fa-check"
					aria-hidden="true"></i> <a href="clientes.jsp" class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("4")) {
			%>
			<div class="alert alert-success" role="alert">
				<strong>Cliente</strong> atualizado com sucesso. <i
					class="fa fa-check" aria-hidden="true"></i> <a href="clientes.jsp"
					class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("5")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro</strong> ao atualizar Cliente no banco de dados. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("6")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao atualizar Cliente. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("7")) {
			%>
			<div class="alert alert-success" role="alert">
				<strong>Setor</strong> criado com sucesso. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("8")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro </strong> ao criar Setor no banco. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("9")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao criar Setor. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>
			<%
				} else if (cod.equals("10")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro </strong> ao apagar Setor no banco. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>	
			<%
				} else if (cod.equals("11")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao apagar Setor. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>	
			<%
				} else if (cod.equals("12")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro </strong> ao alterar Setor no banco. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>	
			<%
				} else if (cod.equals("13")) {
			%>
			<div class="alert alert-danger" role="alert">
				<strong>Erro inesperado</strong> ao alterar Setor. <i
					class="fa fa-exclamation-triangle" aria-hidden="true"></i> <a
					href="clientes.jsp" class="close">&times;</a>
			</div>				
			<%
				}
					}
			%>
		</div>
		<div class="container">
			<div class="row">
		     	<div class="col-sm-4" style="padding-left: 0">
		     	<form class="form-horizontal" method="post" action="clientes.jsp">
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
		     		<a href="clientes.jsp" class="link-box" title="recarregar tabela"><i class="fa fa-refresh" aria-hidden="true"></i></a>
		     	</div>
		     	<div class="col-sm-7"></div>
		     </div>
		     
		     <%
				String busca = request.getParameter("busca");
		     
				if(busca == null){
					if (uLogado.getPerfil() == 1) {
						clientes = ClienteController.getClientes();
					} else {
						clientes = ClienteController.getClientesPorUsuario(uLogado.getId());
					}
				} else {
					if (uLogado.getPerfil() == 1) {
						clientes = ClienteController.searchClientes(busca);						
					} else {
						clientes = ClienteController.searchClientesPorUsuario(busca, uLogado.getId());
					}
				}			
			%>
		     
			<div class="row">
				<div class="col-sm-12">
					<div class="card card-success det-cli">
						<div class="card-header det-cli-h">
							Lista de Clientes
							<div style="float: right">
								<a href="ins_cliente.jsp" class="link-box"> <i
									class="fa fa-plus" aria-hidden="true"></i> adicionar
								</a>
							</div>
						</div>
						<div class="card-block" style="max-height: 320px; overflow: auto;">
							<%
								if (clientes.isEmpty()) {
									if(busca != null) {
									 %>		 
									 	<p>Sua pesquisa "<%=busca%>" não encontrou nenhum registro.</p>
									 <% 	} else { %>	
									 	<p>Não há logs de acessos registrados</p>
								     <% }} else {
							%>
							<div class="table-responsive">
								<table class="table table-striped tab-tab">
									<thead class="thead-tab-usu">
										<th>Cliente</th>
										<th>Setores</th>
										<%
											if (uLogado.getPerfil() == 1) {
										%>
										<th>Representante</th>
										<%
											}
										%>
										<th>Cidade</th>
										<th>UF</th>
										<th>Equip.</th>
										<th>Editar</th>
										<th>Apagar</th>
									</thead>
									<tbody class="tbody-tab-usu">
										<%
											for (Cliente c : clientes) {
										%>
										<tr>
											<td><a id="link" href="SelCliente?id=<%=c.getId()%>&op=det"><%=c.getNome()%></a></td>
											
											<% 
												ArrayList<Setor> setores = SetorController.getSetoresPorCliente(c.getId()); 
												boolean cb = ContatoClienteController.isContCliente(c.getId());
												boolean eb = EquipamentoController.isEquipCliente(c.getId());
											%>
												
											<% if(setores.isEmpty()) { %>
												<% if(cb == true || eb == true) { %>
													<td><a href="#" data-toggle="modal" data-target="#infosetor" class="link-box-new" 
														title="regras para criação de setores">
													<i class="fa fa-info-circle" aria-hidden="true"></i></a></td>
												<% } else { %>
													<td><a href="#" data-toggle="modal" data-target="#addset" class="link-box-new"
														onclick="setSetorCli('<%=c.getId()%>','<%=c.getNome()%>')">
															criar setor</a></td>
												<% } %>													
											<% } else { %>											
												<td>
													<a href="#" data-toggle="modal" data-target="#addset" class="link-box-new"
													onclick="setSetorCli('<%=c.getId()%>','<%=c.getNome()%>')" title="criar novo setor">
															criar setor</a><br />									
													<% for(Setor s: setores) { %>
														<%= s.getSetor() %>													
														<a href="#" data-toggle="modal" data-target="#delset" class="link-box"
															onclick="upDelSetor('<%=s.getSetor()%>','<%=s.getId()%>')" title="apagar setor">
														<i class="fa fa-trash-o" aria-hidden="true"></i></a><br />													
													<% } %>	<!-- Fim do FOR -->
												</td>
											<% } %>																	
											
											<% if (uLogado.getPerfil() == 1) { %>
												<td><%=c.getUsuario().getNome()%></td>
											<% } %>
											
											<td><%=c.getCidade().getCidade()%></td>
											<td><%=c.getEstado().getUf()%></td>
											<td><a href="SelCliente?id=<%=c.getId()%>&op=eqs"
												class="link-box"> <i class="fa fa-cogs"
													aria-hidden="true"></i></a></td>
											<td><a href="#" data-toggle="modal"
												data-target="#updcli" class="link-box"
												onclick="setUpdCli('<%=c.getId()%>','<%=c.getNome()%>')">
													<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
											</a></td>
											<td><a href="#" data-toggle="modal"
												data-target="#delcli" class="link-box"
												onclick="setDelCli('<%=c.getNome()%>','<%=c.getId()%>')">
													<i class="fa fa-trash-o" aria-hidden="true"></i>
											</a></td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</div>
						<%
							}
						%>
						<div class="card-footer">
							<div class="row">
								<div class="col-sm-2">	  	   
								<a href="#" class="legenda btn btn-success" onClick="history.go(-1)"  style="font-size: 14px"> 
									<i class="fa fa-backward" aria-hidden="true"></i> voltar </a> 
								</div>	
								<div class="col-sm-10" align="right"><b><%= clientes.size() %> </b> 
								<% if(clientes.size() != 1) %> clientes registrados.<% else %> cliente registrado. 
								
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div><!-- fim main -->

	<script>
		function setDelCli(val1, val2) {
			document.getElementById('val1').value = val1;
			document.getElementById('val2').value = val2;
		}

		function setUpdCli(val3, val4) {
			document.getElementById('val3').value = val3;
			document.getElementById('val4').value = val4;
		}
		
		function setSetorCli(val5, val6) {
			document.getElementById('val5').value = val5;
			document.getElementById('val6').value = val6;
		}
		
		function upDelSetor(val7, val8) {
			document.getElementById('val7').value = val7;
			document.getElementById('val8').value = val8;
		}		
	</script>

	<hr />
	<div class="footer">
		<p class="rodape">&copy; 2017 Sistema de Gestão de Fluidos de Processo - All
			Lubrificantes.</p>
	</div>

	<div id="infosetor" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Criação de Setores</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body alert alert-warning" role="alert" align="justify">
					Este <strong>Cliente</strong> ja possui um contato e/ou equipamento cadastrados. Para se criar
					setores é necessário que não haja contatos e/ou equipamentos pre-cadastrados, sendo assim é preciso
					apaga-los, criar os setores, e então cadastra-los novamente em seus respectivos setores.									
				</div>				
			</div>
		</div>
	</div>


	<div id="delcli" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Apagar Cliente</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="panel-body">
						Tem certeza que deseja apagar o cliente?<br />
						<output type="text" name="val1" id="val1"></output>
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-sm-6" align="center">
						<form method="post" action="DeleteCliente">
							<input type="hidden" name="val2" id="val2">
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

	<div id="updcli" tabindex="-1" role="dialog"
	
	<%
		ArrayList<Cidade> cidades = CidadeController.getCidades();
		ArrayList<Estado> estadosCad = EstadoController.getEstadosIfCidade();
	%>
	
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Editar Cliente</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form class="form-horizontal" method="post" action="UpdateCliente">
					<div class="modal-body">
						<div class="panel-body">
							<input type="hidden" name="val3" id="val3">
							<div class="form-group">
								<label class="control-label col-sm-11" for="cliente">Cliente:
								</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" name="val4" id="val4" />
								</div>
							</div>
							<%
								if (uLogado.getPerfil() == 1) {
									
									usuarios = UsuarioController.getUsuarios();
							%>
							<div class="form-group">
								<label class="control-label col-sm-2" for="representante">Representante:
								</label>
								<div class="col-sm-12">
									<select class="form-control" name="usuario">
										<option value="">Selecione o Representante</option>
										<!-- Popula lista de representantes no select -->
										<%
											for (Usuario u : usuarios) {
										%>
										<% if(u.getPerfil() != 3) { %>
										<option value=<%=u.getId()%>><%=u.getNome()%></option>
										<%
											} }
										%>
									</select>
								</div>
							</div>
							<%
								} else {
							%>
							<input type="hidden" name="usuario" id="usuario"
								value=<%=uLogado.getId()%>>
							<%
								}
							%>
							<div class="form-group">
								<label class="control-label col-sm-2" for="estado">Estado:
								</label>
								<div class="col-sm-12">
									<select class="form-control" name="estado">
										<option value="">Selecione o Estado</option>
										<%
											for (Estado e : estadosCad) {
										%>
										<option value=<%=e.getId()%>><%=e.getEstado()%></option>
										<%
											}
										%>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-2" for="cidade">Cidade:
								</label>
								<div class="row">
									<div class="col-sm-12">
										<select class="form-control" name="cidade" id="cidade">
											<option value="">Selecione a Cidade</option>
											<%
												for (Cidade c : cidades) {
											%>
											<option class=<%=c.getEstado().getId()%>
												value=<%=c.getId()%>><%=c.getCidade()%></option>
											<%
												}
											%>
										</select>
									</div>
								</div>
							</div>

							<script type="text/javascript">
								$('[name="estado"]').click(
										function() {
											$('[name="cidade"] option').css(
													'display', 'none');
											$(
													'[name="cidade"] .'
															+ $(this).val())
													.css('display', '');
										});
							</script>

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
	
	<!-- Criar Setor -->
	
	<div id="addset" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Criar Setor - <output type="text" name="val6" id="val6"></output><br /></h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<form method="post" action="InsertSetor">					
					<div class="modal-body">				
						<input type="hidden" name="val5" id="val5">
						<div class="form-group">
							<label class="control-label col-sm-11" for="setor">Setor:
							</label>
							<div class="col-sm-12">
								<input type="text" class="form-control" name="setor" id="setor" />
							</div>
						</div>						
					</div>
					<div class="modal-footer">
						<div class="col-sm-12" align="center">
							<button type="submit" class="btn btn-success">
								salvar <i class="fa fa-save" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Editar ou apagar Setor -->
	
	<div id="delset" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
		<div class="modal-dialog modal-md">
			<div class="modal-content col-sm-10">
				<div class="modal-header">
					<h5 class="modal-title">Apagar Setor</h5>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="panel-body">
						Tem certeza que deseja apagar o Setor?<br />
						<output type="text" name="val7" id="val7"></output>
					</div>
				</div>
				<div class="modal-footer">
					<div class="col-sm-6" align="center">
						<form method="post" action="DeleteSetor">
							<input type="hidden" name="val8" id="val8">
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
