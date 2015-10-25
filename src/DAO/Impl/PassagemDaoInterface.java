package DAO.Impl;

import Model.Passagem;

public interface PassagemDaoInterface 
{

	//Cadastra Passagem
	public int cadastrarPassagem(Passagem pass);
	
	//Busca Passagem
	public Passagem buscarPassagem(int numeroPassagem);
	
	//Cancela Passagem (Exclui)
	public void cancelarPassagem(int codPassagem);
	  
	//Realiza CheckIn
	public void checkIn(Passagem pass);  
	
}
