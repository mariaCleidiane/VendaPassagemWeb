package Model;

import java.util.ArrayList;
import java.util.Date;

import DAO.VooDAO;
import DAO.Impl.VooDaoInterface;
import DAO.banco.DaoFactory;

public class Voo
{
	private int codVoo;
	private int horaPartida;
	private int minutoPartida;
	private int diaPartida;
	private int mesPartida;
	private int anoPartida;	  
	private String situacaoVoo;
	private double precoVoo;
	private Aeroporto aeroportoOrigem;
	private Aeroporto aeroportoDestino;
	private Aeronave aeronaveVoo;
	
	//Aeroporto de origem
	public Aeroporto getAeroportoOrigem()
	{
		return aeroportoOrigem;
	}
	
	public void setAeroportoOrigem(Aeroporto aeroportoOrigem) 
	{
		this.aeroportoOrigem = aeroportoOrigem;
	}
	//-----------------------------------------------------------------------------------------------------------
	//Aeroporto Destino
	public Aeroporto getAeroportoDestino()
	{
		return aeroportoDestino;
	}
	public void setAeroportoDestino(Aeroporto aeroportoDestino)
	{
		this.aeroportoDestino = aeroportoDestino;
	}
	
	//-----------------------------------------------------------------------------------------------------------
	//AeronaveVoo
	public Aeronave getAeronaveVoo() 
	{
		return aeronaveVoo;
	}
	
	public void setAeronaveVoo(Aeronave aeronaveVoo) 
	{
		this.aeronaveVoo = aeronaveVoo;
	}
	
	//-------------------------------------------------------------------------------------------------------------

	//Código Voo
	public int getCodVoo()
	{
		return codVoo;
	}
	public void setCodVoo(int codVoo) 
	{
		this.codVoo = codVoo;
	}
	
	//------------------------------------------------------------------------------------------------------------------------
	//Origem Voo
	/*
	public int getCodOrigem() 
	{
		return codOrigem;
	}
	public void setCodOrigem(int codOrigem) 
	{
		this.codOrigem = codOrigem;
	}
	*/
	//---------------------------------------------------------------------------------------------------------------------------
	//
	/*Destino Voo
	public void setCodDestino(int codDestino) 
	{
		this.codDestino = codDestino;
	}
	public void setCodEscalas(int codEscalas) 
	{
		this.codEscalas = codEscalas;
	}
	
	*/
	//--------------------------------------------------------------------------------------------------------------------------
	/*
	/Escalas
	public int getCodEscalas()
	{
		return codEscalas;
	}
	public int getCodDestino() 
	{
		return codDestino;
	}
	//---------------------------------------------------------------------------------------------------------------------------
	//Código Aeronave
	public int getCodAeronave() 
	{
		return codAeronave;
	}
	public void setCodAeronave(int codAeronave) 
	{
		this.codAeronave = codAeronave;
	}

	/
	 * /--------------------------------------------------------------------------------------------------------------------------
	 */
	//Situação
	public String getSituacaoVoo() 
	{
		return situacaoVoo;
	}
	public void setSituacaoVoo(String situacaoVoo) 
	{
		this.situacaoVoo = situacaoVoo;
	}

	//-----------------------------------------------------------------------------------------------------------------------------
	//Hora partida
	public int getHoraPartida() 
	{
		return horaPartida;
	}
	public void setHoraPartida(int horaPartida) 
	{
		this.horaPartida = horaPartida;
	}
	
	//------------------------------------------------------------------------------------------------------------------------------
	//Minuto partida
	public int getMinutoPartida() 
	{
		return minutoPartida;
	}
	public void setMinutoPartida(int minutoPartida) 
	{
		this.minutoPartida = minutoPartida;
	}
		
	//--------------------------------------------------------------------------------------------------------------------------
	//Dia partida
	public int getDiaPartida() 
	{
		return diaPartida;
	}
	public void setDiaPartida(int diaPartida) 
	{
		this.diaPartida = diaPartida;
	}
	
	//--------------------------------------------------------------------------------------------------------------------------
	//Mês Partida
	public int getMesPartida() 
	{
		return mesPartida;
	}
	public void setMesPartida(int mesPartida) 
	{
		this.mesPartida = mesPartida;
	}
	
	//--------------------------------------------------------------------------------------------------------------------------
	//Ano Partida
	public int getAnoPartida() 
	{
		return anoPartida;
	}
	public void setAnoPartida(int anoPartida) 
	{
		this.anoPartida = anoPartida;
	}
	
	//---------------------------------------------------------------------------------------------------------------------------
	//Get e Set Preço do Voo(Passagem)
	
	public double getPrecoVoo()
	{
		return precoVoo;
	}
	
	public void setPrecoVoo(double precoVoo)
	{
		this.precoVoo = precoVoo;
	}
	
	
	public String toString()
	{
		
		return (codVoo + "- De: "+ aeroportoOrigem.getNomeAeroporto()+"/ Para: "+aeroportoDestino.getNomeAeroporto());
	}
	
	//--------------------------------------------------------------------
	//Metodos BD
	//Cadastrar
		 public void cadastrarVoo(Voo voo)
		 {
			 VooDAO vooDAO = new VooDAO();
			 vooDAO.cadastrarVoo(voo);
		 }
			   
		  //Add escalas
		  public void addEscalas(Escalas esc)
		  {
			  VooDAO vooDAO = new VooDAO();
			  vooDAO.addEscalas(esc);
		  }
		 
			
		  //Excluir
		   public void excluir(int cod)
		   {
			   VooDAO vooDAO = new VooDAO();
			   vooDAO.excluir(cod);
		   }
			   
		   //Buscar todos
		    public ArrayList<Voo> buscarTodos()
		    {  
		    	VooDAO vooDAO = new VooDAO();
		    	return vooDAO.buscarTodos();
		    }
			    
		    //Buscar pelo Código
		    public ArrayList<Voo> buscarTodosCodigo(int cod) 
		    {  
		    	VooDAO vooDAO = new VooDAO();
		    	return vooDAO.buscarTodosCodigo(cod);
		    }
		    
			//Busca pelo Código e retorna um Objeto
		    public Voo buscarTodosCodigoObjt(int cod) 
		    {  
		    	VooDAO vooDAO = new VooDAO();
		    	return vooDAO.buscarTodosCodigoObjt(cod);
		    }
			
		    
		    //Busca genérica
		    public ArrayList<Voo> buscaGenericaVoo (int cod, int codOrigem, int codDestino, int horaPartida,
		    										int minPartida, int diaPartida, int mesPartida, int anoPartida, 
		    										int codAeronave, String status, double preco)
			{
		    	VooDAO vooDAO = new VooDAO();
		    	return vooDAO.buscaGenericaVoo(cod, codOrigem, codDestino, horaPartida, minPartida, diaPartida, mesPartida, anoPartida, codAeronave, status, preco);
			}
			    	
		  
		    //Alterar Voo
		    public void alterar(Voo voo)
		    {
		    	VooDAO vooDAO = new VooDAO();
		    	vooDAO.alterar(voo);
		    }
			
		    //LoadJSON
		    
	
}
