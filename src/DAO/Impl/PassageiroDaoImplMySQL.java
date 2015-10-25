package DAO.Impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import Model.Aeronave;
import Model.Passageiro;
//import Model.Passagem;

public class PassageiroDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements PassageiroDaoInterface
{
			   
			   //Cadastra Passageiro
			   public void cadastrar(Passageiro p)
			   {
				   conectar();  
				      try {  
				         String insert = "INSERT INTO passageiro (codPassageiro, nomePassageiro, sobrenomePassageiro, generoPassageiro, rgPassageiro, cpfPassageiro, tratamentoPassageiro, diaNascimento, mesNascimento, anoNascimento, celularPassageiro, emailPassageiro) VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				    	 PreparedStatement stm = null;
				    	 
				    	stm = (PreparedStatement) con.prepareStatement(insert);
				    	

				    	stm.setString(1, p.getNomePassageiro());
				    	stm.setString(2, p.getSobrenomePassageiro());
				    	stm.setString(3, p.getGeneroPassageiro());
				    	stm.setString(4, p.getRG());
				    	stm.setString(5, p.getCPF());
				    	stm.setString(6, p.getTratamentoPassageiro());
				    	stm.setInt(7, p.getDiaNascimento());
				    	stm.setInt(8, p.getMesNascimento());
				    	stm.setInt(9, p.getAnoNascimento());
				    	stm.setString(10, p.getCelularPassageiro());
				    	stm.setString(11, p.getEmailPassageiro());
				    	stm.execute();

				      } catch (SQLException e) {  
				         imprimeErro("Erro ao inserir passageiro", e.getMessage());
				         e.printStackTrace();
				      } finally {  
				         fechar();  
				      }
			   
			   }
			   
			   
			 //Altera Passageiro
				public void alterar(Passageiro passageiro) 
				{  
				      conectar();  
				      String com = "UPDATE passageiro SET nomePassageiro = '" + passageiro.getNomePassageiro()  
				            + "', sobrenomePassageiro = '" + passageiro.getSobrenomePassageiro() + "', generoPassageiro = '"  
				            + passageiro.getGeneroPassageiro() + "', rgPassageiro ='" + passageiro.getRG() 
				            + "', cpfPassageiro = '" + passageiro.getCPF() + "', tratamentoPassageiro ='" + passageiro.getTratamentoPassageiro() +
				            "', diaNascimento = '" + passageiro.getDiaNascimento() + "', mesNascimento ='" + passageiro.getMesNascimento() 				    		  
				            + "', anoNascimento = '" + passageiro.getAnoNascimento() + "', celularPassageiro = '"  
				            + passageiro.getCelularPassageiro() + "', emailPassageiro ='" + passageiro.getEmailPassageiro()  
				            + "' WHERE  codPassageiro = '" + passageiro.getCodPassageiro() + "';";     
				      try {  
				         comando.executeUpdate(com);  
				      } catch (SQLException e) {  
				         e.printStackTrace();  
				      } finally {  
				         fechar();  
				      }  
				   } 
				
			   //Busca de Passageiro pelo CÓDIGO e retorna um OBJETO
			   public Passageiro buscarCodObj(int cod)
			   {
				   conectar();  
				      Passageiro temp = null;  
				      ResultSet rs;  
				      try {  
				    	  rs = comando.executeQuery("SELECT * FROM passageiro WHERE codPassageiro = " + cod);  
				         while (rs.next()) {  
				            temp = new Passageiro();  
				            
				            // pega todos os atributos de passageiro
				             temp.setCodPassageiro(rs.getInt("codPassageiro"));
				             temp.setNomePassageiro(rs.getString("nomePassageiro"));
				             temp.setSobrenomePassageiro(rs.getString("sobrenomePassageiro"));
				             temp.setGeneroPassageiro(rs.getString("generoPassageiro"));
				             temp.setRG(rs.getString("rgPassageiro"));
				             temp.setCPF(rs.getString("cpfPassageiro"));
				             temp.setTratamentoPassageiro(rs.getString("tratamentoPassageiro"));
				             temp.setDiaNascimento(rs.getInt("diaNascimento"));
				             temp.setMesNascimento(rs.getInt("mesNascimento"));
				             temp.setAnoNascimento(rs.getInt("anoNascimento"));
				             temp.setCelularPassageiro(rs.getString("celularPassageiro"));
				             temp.setEmailPassageiro(rs.getString("emailPassageiro"));
				             
				             
				              
				         }  
				         rs.close();
				         return temp;  
				      } catch (SQLException e) {  
				         imprimeErro("Erro ao buscar passageiro", e.getMessage());  
				         return null;  
				      }  
			   }
			   
