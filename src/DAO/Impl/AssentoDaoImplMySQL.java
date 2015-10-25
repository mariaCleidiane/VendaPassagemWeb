package DAO.Impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import Model.Aeronave;
import Model.Assento;

public class AssentoDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements AssentoDaoInterface
{
	
		   
		   
		   public void cadastraAssento(Aeronave aeronave, int fileira , int coluna)
		   {
			   Assento assento = new Assento();
			   
 
			   assento.setColunaAssento(coluna);
			   assento.setFileiraAssento(fileira);  
			   assento.createColunaSigla(coluna);
			   
			   conectar();  
			      try {  
			         String insert = "INSERT INTO assento (codAssento, colunaAssento, fileiraAssento, colunaSigla, codAeronave, disponibilidade) VALUES (null, ?, ?, ?, ?, ?)";
			    	 PreparedStatement stm = null;
			    	 
			    	stm = (PreparedStatement) con.prepareStatement(insert);
			    	
			    	// YOU FALLED THE EMPRAH -> stm.setInt(0, 0);
			    	stm.setInt(1, assento.getColunaAssento());
			    	stm.setInt(2, assento.getFileiraAssento());
			    	
			    	stm.setString(3, "" + assento.getColunaSiglaAssento());

			    	stm.setInt(4, aeronave.getCodAeronave());
			    	
			    	stm.setBoolean(5, false);
			    	
			    	
			    	 stm.execute();
			    	 
			      } catch (SQLException e) 
			      	{  
			         imprimeErro("Erro ao inserir a", e.getMessage());
			         e.printStackTrace();
			      	} finally 
			      		{  
			      			fechar();  
			      		}

		   }
		   
		   public Assento buscaUmAssento(int cod)
		   {
			   conectar();
			   Assento assentoEscolhido;
			   ResultSet rs;
			   
			   try
			   {
				   rs = comando.executeQuery("Select * from assento where codAssento = "+cod);
				   assentoEscolhido = new Assento();
				   
				   while(rs.next())
				   {   
					   assentoEscolhido.setCodAssento(rs.getInt("codAssento"));
					   assentoEscolhido.setColunaAssento(rs.getInt("colunaAssento"));
					   assentoEscolhido.setColunaSiglaAssento(rs.getString("colunaSigla").charAt(0));
					   assentoEscolhido.setCodAeronave(rs.getInt("codAeronave"));
					   assentoEscolhido.setDiponibilidade(rs.getBoolean("disponibilidade"));
				   }
				   return assentoEscolhido;
			   }catch(SQLException e)
			   {
				   imprimeErro("Erro ao buscar assento", e.getMessage());  
			         return null;  
			   }
			   finally
			   {
				   fechar();
			   }
		   }
		   
		   public ArrayList<Assento> buscarTodosAssentosAeronave(int codAeronave)
		   {
			   conectar();
			   ArrayList<Assento> assentosEscolhidos = new ArrayList<Assento>();
			   ResultSet rs;
			   
			   try
			   {
				   rs = comando.executeQuery("Select * from assento where codAeronave = "+codAeronave);
				   
				   while(rs.next())
				   {
					   Assento a = new Assento();
					   
					   a.setCodAssento(rs.getInt("codAssento"));
					   a.setColunaAssento(rs.getInt("colunaAssento"));
					   a.setFileiraAssento(rs.getInt("fileiraAssento"));
					   a.setColunaSiglaAssento(rs.getString("colunaSigla").charAt(0));
					   a.setCodAeronave(rs.getInt("codAeronave"));
					   a.setDiponibilidade(rs.getBoolean("disponibilidade"));
					   
					   assentosEscolhidos.add(a);
				   }
				   return assentosEscolhidos;
				   
			   }
			   catch(SQLException e)
			   {
				   imprimeErro("Erro ao buscar", e.getMessage());
			       e.printStackTrace();
			       return null;
			   }
			   finally
			   {
				   fechar();
			   }
			   
		   }
		   
