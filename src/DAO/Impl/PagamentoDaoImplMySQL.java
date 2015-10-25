package DAO.Impl;

import java.sql.ResultSet;  
import java.sql.SQLException;  

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import Model.Pagamento;

public class PagamentoDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements PagamentoDaoInterface
{
	
	   //Cadastra pagamento
	   public int cadastrarPagamento(Pagamento pagamento)
	   {
		   conectar();  
		      try {  
		         String insert = "INSERT INTO pagamento (codPagamento, codPassageiroTitular, diaPagamento, mesPagamento, anoPagamento, tipoPagamento, numeroPassagem) VALUES (null, ?, ?, ?, ?, ?, ?)";
		    	 PreparedStatement stm = null;
		    	 
		    	stm = (PreparedStatement) con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
		    	
		    	 stm.setInt(1, pagamento.getPassageiroTitular().getCodPassageiro());
		    	 stm.setInt(2, pagamento.getDiaPagamento());
		    	 stm.setInt(3, pagamento.getMesPagamento());
		    	 stm.setInt(4, pagamento.getAnoPagamento());
		    	 stm.setString(5, pagamento.getTipoPagamento());
		    	 stm.setInt(6, pagamento.getNumeroPassagem().getNumeroPassagem());
		    	 stm.execute();

		    	 ResultSet generatedKeys = stm.getGeneratedKeys();
		    	 generatedKeys.next();
		    	 int  auto_id = generatedKeys.getInt(1);
		    	 stm.close();
		    	 
		    	 return auto_id;
		    	 
		      } catch (SQLException e) {  
		         imprimeErro("Erro ao inserir pagamento", e.getMessage());
		         e.printStackTrace();
		         return 0;
		      } finally {  
		         fechar();  
		      }
	   }
	   
	   public Pagamento buscarCodObjPagamento(int codPassagem)
	   {
		   conectar();  
		      Pagamento temp = null;  
		      ResultSet rs;  
		      try {  
		    	  rs = comando.executeQuery("SELECT * FROM pagamento WHERE numeroPassagem = " + codPassagem);  
		    	  rs.next(); 
		          temp = new Pagamento();  
		         return temp;  
		      } catch (SQLException e) {  
		         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
		         return null;  
		      }  
	   }
	   
}
