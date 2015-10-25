<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>
<%@page import="DAO.*, Model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ include file="Include/verificaIdioma.jsp" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.ComprarPassagem %></title>
</head>
<body>
<h1><%=idioma.ComprarPassagem %></h1>

		<%
		
		Double numeroDeParcelas = (Double) request.getAttribute("numeroDeParcelas");
		
		Voo voo = new Voo();
		voo = (Voo) request.getAttribute("voo");
		
		String msg = (String) request.getAttribute("mensagem");
		if(msg != null && msg != "")
		{
			%>
			<script type="text/javascript">
				alert('<%=msg%>');
			</script>
			<%
		}
		
		String pagamentoRealizado = (String) request.getAttribute("pagamentoRealizado");
		
		if(pagamentoRealizado == "true")
		{
			%>
			<script type="text/javascript">
				location.href = "principal.jsp";
			</script>
			<%
		}
		
		%>
		
		
			<!-- Formulario -->
			
		<form action="MainController" method="post">
		<input type="hidden" name="categoria" value="ComprarPassagem">
			<input type="hidden" name="pagina" value="Pagamento">
					<!-- TIPO DE PAGAMENTO -->
					<tr>
						<td><label><%=idioma.TipoPagamento %></label></td>
						<td><select name = "tipoPagamento">
							<option value = "cartao"><%=idioma.Cartao %></option>
							<option value = "dinheiro"><%=idioma.Dinheiro %></option>
							<option value = "cheque"><%=idioma.Cheque %></option>
						</select>
						</td>
					</tr>
					
			<table>
				<tbody>		
					
					<!-- CARTÃO -->
					
						<hr>
							
					<tr>
						<h3><%=idioma.Cartao %></h3>
					</tr>
					
					<!-- NOME TITULAR CARTÃO --> 
					<tr>
						<td><label><%=idioma.NomeTitularCartao %> </label></td>
						<td><input type="text" maxlength="45" size="45" tabindex="1" name="nomeTitularCartao"  >
						</td>
					</tr>
					
					<!-- CPF TITULAR -->
					<tr>
						<td><label><%=idioma.CPFTitular %></label></td>
						<td><input type="text" maxlength="11" size="11" tabindex="1" name="cpfTitularCartao"  >
						</td>
					</tr>
										
					<!-- BANDEIRA CARTÃO -->
					
					<tr>
						<td><label><%=idioma.BandeiraCartao %></label></td>
						<td><select name = "BandeiraCartao">
							<option value = "Visa">Visa</option>
							<option value = "MasterCard">Master Card</option>
							<option value = "AmericanExpress">American Express</option>
						</select>
						</td>
					</tr>
					
					<!-- NUMERO DO CARTÃO -->
					<tr>
						<td><label><%=idioma.NumeroCartao %></label></td>
						<td><input type="text" maxlength="16" size="16" tabindex="1" name="numeroCartao"  >
						</td>
					</tr>
					
										
					<!-- AGÊNCIA -->
					<tr>
						<td><label><%=idioma.Agencia %></label></td>
						<td><input type="text" maxlength="45" size="45" tabindex="1" name="agencia" >
						</td>
					</tr>
					
					
					<!-- DATA VALIDADE  -->
					<tr>
						<td><label><%=idioma.DataValidadeCartao %></label></td>
						<td><select name = "mesValidadeCartao">
							<% for (int i = 1; i<13; i++)
								{%>
									<option value = "<%=i %>"><%=i %></option>
								<%} %>
						</select>
						<select name = "anoValidadeCartao">
						<%GregorianCalendar now = new GregorianCalendar();
						  int anoNow = now.get(Calendar.YEAR);
							for(int j = anoNow; j<anoNow+10; j++)
							{%>
								<option value = "<%=j %>"><%=j %></option>
							<%} %>
						</select>
						</td>
					</tr>
					
					<!-- CÓDIGO DE SEGURANÇA -->
					<tr>
						<td><label><%=idioma.NumeroSegurancaCartao %></label></td>
						<td><input type="text" maxlength="3" size="3" tabindex="1" name="numeroSegurancaCartao" >
						</td>
					</tr>
					
					<!-- NÚMERO DE PARCELAS -->
					<tr>
						<td><label><%=idioma.NumeroParcelas %></label></td>
						<td><select name = "numeroDeParcelas">
							<%
							for (int k = 1; k<13; k++)
								{%>
									<option value = k><%=k %></option>
								<%}%>
						</select>
						</td>
					</tr>
					
					<!-- VALOR PARCELA -->
					<tr>
						<td><label><%=idioma.ValorParcela %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="valorParcela" value="<%=voo.getPrecoVoo()/numeroDeParcelas %>" readonly = "true" >
						</td>
					</tr>
					
					<!-- VALOR TOTAL -->
					<tr>
						<td><label><%=idioma.ValorTotal %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="valorTotal" value="<%=voo.getPrecoVoo() %>" readonly = "true">
						</td>
					</tr>
					
				
					<!-- ------------------------------------------------------------------------- -->
						<!-- SEPARADOR -->
					<tr>
						<td><hr></td>
						
					</tr>
					
					<!-- DINHEIRO -->
					<tr>
						<td><h3><%=idioma.Dinheiro %></h3></td>
						
					</tr>
					
					<!-- CPF -->
					<tr>
						<td><label><%=idioma.CPFTitular %></label></td>
						<td><input type="text" maxlength="11" size="11" tabindex="1" name="cpfTitularDinheiro">
						</td>
					</tr>
					
					
					<!-- VALOR PAGO -->
					<tr>
						<td><label><%=idioma.ValorPago %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="valorPagoDinheiro">
						</td>
					</tr>
				
					
					<!----------------------------------------------------------------------------->
						<!-- SEPARADOR -->
					<tr>
						<td><hr></td>
						
					</tr>
					
					<!-- CHEQUE -->
					<tr>
						<td><h3><%=idioma.Cheque %></h3></td>
					</tr>
					
					<!-- NOME TITULAR
					<tr>
						<td><label>=idioma.NomeTitular %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="nomeTitularCheque">
						</td>
					</tr> -->
					
					<!-- CPF -->
					<tr>
						<td><label><%=idioma.CPFTitular %></label></td>
						<td><input type="text" maxlength="11" size="11" tabindex="1" name="cpfTitularCheque">
						</td>
					</tr>
					<!-- BANCO -->
					<tr>
						<td><label><%=idioma.Banco %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="bancoCheque" >
						</td>
					</tr>
					
					<!-- AGÊNCIA -->
					<tr>
						<td><label><%=idioma.Agencia %></label></td>
						<td><input type="text" maxlength="5" size="5" tabindex="1" name="agenciaCheque" >
						</td>
					</tr>
					
					<!-- NUMERO CHEQUE -->
					<tr>
						<td><label><%=idioma.numeroCheque %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="numeroCheque" >
						</td>
					</tr>
					
					<!-- CONTA -->
					<tr>
						<td><label><%=idioma.Conta %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="contaCheque" >
						</td>
					</tr>
					
					<!-- VALOR TOTAL -->
					<tr>
						<td><label><%=idioma.ValorTotal %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="valorTotalCheque" value="<%=voo.getPrecoVoo()%>" readonly = "true">
						</td>
					</tr>
					
					
					<!-- BOTÕES -->
					<!-- VOLTAR E LIMPAR -->
					<tr>
						<td><button type = "submit" name = "Voltar" value = "Voltar"><%=idioma.Voltar %></button>
						<button type = "reset" name = "Limpar" value = "Limpar"><%=idioma.Limpar %></button>
						</td>
					</tr>
					
					<!-- Comprar PASSAGEM -->
					<tr>
						<td colspan="2">
							<center><button type = "submit" name = "comprarPassagem" value = "<%=request.getParameter("tipoPagamento") %>=>"><%=idioma.ComprarPassagem %></button></center>
						</td>
					</tr>

				</tbody>
			</table>
		</form>

</body>
</html>