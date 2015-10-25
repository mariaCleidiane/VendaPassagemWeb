package DAO.Impl;
import java.sql.ResultSet;  
import java.sql.SQLException;  
import java.util.ArrayList;
 
//import javax.swing.JOptionPane;  

import DAO.AssentoDAO;
import Model.Aeronave;



public class AeronaveDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements AeronaveDaoInterface 
{
	//Método de excluir
	public void excluir(int cod)
	{
		AssentoDAO assentoDAO = new AssentoDAO();
		 conectar();  
	      try {  
	    	  
	    	  
	    	  assentoDAO.excluirAeronave(cod);
	         comando  
             .executeUpdate("DELETE FROM aeronave WHERE codAeronave = '" + cod  
                   + "';"); 
	         
	         
	      //   JOptionPane.showMessageDialog(null, "Aeronave "+" ( "+cod+" ) "+ " excluída com sucesso!" );
	         
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao apagar a aeronave "+ cod, e.getMessage());  
	      } finally {  
	         fechar();  
	      }
	}
	
	//Método para cadastar
	public void cadastrar(Aeronave aeronave)
	{  
	      conectar();  
	      try {  
	         comando.executeUpdate("INSERT INTO aeronave VALUES('"  
	               + aeronave.getCodAeronave() + "', '" + aeronave.getNomeAeronave() + "',"+"'"  
	               + aeronave.getModeloAeronave() + "','" + aeronave.createQtdAssento() + "','"  
	               + aeronave.getQtdFileiras() + "')");  
	       
	         aeronave.setCodAeronave(buscarTodosInverso().get(0).getCodAeronave());
	         
	         AssentoDAO assentoDAO = new AssentoDAO();
	         //Começa do 0 e vai até a qtd - 1
	         
	         for(int coluna = 0; coluna < aeronave.getQtdColunas(); coluna++)
	         {
	        	 for(int fileira = 0; fileira < aeronave.getQtdFileiras(); fileira++)
	        	 {

	        		 assentoDAO.cadastrarAssento(aeronave, fileira , coluna);
	        	 }
	         }
	         
	         
	         
	      //   JOptionPane.showMessageDialog(null, "A aeronave "+
	       // 		 						aeronave.getNomeAeronave()+" foi adicionada com sucesso!");  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao inserir aeronave", e.getMessage());  
	      } finally {  
	         fechar();  
	      }  
	   }
	
	//Método para alterar
	public void alterar(Aeronave aeronave) 
	{  
	      conectar();  
	      String com = "UPDATE aeronave SET nomeAeronave = '" + aeronave.getNomeAeronave()  
	            + "', modeloAeronave = '" + aeronave.getModeloAeronave() + "', qtdAssento = '"  
	            + aeronave.getQtdAssento() + "', qtdFileiras ='" + aeronave.getQtdFileiras()  
	            + "' WHERE  codAeronave = '" + aeronave.getCodAeronave() + "';"; 
	      
	      
	      	AssentoDAO assentoDAO = new AssentoDAO();
	      	assentoDAO.excluirAeronave(aeronave.getCodAeronave());
	         for(int coluna = 0; coluna < aeronave.getQtdColunas(); coluna++)
	         {
	        	 for(int fileira = 0; fileira < aeronave.getQtdFileiras(); fileira++)
	        	 {

	        		 assentoDAO.cadastrarAssento(aeronave, fileira , coluna);
	        	 }
	         }
	     // JOptionPane.showMessageDialog(null, "Aeronave alterada com sucesso!");  
	      
	      
	      
	      try {  
	         comando.executeUpdate(com);  
	      } catch (SQLException e) {  
	         e.printStackTrace();  
	      } finally {  
	         fechar();  
	      }  
	   }  
	
