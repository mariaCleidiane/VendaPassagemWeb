package Model;

import DAO.CartaoDAO;
import DAO.PagamentoDAO;

public class Cartao 
{
	private int codCartao;
	private String numeroCartao;
	private int mesValidade;
	private int anoValidade;
	private String bandeiraCartao;
	private String agenciaCartao;
	private int codSeguranca;
	private Pagamento codPagamento;
	private CartaoDAO cartaoDAO = new CartaoDAO();
	
	//Código 
	public int getCodCartao() 
	{
		return codCartao;
	}
	public void setCodCartao(int codCartao) 
	{
		this.codCartao = codCartao;
	}
	

	//Numero Cartao
	public String getNumeroCartao() 
	{
		return numeroCartao;
	}
	public void setNumeroCartao(String numeroCartao) 
	{
		this.numeroCartao = numeroCartao;
	}
	
	//Mes Validade
	public int getMesValidade() 
	{
		return mesValidade;
	}
	public void setMesValidade(int mesValidade) 
	{
		this.mesValidade = mesValidade;
	}
	
	//Ano Validade
	public int getAnoValidade() 
	{
		return anoValidade;
	}
	public void setAnoValidade(int anoValidade) 
	{
		this.anoValidade = anoValidade;
	}
	
	//Bandeira Cartão
	public String getBandeiraCartao() 
	{
		return bandeiraCartao;
	}
	public void setBandeiraCartao(String bandeiraCartao) 
	{
		this.bandeiraCartao = bandeiraCartao;
	}
	
	//Codigo de segurança
	public int getCodSeguranca() 
	{
		return codSeguranca;
	}
	public void setCodSeguranca(int codSeguranca) 
	{
		this.codSeguranca = codSeguranca;
	}
	
	//Cod pagamento
	public Pagamento getCodPagamento() 
	{
		return codPagamento;
	}
	public void setCodPagamento(Pagamento codPagamento) 
	{
		this.codPagamento = codPagamento;
	}
	public String getAgenciaCartao() {
		return agenciaCartao;
	}
	
	//Agencia Cartão
	public void setAgenciaCartao(String agenciaCartao) 
	{
		this.agenciaCartao = agenciaCartao;
	}
	

	public void cadastrarCartao() 
	{
		cartaoDAO.cadastrarCartao(this);
	}
}
