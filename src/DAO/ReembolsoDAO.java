package DAO;

import DAO.Impl.ReembolsoDaoInterface;
import DAO.banco.DaoFactory;
import Model.Reembolso;

public class ReembolsoDAO 
{
	//Inserir Reembolso
	public void inserirReembolso(Reembolso r)
	{
		DaoFactory factory = DaoFactory.getInstance();
		ReembolsoDaoInterface dao = factory.getReembolsoDaoImpl();
		dao.inserirReembolso(r);
	}
		
}