	 public ArrayList<Aeronave> buscarTodosInverso() {  
	      conectar();  
	      ArrayList<Aeronave> resultados = new ArrayList<Aeronave>();  
	      ResultSet rs;  
	      try {  
	         rs = comando.executeQuery("SELECT * FROM aeronave ORDER BY codAeronave DESC");  
	         while (rs.next()) {  
	            Aeronave temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	            resultados.add(temp);  
	         }  
	         return resultados;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	
	//Buscas
	//Todos
	 public ArrayList<Aeronave> buscarTodos() {  
	      conectar();  
	      ArrayList<Aeronave> resultados = new ArrayList<Aeronave>();  
	      ResultSet rs;  
	      try {  
	         rs = comando.executeQuery("SELECT * FROM aeronave");  
	         while (rs.next()) {  
	            Aeronave temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	            resultados.add(temp);  
	         }  
	         return resultados;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	 
	 //Pelo código
	 public ArrayList<Aeronave> buscarCod(int cod) {  
	      conectar();  
	      ArrayList<Aeronave> resultados = new ArrayList<Aeronave>();  
	      ResultSet rs;  
	      try {  
	    	  rs = comando.executeQuery("SELECT * FROM aeronave WHERE codAeronave LIKE '"  
	                  + cod + "%';");  
	         while (rs.next()) {  
	            Aeronave temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	            resultados.add(temp);  
	         }  
	         return resultados;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	 
	 //Pelo código com retorno de um objeto
	 public Aeronave buscarCodObj(int cod) {  
	      conectar();  
	      Aeronave temp = null;  
	      ResultSet rs;  
	      try {  
	    	  rs = comando.executeQuery("SELECT * FROM aeronave WHERE codAeronave = " + cod);  
	         while (rs.next()) {  
	            temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	              
	         }  
	         return temp;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	 
	

	 public ArrayList<Aeronave> buscarNome(String nome) {  
	      conectar();  
	      ArrayList<Aeronave> resultados = new ArrayList<Aeronave>();  
	      ResultSet rs;  
	      try {  
	    	  rs = comando.executeQuery("SELECT * FROM aeronave WHERE nomeAeronave LIKE '"  
	                  + nome + "%';");  
	         while (rs.next()) {  
	            Aeronave temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	            resultados.add(temp);  
	         }  
	         return resultados;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	 
	 public ArrayList<Aeronave> buscarModelo(String modelo) {  
	      conectar();  
	      ArrayList<Aeronave> resultados = new ArrayList<Aeronave>();  
	      ResultSet rs;  
	      try {  
	    	  rs = comando.executeQuery("SELECT * FROM aeronave WHERE modeloAeronave LIKE '"  
	                  + modelo + "%';");  
	         while (rs.next()) {  
	            Aeronave temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	            resultados.add(temp);  
	         }  
	         return resultados;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	
	 public ArrayList<Aeronave> buscarAssento(int assento) {  
	      conectar();  
	      ArrayList<Aeronave> resultados = new ArrayList<Aeronave>();  
	      ResultSet rs;  
	      try {  
	    	  rs = comando.executeQuery("SELECT * FROM aeronave WHERE qtdAssento LIKE '"  
	                  + assento + "%';");  
	         while (rs.next()) {  
	            Aeronave temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	            resultados.add(temp);  
	         }  
	         return resultados;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	 
	 public ArrayList<Aeronave> buscarFileiras(int fileira) {  
	      conectar();  
	      ArrayList<Aeronave> resultados = new ArrayList<Aeronave>();  
	      ResultSet rs;  
	      try {  
	    	  rs = comando.executeQuery("SELECT * FROM aeronave WHERE qtdFileiras LIKE '"  
	                  + fileira + "%';");  
	         while (rs.next()) {  
	            Aeronave temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	            resultados.add(temp);  
	         }  
	         return resultados;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	
	 public ArrayList<Aeronave> buscarGenerico(int cod,  String nome,  String modelo, int assento, int fileira) {  
	      String generico;
	      
	      /*
	       * cod
	       * nome
	       * modelo
	       * assento
	       * fileira
	       */
	      
	      if(cod == -1)
	      {
	    	  generico = "codAeronave not like '" + cod + "%' and ";
	      }
	      else
	      {
	    	  generico = "codAeronave like '" + cod + "%' and ";
	      }
	      
	      
	      if(nome == "" || nome == null)
	      {
	    	  generico += "nomeAeronave <> '' and ";
	      }
	      else
	      {
	    	  generico += "nomeAeronave like '" + nome + "%' and ";
	      }
	      
	      if(modelo == "" || modelo == null)
	      {
	    	  generico += "modeloAeronave <> '' and ";
	      }
	      else
	      {
	    	  generico += "modeloAeronave like '" + modelo + "%' and ";
	      }
	      
	      if(assento == -1)
	      {
	    	  generico += "qtdAssento not like '" + assento + "%' and ";
	      }
	      else
	      {
	    	  generico += "qtdAssento like '" + assento + "%' and ";
	      }
	      
	      if(fileira == -1)
	      {
	    	  generico += "qtdFileiras not like '" + fileira + "%'";
	      }
	      else
	      {
	    	  generico += "qtdFileiras like '" + fileira + "%'";
	      }
	      
		  conectar();  
	      ArrayList<Aeronave> resultados = new ArrayList<Aeronave>();  
	      ResultSet rs;  
	      try {  
	    	  
	    	  rs = comando.executeQuery("SELECT * FROM aeronave WHERE "  
	                  + generico + ";");  
	         while (rs.next()) {  
	            Aeronave temp = new Aeronave();  
	            // pega todos os atributos da aeronave  
	            temp.setCodAeronave(rs.getInt("codAeronave"));  
	            temp.setNomeAeronave(rs.getString("nomeAeronave"));  
	            temp.setModeloAeronave(rs.getString("modeloAeronave"));  
	            temp.setQtdAssento(rs.getInt("qtdAssento"));  
	            temp.setQtdFileiras(rs.getInt("qtdFileiras"));  
	            resultados.add(temp);  
	         }  
	         return resultados;  
	      } catch (SQLException e) {  
	         imprimeErro("Erro ao buscar aeronave", e.getMessage());  
	         return null;  
	      }  
	   }
	
}
