package Model;

import DAO.DinheiroDAO;


public class Dinheiro
{
	private int codDinheiro;
	private double troco;
	private double valorPago;
	private Pagamento codPagamento;
	private DinheiroDAO dinheiroDAO = new DinheiroDAO();
	
	//Código
	public int getCodDinheiro() 
	{
		return codDinheiro;
	}
	public void setCodDinheiro(int codDinheiro) 
	{
		this.codDinheiro = codDinheiro;
	}
	
	//Troco
	public double getTroco() 
	{
		return troco;
	}
	public void setTroco(double troco) 
	{
		this.troco = troco;
	}
	
	//Valor Pago
	public double getValorPago() 
	{
		return valorPago;
	}
	public void setValorPago(double valorPago) 
	{
		this.valorPago = valorPago;
	}
	
	//Codigo Pagamento
	public Pagamento getCodPagamento() 
	{
		return codPagamento;
	}
	public void setCodPagamento(Pagamento codPagamento) 
	{
		this.codPagamento = codPagamento;
	}
	
	public void cadastrarDinheiro() 
	{
		dinheiroDAO.cadastrarDinheiro(this);
	}
}
