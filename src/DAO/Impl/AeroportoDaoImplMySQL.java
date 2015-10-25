package DAO.Impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Model.Aeronave;
import Model.Aeroporto;

public class AeroportoDaoImplMySQL extends DAO.banco.AcessoBDMySQL implements AeroportoDaoInterface
{

		   public ArrayList<Aeroporto> buscarAeroporto()
		   {
			   conectar();  
			      ArrayList<Aeroporto> resultados = new ArrayList<Aeroporto>();  
			      ResultSet rs;  
			      try {  
			         rs = comando.executeQuery("SELECT * FROM aeroporto");  
			         while (rs.next()) {  
			            Aeroporto temp = new Aeroporto();  
			            // pega todos os atributos da aeronave  
			            temp.setCodAeroporto(rs.getInt("codAeroporto"));
			            temp.setNomeAeroporto(rs.getString("nomeAeroporto"));
			            temp.setSiglaAeroporto(rs.getString("siglaAeroporto"));
			            temp.setIcao(rs.getString("icao"));
			            temp.setEstadoAeroporto(rs.getString("estadoAeroporto"));
			            temp.setCidadeAeroporto(rs.getString("cidadeAeroporto"));
			            resultados.add(temp);  
			         }  
			         return resultados;  
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao buscar aeroporto", e.getMessage());  
			         return null;  
			      }  
			 
		   }
		   
		   public Aeroporto buscarPorCodigoAeroporto(int codigo)
		   {
			   conectar();  
			   	Aeroporto temp = null;
			      ResultSet rs;  
			      try {  
			         rs = comando.executeQuery("SELECT * FROM aeroporto WHERE codAeroporto=" + codigo);  
			         
			         while (rs.next()) {  
			            temp = new Aeroporto();  
			            // pega todos os atributos da aeronave  
			            temp.setCodAeroporto(rs.getInt("codAeroporto"));
			            temp.setNomeAeroporto(rs.getString("nomeAeroporto"));
			            temp.setSiglaAeroporto(rs.getString("siglaAeroporto"));
			            temp.setIcao(rs.getString("icao"));
			            temp.setEstadoAeroporto(rs.getString("estadoAeroporto"));
			            temp.setCidadeAeroporto(rs.getString("cidadeAeroporto"));  
			         }  
			         return temp;  
			      } catch (SQLException e) {  
			         imprimeErro("Erro ao buscar aeroporto", e.getMessage());  
			         return null;  
			      }  
			 
		   }

		
}
