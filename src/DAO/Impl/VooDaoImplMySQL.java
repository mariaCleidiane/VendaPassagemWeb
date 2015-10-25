package DAO.Impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import com.mysql.jdbc.PreparedStatement;

import Model.Aeronave;
import Model.Aeroporto;
import Model.Escalas;
import Model.Voo;

public class VooDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements VooDaoInterface
{
			   //Cadastrar
		   public void cadastrarVoo(Voo voo)
		   {
			   conectar();  
			      try {  
			         String insert = "INSERT INTO voo (codVoo, precoVoo, statusVoo, horaPartida, minutoPartida, diaPartida, mesPartida, anoPartida, codAeronave, codOrigem, codDestino) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			    	 PreparedStatement stm = null;
			    	 
			    	stm = (PreparedStatement) con.prepareStatement(insert);
			    	
			    	 stm.setInt(1, 0);
			    	 stm.setDouble(2, voo.getPrecoVoo());
			    	 stm.setString(3, voo.getSituacaoVoo());
			    	 stm.setInt(4, voo.getHoraPartida());
			    	 stm.setInt(5, voo.getMinutoPartida());
			    	 stm.setInt(6, voo.getDiaPartida());
			    	 stm.setInt(7, voo.getMesPartida());
			    	 stm.setInt(8, voo.getAnoPartida());
			    	 
			    	 stm.setInt(9, voo.getAeronaveVoo().getCodAeronave());
			    	 stm.setInt(10, voo.getAeroportoOrigem().getCodAeroporto());
			    	 stm.setInt(11, voo.getAeroportoDestino().getCodAeroporto());
			    	
			    	 stm.execute();
			    	 
			    	 
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao inserir voo", e.getMessage());
			         e.printStackTrace();
			      } finally {  
			         fechar();  
			      }
		   }
		   
		   //Add escalas
		   public void addEscalas(Escalas esc)
		   {
			   conectar();  
			      try {  
			         String insert = "INSERT INTO escalas (codEscala, cod_Voo, cod_Aeroporto) VALUES (?, ?, ?)";
			    	 PreparedStatement stm = null;
			    	 
			    	stm = (PreparedStatement) con.prepareStatement(insert);
			    	
			    	 stm.setInt(1, 0);
			    	 stm.setInt(2, esc.getCodVoo().getCodVoo());
			    	 stm.setInt(3, esc.getCodAeroporto().getCodAeroporto());
			    	
			    	 stm.execute();
			    	 
			    	 JOptionPane.showMessageDialog(null, "A escala foi adicionada com sucesso!");
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao inserir voo", e.getMessage());
			         e.printStackTrace();
			      } finally {  
			         fechar();  
			      }
		   }
		 
		   
		   public void excluir(int cod)
		   {
			   conectar();  
			      try {  
			         comando  
			               .executeUpdate("DELETE FROM voo WHERE codVoo = '" + cod  
			                     + "';");  
			         
			         
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao apagar voo "+ cod, e.getMessage());  
			      } finally {  
			         fechar();  
			      }
			
		   }
		   
