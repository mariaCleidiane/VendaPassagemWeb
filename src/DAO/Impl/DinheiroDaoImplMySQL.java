package DAO.Impl;

import java.sql.SQLException;

import Model.Dinheiro;

import com.mysql.jdbc.PreparedStatement;

public class DinheiroDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements DinheiroDaoInterface
{
	public void cadastrarDinheiro(Dinheiro dinheiro)
	{
		   
		   conectar();  
		      try {  
		         String insert = "INSERT INTO dinheiro (codDinheiro, troco, valorPago, codPagamento) VALUES (null, ?, ?, ?)";
		    	 PreparedStatement stm = null;
		    	 
		    	stm = (PreparedStatement) con.prepareStatement(insert);
		    	
		    	stm.setDouble(1, dinheiro.getTroco());
		    	stm.setDouble(2, dinheiro.getValorPago());
		    	stm.setInt(3, (dinheiro.getCodPagamento().getCodPagamento()));  		    	
		    	stm.execute();
		    	 
		      } catch (SQLException e) 
		      	{  
		         imprimeErro("Erro ao inserir dinheiro", e.getMessage());
		         e.printStackTrace();
		      	} finally 
		      		{  
		      			fechar();  
		      		}

	}

}
