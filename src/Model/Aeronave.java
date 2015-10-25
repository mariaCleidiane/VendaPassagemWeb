package Model;

import java.util.ArrayList;

import DAO.AeronaveDAO;
import DAO.Impl.AeronaveDaoInterface;
import DAO.banco.DaoFactory;


public class Aeronave 
{
	
	
	private int codAeronave;
	private String nomeAeronave;
	private String modeloAeronave;
	private int qtdColunas;
	private int qtdFileiras;
	private int qtdAssento;
	private Assento[][] assentos;
	private AeronaveDAO aeronaveDAO;
	
	public Aeronave()
	{
		codAeronave = 0;
		nomeAeronave = "";
		modeloAeronave = "";
		qtdColunas = 0;
		qtdFileiras = 0;
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
	//-----------------------------------------------------------------
	//Nome Aeronave
	public String getNomeAeronave() 
	{
		return nomeAeronave;
	}
	
	public void setNomeAeronave(String nomeAeronave) 
	{
		this.nomeAeronave = nomeAeronave;
	}
	
	//--------------------------------------------------------------------
	//Modelo Aeronave
	public String getModeloAeronave()
	{
		return modeloAeronave;
	}
	
	public void setModeloAeronave(String modeloAeronave) 
	{
		this.modeloAeronave = modeloAeronave;
	}
	
	//---------------------------------------------------------------------
	//Quantidade Colunas
	public int getQtdColunas()
	{
		return qtdColunas;
	}
	
	public void setQtdColunas(int qtdColunas) 
	{
		this.qtdColunas = qtdColunas;
	}
	
	//-----------------------------------------------------------------------
	//Quantidade de fileiras
	public int getQtdFileiras() {
		return qtdFileiras;
	}
	public void setQtdFileiras(int qtdFileiras) {
		this.qtdFileiras = qtdFileiras;
	}
	
	//-----------------------------------------------------------------------
	//Quantidade de assentos
		//Calculo para criar assentos
	public int createQtdAssento() {
		int qtdAssento=qtdFileiras*qtdColunas;
		this.qtdAssento = qtdAssento;
		return qtdAssento;
		
	}	
	
	public int getQtdAssento() {
		if (qtdAssento == 0)
		return	createQtdAssento();
		else
		return qtdAssento;
	}
	
	public void setQtdAssento(int qtdAssento) {
		this.qtdAssento = qtdAssento;
	}	
	
	//-----------------------------------------------------------------------
	//Pega o nome e código para passar ao ComboBox
	public String toString() 
	{
		return (getCodAeronave() + " - " + getNomeAeronave());
	}
	
	public void setAssentos(Assento[][] assentos) 
	{
		
		this.assentos = assentos;
	}
	
	public Assento[][] getAssentos() 
	{
		return assentos;
	}
	//-------------------------------------------------------------------------
	//Métodos de BD
	
	//Cadastrar
	public void cadastrar(Aeronave aeronave)
	{
		aeronaveDAO = new AeronaveDAO();
		aeronaveDAO.cadastrar(aeronave);
	}
	
	//Excluir Aeronave
	public void excluir(int cod)
	{
		aeronaveDAO = new AeronaveDAO();
		aeronaveDAO.excluir(cod);
	}
	
	//Alterar Aeronave
	public void alterar(Aeronave aeronave)
	{
		aeronaveDAO = new AeronaveDAO();
		aeronaveDAO.alterar(aeronave);
	}
		
	//Busca TODAS as Aeronaves e retorna um ARRAYLIST
	public ArrayList<Aeronave> buscarTodos()
	{
		aeronaveDAO = new AeronaveDAO();
		return aeronaveDAO.buscarTodos();
	}
	
	//Busca pelo Código e retorna ArrayList
	public ArrayList<Aeronave> buscarCod(int cod)
	{
		aeronaveDAO = new AeronaveDAO();
		return aeronaveDAO.buscarCod(cod);
	}
	
	//Busca pelo Código e retorna um Objeto
	public Aeronave buscarCodObj(int cod)
	{
		aeronaveDAO = new AeronaveDAO();
		return aeronaveDAO.buscarCodObj(cod);
	}
	
	//Busca aeronave pelo Nome e retorna um ArrayList
	public ArrayList<Aeronave> buscarNome(String nome)
	{
		aeronaveDAO = new AeronaveDAO();
		return aeronaveDAO.buscarNome(nome);
	}
		
	//Busca pelo Assento
	public ArrayList<Aeronave> buscarAssento(int assento)
	{
		aeronaveDAO = new AeronaveDAO();
		return aeronaveDAO.buscarAssento(assento);
	}
		
	//Busca pela Fileira
	public ArrayList<Aeronave> buscarFileiras(int fileira)
	{
		aeronaveDAO = new AeronaveDAO();
		return aeronaveDAO.buscarFileiras(fileira);
	}
	
	//Busca Genérico
	public ArrayList<Aeronave> buscarGenerico(int cod,  String nome,  String modelo, int assento, int fileira)
	{
		aeronaveDAO = new AeronaveDAO();
		return aeronaveDAO.buscarGenerico(cod, nome, modelo, assento, fileira);
	}
	
}
