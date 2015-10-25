package Model;

import DAO.ReembolsoDAO;

public class Reembolso
{
	private int codReembolso;
	private String bancoReembolso;
	private String agenciaReembolso;
	private String contaReembolso;
	private Passagem codPassagem;
	private Passageiro codPassageiroTitular;
	
	//codReembolso
	public int getCodReembolso() 
	{
		return codReembolso;
	}
	public void setCodReembolso(int codReembolso) 
	{
		this.codReembolso = codReembolso;
	}
	
	//Banco
	public String getBancoReembolso() 
	{
		return bancoReembolso;
	}
	public void setBancoReembolso(String bancoReembolso) 
	{
		this.bancoReembolso = bancoReembolso;
	}
	
	//Agencia
	public String getAgenciaReembolso() 
	{
		return agenciaReembolso;
	}
	public void setAgenciaReembolso(String agenciaReembolso) 
	{
		this.agenciaReembolso = agenciaReembolso;
	}
	
	//Conta
	public String getContaReembolso()
	{
		return contaReembolso;
	}
	public void setContaReembolso(String contaReembolso)
	{
		this.contaReembolso = contaReembolso;
	}
	
	//Cod Passagem
	public Passagem getCodPassagem() 
	{
		return codPassagem;
	}
	public void setCodPassagem(Passagem codPassagem) 
	{
		this.codPassagem = codPassagem;
	}
	
	//Cod Passageiro
	public Passageiro getCodPassageiroTitular() 
	{
		return codPassageiroTitular;
	}
	public void setCodPassageiroTitular(Passageiro codPassageiro) 
	{
		this.codPassageiroTitular = codPassageiro;
	}
	//--------------------------------------------------------------------------------------------------------
	//Métodos BD
	
	//Inserir Reembolso
		public void inserirReembolso(Reembolso r)
		{
			ReembolsoDAO reembolsoDAO = new ReembolsoDAO();
			reembolsoDAO.inserirReembolso(this);
		}
}
