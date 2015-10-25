package DAO.Impl;

import java.sql.SQLException;
import com.mysql.jdbc.PreparedStatement;
import Model.Reembolso;

public class ReembolsoDaoImpMySQL extends DAO.banco.AcessoBDMySQL implements ReembolsoDaoInterface
{
	
	//Inserir Reembolso
	public void inserirReembolso(Reembolso r)
	{
		conectar();
		try
		{
			String insertReembolso = "insert into reembolso (codReembolso, bancoReembolso, agenciaReembolso, contaReembolso, codPassagem, cod_PassageiroTitular) values (?, ?, ?, ?, ?, ?)";
			PreparedStatement stm = null;
			
			stm = (PreparedStatement) con.prepareStatement(insertReembolso);
			
			stm.setInt(1, 0);
			stm.setString(2, r.getBancoReembolso());
			stm.setString(3, r.getAgenciaReembolso());
			stm.setString(4, r.getAgenciaReembolso());
			stm.setString(5, r.getContaReembolso());
			stm.setInt(6, r.getCodPassagem().getNumeroPassagem());
			stm.setInt(7, r.getCodPassageiroTitular().getCodPassageiro());
			
			stm.execute();
		}
		catch (SQLException e)
		{
			imprimeErro("Erro ao inserir reembolso", e.getMessage());
	        e.printStackTrace();
		}
		finally
		{
			fechar();
		}
	}
}
