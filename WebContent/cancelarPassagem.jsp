<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file="Include/verificaIdioma.jsp" %>
    <%@page import = "Model.Passagem" %>
    <%@page import = "Model.Passageiro" %>
    <%@page import = "Model.Reembolso" %>
    <%@page import = "DAO.PassagemDAO" %>
    <%@page import = "DAO.PassageiroDAO" %>
    <%@page import = "DAO.ReembolsoDAO" %>
     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.CancelarPassagem %></title>
</head>
<body>

<!-- FUNÇÕES -->
<%

	String msg = (String) request.getAttribute("mensagem");
	if(msg != null && msg != "")
	{
		%>
		<script type="text/javascript">
			alert('<%=msg%>');
		</script>
		<%
	}
	
	//Passagem
	Passagem pass = new Passagem();
	
	//Reembolso
	Reembolso reembolso = new Reembolso();
	
	//Passageiro
	Passageiro passageiroTitular = new Passageiro();
	
	
	String tempoRestante = "", nomeTitular = "";
	long horaMilissegundo = 0, minMilissegundo = 0, tempoPassagemMilissegundo = 0, nowMilissegundo = 0, diferencaMilissegundo = 0;
	double valorDevolvido = 0.0;
	
	
	
	
	
	
	
	
	//Consultar Passagem para calcular reembolso
	if(request.getAttribute("valorDevolucao") != null)
	{
		valorDevolvido = (Double) request.getAttribute("valorDevolucao");
	}
	
	//Consultar Cliente
	
	passageiroTitular = (Passageiro) request.getAttribute("passageiro");
	
	if(passageiroTitular != null)
	{
		nomeTitular = passageiroTitular.getNomePassageiro();
		
	}
	

	
	
	
	
	
%>

<!-- Formulario -->

<h1><%=idioma.CancelarPassagem %></h1>

		<form action="MainController" method="post">
			<input type="hidden" name= "categoria" value= "passagem">
				<input type = "hidden" name = "pagina" value = "cancelar">
					<table>
						<tbody>		
						
						
							<!-- CÓDIGO BILHETE -->
							<tr>
								<td><label><%=idioma.CodigoBilhete %></label></td>
								<td><input type="text" maxlength="45" size="45" tabindex="1" name="codBilhete">
								<button type = "submit" name = "operacao" value = "buscarPassagem" ><%=idioma.Buscar %></button>
								</td>
							</tr>			
							
							<!-- TEMPO RESTANTE -->
							<tr>
								<td><label><%=idioma.TempoRestante %></label></td>
								<td><input type="text" maxlength="45" size="45" tabindex="1" name="tempoRestante" value = "<%=tempoRestante %>" readonly = "true" >
								</td>
							</tr>
							
							<!-- VALOR DEVOLVIDO -->
							<tr>
								<td><label><%=idioma.ValorDevolvido %>&nbsp;R$</label></td>
								<td><input type="text" maxlength="15" size="15" tabindex="1" name="valorDevolvido" value = "<%=valorDevolvido %> "readonly = "true" >
								</td>
							</tr>
							
							<!-- DADOS DO REEBOLSO -->
							
							<!-- CPF TITULAR -->
							
							<tr>
								<td><label><%=idioma.CPFTitular %></label></td>
								<td><input type="text" maxlength="11" size="11" tabindex="1" name="cpfTitular"  >
								<button type = "submit" name = "operacao" value = "buscarPassageiro"><%=idioma.Consultar %></button>
								
								</td>
							</tr>
							
							<!-- NOME TITULAR -->
							<tr>
								<td><label><%=idioma.NomeTitular %></label></td>
								<td><input type="text" maxlength="45" size="45" tabindex="1" name="nomeTitular" value = "<%=nomeTitular %>" readonly = "true" >
								</td>
							</tr>
							
							<!-- BANCO -->
							<tr>
								<td><label><%=idioma.Banco %></label></td>
								<td><input type="text" maxlength="45" size="45" tabindex="1" name="banco"  >
								</td>
							</tr>
							
							<!-- AGÊNCIA -->
							<tr>
								<td><label><%=idioma.Agencia %></label></td>
								<td><input type="text" maxlength="45" size="45" tabindex="1" name="agencia" >
								</td>
							</tr>
							
							<!-- NÚMERO DA CONTA -->
							<tr>
								<td><label><%=idioma.NumeroDaConta %></label></td>
								<td><input type="text" maxlength="45" size="45" tabindex="1" name="numeroDaConta" >
								</td>
							</tr>
							
							<!-- BOTÕES -->
							<!-- VOLTAR E LIMPAR -->
								<!-- CANCELAR PASSAGEM -->
							<tr>
								<td colspan="2">
									<center><button type = "submit" name = "operacao" value = "cancelarPassagem"><%=idioma.CancelarPassagem %></button></center>
								</td>
							</tr>
							<tr>
								<td><button type = "submit" name = "operacao" value = "voltar"><%=idioma.Voltar %></button>
								<button type = "reset" name = "Limpar" value = "Limpar"><%=idioma.Limpar %></button>
								</td>
							</tr>
							
							
						
		
						</tbody>
					</table>
				</form>
		
		</body>
</html>