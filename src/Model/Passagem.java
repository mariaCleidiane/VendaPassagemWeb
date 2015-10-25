package Model;

import DAO.PassagemDAO;


public class Passagem 
{
	private int numeroPassagem;
	private double valorPassagem;
	private double taxaEmbarque;
	private String tipoPassagem;
	private boolean checkIn;
	private int assentoPassagem;
	private String ticketBagagem;
	private Passageiro passageiro;
	private Voo voo;
	private PassagemDAO passDAO = new PassagemDAO();
	
	//Número da passagem
	public int getNumeroPassagem() 
	{
		return numeroPassagem;
	}
	public void setNumeroPassagem(int numeroPassagem) 
	{
		this.numeroPassagem = numeroPassagem;
	}
	
	//Valor Passagem
	public double getValorPassagem() 
	{
		return valorPassagem;
	}
	public void setValorPassagem(double valorPassagem) 
	{
		this.valorPassagem = valorPassagem;
	}
	
	//Taxa Embarque
	public double getTaxaEmbarque() 
	{
		return taxaEmbarque;
	}
	public void setTaxaEmbarque(double taxaEmbarque) 
	{
		this.taxaEmbarque = taxaEmbarque;
	}
	
	//Tipo Passagem
	public String getTipoPassagem() 
	{
		return tipoPassagem;
	}
	public void setTipoPassagem(String tipoPassagem) 
	{
		this.tipoPassagem = tipoPassagem;
	}
	
	//CheckIn
	public boolean isCheckIn()
	{
		return checkIn;
	}
	public void setCheckIn(boolean checkIn)
	{
		this.checkIn = checkIn;
	}
	
	//Assento Passagem
	public int getAssentoPassagem() 
	{
		return assentoPassagem;
	}
	public void setAssentoPassagem(int assentoPassagem) 
	{
		this.assentoPassagem = assentoPassagem;
	}
	
	
	//Ticket Bagagem
	public String getTicketBagagem() 
	{
		return ticketBagagem;
	}
	public void setTicketBagagem(String ticketBagagem) 
	{
		this.ticketBagagem = ticketBagagem;
	}
	
	//Passageiro
	public Passageiro getPassageiro() 
	{
		return passageiro;
	}
	public void setPassageiro(Passageiro passageiro) 
	{
		this.passageiro = passageiro;
	}
	
	//Voo
	public Voo getVoo() 
	{
		return voo;
	}
	public void setVoo(Voo voo) 
	{
		this.voo = voo;
	}
	
	//-----------------------------------------------------------------------------------------------
	//Métodos BD
	public Passagem buscarPassagem(int codPassagem)
	{
		return passDAO.buscarPassagem(codPassagem);
	}
	
	public void checkIn()
	{
		passDAO.checkIn(this);
	}
	
	public int cadastrarPassagem()
	{
		return passDAO.cadastrarPassagem(this);
	}
	
}
