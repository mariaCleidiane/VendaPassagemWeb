<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="DAO.PassageiroDAO, Model.Passageiro" %>
<%@ include file="Include/verificaIdioma.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%=idioma.AlterarPassageiro %></title>
	</head>
	
	<body>
	<!-- FUNÇÕES -->
	
		<%
		String disabled = "disabled",readOnly = "readonly", readOnlyCod = "", checkedM= "", checkedF="",
		codPassageiro, nomePassageiro = "" , sobrenomePassageiro = "",
		generoPassageiro = "", rgPassageiro= "", cpfPassageiro= "",
		tratamentoPassageiro= "", diaNascimento= "", mesNascimento = "", anoNascimento="",
		celularPassageiro= "",emailPassageiro = "";
		if(request.getParameter("CodigoPassageiro") == null)codPassageiro =  "";else codPassageiro = request.getParameter("CodigoPassageiro");
		
		//Exibe mensagem para o usuário.
				String msg = (String) request.getAttribute("mensagemRetorno");
				if(msg != null && msg != "")
				{
					%>
					<script type="text/javascript">
						alert('<%=msg%>');
					</script>
					<%
					
					checkedM= ""; checkedF="";
					 
					readOnly = "readonly";	
					readOnlyCod = "";
					disabled = "disabled";	
				
				}
		
		Passageiro passageiro = (Passageiro) request.getAttribute("passageiro");
	
		if(passageiro != null) 
		{
			codPassageiro = request.getParameter("CodigoPassageiro");
			nomePassageiro = passageiro.getNomePassageiro();
			sobrenomePassageiro = passageiro.getSobrenomePassageiro();
			generoPassageiro= passageiro.getGeneroPassageiro();
			
			if(generoPassageiro.equals("M"))
			{
				checkedM = "checked";
			}
			else
			{
				checkedF = "checked";
			}
			
			rgPassageiro= passageiro.getRG();
			cpfPassageiro = passageiro.getCPF();
			tratamentoPassageiro= passageiro.getTratamentoPassageiro();
			diaNascimento= Integer.toString(passageiro.getDiaNascimento());
			mesNascimento = Integer.toString(passageiro.getMesNascimento());
			anoNascimento= Integer.toString(passageiro.getAnoNascimento());
			celularPassageiro= passageiro.getCelularPassageiro();
			emailPassageiro = passageiro.getEmailPassageiro();
			
			readOnly = "";	
			readOnlyCod = "readonly";
			disabled = "";
		}
					
		
		
		if("limpar".equals(request.getParameter("operacaoPagina")))
		{
			codPassageiro = ""; nomePassageiro = ""; sobrenomePassageiro = "";
					generoPassageiro = ""; rgPassageiro= ""; cpfPassageiro= "";
					tratamentoPassageiro= ""; diaNascimento= ""; mesNascimento = ""; anoNascimento="";
					celularPassageiro= "";emailPassageiro = "";
					 checkedM= ""; checkedF="";
		}
		
	%>
	
<!-- Formulario -->

