package Model;

import java.util.ArrayList;

import DAO.AeroportoDAO;
import DAO.Impl.AeroportoDaoInterface;
import DAO.banco.DaoFactory;

public class Aeroporto 
{
	private int codAeroporto;
	private String nomeAeroporto;
	private String siglaAeroporto;
	private String icao;
	private String estadoAeroporto;
	private String cidadeAeroporto;
	private AeroportoDAO aeroportoDAO;
	
	public Aeroporto()
	{
		siglaAeroporto = "";
		icao = "";
		estadoAeroporto = "";
		cidadeAeroporto = "";
		
	}
	
	public String getIcao() 
	{
		return icao;
	}
	public void setIcao(String icao) 
	{
		this.icao = icao;
	}

	
	public int getCodAeroporto() 
	{
		return codAeroporto;
	}
	public void setCodAeroporto(int codAeroporto) 
	{
		this.codAeroporto = codAeroporto;
	}
	
	
	
	public String getNomeAeroporto() 
	{
		return nomeAeroporto;
	}
	public void setNomeAeroporto(String nomeAeroporto) 
	{
		this.nomeAeroporto = nomeAeroporto;
	}
	
	
	public String getSiglaAeroporto() 
	{
		return siglaAeroporto;
	}
	public void setSiglaAeroporto(String siglaAeroporto) 
	{
		this.siglaAeroporto = siglaAeroporto;
	}
	
	
	public String getEstadoAeroporto() 
	{
		return estadoAeroporto;
	}
	public void setEstadoAeroporto(String estadoAeroporto) 
	{
		this.estadoAeroporto = estadoAeroporto;
	}
	
	
	public String getCidadeAeroporto() 
	{
		return cidadeAeroporto;
	}
	public void setCidadeAeroporto(String cidadeAeroporto) 
	{
		this.cidadeAeroporto = cidadeAeroporto;
	}
	
	public String toString()
	{
		return (getEstadoAeroporto() + " - " + getNomeAeroporto() + " - " + getSiglaAeroporto());
	}
	
	//--------------------------------------------------------------------------------------------------
	//Metodos BD
	public ArrayList<Aeroporto> buscarAeroporto()
	{
		aeroportoDAO = new AeroportoDAO();
		return aeroportoDAO.buscarAeroporto();
	}
	
	public Aeroporto buscarPorCodigoAeroporto(int codigo)
	{
		aeroportoDAO = new AeroportoDAO();
		return aeroportoDAO.buscarPorCodigoAeroporto(codigo);
	}
}
