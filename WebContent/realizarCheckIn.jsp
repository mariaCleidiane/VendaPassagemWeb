<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
    <%@ include file="Include/verificaIdioma.jsp" %>
       <%@page import="DAO.PassageiroDAO, Model.Passageiro, DAO.PassagemDAO, Model.Passagem, DAO.VooDAO, Model.Voo "%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.CheckIn %></title>
</head>
<body>


	<!-- FUNÇÕES -->
	
		<%		
			String checkIn ="";
			if(request.getAttribute("checkInVar") != null)
			{	
				checkIn = Boolean.parseBoolean(request.getAttribute("checkInVar").toString()) ? idioma.Sim : idioma.Nao;
			}
				
			String mensagem = (String) request.getAttribute("mensagem");
			
			if(mensagem != null && mensagem != "")
			{
				%>
				<script type="text/javascript">
							alert('<%=mensagem%>');
				</script>
				
				<%
			}


		
		%>
		
<!-- Formulario -->

<h1><%=idioma.RealizarCheckIn %></h1>

<form action="MainController" method="post">
	<input type = "hidden" name = "categoria" value = "checkIn">
			<input type="hidden" name="pagina" value="realizarCheckIn">
			<table>
				<tbody>		
				
				
					<!-- CÓDIGO PASSAGEM -->
					<tr>
						<td><label><%=idioma.CodigoPassagem %></label></td>
						<td><input type="text" maxlength="20" size="20" tabindex="1" name="codPassagem">
						<button type = "submit" name = "BuscarPassagem" value = "BuscarPassagem" ><%=idioma.Buscar %></button>
						</td>
					</tr>			
				
					<!-- NOME PASSAGEIRO -->
					<tr>
						<td><label><%=idioma.Nome %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="nomePassageiro" value = "<%=request.getAttribute("nomePassageiro") %>" readonly = "true">
						</td>
					</tr>			
					
					<!-- CPF -->
					<tr>
						<td><label><%=idioma.CPF %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="cpfPassageiro" value = "<%=request.getAttribute("cpfPassageiro") %>" readonly = "true">
						</td>
					</tr>			
					
					<!-- DATA NASCIMENTO -->
					<tr>
						<td><label><%=idioma.Nome %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="dataNascPassageiro" value = "<%=request.getAttribute("dataNascPassageiro")  %>" readonly = "true">
						</td>
					</tr>			
					
					<!-- INFO PASSAGEM  -->

				
					<!-- ORIGEM -->
					<tr>
						<td><label><%=idioma.Origem %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="origemVoo" value = "<%=request.getAttribute("origemVoo")%>" readonly = "true">
						</td>
					</tr>
					
					<!-- DESTINO -->
					<tr>
						<td><label><%=idioma.Destino %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="destinoVoo" value = "<%=request.getAttribute("destinoVoo")%>"  readonly = "true">
						</td>
					</tr>			
							
					<!-- DATA -->
					<tr>
						<td><label><%=idioma.DataPartida %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="dataPartida" value = "<%=request.getAttribute("dataPartida")%>" readonly = "true">
						</td>
					</tr>			
					
					<!-- VALOR -->
					<tr>
						<td><label><%=idioma.Preco %></label></td>
						<td><input type="text" maxlength="15" size="15" tabindex="1" name="precoPassagem" value = "<%=request.getAttribute("precoPassagem")%>" readonly = "true">
						</td>
					</tr>			
					
					 <!-- CHECK-IN -->
					 <tr>
						<td><label><%=idioma.CheckIn %></label></td>
						<td><input type="text" maxlength="4" size="4" tabindex="1" name="checkIn" value = "<%=checkIn%>" readonly = "true">
						</td>
					</tr>			
					
					<!-- BOTÕES -->
					<tr>
						<td colspan="2"><button type = "submit" name = "Voltar" value = "Voltar"><%=idioma.Voltar %></button>
						<button type = "submit" name = "Limpar" value = "Limpar"><%=idioma.Limpar %></button>
						</td>
					</tr>			
					
					<!-- CHECK-IN -->
					<tr>
						<td colspan="2"><center><button <%=request.getAttribute("disabled") !=null ? request.getAttribute("disabled") : "disabled" %> type = "submit" name = "CheckIn" value = "CheckIn"><%=idioma.RealizarCheckIn %></button></center>
						</td>
					</tr>
					
					
				</tbody>
			</table>
		</form>
</body>
</html>