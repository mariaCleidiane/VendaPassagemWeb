package Model;

import java.util.ArrayList;

import DAO.AssentoDAO;
import DAO.Impl.AssentoDaoInterface;
import DAO.banco.DaoFactory;

public class Assento 
{
	private int codAssento;
	private int fileiraAssento;
	private int colunaAssento;
	private char colunaSiglaAssento;
	private boolean diponibilidade;
	private int codAeronave;
	
	AssentoDAO assentoDAO = new AssentoDAO();
	//Código Assento
	public int getCodAssento() 
	{
		return codAssento;
	}
	public void setCodAssento(int codAssento) 
	{
		this.codAssento = codAssento;
	}
	
	
	//FIleira Assento
	public int getFileiraAssento() 
	{
		return fileiraAssento;
	}
	public void setFileiraAssento(int fileiraAssento) 
	{
		this.fileiraAssento = fileiraAssento;
	}
	
	public int getColunaAssento() 
	{
		return colunaAssento;
	}
	
	public void setColunaAssento(int colunaAssento) 
	{
		this.colunaAssento = colunaAssento;
	}
	
	public char getColunaSiglaAssento() 
	{
		return colunaSiglaAssento;
	}
	
	public void setColunaSiglaAssento(char colunaSiglaAssento)
	{
		this.colunaSiglaAssento = colunaSiglaAssento;
	}
	
	//Disponibilidade
	public boolean getDiponibilidade() 
	{
		return diponibilidade;
	}
	public void setDiponibilidade(boolean diponibilidade) 
	{
		this.diponibilidade = diponibilidade;
	}
	
	//Código Aeronave
	public int getCodAeronave() 
	{
		return codAeronave;
	}
	public void setCodAeronave(int codAeronave) 
	{
		this.codAeronave = codAeronave;
	}
	//--------------------------------------------------------------------
	public void createColunaSigla(int colunaInt) 
	{

		colunaSiglaAssento = colunaInt<0 || colunaInt>25 ? '?' : (char)('A' + colunaInt);
		
	}
	
	public ArrayList<Assento> buscarTodosAssentosVoo(int codAeronave, int codVoo)
	{
		return assentoDAO.buscarTodosAssentosVoo(codAeronave, codVoo);
	}
	
	//Busca QUANTIDADE de assentos DISPONÍVEIS
	public int buscarQtdDisponivelVoo(int codAeronave, int codVoo)
	{
		return assentoDAO.buscarQtdDisponivelVoo(codAeronave, codVoo);
	}
	
}
