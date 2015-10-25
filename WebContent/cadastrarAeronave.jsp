<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="DAO.*, Model.*"%>
<%@page import="Internacionalizacao.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ include file="Include/verificaIdioma.jsp" %>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%= idioma.CadastrarAeronave %></title>
</head>
<body>
<!-- FUNÇÕES -->
	<%
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
	
	
	
	
<!-- Formulario -->

<h1><%=idioma.CadastrarAeronave %></h1>



<form action="MainController" method="post">
	<input type = "hidden" name = "categoria" value = "aeronave">
		
		<table>
			<tbody>		
			
			
				<!-- Nome -->
				<tr>
					<td><label><%=idioma.NomeAeronave %></label></td>
					<td><input type="text" maxlength="45" 
							size="45" tabindex="1" name="NomeAeronave">
					</td>
				</tr>			
				
				
				<!-- Modelo -->
				<tr>
					<td><label><%=idioma.ModeloAeronave %></label></td>
					<td>
					 <input type="text" maxlength="45" size="45" tabindex="2" name="ModeloAeronave">
					</td>
				</tr>
				
				
				<!-- Colunas de assento -->
				<tr>
					<td><label><%=idioma.QuantidadeColunas %></label></td>
					
					<td>
					 <input type="text" maxlength="11" size="11" tabindex="3" name="QuantidadeColunas">
					</td>
					
				</tr>
				
				
				<!-- Quantidade de Fileiras -->
				<tr>
					<td><label><%=idioma.QuantidadeFileiras %></label></td>
			
					<td>
					 <input type="text" maxlength="11" size="11" tabindex="4" name="QuantidadeFileiras">
					</td>
				</tr>
				
				
				<!-- BOTÕES -->
				<tr>
					<td colspan="2">
						<button type="submit" name="operacao" value="cadastrar" tabindex="13"><%=idioma.Cadastrar %></button>
						<button type="reset" name="limpar" tabindex="14"><%=idioma.Limpar %></button>
					</td>
				</tr>
				
				<!-- Retorna para pagina daonde veio -->
				<tr>
					<td colspan="1">
						&nbsp;
						<button type="submit" name="operacao" value = "voltar" tabindex="13"><%=idioma.Voltar %></button>
						<!-- <input type="button" name="voltar" tabindex="99" value="Voltar" 
						onclick="location.href = 'principal.jsp'"> -->
						
						
					</td>
				</tr>
				 


			</tbody>
		</table>
	</form>
	<!-- FIM -->
</body>
</html>