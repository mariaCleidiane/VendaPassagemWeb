package DAO.Impl;

import java.sql.ResultSet;
import java.sql.SQLException;




import DAO.PassageiroDAO;
import DAO.VooDAO;

import Model.Passageiro;
import Model.Passagem;
import Model.Voo;

import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

public class PassagemDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements PassagemDaoInterface
{
	//Cadastra Passagem
	public int cadastrarPassagem(Passagem pass)
	   {
		//--------------------------------Como pegar a ultima chave gerada abaixo-------------------------------------------------------------------------------------
		   conectar();  

		      try {  
		         String insert = "INSERT INTO passagem (numeroPassagem, valorPassagem, taxaEmbarque, tipoPassagem, assentoPassagem, checkIn, ticketBagagem, cod_Passageiro, codVoo) VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
		    	 PreparedStatement stm = null;
		    	 //O que usar para pegar a ultima , Statement.RETURN_GENERATED_KEYS
		    	stm = (PreparedStatement) con.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
		    	
		    	 stm.setDouble(1, pass.getValorPassagem());
		    	 stm.setDouble(2, pass.getTaxaEmbarque());
		    	 stm.setString(3, pass.getTipoPassagem());
		    	 //Ao cadastrar ainda não atribuirá um assento, somente no Check-In
		    	 stm.setString(4, null);
		    	 stm.setBoolean(5, false);
		    	 stm.setString(6, pass.getTicketBagagem());
		    	 stm.setInt(7, pass.getPassageiro().getCodPassageiro());
		    	 stm.setInt(8, pass.getVoo().getCodVoo());
		    	 stm.execute();
		    	 
		    	 ResultSet generatedKeys = stm.getGeneratedKeys();
		    	 
		    	 // e tudo isso aqui
		    	 generatedKeys.next();
		    	 int  auto_id = generatedKeys.getInt(1);
		    	 
		    	 stm.close();
		    	 
		    	 return auto_id;
		    	 
		      } catch (SQLException e) {  
		         imprimeErro("Erro ao inserir passagem", e.getMessage());
		         e.printStackTrace();
		         return 0;
		      } finally {  
		         fechar();  
		      }
	   
	   }
	   
	   //Busca Passagem
	   public Passagem buscarPassagem(int numeroPassagem)
	   {
		   conectar();  
		      Passagem temp = null;
		      PassageiroDAO passageiroDAO;
		      VooDAO vooDAO;
		      
		      ResultSet rs;  
		      try
		      {  
		    	  rs = comando.executeQuery("SELECT * FROM passagem WHERE numeroPassagem = " + numeroPassagem);  
		         while (rs.next())
		         {  
		            temp = new Passagem();
		            passageiroDAO = new PassageiroDAO();
		            vooDAO = new VooDAO();
		            
		            // pega todos os atributos da passagem
		            temp.setNumeroPassagem(rs.getInt("numeroPassagem"));
		            temp.setValorPassagem(rs.getDouble("valorPassagem"));
		            temp.setTaxaEmbarque(rs.getDouble("taxaEmbarque"));
		            temp.setTipoPassagem(rs.getString("tipoPassagem"));
		            temp.setCheckIn(rs.getBoolean("checkIn"));
		            temp.setAssentoPassagem(rs.getInt("assentoPassagem"));
		            temp.setTicketBagagem(rs.getString("ticketBagagem"));
		            
		            //Código Passageiro
		            Passageiro passageiro = passageiroDAO.buscarCodObj(rs.getInt("cod_Passageiro")); 
		            temp.setPassageiro(passageiro);
		            
		            //Código Voo
		            Voo vooModel = vooDAO.buscarTodosCodigoObjt(rs.getInt("codVoo"));
		            temp.setVoo(vooModel);  
		            
		         }  
		         return temp;  
		      } catch (SQLException e) {  
		         imprimeErro("Erro ao buscar passagem", e.getMessage());  
		         return null;  
		      }  
		   
	   }
	   
	   
		public void checkIn(Passagem pass) 
		{  
		      conectar();  
		      int checkIn = (pass.isCheckIn()) ? 1:0;
		      String com = "UPDATE passagem SET checkIn = '" + checkIn
		    		+ "', assentoPassagem ='" + pass.getAssentoPassagem()  
		            + "' WHERE  numeroPassagem = '" + pass.getNumeroPassagem() + "';"; 
		      
		      try {  
		         comando.executeUpdate(com);  
		      } catch (SQLException e) {  
		         e.printStackTrace();  
		      } finally {  
		         fechar();  
		      }  
		   } 
	   
	   
	   //Cancela Passagem (Exclui)
	   public void cancelarPassagem(int codPassagem)
	   {
		   conectar();
		   
		   String cancelar = "DELETE FROM passagem WHERE numeroPassagem = "+codPassagem;
		   PreparedStatement stm = null;
		   
		   try
		   {
			   stm = (PreparedStatement) con.prepareStatement(cancelar);
			   stm.execute();
		   }
		   catch(SQLException e)
		   {
			   imprimeErro("Erro ao cancelar passagem",e.getMessage());
		   }
		   finally
		   {
			   fechar();
		   }
	   }
	   
	   //Transferir
	   
	 /*  public Passagem transferirPassagem (Passagem p)
	   {
		   conectar();
		   
		   try
		   {
			   String transferir = "UPDATE passagem SET valorPassagem = ?, taxaEmbarque = ?, tipoPassagem = ?, assentoPassagem = ?, checkIn = ?, ticketBagagem = ?, cod_Passageiro = ?, codVoo = ? WHERE numeroPassagem = ?";
			   PreparedStatement stm = null;
			   
			   stm = (PreparedStatement) con.prepareStatement(transferir);
			   
			   stm.setDouble(1, p.getValorPassagem());
			   stm.setDouble(2, p.getTaxaEmbarque());
			   stm.setString(3, p.getTipoPassagem());
			   stm.setInt(4, p.getAssentoPassagem().getCodAssento());
			   stm.setBoolean(5, p.isCheckIn());
			   stm.setString(6, p.getTicketBagagem());
			   stm.setInt(7, p.getPassageiro().getCodPassageiro());
			   stm.setInt(8, p.getVoo().getCodVoo());
			   stm.setInt(9, p.getNumeroPassagem());
			   
		   }
		   catch(SQLException e)
		   {
			   imprimeErro("Não foi possivel transferir a passagem", e.getMessage());
			   return null;
		   }
	   }*/ 
	    
	   
}
