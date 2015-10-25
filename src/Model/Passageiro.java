package Model;

import java.util.ArrayList;

import DAO.PassageiroDAO;
import DAO.Impl.PassageiroDaoInterface;
import DAO.banco.DaoFactory;

public class Passageiro
{
	
	private String CPF;
	private String RG;
	private int codPassageiro;
	private String nomePassageiro;
	private String sobrenomePassageiro;
	private String tratamentoPassageiro;
	private int diaNascimento;
	private int mesNascimento;
	private int anoNascimento;
	private String celularPassageiro;
	private String emailPassageiro;
	private String generoPassageiro;
	private PassageiroDAO passageiroDAO;
	
	//Código Passagiero
	public int getCodPassageiro()
	{
		return codPassageiro;
	}
	public void setCodPassageiro(int codPassageiro)
	{
		this.codPassageiro = codPassageiro;
	}
	
	//Nome Passageiro
	public String getNomePassageiro() 
	{
		return nomePassageiro;
	}
	public void setNomePassageiro(String nomePassageiro) 
	{
		this.nomePassageiro = nomePassageiro;
	}
	
	//Sobrenome Passageiro
	public String getSobrenomePassageiro() 
	{
		return sobrenomePassageiro;
	}
	public void setSobrenomePassageiro(String sobrenomePassageiro) 
	{
		this.sobrenomePassageiro = sobrenomePassageiro;
	}
	
	//Genero Passageiro
	public String getGeneroPassageiro() 
	{
		return generoPassageiro;
	}
	public void setGeneroPassageiro(String generoPassageiro) {

		this.generoPassageiro = generoPassageiro;
	}

	
	//Tratamento Passageiro
	public String getTratamentoPassageiro() 
	{
		return tratamentoPassageiro;
	}
	public void setTratamentoPassageiro(String tramentoPassageiro) 
	{
		this.tratamentoPassageiro = tramentoPassageiro;
	}
	
	//RG
	public String getRG() 
	{
		return RG;
	}
	public void setRG(String RG) 
	{
		this.RG = RG;
	}
	
	//CPF
	public String getCPF() 
	{
		return CPF;
	}
	public void setCPF(String CPF) 
	{
		this.CPF = CPF;
	}
	
	//Dia Nascimento
	public int getDiaNascimento() 
	{
		return diaNascimento;
	}
	public void setDiaNascimento(int diaNascimento) 
	{
		this.diaNascimento = diaNascimento;
	}
	
	//Mes Nascimento
	public int getMesNascimento() 
	{
		return mesNascimento;
	}
	public void setMesNascimento(int mesNascimento) 
	{
		this.mesNascimento = mesNascimento;
	}
	
	//Ano Nascimento
	public int getAnoNascimento() 
	{
		return anoNascimento;
	}
	public void setAnoNascimento(int anoNascimento) 
	{
		this.anoNascimento = anoNascimento;
	}
	
	//Celular
	public String getCelularPassageiro() 
	{
		return celularPassageiro;
	}
	public void setCelularPassageiro(String celularPassageiro) 
	{
		this.celularPassageiro = celularPassageiro;
	}
	
	//E-mail
	public String getEmailPassageiro() {
		return emailPassageiro;
	}
	public void setEmailPassageiro(String emailPassageiro) {
		this.emailPassageiro = emailPassageiro;
	}
	
	public String toString() 
	{
		return (getCodPassageiro() + " - " + getNomePassageiro());
	}
	
	//---------------------------------------------------------------------------------------------------------------
	//Métodos de BD
	
	//Cadastrar
		public void cadastrar (Passageiro p)
		{
			passageiroDAO = new PassageiroDAO();
			passageiroDAO.cadastrar(p);
		}

	   			   
		//Altera Passageiro
		public void alterar(Passageiro passageiro) 
		{  
			passageiroDAO = new PassageiroDAO();
			passageiroDAO.alterar(passageiro);
		} 
				
	   //Busca de Passageiro pelo CÓDIGO
	   public Passageiro buscarCodObj(int cod)
	   {
		   passageiroDAO = new PassageiroDAO();
		   return passageiroDAO.buscarCodObj(cod);
	   }
	   
	   //Busca todos os Passageiros
	   public ArrayList<Passageiro> buscarTodos()
	   {  
		   passageiroDAO = new PassageiroDAO();
		   return passageiroDAO.buscarTodos();
	   }
		   
		//Excluir
		public void excluir(int cod)
		{
			passageiroDAO = new PassageiroDAO();
			passageiroDAO.excluir(cod);
		}
		
		//Busca genérica
		 public ArrayList<Passageiro> buscarGenerico(int cod,  String nome, String sobrenome, String genero,
					 String rg, String cpf, String tratamento, int dia, int mes, int ano, String email,
					 String celular) 
					 {  
			 				passageiroDAO = new PassageiroDAO();
			 				return passageiroDAO.buscarGenerico(cod, nome, sobrenome, genero, rg, cpf, tratamento, dia, mes, ano, email, celular);
					 }
				
		
		 //Busca Passageiro por CPF ou RG.
		 public int buscarCodPassageiroCpfRg(String cpf, String rg)
		 {
			 passageiroDAO = new PassageiroDAO();
			 return passageiroDAO.buscarCodPassageiroCpfRg(cpf, rg);
		 }			

}
