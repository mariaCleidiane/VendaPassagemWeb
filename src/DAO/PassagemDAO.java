package DAO;

import DAO.Impl.PassagemDaoInterface;
import DAO.banco.DaoFactory;
import Model.Passagem;

import DAO.Impl.PassagemDaoInterface;
import DAO.banco.DaoFactory;
import Model.Passagem;

public class PassagemDAO 
{
	//Cadastra Passagem
	public int cadastrarPassagem(Passagem pass)
	{
		DaoFactory factory = DaoFactory.getInstance();
		PassagemDaoInterface dao = factory.getPassagemDaoImpl();
		return dao.cadastrarPassagem(pass);
	}
	
	//Busca Passagem
	public Passagem buscarPassagem(int numeroPassagem)
	{
		DaoFactory factory = DaoFactory.getInstance();
		PassagemDaoInterface dao = factory.getPassagemDaoImpl();
		return dao.buscarPassagem(numeroPassagem);
	}
	
	public void checkIn(Passagem pass)
	{
		DaoFactory factory = DaoFactory.getInstance();
		PassagemDaoInterface dao = factory.getPassagemDaoImpl();
		dao.checkIn(pass);
	}
	
	//Cancela Passagem (Exclui)
	public void cancelarPassagem(int codPassagem)
	{
		DaoFactory factory = DaoFactory.getInstance();
		PassagemDaoInterface dao = factory.getPassagemDaoImpl();
		dao.cancelarPassagem(codPassagem);
	}
		
		
		
}
