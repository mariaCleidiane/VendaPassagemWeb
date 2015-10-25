<%@page import="Internacionalizacao.Internacionalizacao"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="DAO.*, Model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="Include/verificaIdioma.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%=idioma.ConsultarPassageiro %></title>
	</head>
	


	<body>
	<!-- FUNÇÕES -->

	
		<%
		
		String  codPassageiro = "", nomePassageiro = "" , sobrenomePassageiro = "",
				generoPassageiro = "", rgPassageiro= "", cpfPassageiro= "",
				tratamentoPassageiro= "", diaNascimento= "", mesNascimento = "", anoNascimento="",
				celularPassageiro= "",emailPassageiro = "";
				
				//Pega o ArrayList da PassageiroController
				ArrayList<Passageiro> passList = (ArrayList<Passageiro>) request.getAttribute("passList");
					
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
				
				Passageiro passageiro = (Passageiro) request.getAttribute("passageiro");	
				if(passageiro != null) 
				{
					codPassageiro = String.valueOf(passageiro.getCodPassageiro());
					nomePassageiro = passageiro.getNomePassageiro();
					sobrenomePassageiro = passageiro.getSobrenomePassageiro();
					generoPassageiro= passageiro.getGeneroPassageiro();
					rgPassageiro= passageiro.getRG();
					cpfPassageiro = passageiro.getCPF();
					tratamentoPassageiro= passageiro.getTratamentoPassageiro();
					diaNascimento= Integer.toString(passageiro.getDiaNascimento());
					mesNascimento = Integer.toString(passageiro.getMesNascimento());
					anoNascimento= Integer.toString(passageiro.getAnoNascimento());
					celularPassageiro= passageiro.getCelularPassageiro();
					emailPassageiro = passageiro.getEmailPassageiro();

				}
						
				
				if("limpar".equals(request.getParameter("operacaoPagina")))
				{
					codPassageiro  = "";
					nomePassageiro   = "";
					sobrenomePassageiro  = ""; 
					generoPassageiro = "";
					rgPassageiro  = "";
					cpfPassageiro = "";
					tratamentoPassageiro = "";
					diaNascimento = "";
					mesNascimento  = "";
					anoNascimento = "";
					celularPassageiro = "";
					emailPassageiro  = "";
				}
				
				
			
		%>
	
<!-- Formulario -->

<h1><%=idioma.ConsultarPassageiro %></h1>

		<form action="MainController" method="post">
			<input type="hidden" name = "categoria" value= "passageiro">
			<table>
				<tbody>		
				
				
					<!-- codigo da Passageiro -->
					<tr>
						<td><label><%=idioma.CodigoPassageiro %></label></td>
						<td><input type="text" maxlength="11"
							size="11" tabindex="1" name="CodigoPassageiro">
						</td>
					</tr>			
					
				<!-- Nome -->
				<tr>
					<td><label><%=idioma.Nome %></label></td>
					<td><input type="text" maxlength="45" 
							size="45" tabindex="2" name="NomePassageiro">
					</td>
				</tr>			
				
				
				<!-- Sobrenome -->
				<tr>
					<td><label><%=idioma.Sobrenome %></label></td>
					<td>
					 <input type="text" maxlength="45" size="45" tabindex="3" name="ModeloPassageiro">
					</td>
				</tr>
				
						<!-- GeneroPassageiro -->
					<tr>
						<td><label><%= idioma.Genero %></label></td>
						<td colspan="2"><%= idioma.Masculino %><input type="radio" name="Genero" value="M">
							<%= idioma.Feminino %><input type="radio" name="Genero" value="F">
							<%= idioma.Ambos %><input checked type="radio" name="Genero" value="">
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
						<td><label><%= idioma.Tratamento%></label></td>
						<td><input type="text" maxlength="20" 
								size="25" tabindex="6" name="TratamentoPassageiro">
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
							<button type="submit" name="operacao" value = "buscarPassageiroGenerico" tabindex="13"><%=idioma.Consultar %></button>
							<button type="reset" name="limpar" tabindex="14"><%=idioma.Limpar %></button>
						</td>
					</tr>
					
					<!-- Retorna para pagina daonde veio -->
					<tr>
						<td colspan="2">
							&nbsp;
							<button type="submit" name= "operacao" value="voltar" tabindex="15"><%= idioma.Voltar %></button>
						
							<!--<input type="button" name="voltar" tabindex="15" value="Voltar" 
							onClick="location.href = 'principal.jsp'"/>  -->
						</td>
					</tr>
					
				</tbody>
			 </table>
		</form>
		
		<hr>
		
		<form action= "MainController" method="post">
			<input type = "hidden" name = "categoria" value = "passageiro">
				<input type = "hidden" name = "pagina" value = "consultar">
					<table>
					
						<tr>
							<td><label><%= idioma.ListaDePassageiro %></label></td>
							<td>
								<select name = "CodigoPassageiro">
									<%try{ for(Passageiro a : passList)
									{ %>
									<option value = "<%=a.getCodPassageiro()%>"> <%=a %></option>
									<%} } catch(Exception e){} %>
								</select>
							</td>
						</tr>
					
						 <tr>
							<td colspan="2">
								<button type="submit" name="operacao" value = "buscarPassageiro" tabindex="13"><%= idioma.Detalhes %></button>
							</td>
						</tr>
					</table>
					
					<table border="1px" > 
					 
							<!-- Tabela Labels -->
							<tr align="center" >
								<td><label><%=idioma.CodigoPassageiro %></label></td>
								<td><label><%=idioma.Nome %></label></td>
								<td><label><%=idioma.Sobrenome %></label></td>
								<td><label><%=idioma.Genero %></label></td>
								<td><label><%=idioma.RG %></label></td>
								<td><label><%=idioma.CPF %></label></td>
								<td><label><%=idioma.Tratamento %></label></td>
								<td><label><%=idioma.Dia %></label></td>
								<td><label><%=idioma.Mes %></label></td>
								<td><label><%=idioma.Ano %></label></td>
								<td><label><%=idioma.Celular %></label></td>
								<td><label><%=idioma.Email %></label></td>
							</tr>
							
							<!--checkedM= "", checkedF="",
						codPassageiro, nomePassageiro = "" , sobrenomePassageiro = "",
						generoPassageiro = "", rgPassageiro= "", cpfPassageiro= "",
						tratamentoPassageiro= "", diaNascimento= "", mesNascimento = "", anoNascimento="",
						celularPassageiro= "",emailPassageiro = "";-->
							
							<!-- Tabela Dados -->
							<tr align="center">
								
								<td width="40px"><%=codPassageiro %></td>
								<td width="200px"><%=nomePassageiro %></td>
								<td width="200px"><%=sobrenomePassageiro %></td>
								<td width="20px"><%=generoPassageiro %></td>
								<td width="150px"><%=rgPassageiro %></td>
								<td width="150px"><%=cpfPassageiro %></td>
								<td width="100px"><%=tratamentoPassageiro %></td>
								<td width="30px"><%=diaNascimento %></td>
								<td width="30px"><%=mesNascimento %></td>
								<td width="80px"><%=anoNascimento %></td>
								<td width="200px"><%=celularPassageiro %></td>
								<td width="200px"><%=emailPassageiro %></td>
							</tr>
						
					</table>
				</form>
		
		<form action="consultarPassageiro.jsp">
			<button type = "submit" name="operacaoPagina" value="limpar" tabindex="14"><%= idioma.Limpar %></button>
		</form>
		
		<!-- FIM -->
	</body>
</html>
