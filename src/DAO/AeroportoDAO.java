package DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import DAO.Impl.AeronaveDaoInterface;
import DAO.Impl.AeroportoDaoInterface;
import DAO.banco.DaoFactory;
import Model.Aeronave;
import Model.Aeroporto;

public class AeroportoDAO
{

	public ArrayList<Aeroporto> buscarAeroporto()
	{
		DaoFactory factory = DaoFactory.getInstance();
		AeroportoDaoInterface dao = factory.getAeroportoDaoImpl();
		return dao.buscarAeroporto();
	}
	
	public Aeroporto buscarPorCodigoAeroporto(int codigo)
	{
		DaoFactory factory = DaoFactory.getInstance();
		AeroportoDaoInterface dao = factory.getAeroportoDaoImpl();
		return dao.buscarPorCodigoAeroporto(codigo);
	}

}
