package DAO.banco;

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.SQLException;  
import java.sql.Statement;
  
public class AcessoBDMySQL {  
     
   public static final int MYSQL = 0;  
   private static final String MySQLDriver = "com.mysql.jdbc.Driver";  
  
   public static Connection conexao(String url, String nome, String senha,  
         int banco) throws ClassNotFoundException, SQLException 
         {  
      switch (banco) 
      {        
      case MYSQL:           
         Class.forName(MySQLDriver);  
         break;  
      }  
      return DriverManager.getConnection(url, nome, senha);  
   }  
 //Dados parar a conexão com o banco
 		protected final String URL = "jdbc:mysql://localhost:3306/tam";
 		protected final String NOME = "root";
 		protected final String SENHA = "";
 		
 		public Connection con; 
 		public Statement comando;
 		 
 		protected void conectar() {  
 		      try {  
 		         con = AcessoBDMySQL.conexao(URL, NOME, SENHA, AcessoBDMySQL.MYSQL);  
 		         comando = con.createStatement();  
 		         System.out.println("Conectado!");  
 		      } catch (ClassNotFoundException e) {  
 		         imprimeErro("Erro ao carregar o driver", e.getMessage());  
 		      } catch (SQLException e) {  
 		         imprimeErro("Erro ao conectar", e.getMessage());  
 		      }  
 		   }  
 		  
 		protected void fechar() {  
 		      try {  
 		         comando.close();  
 		         con.close();  
 		         System.out.println("Conexão Fechada");  
 		      } catch (SQLException e) {  
 		         imprimeErro("Erro ao fechar conexão", e.getMessage());  
 		      }  
 		   }  
 		   
 		protected void imprimeErro(String msg, String msgErro) 
		   {  
			      //.showMessageDialog(null, msg, "Erro crítico", 0);  
			      System.err.println(msg);  
			      System.out.println(msgErro);  
			      System.exit(0);  
		   }
 		  
 		  
}  