<h1><%=idioma.AlterarPassageiro%></h1>

		<form action="MainController" method="post">
			<input type = "hidden" name = "categoria" value = "passageiro">
				<input type = "hidden" name = "pagina" value = "alterar">
					<table>
						<tbody>		
						
							<!-- CodigoPassageiro -->
							<tr>
								<td><label><%= idioma.CodigoPassageiro %></label></td>
								<td><input <%=readOnlyCod %> type="text" maxlength="45" 
										size="45" tabindex="1" name="CodigoPassageiro" value="<%=codPassageiro %>" >
								</td>
							</tr>	
							
							<!-- NomePassageiro -->
							<tr>
								<td><label><%= idioma.Nome %></label></td>
								<td><input <%=readOnly%> type="text" maxlength="45" 
										size="45" tabindex="1" name="NomePassageiro" value="<%=nomePassageiro %>">
								</td>
							</tr>			
							
							<!-- SobrenomePassageiro -->
							
							<tr>
								<td><label><%= idioma.Sobrenome %></label></td>
								<td><input <%=readOnly%> type="text" maxlength="45" 
										size="45" tabindex="2" name="SobrenomePassageiro" value="<%=sobrenomePassageiro %>">
								</td>
							</tr>		
							
								<!-- GeneroPassageiro -->				
							<tr>
								<td><label><%= idioma.Genero %></label></td>
								<td colspan="2"><%=idioma.Masculino %><input  <%=readOnly%> <%=checkedM%> type="radio" name="Genero" value="M">
									<%=idioma.Feminino %><input  <%=readOnly%> <%=checkedF%> type="radio" name="Genero" value="F">
								</td>
							</tr>	
							
					            <!-- RGPassageiro -->
					        <tr>
								<td><label><%= idioma.RG %></label></td>
								<td><input <%=readOnly%> type="text" maxlength="15" 
										size="20" tabindex="4" name="RGPassageiro" value="<%=rgPassageiro %>">
								</td>
							</tr>
					            <!-- CPFPassageiro -->
					        <tr>
								<td><label><%= idioma.CPF %></label></td>
								<td><input <%=readOnly%> type="text" maxlength="11" 
										size="15" tabindex="5" name="CPFPassageiro" value="<%=cpfPassageiro %>">
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
									<input <%=readOnly%> type="text" maxlength="2" 
										size="2" tabindex="7" name="DiaNascimento" value="<%=diaNascimento %>">
									<!-- MesNascimento -->
									<input <%=readOnly%> type="text" maxlength="2" 
										size="2" tabindex="8" name="MesNascimento" value="<%= mesNascimento %>">
									 <!-- AnoNascimento -->
									 <input <%=readOnly%> type="text" maxlength="4" 
										size="4" tabindex="9" name="AnoNascimento" value="<%=anoNascimento %>">
								</td>
							</tr>
							
					            <!-- CelularPassageiro -->
					        <tr>
								<td><label><%= idioma.Celular %></label></td>
								<td><input <%=readOnly%> type="text" maxlength="15" 
										size="35" tabindex="10" name="CelularPassageiro" value="<%=celularPassageiro %>">
								</td>
							</tr>
					            <!-- EmailPassageiro -->
					        <tr>
								<td><label><%= idioma.Email %></label></td>
								<td><input <%=readOnly%> type="text" maxlength="45" 
										size="50" tabindex="11" name="EmailPassageiro" value="<%=emailPassageiro %>">
								</td>
							</tr>
							
		
							<!-- Limpa tabela e executa o jsp -->
							<tr>
								<td colspan="2">
								<button type="submit" name="operacao" value = "buscarPassageiro" tabindex="13"><%= idioma.Pesquisar %></button>
								<button <%=disabled%> type="submit" name = "operacao" value = "alterarPassageiro" tabindex="14"><%= idioma.Alterar %></button>
									
									<!-- <input type="submit" name="operacao" value="Procurar" tabindex="13">
									<input <%=disabled%> type="submit" name="operacao" value="Alterar" tabindex="14">
									<input type="submit" name="operacao" value="Limpar" tabindex="15">
									 -->
									
								</td>
							</tr>
							
							<!-- Retorna para pagina daonde veio -->
							<tr>
								<td colspan="2">
									&nbsp;
									<!-- <input type="button" name="voltar" tabindex="15" value="Voltar" 
									onClick="location.href='principal.jsp'"/> -->
									<button type="submit" name="Voltar" value="Voltar" tabindex="13"><%= idioma.Voltar %></button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<!-- Operação de limpar na própria página -->
				<form action="alterarPassageiro.jsp">
					<button type = "submit" name = "operacaoPagina" value = "limpar"><%=idioma.Limpar %></button>
				</form>
		<!-- FIM -->
	</body>
</html>
