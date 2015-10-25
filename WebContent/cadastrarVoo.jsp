<%@page import="DAO.VooDAO"%>
<%@page import="com.sun.corba.se.spi.legacy.connection.GetEndPointInfoAgainException"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="Model.Voo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "DAO.AeroportoDAO" %>
<%@page import = "Model.Aeroporto" %>
<%@page import = "DAO.AeronaveDAO" %>
<%@page import = "Model.Aeronave" %>
<%@ include file="Include/verificaIdioma.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.CadastrarVoo %></title>
</head>
<body>

</head>


<h1><%=idioma.CadastrarVoo %></h1>

<!-- FUNÇÕES -->
<%
	//Preeche a origem 
		//Objeto de DAO
		Aeroporto aeroportoDAO = new Aeroporto();
		
		//ArrayList Origem e Destino
		 ArrayList<Aeroporto> origem = new ArrayList<Aeroporto>();
		 ArrayList<Aeroporto> destino = new ArrayList<Aeroporto>();
		 
		
		 //Lista com os aeroportos
		origem = aeroportoDAO.buscarAeroporto();
		destino = aeroportoDAO.buscarAeroporto();
		
		//Preeche Aeronaves 
			//Objeto de DAO
			Aeronave aeronave = new Aeronave();
			//ArrayList Aeronave
			 ArrayList<Aeronave> aero = new ArrayList<Aeronave>();
			//Lista com as aeronaves
			aero = aeronave.buscarTodos();
			
			//Exibe mensagem para o usuário.
			String msg = (String) request.getAttribute("mensagemRetorno");
			if(msg != null && msg != "")
			{
				%>
				<script type="text/javascript">
					alert('<%=msg%>');
				</script>
				<%
			}
			
		%>

<!-- FORMULÁRIO -->
<form action="MainController" method="post">
			<input type="hidden" name="categoria" value="voo">
			<table>
				<tbody>		
				
				
					<!-- ORIGEM -->
					<tr>
						<td><label><%=idioma.Origem %></label></td>
						<td><select name = "listaAeroportoOrigem">
							<% for(Aeroporto a : origem)
							{ %>
							<option value = "<%=a.getCodAeroporto()%>"> <%=a %></option>
							<%} %>
							</select>
						</td>
					</tr>	
					<!-- DESTINO -->
					<tr>
						<td><label><%=idioma.Destino %></label></td>
						<td><select name = "listaAeroportoDestino">
							<% for(Aeroporto a : destino)
							{ %>
							<option value = "<%=a.getCodAeroporto() %>"> <%=a %></option>
							<%} %>
							</select>
						</td>
					</tr>			
							
					<!-- DATA -->
					<tr>
						<td><label><%=idioma.Data %></label></td>
						<td><input type = "text" name = "diaVoo" size = 2 tabindex = "1"> /
						    <input type = "text" name = "mesVoo" size = 2 tabindex = "2"> / 
						    <input type = "text" name = "anoVoo" size = 4 tabindex = "3">							
						</td>
					</tr>			
					
					
					<!-- HORA -->
					<tr>
						<td><label><%=idioma.Hora %></label></td>
						<td><input type = "text" name = "horaVoo" size = 2 tabindex = "4"> :
						    <input type = "text" name = "minVoo" size = 2 tabindex = "5"> 
						</td>
					</tr>			
					
									
					<!-- AERONAVES -->
					<tr>
						<td><label><%=idioma.Aeronave %></label></td>
						<td><select name = "listaAeronave">
							<% for(Aeronave a : aero)
							{ %>
							<option value="<%=a.getCodAeronave() %>"> <%=a.getNomeAeronave() %></option>
							<%} %>
							</select>
						</td>
					</tr>
					
					<!-- PREÇO -->
					<tr>
						<td><label><%=idioma.Preco %></label></td>
						<td><input type = "text" name = "precoVoo" size = "10" tabindex = "8">
						</td>
					</tr>
					
					<!-- SITUAÇÃO -->
					<tr>
						<td><label><%=idioma.Situacao %></label></td>
						<td><select name = "situacaoVoo">
						  	<option value = "EmEspera"><%=idioma.EmEspera %> </option>
						  	<option value = "Confirmado"><%=idioma.Confirmado %> </option>
						  	<option value = "Encerrado"><%=idioma.Encerrado %> </option>
						  </select>

						</td>
					</tr>			
								
								
			
						
					
			
					
					
					<!-- Retorna para pagina daonde veio -->
					<tr>
						<td colspan="2">
							&nbsp;
							
							<button type="submit" name = "operacao" value = "voltar" tabindex="15"><%=idioma.Voltar %></button>
							<!--<input type="button" name="voltar" tabindex="15" value="Voltar" 
							onClick="history.back()"/>  -->
							
						</td>
					</tr>
					
					
					<!-- BOTÕES -->
					<tr>
						<td colspan="2">
						<button type="submit" name="operacao" value = "cadastrarVoo" tabindex="13"><%=idioma.Cadastrar %></button>
						<button type="reset" name="operacao" value = "Limpar" tabindex="14"><%=idioma.Limpar %></button>
						</td>
					</tr>

				</tbody>
			</table>
		</form>

		






	
</body>
</html>