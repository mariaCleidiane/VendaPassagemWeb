package DAO.banco;


import DAO.AeronaveDAO;
import DAO.Impl.*;

public class DaoFactory {

	private static DaoFactory factory = null;
	
	private DaoFactory(){}
	
	
	public static DaoFactory getInstance(){
		if(factory == null) {
			factory = new DaoFactory();
		}
		return factory;
	}
 
	//Aeronave
	public AeronaveDaoInterface getAeronaveDaoImpl() {
		return new AeronaveDaoImplMySQL();
		//return new AeronaveDaoImplPostgre();
	}
	
	//Aeroporto
	public AeroportoDaoInterface getAeroportoDaoImpl()
	{
		return new AeroportoDaoImplMySQL();
		//return new AeroportoDaoImplPostgre();
	}
	
	//Assento
	public AssentoDaoInterface getAssentoDaoImpl()
	{
		return new AssentoDaoImplMySQL();
		//return new AssentoDaoImplPostgre();
	}
	
	//Passageiro
	public PassageiroDaoInterface getPassageiroDaoImpl()
	{
		return new PassageiroDaoImplMySQL();
		//return new AssentoDaoImplPostgre();
	}
	
	//Voo
	public VooDaoInterface getVooDaoImpl()
	{
		return new VooDaoImplMySQL();
		//return new VooDaoImplPostgre();
	}
	
	//Passagem
	public PassagemDaoInterface getPassagemDaoImpl()
	{
		return new PassagemDaoImplMySQL();
	}
	
	//Pagamento
	public PagamentoDaoInterface getPagamentoDaoImpl()
	{
		return new PagamentoDaoImplMySQL();
	}
	
	//Dinheiro
	public DinheiroDaoInterface getDinheiroDaoImpl()
	{
		return new DinheiroDaoImplMySQL();
	}
	
	//Cheque
	public ChequeDaoInterface getChequeDaoImpl()
	{
		return new ChequeDaoImplMySQL();
	}
	
	//Cartão
	public CartaoDaoInterface getCartaoDaoImpl()
	{
		return new CartaoDaoImplMySQL();
	}
	
	//Reembolso
	public ReembolsoDaoInterface getReembolsoDaoImpl()
	{
		return new ReembolsoDaoImpMySQL();
	}
}
