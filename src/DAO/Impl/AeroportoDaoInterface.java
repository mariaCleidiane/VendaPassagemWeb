package DAO.Impl;

import java.util.ArrayList;

import Model.Aeroporto;

public interface AeroportoDaoInterface 
{
	//Busca todos Aeroportos
	public ArrayList<Aeroporto> buscarAeroporto();
	
	//Busca um Aeroporto
	public Aeroporto buscarPorCodigoAeroporto(int codigo);
}
