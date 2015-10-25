<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="DAO.AeronaveDAO, Model.Aeronave" %>
<%@ include file="Include/verificaIdioma.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%=idioma.AlterarAeronave %></title>
	</head>
	
	<body>
	<!-- FUNÇÕES -->
	
		<%
		String disabled = "disabled";
		String readOnly = "readonly";
		String readOnlyCod = "";
		String codAeronave = "";
		String nomeAeronave = "";
		String modeloAeronave = ""; 
		String qtdColunas = "";
		String qtdFileiras = "";
		
	//	if(request.getParameter("CodigoAeronave") == null)codAeronave =  "";else codAeronave = request.getParameter("CodigoAeronave");
		
		Aeronave aeronave = new Aeronave();
		aeronave = (Aeronave) request.getAttribute("aeronave");
		
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
		
		if(aeronave != null) 
		{
			//Isso acontece porque não gravado o qtd de colunas
			int col = (aeronave.getQtdAssento()/aeronave.getQtdFileiras());
			aeronave.setQtdColunas(col);
			
			codAeronave = request.getParameter("CodigoAeronave");
			nomeAeronave = aeronave.getNomeAeronave();
			modeloAeronave = aeronave.getModeloAeronave();
			qtdColunas = String.valueOf(aeronave.getQtdColunas());
			qtdFileiras = String.valueOf(aeronave.getQtdFileiras());
			readOnly = "";	
			readOnlyCod = "readonly";
			disabled = "";
		}
		
				
		else if("Limpar".equals(request.getParameter("operacaoPagina")))
		{
			codAeronave ="";
			nomeAeronave = "";
			modeloAeronave = "";
			qtdColunas = "";
			qtdFileiras = "";
		}
		
		
	%>
	
<!-- Formulario -->

<h1><%=idioma.AlterarAeronave %></h1>

		<form action="MainController" method="post">
			<!-- Informa a categoria da página (aeronave/passageiro/checkin/pagamento/voo) -->
			<input type = "hidden" name = "categoria" value = "aeronave">
			
				<!--Informa a função principal da página (cadastrar/alterar/excluir/etc)  -->
				<input type= "hidden" name = "pagina" value = "alterar">
				<table>
					<tbody>		
					
					
						<!-- codigo da aeronave -->
						<tr>
							<td><label><%=idioma.CodigoAeronave %></label></td>
							<td><input <%=readOnlyCod%> type="text" maxlength="11"
								size="11" tabindex="1" name="CodigoAeronave" value="<%=codAeronave %>">
							</td>
						</tr>			
						
					<!-- Nome -->
					<tr>
						<td><label><%=idioma.NomeAeronave %></label></td>
						<td><input <%=readOnly%> type="text" maxlength="45" 
								size="45" tabindex="2" name="NomeAeronave" value="<%=nomeAeronave %>">
						</td>
					</tr>			
					
					
					<!-- Modelo -->
					<tr>
						<td><label><%=idioma.ModeloAeronave %></label></td>
						<td>
						 <input <%=readOnly%> type="text" maxlength="45" size="45" tabindex="3" name="ModeloAeronave" value="<%=modeloAeronave %>">
						</td>
					</tr>
					
					
					<!-- quantidade de colunas -->
					<tr>
						<td><label><%=idioma.QuantidadeColunas %></label></td>
						
						<td>
						 <input <%=readOnly%> type="text" maxlength="11" size="11" tabindex="4" name="QuantidaDeColunas" value="<%=qtdColunas %>">
						</td>
						
					</tr>
					
					
					<!-- Quantidade de Fileiras -->
					<tr>
						<td><label><%=idioma.QuantidadeFileiras %></label></td>
				
						<td>
						 <input <%=readOnly%> type="text" maxlength="11" size="11" tabindex="5" name="QuantidaDeFileiras" value="<%=qtdFileiras %>">
						</td>
					</tr>		
						
						
						<!-- Limpa tabela e executa o jsp -->
						<tr>
							<td colspan="2">
							
							<button type="submit" name="operacao" value= "procurarAeronave" tabindex="13"><%= idioma.Buscar %></button>
							<button <%=disabled %>type="submit" name="operacao" value="alterar" tabindex="14"><%= idioma.Alterar %></button>
							
							<!--<input type="submit" name="operacao" value="Procurar" tabindex="13">
								<input <%=disabled%> type="submit" name="operacao" value="Alterar" tabindex="14">
								<input type="submit" name="operacao" value="Limpar" tabindex="15">
								  -->
								
							</td>
						</tr>
						
						<!-- Retorna para pagina daonde veio -->
						<tr>
							<td colspan="2">
								&nbsp;
								<button type="submit" name= "operacao" value = "voltar" tabindex="15"><%=idioma.Voltar %></button>
								<!--<input type="button" name="voltar" tabindex="15" value="Voltar" 
								onClick="location.href='principal.jsp'"/>  -->
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			
			<!-- Limpa as variáveis -->
			<form action="alterarAeronave.jsp">
				<button type="submit" name="operacaoPagina" value="Limpar" tabindex="15"><%= idioma.Limpar %></button>
			</form>
			
			<!-- FIM -->
		</body>
</html>
