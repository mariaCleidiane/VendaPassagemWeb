<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="Include/verificaIdioma.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	</head>


	<body>
	<!-- FUNÇÕES -->
	
		<%
				
			if("PREENCHER".equals(request.getParameter("PREENCHER"))) 
			{
	
				
				
			}
		
		%>
	
<!-- Formulario -->

<h1>insert title here</h1>

		<form action="insert.jsp" method="get">
			<input type="hidden" name="insert" value="insert">
			<table>
				<tbody>		
				
				
					<!-- insert -->
					<tr>
						<td><label>insert</label></td>
						<td><input type="text" maxlength="45" 
								size="45" tabindex="1" name="insert">
						</td>
					</tr>			
					
					
					
					<!-- Retorna para pagina daonde veio -->
					<tr>
						<td colspan="2">
							&nbsp;
							<input type="button" name="voltar" tabindex="15" value="Voltar" 
							onClick="history.back()"/>
						</td>
					</tr>
					
					
					<!-- Limpa tabela e executa o jsp -->
					<tr>
						<td colspan="2">
							<button type="submit" name="Cadastrar" tabindex="13">Cadastrar</button>
							<button type="reset" name="limpar" tabindex="14">Limpar</button>
						</td>
					</tr>

				</tbody>
			</table>
		</form>
		
		
		
		<body>
<!-- Formulario -->

<h1><%=idioma.TransferirPassagem %></h1>

		<form action="transferirPassagem.jsp" method="get">
			<input type="hidden" name="transferirPassagem" value="transferirPassagem">
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
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="nomePassageiro" readonly = "true">
						</td>
					</tr>			
					
					<!-- CPF -->
					<tr>
						<td><label><%=idioma.CPF %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="cpfPassageiro" readonly = "true">
						</td>
					</tr>			
					
					<!-- DATA NASCIMENTO -->
					<tr>
						<td><label><%=idioma.Nome %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="dataNascPassageiro" readonly = "true">
						</td>
					</tr>			
					
					<!-- INFO PASSAGEM  -->
					<tr>
						<td><hr></td>
						
					</tr>			
				
					<!-- ORIGEM -->
					<tr>
						<td><label><%=idioma.Origem %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="origemVoo" readonly = "true">
						</td>
					</tr>
					
					<!-- DESTINO -->
					<tr>
						<td><label><%=idioma.Destino %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="destinoVoo" readonly = "true">
						</td>
					</tr>			
							
					<!-- DATA -->
					<tr>
						<td><label><%=idioma.DataPartida %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="dataPartida" readonly = "true">
						</td>
					</tr>			
					
					<!-- VALOR -->
					<tr>
						<td><label><%=idioma.Preco %></label></td>
						<td><input type="text" maxlength="15" size="15" tabindex="1" name="precoPassagem" readonly = "true">
						</td>
					</tr>			
					
					 <!-- CHECK-IN -->
					 <tr>
						<td><label><%=idioma.CheckIn %></label></td>
						<td><input type="text" maxlength="4" size="4" tabindex="1" name="checkIn" readonly = "true">
						</td>
					</tr>			
					
					<!-- BOTÕES -->
					<tr>
						<td colspan="2"><button type = "submit" name = "Voltar" value = "Voltar"><%=idioma.Voltar %></button>
						<button type = "reset" name = "Limpar" value = "Limpar"><%=idioma.Limpar %></button>
						</td>
					</tr>			
					
					<!-- TRANSFERIR -->
					<tr>
						<td colspan="2"><center><button type = "submit" name = "Transferir" value = "Transferir"><%=idioma.TransferirPassagem %></button></center>
						</td>
					</tr>
					
					
				</tbody>
			</table>
		</form>
		
		
		<!-- FIM -->
	</body>
</html>
