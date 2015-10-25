package DAO.Impl;

import java.sql.SQLException;
import java.util.ArrayList;

import Model.Escalas;
import Model.Voo;

public interface VooDaoInterface 
{
	//Cadastrar
	 public void cadastrarVoo(Voo voo);
	 
	 //Add escalas
	 public void addEscalas(Escalas esc);
	 
	 //Excluir
	 public void excluir(int cod);
	 
	//Busca todos
	public ArrayList<Voo> buscarTodos();
	
	//Busca pelo CÓDIGO e retorna um ArrayList
	public ArrayList<Voo> buscarTodosCodigo(int cod);
	
	//Busca pelo CÓDIGO e retorna OBJETO
	public Voo buscarTodosCodigoObjt(int cod);
	
	//Busca Genérica
	public ArrayList<Voo> buscaGenericaVoo (int cod, int codOrigem, int codDestino, int horaPartida,
			int minPartida, int diaPartida, int mesPartida, int anoPartida, 
			int codAeronave, String status, double preco);
	
	//Alterar Voo
	public void alterar(Voo voo);

		
}
