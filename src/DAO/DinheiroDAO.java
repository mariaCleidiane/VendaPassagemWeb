package DAO;

import DAO.Impl.DinheiroDaoInterface;
import DAO.banco.DaoFactory;
import Model.Dinheiro;

public class DinheiroDAO 
{
	//Cadastra Dinheiro no Banco
	public void cadastrarDinheiro(Dinheiro dinheiro)
	{
	   	DaoFactory factory = DaoFactory.getInstance();
	   	DinheiroDaoInterface dao = factory.getDinheiroDaoImpl();
		dao.cadastrarDinheiro(dinheiro);
	}
}
