package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.mysql.jdbc.PreparedStatement;

import DAO.Impl.VooDaoInterface;
import DAO.banco.DaoFactory;
import Model.Aeronave;
import Model.Aeroporto;
import Model.Escalas;
import Model.Voo;

public class VooDAO
{
	//Cadastrar
	 public void cadastrarVoo(Voo voo)
	 {
		 DaoFactory factory = DaoFactory.getInstance();
		 VooDaoInterface dao = factory.getVooDaoImpl();
		 dao.cadastrarVoo(voo);
	 }
		   
	  //Add escalas
	  public void addEscalas(Escalas esc)
	  {
		  DaoFactory factory = DaoFactory.getInstance();
		  VooDaoInterface dao = factory.getVooDaoImpl();
		  dao.addEscalas(esc);
	  }
	 
		
	  //Excluir
	   public void excluir(int cod)
	   {
		   DaoFactory factory = DaoFactory.getInstance();
		   VooDaoInterface dao = factory.getVooDaoImpl();
		   dao.excluir(cod);
	   }
		   
	   //Buscar todos
	    public ArrayList<Voo> buscarTodos()
	    {  
	    	DaoFactory factory = DaoFactory.getInstance();
	    	VooDaoInterface dao = factory.getVooDaoImpl();
	    	return dao.buscarTodos();
	    }
		    
	    //Buscar pelo Código
	    public ArrayList<Voo> buscarTodosCodigo(int cod) 
	    {  
	    	DaoFactory factory = DaoFactory.getInstance();
	    	VooDaoInterface dao = factory.getVooDaoImpl();
	    	return dao.buscarTodosCodigo(cod);
	    }
	    
		//Busca pelo Código e retorna um Objeto
	    public Voo buscarTodosCodigoObjt(int cod) 
	    {  
	    	DaoFactory factory = DaoFactory.getInstance();
	    	VooDaoInterface dao = factory.getVooDaoImpl();
	    	return dao.buscarTodosCodigoObjt(cod);
	    }
		
	    
	    //Busca genérica
	    public ArrayList<Voo> buscaGenericaVoo (int cod, int codOrigem, int codDestino, int horaPartida,
	    										int minPartida, int diaPartida, int mesPartida, int anoPartida, 
	    										int codAeronave, String status, double preco)
		{
		    DaoFactory factory = DaoFactory.getInstance();
		    VooDaoInterface dao = factory.getVooDaoImpl();
		    return dao.buscaGenericaVoo(cod, codOrigem, codDestino, horaPartida, minPartida, diaPartida, mesPartida, anoPartida, codAeronave, status, preco);
		}
		    	
	  
	    //Controlar Status Voo
	    public void alterar(Voo voo)
	    {
	    	DaoFactory factory = DaoFactory.getInstance();
	    	VooDaoInterface dao = factory.getVooDaoImpl();
	    	dao.alterar(voo);
	    }
		
	
		
}
