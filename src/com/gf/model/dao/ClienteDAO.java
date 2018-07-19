package com.gf.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gf.connection.Conexao;
import com.gf.model.entity.Cliente;

public class ClienteDAO {
	
	public static void insCliente(Cliente c) throws Exception, SQLException{
		
		String query = "INSERT INTO cliente(cli_nome, cli_usuario, cli_cidade, cli_estado) VALUES (?,?,?,?) ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
		pst.setString(1, c.getNome());
		pst.setInt(2, c.getUsuario().getId());
		pst.setInt(3, c.getCidade().getId());
		pst.setInt(4, c.getEstado().getId());
		pst.executeUpdate();
		
		ResultSet rs = pst.getGeneratedKeys();
		if(rs.next()) {
			c.setId(rs.getInt(1));
		}
		
		con.close();
		pst.close();
		rs.close();
	}
	
	public static Cliente getCliente(int id) throws Exception, SQLException{
		
		String query = "SELECT cli_nome, cli_usuario, cli_cidade, cli_estado FROM cliente WHERE cli_id = ?";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		Cliente c = null;
		
		if(rs.next()) {
			c = new Cliente();
			c.setId(id);
			c.setNome(rs.getString("cli_nome"));
			c.setUsuario(UsuarioDAO.getUsuario(rs.getInt("cli_usuario")));
			c.setCidade(CidadeDAO.getCidade(rs.getInt("cli_cidade")));
			c.setEstado(EstadoDAO.getEstado(rs.getInt("cli_estado")));
		}
		
		con.close();
		pst.close();
		rs.close();
		
		return c;
	}
	
	public static ArrayList<Cliente> getClientes() throws Exception, SQLException{
		
		String query = "SELECT cli_id, cli_nome, cli_usuario, cli_cidade, cli_estado FROM cliente ORDER BY cli_nome";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Cliente> clientes = new ArrayList<>();
		Cliente c = null;
		
		while(rs.next()) {
			c = new Cliente();
			c.setId(rs.getInt("cli_id"));
			c.setNome(rs.getString("cli_nome"));
			c.setUsuario(UsuarioDAO.getUsuario(rs.getInt("cli_usuario")));
			c.setCidade(CidadeDAO.getCidade(rs.getInt("cli_cidade")));
			c.setEstado(EstadoDAO.getEstado(rs.getInt("cli_estado")));
			clientes.add(c);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return clientes;
	}
	
	public static ArrayList<Cliente> getClientesPorUsuario(int id) throws Exception, SQLException{
		
		String query = "SELECT cli_id, cli_nome, cli_usuario, cli_cidade, cli_estado FROM cliente WHERE cli_usuario = ? ORDER BY cli_nome";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Cliente> clientes = new ArrayList<>();
		Cliente c = null;
		
		while(rs.next()) {
			c = new Cliente();
			c.setId(rs.getInt("cli_id"));
			c.setNome(rs.getString("cli_nome"));
			c.setUsuario(UsuarioDAO.getUsuario(rs.getInt("cli_usuario")));
			c.setCidade(CidadeDAO.getCidade(rs.getInt("cli_cidade")));
			c.setEstado(EstadoDAO.getEstado(rs.getInt("cli_estado")));
			clientes.add(c);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return clientes;
	}
	
	public static ArrayList<Cliente> searchClientes(String busca) throws Exception, SQLException{
		
		String query = "SELECT c.cli_id, c.cli_nome, c.cli_usuario, c.cli_cidade, c.cli_estado FROM cliente AS c " + 
				"INNER JOIN cidade AS cid ON c.cli_cidade = cid.cid_id INNER JOIN estado AS e ON " + 
				"c.cli_estado = e.est_id INNER JOIN usuario AS u ON c.cli_usuario = u.usu_id "
				+ " WHERE (c.cli_nome LIKE ? OR u.usu_nome LIKE ? OR cid.cid_nome LIKE ? OR e.est_uf LIKE ? ) ORDER BY cli_nome ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, "%"+busca+"%");
		pst.setString(2, "%"+busca+"%");
		pst.setString(3, "%"+busca+"%");
		pst.setString(4, "%"+busca+"%");
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Cliente> clientes = new ArrayList<>();
		Cliente c = null;
		
		while(rs.next()) {
			c = new Cliente();
			c.setId(rs.getInt("cli_id"));
			c.setNome(rs.getString("cli_nome"));
			c.setUsuario(UsuarioDAO.getUsuario(rs.getInt("cli_usuario")));
			c.setCidade(CidadeDAO.getCidade(rs.getInt("cli_cidade")));
			c.setEstado(EstadoDAO.getEstado(rs.getInt("cli_estado")));
			clientes.add(c);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return clientes;
	}
	
	public static ArrayList<Cliente> searchClientesPorUsuario(String busca, int id) throws Exception, SQLException{
		
		String query = "SELECT c.cli_id, c.cli_nome, c.cli_usuario, c.cli_cidade, c.cli_estado FROM cliente AS c " + 
				"INNER JOIN cidade AS cid ON c.cli_cidade = cid.cid_id INNER JOIN estado AS e ON " + 
				"c.cli_estado = e.est_id WHERE (c.cli_nome LIKE ? OR cid.cid_nome LIKE ? OR e.est_uf LIKE ? ) ORDER BY cli_nome "
				+ " AND c.cli_usuario = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, "%"+busca+"%");
		pst.setString(2, "%"+busca+"%");
		pst.setString(3, "%"+busca+"%");
		pst.setInt(4, id);
		ResultSet rs = pst.executeQuery();
		
		ArrayList<Cliente> clientes = new ArrayList<>();
		Cliente c = null;
		
		while(rs.next()) {
			c = new Cliente();
			c.setId(rs.getInt("cli_id"));
			c.setNome(rs.getString("cli_nome"));
			c.setUsuario(UsuarioDAO.getUsuario(rs.getInt("cli_usuario")));
			c.setCidade(CidadeDAO.getCidade(rs.getInt("cli_cidade")));
			c.setEstado(EstadoDAO.getEstado(rs.getInt("cli_estado")));
			clientes.add(c);
		}	
		
		con.close();
		pst.close();
		rs.close();
		
		return clientes;
	}
	
	public static void updateNomeCliente(Cliente c) throws Exception, SQLException{
		
		String query = "UPDATE cliente SET cli_nome = ?, cli_usuario = ?, cli_cidade = ?, cli_estado = ? WHERE cli_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setString(1, c.getNome());
		pst.setInt(2, c.getUsuario().getId());
		pst.setInt(3, c.getCidade().getId());
		pst.setInt(4, c.getEstado().getId());
		pst.setInt(5, c.getId());
		pst.executeUpdate();
		
		con.close();
		pst.close();	
	}
	
	public static void deleteCliente(int id) throws Exception, SQLException{
		
		String query = "DELETE FROM cliente WHERE cli_id = ? ";
		
		Connection con = Conexao.getConnection();
		PreparedStatement pst = con.prepareStatement(query);
		pst.setInt(1, id);
		pst.executeUpdate();
		
		con.close();
		pst.close();	
	}

}
