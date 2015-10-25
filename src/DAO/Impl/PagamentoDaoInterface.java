package DAO.Impl;

import Model.Pagamento;

public interface PagamentoDaoInterface 
{
	//Cadastra Pagamento
	 public int cadastrarPagamento(Pagamento pagamento);
	 
	 //Retorna OBJETO de Pagamento
	 public Pagamento buscarCodObjPagamento(int codPassagem);

}