		   //Consultar
		    public ArrayList<Voo> buscarTodos() {  
			      conectar();  
			      ArrayList<Voo> resultados = new ArrayList<Voo>();  
			      ResultSet rs;  
			      try {  
			         rs = comando.executeQuery("SELECT * FROM voo");  
			         while (rs.next()) {  
			            Voo temp = new Voo();
			            AeroportoDaoImplMySQL aeroportoDAO = new AeroportoDaoImplMySQL();
			            AeronaveDaoImplMySQL aeronaveDAO = new AeronaveDaoImplMySQL();
			            
			            // pega todos os atributos de Voo  
			            temp.setCodVoo(rs.getInt("codVoo"));
			            temp.setPrecoVoo(rs.getDouble("precoVoo"));
			            temp.setSituacaoVoo(rs.getString("statusVoo"));
			            temp.setHoraPartida(rs.getInt("horaPartida"));
			            temp.setMinutoPartida(rs.getInt("minutoPartida"));
			            temp.setDiaPartida(rs.getInt("diaPartida"));
			            temp.setMesPartida(rs.getInt("mesPartida"));
			            temp.setAnoPartida(rs.getInt("anoPartida"));
			            
			            
			            //Adiciona os Aeroportos
			            Aeroporto a = aeroportoDAO.buscarPorCodigoAeroporto(rs.getInt("codOrigem"));
			            temp.setAeroportoOrigem(a);
			            
			            a = aeroportoDAO.buscarPorCodigoAeroporto(rs.getInt("codDestino"));
			            temp.setAeroportoDestino(a);
			            
			            //Adiciona a aeronave
			            Aeronave aero = aeronaveDAO.buscarCodObj(rs.getInt("codAeronave"));
			            temp.setAeronaveVoo(aero);
			            
			            resultados.add(temp);  
			         }  
			         return resultados;  
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao buscar voo", e.getMessage());  
			         return null;  
			      }  
			   }
		    
		    public ArrayList<Voo> buscarTodosCodigo(int cod) {  
			      conectar();  
			      ArrayList<Voo> resultados = new ArrayList<Voo>();  
			      ResultSet rs;  
			      try {  
			    	  rs = comando.executeQuery("SELECT * FROM voo WHERE codVoo LIKE '"  
			                  + cod + "%';");   
			         while (rs.next()) {  
			            Voo temp = new Voo();
			            AeroportoDaoImplMySQL aeroportoDAO = new AeroportoDaoImplMySQL();
			            AeronaveDaoImplMySQL aeronaveDAO = new AeronaveDaoImplMySQL();
			            
			            // pega todos os atributos de Voo  
			            temp.setCodVoo(rs.getInt("codVoo"));
			            temp.setPrecoVoo(rs.getDouble("precoVoo"));
			            temp.setSituacaoVoo(rs.getString("statusVoo"));
			            temp.setHoraPartida(rs.getInt("horaPartida"));
			            temp.setMinutoPartida(rs.getInt("minutoPartida"));
			            temp.setDiaPartida(rs.getInt("diaPartida"));
			            temp.setMesPartida(rs.getInt("mesPartida"));
			            temp.setAnoPartida(rs.getInt("anoPartida"));
			            
			            
			            //Adiciona os Aeroportos
			            Aeroporto a = aeroportoDAO.buscarPorCodigoAeroporto(rs.getInt("codOrigem"));
			            temp.setAeroportoOrigem(a);
			            
			            a = aeroportoDAO.buscarPorCodigoAeroporto(rs.getInt("codDestino"));
			            temp.setAeroportoDestino(a);
			            
			            //Adiciona a aeronave
			            Aeronave aero = aeronaveDAO.buscarCodObj(rs.getInt("codAeronave"));
			            temp.setAeronaveVoo(aero);
			            
			            resultados.add(temp);  
			         }  
			         return resultados;  
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao buscar voo", e.getMessage());  
			         return null;  
			      }  
			   }
		    
