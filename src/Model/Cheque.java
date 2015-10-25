package Model;

import java.util.Set;

import DAO.ChequeDAO;

public class Cheque 
{
	private int codCheque;
	private String numeroCheque;
	private String banco;
	private String agencia;
	private String conta;
	private Pagamento codPagamento;
	private ChequeDAO chequeDAO = new ChequeDAO();
	
	//Código
	public int getCodCheque() 
	{
		return codCheque;
	}
	public void setCodCheque(int codCheque) 
	{
		this.codCheque = codCheque;
	}
	
	//Numero Cheque
	public String getNumeroCheque() 
	{
		return numeroCheque;
	}
	public void setNumeroCheque(String numeroCheque) 
	{
		this.numeroCheque = numeroCheque;
	}
	
	//Banco
	public String getBanco() 
	{
		return banco;
	}
	public void setBanco(String banco) 
	{
		this.banco = banco;
	}
	
	//Agencia
	public String getAgencia() 
	{
		return agencia;
	}
	public void setAgencia(String agencia) 
	{
		this.agencia = agencia;
	}
	
	//Número Conta
	public String getConta() 
	{
		return conta;
	}
	public void setConta(String conta) 
	{
		this.conta = conta;
	}
	
	//Código Pagamento
	public Pagamento getCodPagamento() 
	{
		return codPagamento;
	}
	public void setCodPagamento(Pagamento codPagamento) 
	{
		this.codPagamento = codPagamento;
	}

	public void cadastrarCheque() 
	{
		chequeDAO.cadastrarCheque(this);
	}
		
	
}
