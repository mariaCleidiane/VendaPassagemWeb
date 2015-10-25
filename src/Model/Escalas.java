package Model;

public class Escalas 
{
	private int codEscalas;
	private Voo codVoo;
	private Aeroporto codAeroporto;
	
	public int getCodEscalas() 
	{
		return codEscalas;
	}
	public void setCodEscalas(int codEscalas) 
	{
		this.codEscalas = codEscalas;
	}
	
	public Voo getCodVoo() 
	{
		return codVoo;
	}
	public void setCodVoo(Voo codVoo) 
	{
		this.codVoo = codVoo;
	}
	
	public Aeroporto getCodAeroporto() 
	{
		return codAeroporto;
	}
	public void setCodAeroporto(Aeroporto codAeroporto)
	{
		this.codAeroporto = codAeroporto;
	}
}