		    public Voo buscarTodosCodigoObjt(int cod) {  
			      conectar();  
			      Voo temp = new Voo();  
			      ResultSet rs;  
			      try {  
			    	  rs = comando.executeQuery("SELECT * FROM voo WHERE codVoo = " + cod );   
			         while (rs.next()) {  
			            temp = new Voo();
			            AeroportoDaoImplMySQL aeroportoDAO = new AeroportoDaoImplMySQL();
			            AeronaveDaoImplMySQL aeronaveDAO = new AeronaveDaoImplMySQL();
			            
			            // pega todos os atributos de Voo  
			            temp.setCodVoo(rs.getInt("codVoo"));
			            temp.setPrecoVoo(rs.getDouble("precoVoo"));
			            temp.setSituacaoVoo(rs.getString("statusVoo"));
			            temp.setHoraPartida(rs.getInt("horaPartida"));
			            temp.setMinutoPartida(rs.getInt("minutoPartida"));
			            temp.setDiaPartida(rs.getInt("diaPartida"));
			            temp.setMesPartida(rs.getInt("mesPartida"));
			            temp.setAnoPartida(rs.getInt("anoPartida"));
			            
			            
			            //Adiciona os Aeroportos
			            Aeroporto a = aeroportoDAO.buscarPorCodigoAeroporto(rs.getInt("codOrigem"));
			            temp.setAeroportoOrigem(a);
			            
			            a = aeroportoDAO.buscarPorCodigoAeroporto(rs.getInt("codDestino"));
			            temp.setAeroportoDestino(a);
			            
			            //Adiciona a aeronave
			            Aeronave aero = aeronaveDAO.buscarCodObj(rs.getInt("codAeronave"));
			            temp.setAeronaveVoo(aero);
			            
			              
			         }  
			         return temp;  
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
			         return null;  
			      }  
			   }
		    
		    public ArrayList<Voo> buscaGenericaVoo (int cod, int codOrigem, int codDestino, int horaPartida,
		    										int minPartida, int diaPartida, int mesPartida, int anoPartida, 
		    										int codAeronave, String status, double preco)
		    {
		    	String generico;
		    	
		    	//Código do Voo
		    	if(cod == -1)
		    	{
		    		generico = "codVoo not like '" + cod +"%' and ";
		    	}
		    	else
		    	{
		    		generico = "codVoo like '" + cod +"%' and ";
		    	}
		    	
		    	//Origem
		    	if(codOrigem == -1)
		    	{
		    		generico += "codOrigem not like'" + codOrigem +"%' and ";
		    	}
		    	else
		    	{
		    		generico += "codOrigem like '" + codOrigem +"%' and ";
		    	}
		    	
		    	//Destino
		    	if(codDestino == -1)
		    	{
		    		generico += "codDestino not like '" + codDestino +"%' and ";
		    	}
		    	else
		    	{
		    		generico += "codDestino like '" + codDestino +"%' and ";
		    	}
		    	
		    	//Hora Partida
		    	if(horaPartida == -1)
		    	{
		    		generico += "horaPartida not like '" + horaPartida +"%' and ";
		    	}
		    	else
		    	{
		    		generico += "horaPartida like '" + horaPartida +"%' and ";
		    	}
		    	
		    	//Minuto Partida
		    	if(minPartida == -1)
		    	{
		    		generico += "minutoPartida not like '" + minPartida +"%' and ";
		    	}
		    	else
		    	{
		    		generico += "minutoPartida like '" + minPartida +"%' and ";
		    	}
		    	
		    	//Dia
		    	if(diaPartida == -1)
		    	{
		    		generico += "diaPartida not like '" + diaPartida +"%' and ";
		    	}
		    	else
		    	{
		    		generico += "diaPartida like '" + diaPartida +"%' and ";
		    	}
		    	
		    	//Mes
		    	if(mesPartida == -1)
		    	{
		    		generico += "mesPartida not like '" + mesPartida +"%' and ";
		    	}
		    	else
		    	{
		    		generico += "mesPartida like '" + mesPartida +"%' and ";
		    	}
		    	
		    	//Ano
		    	if(anoPartida == -1)
		    	{
		    		generico += "anoPartida not like '" + anoPartida +"%' and ";
		    	}
		    	else
		    	{
		    		generico += "anoPartida like '" + anoPartida +"%' and ";
		    	}
		    	
		    	//Preço
		    	if(preco == -1)
		    	{
		    		generico += "precoVoo not like '" + preco +"%' and ";
		    	}
		    	else
		    	{
		    		generico += "precoVoo like '" + preco +"%' and ";
		    	}
		    	
		    	if(status == "" || status == null)
		    	{
		    		 generico += "statusVoo <> '' ";
		    	}
		    	else
		    	{
		    		generico += "statusVoo like '" + status + "%' ";
		    	}
		    	
		    	
		    	conectar();
		    	ArrayList<Voo> resultados = new ArrayList<Voo>();
		    	ResultSet rs;
		    	
		    	
		    	try
		    	{
		    		rs = comando.executeQuery("SELECT * FROM voo WHERE "  
			                  + generico + ";");  
			         while (rs.next()) 
			         {  
			            Voo temp = new Voo();  
			            
			            
			            // pega todos os atributos de Voo  
			            temp.setCodVoo(rs.getInt("codVoo"));
			            temp.setPrecoVoo(rs.getDouble("precoVoo"));
			            temp.setSituacaoVoo(rs.getString("statusVoo"));
			            temp.setHoraPartida(rs.getInt("horaPartida"));
			            temp.setMinutoPartida(rs.getInt("minutoPartida"));
			            temp.setDiaPartida(rs.getInt("diaPartida"));
			            temp.setMesPartida(rs.getInt("mesPartida"));
			            temp.setAnoPartida(rs.getInt("anoPartida"));
			            
			            AeroportoDaoImplMySQL aeroportoDAO = new AeroportoDaoImplMySQL();
			            AeronaveDaoImplMySQL aeronaveDAO = new AeronaveDaoImplMySQL();
			            
			            //Adiciona os Aeroportos
			            Aeroporto a = aeroportoDAO.buscarPorCodigoAeroporto(rs.getInt("codOrigem"));
			            temp.setAeroportoOrigem(a);
			            
			            a = aeroportoDAO.buscarPorCodigoAeroporto(rs.getInt("codDestino"));
			            temp.setAeroportoDestino(a);
			            
			            //Adiciona a aeronave
			            Aeronave aero = aeronaveDAO.buscarCodObj(rs.getInt("codAeronave"));
			            temp.setAeronaveVoo(aero);
			            
			            resultados.add(temp);  
			         }  
			         return resultados;  
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao buscar voo", e.getMessage());  
			         return null;  
			      }  
			
		    	}
		    	
		    		    
		    
