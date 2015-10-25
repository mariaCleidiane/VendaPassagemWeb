package DAO;

import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import DAO.Impl.AeroportoDaoInterface;
import DAO.Impl.AssentoDaoInterface;
import DAO.banco.DaoFactory;
import Model.Aeronave;
import Model.Assento;

public class AssentoDAO
{
	
		   //Cadastrar
		   public void cadastrarAssento (Aeronave aeronave, int fileira, int coluna)
		   {
			   	DaoFactory factory = DaoFactory.getInstance();
				AssentoDaoInterface dao = factory.getAssentoDaoImpl();
				dao.cadastraAssento(aeronave, fileira, coluna);

		   }
		   		
		   //Excluir
			public void excluirAssento(int cod)
			{
				DaoFactory factory = DaoFactory.getInstance();
				AssentoDaoInterface dao = factory.getAssentoDaoImpl();
				dao.excluirAssento(cod);
			}
			
			//Excluir Aeronave
			public void excluirAeronave(int cod)
			{
				DaoFactory factory = DaoFactory.getInstance();
				AssentoDaoInterface dao = factory.getAssentoDaoImpl();
				dao.excluirAeronave(cod);
			}
			
			//Alterar Assento
			public void alterarAssento(Assento assento)
			{
				DaoFactory factory = DaoFactory.getInstance();
				AssentoDaoInterface dao = factory.getAssentoDaoImpl();
				dao.alterarAssento(assento);
			}
			
			//Buscar TODOS Assentos
			public ArrayList<Assento> buscaTodosAssentosAeronave(int codAeronave)
			{
				DaoFactory factory = DaoFactory.getInstance();
				AssentoDaoInterface dao = factory.getAssentoDaoImpl();
				return dao.buscarTodosAssentosAeronave(codAeronave);
			}
			
			//Buscar UM Assento
			public Assento buscaUmAssento(int cod)
			{
				DaoFactory factory = DaoFactory.getInstance();
				AssentoDaoInterface dao = factory.getAssentoDaoImpl();
				return dao.buscaUmAssento(cod);
			}
			
			//Busca QUANTIDADE de assentos DISPONÍVEIS
			public int buscarQtdDisponivelVoo(int codAeronave, int codVoo)
			{
				DaoFactory factory = DaoFactory.getInstance();
				AssentoDaoInterface dao = factory.getAssentoDaoImpl();
				return dao.buscarQtdDisponivelVoo(codAeronave, codVoo);
			}
			
			//Buscar TODOS Assentos
			public ArrayList<Assento> buscarTodosAssentosVoo(int codAeronave, int codVoo)
			{
				DaoFactory factory = DaoFactory.getInstance();
				AssentoDaoInterface dao = factory.getAssentoDaoImpl();
				return dao.buscarTodosAssentosVoo(codAeronave, codVoo);
			}
		 
}
