package Model;

import DAO.PagamentoDAO;

public class Pagamento 
{
	private int codPagamento;
	private Passageiro codPassageiroTitular;
	private int diaPagamento;
	private int mesPagamento;
	private int anoPagamento;
	private String tipoPagamento;
	private Passagem numeroPassagem;
	private PagamentoDAO  pagamentoDAO = new PagamentoDAO();
	
	//Código
	public int getCodPagamento() 
	{
		return codPagamento;
	}
	public void setCodPagamento(int codPagamento) 
	{
		this.codPagamento = codPagamento;
	}
	
	//Passageiro Titular
	public Passageiro getPassageiroTitular()
	{
		return codPassageiroTitular;
	}
	public void setPassageiroTitular(Passageiro passageiro)
	{
		codPassageiroTitular = passageiro;
	}
	
	//Dia Pagamento
	public int getDiaPagamento() 
	{
		return diaPagamento;
	}
	public void setDiaPagamento(int diaPagamento) 
	{
		this.diaPagamento = diaPagamento;
	}
	
	//Mes Pagamento
	public int getMesPagamento() 
	{
		return mesPagamento;
	}
	public void setMesPagamento(int mesPagamento) 
	{
		this.mesPagamento = mesPagamento;
	}
	
	//Ano Pagamento
	public int getAnoPagamento() 
	{
		return anoPagamento;
	}
	public void setAnoPagamento(int anoPagamento) 
	{
		this.anoPagamento = anoPagamento;
	}
	
	
	//Tipo Pagamento
	public String getTipoPagamento() 
	{
		return tipoPagamento;
	}
	public void setTipoPagamento(String tipoPagamento) 
	{
		this.tipoPagamento = tipoPagamento;
	}
	
	//Número Passagem
	public Passagem getNumeroPassagem() 
	{
		return numeroPassagem;
	}
	public void setNumeroPassagem(Passagem numeroPassagem) 
	{
		this.numeroPassagem = numeroPassagem;
	}
	
	public int cadastrarPagamento() 
	{
		return pagamentoDAO.cadastrarPagamento(this);
	}
	
	public void cadastrarPagamento(int codPassagem) 
	{
		pagamentoDAO.buscarCodObjPagamento(codPassagem);
	}
	
	
}
