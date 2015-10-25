package DAO.Impl;

import java.util.ArrayList;

import Model.Aeronave;

public interface AeronaveDaoInterface
{
	public void excluir(int cod);
	
	
	public void cadastrar(Aeronave aeronave);
	
	
	public void alterar(Aeronave aeronave);
	
	public ArrayList<Aeronave> buscarTodosInverso();
	
	public ArrayList<Aeronave> buscarTodos();
	
	public ArrayList<Aeronave> buscarCod(int cod);
	
	public Aeronave buscarCodObj(int cod);
	
	public ArrayList<Aeronave> buscarNome(String nome);
	
	public ArrayList<Aeronave> buscarAssento(int assento);
	
	public ArrayList<Aeronave> buscarFileiras(int fileira);
	 
	public ArrayList<Aeronave> buscarGenerico(int cod,  String nome,  String modelo, int assento, int fileira);
}