		   public ArrayList<Assento> buscarTodosAssentosVoo(int codAeronave, int codVoo)
		   {
			   conectar();
			   ArrayList<Assento> assentosEscolhidos = new ArrayList<Assento>();
			   ResultSet rs;
			   
			   try
			   {
				   rs = comando.executeQuery("Select assento.*, If(assento.codAssento=passagem.assentoPassagem,1,0) AS disponibilidadeVoo from (Select * from passagem where codVoo = " + codVoo + ") as passagem RIGHT JOIN assento ON passagem.assentoPassagem = assento.codAssento where assento.codAeronave = " +codAeronave + " order by codAssento ASC;");
				   
				   while(rs.next())
				   {
					   Assento a = new Assento();
					   
					   a.setCodAssento(rs.getInt("codAssento"));
					   a.setColunaAssento(rs.getInt("colunaAssento"));
					   a.setFileiraAssento(rs.getInt("fileiraAssento"));
					   a.setColunaSiglaAssento(rs.getString("colunaSigla").charAt(0));
					   a.setCodAeronave(rs.getInt("codAeronave"));
					   a.setDiponibilidade(rs.getBoolean("disponibilidadeVoo"));
					   
					   assentosEscolhidos.add(a);
				   }
				   return assentosEscolhidos;
				   
			   }
			   catch(SQLException e)
			   {
				   imprimeErro("Erro ao buscar", e.getMessage());
			       e.printStackTrace();
			       return null;
			   }
			   finally
			   {
				   fechar();
			   }
			   
		   }
		   
		   public void alterarAssento(Assento assento)
		   {
			   conectar();
			   try
			   {
				   String alterar = "Update assento set disponibilidade = ? WHERE codAssento = ? AND colunaAssento = ? AND fileiraAssento = ? AND colunaSigla = ? AND codAeronave = ?";
				   PreparedStatement stm = null;
				   stm = (PreparedStatement) con.prepareStatement(alterar);
				   
				   stm.setBoolean(1, assento.getDiponibilidade());
				   stm.setInt(2, assento.getCodAssento());
				   stm.setInt(3, assento.getColunaAssento());
				   stm.setInt(4, assento.getFileiraAssento());
				   stm.setObject(5, assento.getColunaSiglaAssento(), java.sql.Types.CHAR);//Não é possível fazer o SET de CHAR.
				   stm.setInt(6, assento.getCodAeronave());
				   
				   stm.execute();
				   
			   }
			   catch(SQLException e)
			   {
				   imprimeErro("Erro ao alterar a", e.getMessage());
			         e.printStackTrace();
			   }
			   finally
			   {
				   fechar();
			   }
		   }
		   
			public void excluirAssento(int cod)
			{
				 conectar();  
			      try {  
			    	  
			         comando  
		             .executeUpdate("DELETE FROM assento WHERE codAssento = '" + cod  
		                   + "';"); 
			         
			      } catch (SQLException e) {  
				         imprimeErro("Erro ao apagar o assento "+ cod, e.getMessage());  
				      } finally {  
				         fechar();  
				      }
				}
			
			public void excluirAeronave(int cod)
			{

			 try {  
				 conectar();
			         comando  
		             .executeUpdate("DELETE FROM assento WHERE codAeronave = '" + cod  
		                   + "';"); 
			         
			     } catch (SQLException e) 
			      {  
				         imprimeErro("Erro ao apagar a aeronave "+ cod, e.getMessage());  
			      } finally {  
				         fechar();  
			      }
				}
			
			//Busca QUANTIDADE de assentos DISPONÍVEIS
			public int buscarQtdDisponivelVoo(int codAeronave, int codVoo) 
			{
				conectar();
				ResultSet rs;
			try{
				   
				   rs = comando.executeQuery("Select assento.*, If(assento.codAssento=passagem.assentoPassagem,1,0) AS disponibilidadeVoo from " + 
				   "(Select * from passagem where codVoo = " + 
				   codVoo + ") as passagem RIGHT JOIN assento ON passagem.assentoPassagem = assento.codAssento where assento.codAeronave = " +
				   codAeronave + " order by codAssento ASC;");
				   
				   int count = 0;
				   
				   while(rs.next())
				   {   
					   if(rs.getBoolean("disponibilidadeVoo") == false)
					   	{
					   		count ++;
				   		}
				   }
				   return count;
				   
				}catch(SQLException e)
				{
					imprimeErro("Erro ao contar assentos disponiveis:", e.getMessage());
			         e.printStackTrace();
				     return 0;
				}
			   finally
			   {
				   fechar();
			   }
			}

		 
}
