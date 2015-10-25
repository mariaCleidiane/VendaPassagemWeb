package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import DAO.Impl.PassageiroDaoImplMySQL;
import DAO.Impl.PassageiroDaoInterface;
import DAO.banco.DaoFactory;
import Model.Aeronave;
import Model.Passageiro;
//import Model.Passagem;

public class PassageiroDAO
{
	
	//Cadastrar
	public void cadastrar (Passageiro p)
	{
		DaoFactory factory = DaoFactory.getInstance();
		PassageiroDaoInterface dao = factory.getPassageiroDaoImpl();
		dao.cadastrar(p);
	}

   			   
	//Altera Passageiro
	public void alterar(Passageiro passageiro) 
	{  
		DaoFactory factory = DaoFactory.getInstance();
		PassageiroDaoInterface dao = factory.getPassageiroDaoImpl();
		dao.alterar(passageiro);
	} 
			
   //Busca de Passageiro pelo CÓDIGO
   public Passageiro buscarCodObj(int cod)
   {
	   DaoFactory factory = DaoFactory.getInstance();
	   PassageiroDaoInterface dao = factory.getPassageiroDaoImpl();
	   return dao.buscarCodObj(cod);
   }
   
   //Busca todos os Passageiros
   public ArrayList<Passageiro> buscarTodos()
   {  
	   DaoFactory factory = DaoFactory.getInstance();
	   PassageiroDaoInterface dao = factory.getPassageiroDaoImpl();
	   return dao.buscarTodos();
   }
	   
	//Excluir
	public void excluir(int cod)
	{
		DaoFactory factory = DaoFactory.getInstance();
		PassageiroDaoInterface dao = factory.getPassageiroDaoImpl();
		dao.excluir(cod);
	}
	
	//Busca genérica
	 public ArrayList<Passageiro> buscarGenerico(int cod,  String nome, String sobrenome, String genero,
				 String rg, String cpf, String tratamento, int dia, int mes, int ano, String email,
				 String celular) 
				 {  
		      		DaoFactory factory = DaoFactory.getInstance();
		      		PassageiroDaoInterface dao = factory.getPassageiroDaoImpl();
		      		return dao.buscarGenerico(cod, nome, sobrenome, genero, rg, cpf, tratamento, dia, mes, ano, email, celular);
				 }
			
	
	 //Busca Passageiro por CPF ou RG.
	 public int buscarCodPassageiroCpfRg(String cpf, String rg)
	 {
				DaoFactory factory = DaoFactory.getInstance();
				PassageiroDaoInterface dao = factory.getPassageiroDaoImpl();
				return dao.buscarCodPassageiroCpfRg(cpf, rg);
	 }			

}
