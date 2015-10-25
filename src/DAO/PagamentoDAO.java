package DAO;

import DAO.Impl.PagamentoDaoInterface;
import DAO.banco.DaoFactory;
import Model.Pagamento;

public class PagamentoDAO 
{
	//Cadastrar Pagamento
	   public int cadastrarPagamento(Pagamento pagamento)
	   {
		   	DaoFactory factory = DaoFactory.getInstance();
			PagamentoDaoInterface dao = factory.getPagamentoDaoImpl();
			return dao.cadastrarPagamento(pagamento);

	   }
	   		
	   //Retorna OBJETO de Pagamento
		public Pagamento buscarCodObjPagamento(int codPassagem)
		{
			DaoFactory factory = DaoFactory.getInstance();
			PagamentoDaoInterface dao = factory.getPagamentoDaoImpl();
			return dao.buscarCodObjPagamento(codPassagem);
		}
}
