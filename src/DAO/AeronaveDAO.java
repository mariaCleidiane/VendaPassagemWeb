package DAO;

import java.util.ArrayList;

import javax.servlet.jsp.tagext.TryCatchFinally;

import DAO.Impl.AeronaveDaoInterface;
import DAO.banco.DaoFactory;
import Model.Aeronave;

public class AeronaveDAO
{
	//Excluir Aeronave
	public void excluir(int cod)
	{

		DaoFactory factory = DaoFactory.getInstance();
		 AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		dao.excluir(cod);
		
	}
	
	//Cadastrar Aeronave
	public void cadastrar(Aeronave aeronave)
	{
		DaoFactory factory = DaoFactory.getInstance();
		 AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		dao.cadastrar(aeronave);
	}
	
	//Alterar Aeronave
	public void alterar(Aeronave aeronave)
	{
		DaoFactory factory = DaoFactory.getInstance();
		 AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		dao.alterar(aeronave);
	}
		
	//Busca TODAS as Aeronaves e retorna um ARRAYLIST
	public ArrayList<Aeronave> buscarTodos()
	{
		DaoFactory factory = DaoFactory.getInstance();
		AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		return dao.buscarTodos();
	}
	
	public ArrayList<Aeronave> buscarCod(int cod)
	{
		DaoFactory factory = DaoFactory.getInstance();
		AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		return dao.buscarCod(cod);
	}
	
	public Aeronave buscarCodObj(int cod)
	{
		DaoFactory factory = DaoFactory.getInstance();
		AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		return dao.buscarCodObj(cod);
	}
	
	public ArrayList<Aeronave> buscarNome(String nome)
	{
		DaoFactory factory = DaoFactory.getInstance();
		 AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		 return dao.buscarNome(nome);
	}
	
	public ArrayList<Aeronave> buscarAssento(int assento)
	{
		DaoFactory factory = DaoFactory.getInstance();
		 AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		 return dao.buscarAssento(assento);
	}
	
	public ArrayList<Aeronave> buscarFileiras(int fileira)
	{
		DaoFactory factory = DaoFactory.getInstance();
		 AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		return dao.buscarFileiras(fileira);
	}
	
	public ArrayList<Aeronave> buscarGenerico(int cod,  String nome,  String modelo, int assento, int fileira)
	{
		DaoFactory factory = DaoFactory.getInstance();
		AeronaveDaoInterface dao = factory.getAeronaveDaoImpl();
		return dao.buscarGenerico(cod, nome, modelo, assento, fileira);
	}
}
