package DAO;

import DAO.Impl.CartaoDaoInterface;
import DAO.banco.DaoFactory;
import Model.Cartao;

public class CartaoDAO 
{
	//Cadastra Cart�o
	public void cadastrarCartao(Cartao cartao)
	{
		DaoFactory factory = DaoFactory.getInstance();
		CartaoDaoInterface dao = factory.getCartaoDaoImpl();
		dao.cadastrarCartao(cartao);
	}
		
}