		    //AlterarVoo
		    public void alterar(Voo voo)
		    {
		    	try{
		    		conectar();  
				      
				      String alterar = "UPDATE voo SET precoVoo = ?, statusVoo = ?, horaPartida = ?, minutoPartida = ?, diaPartida = ?, mesPartida = ?, anoPartida = ?, codAeronave = ?, codOrigem = ?, codDestino = ? WHERE codVoo = ?;";
				      	
				      PreparedStatement stm = null;
				      stm = (PreparedStatement) con.prepareStatement(alterar);
				      	
				    	 stm.setDouble(1, voo.getPrecoVoo());
				    	 stm.setString(2, voo.getSituacaoVoo());
				    	 stm.setInt(3, voo.getHoraPartida());
				    	 stm.setInt(4, voo.getMinutoPartida());
				    	 stm.setInt(5, voo.getDiaPartida());
				    	 stm.setInt(6, voo.getMesPartida());
				    	 stm.setInt(7, voo.getAnoPartida());
				    	 stm.setInt(8, voo.getAeronaveVoo().getCodAeronave());
				    	 stm.setInt(9, voo.getAeroportoOrigem().getCodAeroporto());
				    	 stm.setInt(10, voo.getAeroportoDestino().getCodAeroporto());
				    	 stm.setInt(11, voo.getCodVoo());
				    	 
				    	 stm.execute();
				    	 
				      //JOptionPane.showMessageDialog(null, "Aeronave alterada com sucesso!");  
				    
		    	}
		    	    catch (SQLException e) {  
			         e.printStackTrace();  
			      } finally {  
			         fechar();  
			      }  
			
		    }
			
	
		
}