			   //Retorna todos os Passageiros em um ArrayList
			   public ArrayList<Passageiro> buscarTodos()
			   {
				   conectar(); 
				   	ArrayList<Passageiro> resultados = new ArrayList<Passageiro>(); 
				      ResultSet rs;  
				       
				      try {  
				    	  rs = comando.executeQuery("SELECT * FROM passageiro ");  
				         while (rs.next()) {  
				        	 Passageiro temp = new Passageiro();
				            // pega todos os atributos de passageiro
				             temp.setCodPassageiro(rs.getInt("codPassageiro"));
				             temp.setNomePassageiro(rs.getString("nomePassageiro"));
				             temp.setSobrenomePassageiro(rs.getString("sobrenomePassageiro"));
				             temp.setGeneroPassageiro(rs.getString("generoPassageiro"));
				             temp.setRG(rs.getString("rgPassageiro"));
				             temp.setCPF(rs.getString("cpfPassageiro"));
				             temp.setTratamentoPassageiro(rs.getString("tratamentoPassageiro"));
				             temp.setDiaNascimento(rs.getInt("diaNascimento"));
				             temp.setMesNascimento(rs.getInt("mesNascimento"));
				             temp.setAnoNascimento(rs.getInt("anoNascimento"));
				             temp.setCelularPassageiro(rs.getString("celularPassageiro"));
				             temp.setEmailPassageiro(rs.getString("emailPassageiro"));
				             resultados.add(temp);  
				         }  
				         rs.close();
				         return resultados;  
				      } catch (SQLException e) {  
				         imprimeErro("Erro ao buscar passageiro", e.getMessage());  
				         return null;  
				      }  
			   }
			   
			 //Busca de Passageiro CPF e RG
			   public int buscarCodPassageiroCpfRg(String cpf, String rg)
			   {
				   String buscar = "";
				   
				   if(cpf == null || cpf == "")
				   {
					   buscar=" rgPassageiro='" + rg + "';";
				   }
				   if(rg == null || rg =="")
				   {
					   buscar= "cpfPassageiro = '" + cpf + "';";
				   }
				   if((cpf != null && cpf != "")&&(rg != null && rg !=""))
				   {
					 buscar= "cpfPassageiro = '" + cpf + "' or rgPassageiro='" + rg + "';";
				   }
				   
				   conectar();  
				  	int temp = -1;  
				      ResultSet rs;  
				      try {  
				    	  rs = comando.executeQuery("SELECT * FROM passageiro WHERE " + buscar);  
				          if(rs.next())
				          {
					          temp = rs.getInt("codPassageiro");  
				          }
				          else
				          {
				        	  temp = -1;
				          }
					      rs.close();
				          return temp;  
				      } catch (SQLException e) {  
				         imprimeErro("Erro ao buscar codigo do passageiro", e.getMessage());  
				         return -1;  
				      }  
			   }
			   
			   
				//Método de excluir
				public void excluir(int cod)
				{
					 conectar();  
				      try {  
				    	  
				    	  
				         comando  
			             .executeUpdate("DELETE FROM passageiro WHERE codPassageiro = '" + cod  
			                   + "';"); 

				         
				      } catch (SQLException e) {  
				         imprimeErro("Erro ao apagar a passageiro "+ cod, e.getMessage());  
				      } finally {  
				         fechar();  
				      }
				}
			    
