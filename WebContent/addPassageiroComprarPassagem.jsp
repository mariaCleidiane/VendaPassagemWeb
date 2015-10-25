<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="Include/verificaIdioma.jsp" %>

<%@page import="DAO.PassageiroDAO, Model.Passageiro"%>
<%@page import="Internacionalizacao.Internacionalizacao" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%= idioma.CadastrarPassageiro %></title>
	</head>

	<body>
	<!-- FUNÇÕES -->
	<% 
				String msg = (String) request.getAttribute("mensagem");
				if(msg != null && msg != "" && msg != "Erro ao cadastrar!")
				{
					%>
					<script type="text/javascript">
						alert('<%=msg%>');
					</script>
					<%
				}
				else if( msg == "Erro ao cadastrar!")
					{			
				%><script type="text/javascript">
						if (confirm("Ocorreu um erro no cadastro. Deseja tentar novamente?"))
								location.href="addPassageiroComprarPassagem.jsp";
						else
								location.href = "consultarVooComprarPassagem.jsp";
					</script>
				<% }		
	%>
<!-- Formulario -->

<h1><%= idioma.CadastrarPassageiro %></h1>

		<form action="MainController" method="post">
		<input type="hidden" name="categoria" value="ComprarPassagem">
			<input type="hidden" name="pagina" value="AddPassageiro">
			<table>
				<tbody>		
					<!-- NomePassageiro -->
					<tr>
						<td><label><%= idioma.Nome %></label></td>
						<td><input type="text" maxlength="45" 
								size="45" tabindex="1" name="NomePassageiro">
						</td>
					</tr>			
					
					<!-- "SobrenomePassageiro" -->
					
					<tr>
						<td><label><%= idioma.Sobrenome %></label></td>
						<td><input type="text" maxlength="45" 
								size="45" tabindex="2" name="SobrenomePassageiro">
						</td>
					</tr>		
						<!-- GeneroPassageiro -->
					<tr>
						<td><label><%= idioma.Genero %></label></td>
						<td colspan="2"><%= idioma.Masculino %><input checked type="radio" name="Genero" value="M">
							<%= idioma.Feminino %><input type="radio" name="Genero" value="F">
						</td>
					</tr>	
			            <!-- RGPassageiro -->
			        <tr>
						<td><label><%= idioma.RG %></label></td>
						<td><input type="text" maxlength="15" 
								size="20" tabindex="4" name="RGPassageiro">
						</td>
					</tr>
			            <!-- CPFPassageiro -->
			        <tr>
						<td><label><%= idioma.CPF %></label></td>
						<td><input type="text" maxlength="11" 
								size="15" tabindex="5" name="CPFPassageiro">
						</td>
					</tr>
			      
			       <!-- TratamentoPassageiro -->
			       <tr>
						<td><label><%=idioma.Tratamento %></label></td>
						<td><select name = "TratamentoPassageiro">
						  	<option value = "Senhor"><%=idioma.Senhor %> </option>
						  	<option value = "Senhora"><%=idioma.Senhora %> </option>
						  	<option value = "Senhorita"><%=idioma.Senhorita %> </option>
						  </select>

						</td>
					</tr>			

								            <!-- DATA DE NASCIMENTO -->			            
					<tr>
						<td><label><%= idioma.DataDeNascimento %></label></td>
						<td colspan="3">
							&nbsp;
							<!-- DiaNascimento -->
							<input type="text" maxlength="2" 
								size="2" tabindex="7" name="DiaNascimento">
							<!-- MesNascimento -->
							<input type="text" maxlength="2" 
								size="2" tabindex="8" name="MesNascimento">
							 <!-- AnoNascimento -->
							 <input type="text" maxlength="4" 
								size="4" tabindex="9" name="AnoNascimento">
						</td>
					</tr>
					
			            <!-- CelularPassageiro -->
			        <tr>
						<td><label><%= idioma.Celular %></label></td>
						<td><input type="text" maxlength="15" 
								size="35" tabindex="10" name="CelularPassageiro">
						</td>
					</tr>
			            <!-- EmailPassageiro -->
			        <tr>
						<td><label><%= idioma.Email %></label></td>
						<td><input type="text" maxlength="45" 
								size="50" tabindex="11" name="EmailPassageiro">
						</td>
					</tr>
					
					<!-- Limpa tabela e executa o jsp -->
					<tr>
						<td colspan="2">
							<button type="submit" name="Cadastrar" value ="Cadastrar" tabindex="13"><%= idioma.Cadastrar %></button>
							<button type="reset" name="limpar" tabindex="14"><%= idioma.Limpar %></button>
						</td>
					</tr>
					
					<!-- Retorna para pagina daonde veio -->
					<tr>
						<td colspan="2">
							&nbsp;
							<button type="submit" name="Voltar" value = "Voltar" tabindex="15"><%=idioma.Voltar %></button>
							
							
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		
		<!-- FIM -->
	</body>
</html>
