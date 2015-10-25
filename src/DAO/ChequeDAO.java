package DAO;

import DAO.Impl.ChequeDaoInterface;
import DAO.banco.DaoFactory;
import Model.Cheque;

public class ChequeDAO 
{
	//Cadastra Cheque
	public void cadastrarCheque(Cheque cheque)
	{
		DaoFactory factory = DaoFactory.getInstance();
		ChequeDaoInterface dao = factory.getChequeDaoImpl();
		dao.cadastrarCheque(cheque);
	}
		
}
