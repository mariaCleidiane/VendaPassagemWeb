<%@page import="DAO.PassagemDAO"%>
<%@page import="Model.Passagem"%>
<%@page import="Model.Voo"%>
<%@page import="DAO.VooDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Assento"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="Include/verificaIdioma.jsp" %>
    <%@ page import = "Model.Aeronave, Model.Assento, DAO.AssentoDAO, DAO.AeronaveDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.RealizarCheckIn %></title>

</head>
<body>
<%
		
		Aeronave aeronave = (Aeronave) request.getAttribute("Aeronave");
		ArrayList<Assento> assentoList = (ArrayList<Assento>) request.getAttribute("AssentoList");
		String nomeAeronave = (String) request.getAttribute("NomeAeronave");
%>
	
	<center><h3><%=nomeAeronave %></h3></center>
	<form action="MainController" method="post">
		<input type = "hidden" name = "categoria" value = "checkIn">
			<input type="hidden" name="pagina" value="EscolherAssento">
       

		<% int cont = 0;
		
		int n_colunas = aeronave.getQtdAssento() / aeronave.getQtdFileiras();
		
		for(int coluna = 0; coluna < n_colunas; coluna++)
        	{
       			 for(int fileira = 0; fileira < aeronave.getQtdFileiras(); fileira++)
       	 		 {%>
       		 		<input type = "radio" 
       		 		<%if(assentoList.get(cont).getDiponibilidade() == true)
       		 		{
       		 			%> disabled="disabled" <% 
       		 		}
       		 		%> 
       		 		name = "assento" value = "<%=assentoList.get(cont).getCodAssento() %>"><%=""+assentoList.get(cont).getFileiraAssento()+assentoList.get(cont).getColunaSiglaAssento() 
       		 		 %>
       	 		  <% cont++;
       		 		}
       			 %> <br /> <% 
        	} %>
        	
			 <table>
				<tbody>	
		
	       			<tr>
						<td colspan="2"><button type = "submit" name = "Salvar" value = "Salvar"><%=idioma.Salvar %></button>
						
						<button type = "submit" name = "Voltar" value = Voltar><%=idioma.Voltar%></button>
						</td>
					</tr>	
				</tbody>
			</table>
	</form>
</body>
</html>