<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="DAO.PassageiroDAO, Model.Passageiro" %>

<%@ include file="Include/verificaIdioma.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%=idioma.ExcluirPassageiro %></title>
	</head>


	<body>
	<!-- FUNÇÕES -->
	
		<%

		String disabled = "", readOnly = "", codPassageiro, nomePassageiro = "" , sobrenomePassageiro = "",
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
		}
		
		//Recebe passageiro encontrado na PassageiroController.
		Passageiro passageiro = (Passageiro) request.getAttribute("passageiro");
		
		if(passageiro != null) 
		{
			codPassageiro = request.getParameter("CodigoPassageiro");
			nomePassageiro = passageiro.getNomePassageiro();
			sobrenomePassageiro = passageiro.getSobrenomePassageiro();
			generoPassageiro= passageiro.getGeneroPassageiro();
			rgPassageiro= passageiro.getRG();
			cpfPassageiro = passageiro.getCPF();
			
			tratamentoPassageiro= passageiro.getTratamentoPassageiro();
			if(tratamentoPassageiro.equals("Senhor"))
				tratamentoPassageiro = idioma.Senhor;
			else if(tratamentoPassageiro.equals("Senhora"))
				tratamentoPassageiro = idioma.Senhora;
			else if(tratamentoPassageiro.equals("Senhorita"))
				tratamentoPassageiro = idioma.Senhorita;
				
			diaNascimento= Integer.toString(passageiro.getDiaNascimento());
			mesNascimento = Integer.toString(passageiro.getMesNascimento());
			anoNascimento= Integer.toString(passageiro.getAnoNascimento());
			celularPassageiro= passageiro.getCelularPassageiro();
			emailPassageiro = passageiro.getEmailPassageiro();
		}
			
			
			else if("limpar".equals(request.getParameter("operacaoPagina")))
			{
				codPassageiro ="";
				nomePassageiro = "";
				sobrenomePassageiro = "";
				generoPassageiro = "";
				rgPassageiro= "";
				cpfPassageiro = "";
				tratamentoPassageiro= ""; 
				diaNascimento= "";
				mesNascimento = "";
				anoNascimento="";
				celularPassageiro= "";
				emailPassageiro = "";
			}
		%>
	
<!-- Formulario -->

<h1><%= idioma.ExcluirPassageiro%></h1>

		<form action="MainController" method="post">
			<!-- Informa a categoria da página (aeronave/passageiro/checkin/pagamento/voo) -->
			<input type = "hidden" name = "categoria" value = "passageiro">
				
				<!--Informa a função principal da página (cadastrar/alterar/excluir/etc)  -->
				<input type = "hidden" name = "pagina" value = "excluir">
					<table>
						<tbody>		
						
							<!-- CodigoPassageiro -->
							<tr>
								<td><label><%= idioma.CodigoPassageiro %></label></td>
								<td><input <%=readOnly %> type="text" maxlength="45" 
										size="45" tabindex="1" name="CodigoPassageiro" value="<%=codPassageiro %>" >
								</td>
							</tr>	
							
							<!-- NomePassageiro -->
							<tr>
								<td><label><%= idioma.Nome %></label></td>
								<td><input readonly type="text" maxlength="45" 
										size="45" tabindex="1" name="NomePassageiro" value="<%=nomePassageiro %>">
								</td>
							</tr>			
							
							<!-- SobrenomePassageiro -->
							
							<tr>
								<td><label><%= idioma.Sobrenome %></label></td>
								<td><input readonly type="text" maxlength="45" 
										size="45" tabindex="2" name="SobrenomePassageiro" value="<%=sobrenomePassageiro %>">
								</td>
							</tr>		
								<!-- GeneroPassageiro -->
							<tr>
								<td><label><%= idioma.Genero %></label></td>
								<td><input readonly type="text" maxlength="1" 
										size="1" tabindex="3" name="GeneroPassageiro" value="<%=generoPassageiro %>">
								</td>
							</tr>	
					            <!-- RGPassageiro -->
					        <tr>
								<td><label><%= idioma.RG %></label></td>
								<td><input readonly type="text" maxlength="15" 
										size="20" tabindex="4" name="RGPassageiro" value="<%=rgPassageiro %>">
								</td>
							</tr>
					            <!-- CPFPassageiro -->
					        <tr>
								<td><label><%= idioma.CPF %></label></td>
								<td><input readonly type="text" maxlength="11" 
										size="15" tabindex="5" name="CPFPassageiro" value="<%=cpfPassageiro %>">
								</td>
							</tr>
					            <!-- TratamentoPassageiro -->
					        <tr>
								<td><label><%= idioma.Tratamento%></label></td>
								<td><input readonly type="text" maxlength="20" 
										size="25" tabindex="6" name="TratamentoPassageiro" value="<%=tratamentoPassageiro %>">
								</td>
							</tr>
										            <!-- DATA DE NASCIMENTO -->			            
							<tr>
								<td><label><%= idioma.DataDeNascimento %></label></td>
								<td colspan="3">
									&nbsp;
									<!-- DiaNascimento -->
									<input readonly type="text" maxlength="2" 
										size="2" tabindex="7" name="DiaNascimento" value="<%=diaNascimento %>">
									<!-- MesNascimento -->
									<input readonly type="text" maxlength="2" 
										size="2" tabindex="8" name="MesNascimento" value="<%= mesNascimento %>">
									 <!-- AnoNascimento -->
									 <input readonly type="text" maxlength="4" 
										size="4" tabindex="9" name="AnoNascimento" value="<%=anoNascimento %>">
								</td>
							</tr>
							
					            <!-- CelularPassageiro -->
					        <tr>
								<td><label><%= idioma.Celular %></label></td>
								<td><input readonly type="text" maxlength="15" 
										size="35" tabindex="10" name="CelularPassageiro" value="<%=celularPassageiro %>">
								</td>
							</tr>
					            <!-- EmailPassageiro -->
					        <tr>
								<td><label><%= idioma.Email %></label></td>
								<td><input readonly type="text" maxlength="45" 
										size="50" tabindex="11" name="EmailPassageiro" value="<%=emailPassageiro %>">
								</td>
							</tr>
							
							<!-- Executa operações jsp -->
							<tr>
								<td colspan="3">
									<button type= "submit" name = "operacao" value = "buscarPassageiro" tabindex="13"><%=idioma.Buscar %></button>
									<button <%=disabled%> type="submit" name= "operacao" value = "excluirPassageiro" tabindex="14"><%=idioma.Excluir %></button>
									
							</tr>
		
		
							<!-- Retorna para pagina daonde veio -->
							<tr>
								<td colspan="2">
									&nbsp;
									<input type="button" name="<%= idioma.Voltar %>" tabindex="15" value="Voltar" 
									onClick="location.href = 'principal.jsp'"/>
								</td>
							</tr>
							
						</tbody>
					</table>
				</form>
				
				<form action="excluirPassageiro.jsp">
				<!-- Ação na própria página -->
					<button type="submit" name="operacaoPagina" value = "limpar" tabindex="15"><%=idioma.Limpar %></button>
				</form>
		
		<!-- FIM -->
	</body>
</html>
