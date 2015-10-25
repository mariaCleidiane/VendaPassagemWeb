package DAO.Impl;

import java.sql.SQLException;

import com.mysql.jdbc.PreparedStatement;

import Model.Cheque;

public class ChequeDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements ChequeDaoInterface
{

	//Cadastra Cheque
	public void cadastrarCheque(Cheque cheque)
	{
		conectar();
		
		String insert = "INSERT INTO cheque (codCheque, numeroCheque, banco, agencia, conta, cod_Pagamento) values (null, ?, ?, ?, ?, ?)";
		PreparedStatement stm = null;
		
		try
		{
			stm = (PreparedStatement) con.prepareStatement(insert);
			
			stm.setString(1, cheque.getNumeroCheque());
			stm.setString(2, cheque.getBanco());
			stm.setString(3, cheque.getAgencia());
			stm.setString(4, cheque.getConta());
			stm.setInt(5, cheque.getCodPagamento().getCodPagamento());
			
		}
		catch (SQLException e)
		{
			imprimeErro("Erro ao inserir registro de Cheque", e.getMessage());
			e.printStackTrace();
		}
		finally
		{
			fechar();
		}
	}
}