				 public ArrayList<Passageiro> buscarGenerico(int cod,  String nome, String sobrenome, String genero,
						 String rg, String cpf, String tratamento, int dia, int mes, int ano, String email,
						 String celular) {  
				      String generico;
				      
			             //"codPassageiro"
			             //"nomePassageiro"
			            //"sobrenomePassageiro"
			            // "generoPassageiro"
			            // "rgPassageiro"
			            // "cpfPassageiro"
			           //  "tratamentoPassageiro"
			           //  "diaNascimento"
			           //  "mesNascimento"
			           //  "anoNascimento"
				      // "celularPassageiro"
			            // "emailPassageiro"
			            
				      
				      if(cod == -1)
				      {
				    	  generico = "codPassageiro not like '" + cod + "%' and ";
				      }
				      else
				      {
				    	  generico = "codPassageiro like '" + cod + "%' and ";
				      }
				      
				      
				      if(nome == "" || nome == null)
				      {
				    	  generico += "nomePassageiro <> '' and ";
				      }
				      else
				      {
				    	  generico += "nomePassageiro like '" + nome + "%' and ";
				      }
				      
				    
				      if(sobrenome == "" || sobrenome == null)
				      {
				    	  generico += "sobrenomePassageiro <> '' and ";
				      }
				      else
				      {
				    	  generico += "sobrenomePassageiro like '" + sobrenome + "%' and ";
				      }
				      
				      if(genero == "" || genero == null)
				      {
				    	  generico += "generoPassageiro <> '' and ";
				      }
				      else
				      {
				    	  generico += "generoPassageiro like '" + genero + "%' and ";
				      }
				      
				      
				      if(rg == "" || rg == null)
				      {
				    	  generico += "rgPassageiro <> '' and ";
				      }
				      else
				      {
				    	  generico += "rgPassageiro like '" + rg + "%' and ";
				      }
				      
				      if(cpf == "" || cpf == null)
				      {
				    	  generico += "cpfPassageiro <> '' and ";
				      }
				      else
				      {
				    	  generico += "cpfPassageiro like '" + cpf + "%' and ";
				      }
				      
				      if(tratamento == "" || tratamento == null)
				      {
				    	  generico += "tratamentoPassageiro <> '' and ";
				      }
				      else
				      {
				    	  generico += "tratamentoPassageiro like '" + tratamento + "%' and ";
				      }
				      
				      
				      if(dia == -1)
				      {
				    	  generico += "diaNascimento not like '" + dia + "%' and ";
				      }
				      else
				      {
				    	  generico += "diaNascimento like '" + dia + "%' and ";
				      }
				      
				      if(mes == -1)
				      {
				    	  generico += "mesNascimento not like '" + mes + "%' and ";
				      }
				      else
				      {
				    	  generico += "mesNascimento like '" + mes + "%' and ";
				      }
				      
				      if(ano == -1)
				      {
				    	  generico += "anoNascimento not like '" + ano + "%' and ";
				      }
				      else
				      {
				    	  generico += "anoNascimento like '" + ano + "%' and ";
				      }
					     
				      if(celular == "" || celular == null)
				      {
				    	  generico += "celularPassageiro <> '' and ";
				      }
				      else
				      {
				    	  generico += "celularPassageiro like '" + celular + "%' and ";
				      } 
				      if(email == "" || email == null)
				      {
				    	  generico += "emailPassageiro <> ''";
				      }
				      else
				      {
				    	  generico += "emailPassageiro like '" + email + "%'";
				      }

  
					  conectar();  
				      ArrayList<Passageiro> resultados = new ArrayList<Passageiro>();  
				      ResultSet rs;  
				      try {  
				    	  
				    	  rs = comando.executeQuery("SELECT * FROM passageiro WHERE "  
				                  + generico + ";");  
				         while (rs.next()) {  
				            Passageiro temp = new Passageiro();  
				            // pega todos os atributos do Passageiro 
				            
				            temp.setCodPassageiro(rs.getInt("codPassageiro"));  
				            temp.setNomePassageiro(rs.getString("nomePassageiro"));  
				            temp.setSobrenomePassageiro(rs.getString("sobrenomePassageiro"));
				            temp.setGeneroPassageiro(rs.getString("generoPassageiro"));  
				            temp.setRG(rs.getString("rgPassageiro"));  
				            temp.setRG(rs.getString("cpfPassageiro"));  
				            temp.setTratamentoPassageiro(rs.getString("tratamentoPassageiro")); 
				            temp.setDiaNascimento(rs.getInt("diaNascimento"));  
				            temp.setMesNascimento(rs.getInt("mesNascimento"));  
				            temp.setAnoNascimento(rs.getInt("anoNascimento"));
				            temp.setCelularPassageiro("celularPassageiro");
				            temp.setEmailPassageiro("emailPassageiro");
				            
				            
				            resultados.add(temp);  
				         }  
				         rs.close();
				         return resultados;  
				      } catch (SQLException e) {  
				         imprimeErro("Erro ao buscar Passageiro", e.getMessage());  
				         return null;  
				      }  
				   }
				
				

}
