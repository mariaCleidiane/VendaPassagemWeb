package DAO.Impl;

import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

import Model.Cartao;

public class CartaoDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements CartaoDaoInterface
{
	//Cadastra Cartão
	public void cadastrarCartao(Cartao cartao)
	{
		conectar();
		
		String insert = "INSERT INTO cartao (codCartao, numeroCartao, mesValidade, anoValidade, bandeiraCartao, agenciaCartao, codSeguranca, cod_pagamento) VALUES (null, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement stm = null;
		
		try
		{
			stm = (PreparedStatement)con.prepareStatement(insert);
			
			stm.setString(1, cartao.getNumeroCartao());
			stm.setInt(2, cartao.getMesValidade());
			stm.setInt(3, cartao.getAnoValidade());
			stm.setString(4, cartao.getBandeiraCartao());
			stm.setString(5, cartao.getAgenciaCartao());
			stm.setInt(6, cartao.getCodSeguranca());
			stm.setInt(7, cartao.getCodPagamento().getCodPagamento());
		}
		catch(SQLException e)
		{
			imprimeErro("Não foi possível cadastrar registro", e.getMessage());
			e.printStackTrace();
		}
		finally
		{
			fechar();
		}
	}
}
