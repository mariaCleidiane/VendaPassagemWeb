package DAO.Impl;

import java.util.ArrayList;

import Model.Aeronave;
import Model.Assento;

public interface AssentoDaoInterface 
{
	//Cadastrar Assento
	public void cadastraAssento(Aeronave aeronave, int fileira , int coluna);
	
	//Excluir Assento
	public void excluirAssento(int cod);
	
	//Excluir Aeronave
	public void excluirAeronave(int cod);
	
	//Alterar Assento
	public void alterarAssento(Assento assento);
	
	//Buscar TODOS Assentos
	public ArrayList<Assento> buscarTodosAssentosAeronave(int codAeronave);
	
	//Buscar UM Assento
	public Assento buscaUmAssento(int cod);
	
	//Busca a QUANTIDADE de assentos DISPONÍVEIS
	public int buscarQtdDisponivelVoo(int codAeronave, int codVoo);
	
	//Buscar TODOS Assentos DISPONÍVEIS do VOO
	public ArrayList<Assento> buscarTodosAssentosVoo(int codAeronave, int codVoo);
	
}
