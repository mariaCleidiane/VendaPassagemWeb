package DAO.Impl;

import java.util.ArrayList;

import Model.Passageiro;

public interface PassageiroDaoInterface 
{
	//Cadastrar
	public void cadastrar(Passageiro p);
	
	//Altera Passageiro
	public void alterar(Passageiro passageiro);
	
	 //Busca de Passageiro
	public Passageiro buscarCodObj(int cod);
	 
	 //Busca todos
	public ArrayList<Passageiro> buscarTodos();
	
	//Busca genérica
	public ArrayList<Passageiro> buscarGenerico(int cod,  String nome, String sobrenome, String genero,
			 String rg, String cpf, String tratamento, int dia, int mes, int ano, String email,
			 String celular);
	
	//Busca Passageiro por CPF e RG
	public int buscarCodPassageiroCpfRg(String cpf, String rg);
	
	//Excluir
    public void excluir(int cod);
	  
     

}
