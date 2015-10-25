<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="DAO.AeronaveDAO, Model.Aeronave" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="Include/verificaIdioma.jsp" %>
 
 
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title><%=idioma.ExcluirAeronave %></title>
	</head>


	<body>
	<!-- FUNÇÕES -->
	
	<%
		
		String disabled = "disabled";
		String readOnly = "";
		String codAeronave = ""; 
		String nomeAeronave = ""; 
		String modeloAeronave = "";
		String qtdAssento = "";
		String qtdFileiras = "";
		
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
	
		if(request.getParameter("CodigoAeronave") == null)codAeronave =  "";else codAeronave = request.getParameter("CodigoAeronave");
		
		Aeronave aeronave = new Aeronave();
		aeronave = (Aeronave) request.getAttribute("aeronave");
		
		if(aeronave != null) 
		{
			//codAeronave = aeronave.getCodAeronave();
			nomeAeronave = aeronave.getNomeAeronave();
			modeloAeronave = aeronave.getModeloAeronave();
			qtdAssento = String.valueOf(aeronave.getQtdAssento());
			qtdFileiras = String.valueOf(aeronave.getQtdFileiras());
			readOnly = "readonly";
			disabled = "";
		}
			
			
		if("limpar".equals(request.getParameter("operacaoPagina")))
		{
				codAeronave ="";
				nomeAeronave = "";
				modeloAeronave = "";
				qtdAssento = "";
				qtdFileiras = "";
				readOnly = "";
				disabled = "disabled";
		}
		%>
	
<!-- Formulario -->

<h1><%=idioma.ExcluirAeronave %></h1>

		<form action="MainController" method="post">
			<!-- Informa a categoria da página (aeronave/passageiro/checkin/pagamento/voo) -->
			<input type = "hidden" name = "categoria" value = "aeronave">
				
				<!--Informa a função principal da página (cadastrar/alterar/excluir/etc)  -->
				<input type= "hidden" name = "pagina" value = "excluir">
				
					<table>
						<tbody>		
						
							<!-- codigo da aeronave -->
							<tr>
								<td><label><%=idioma.CodigoAeronave %></label></td>
								<td><input <%=readOnly %> type="text" maxlength="11"
									size="11" tabindex="1" name="CodigoAeronave" value="<%=codAeronave %>">
								</td>
							</tr>			
							
						<!-- Nome -->
						<tr>
							<td><label><%=idioma.NomeAeronave %></label></td>
							<td><input readonly type="text" maxlength="45" 
									size="45" tabindex="2" name="NomeAeronave" value="<%=nomeAeronave %>">
							</td>
						</tr>			
						
						
						<!-- Modelo -->
						<tr>
							<td><label><%=idioma.ModeloAeronave %></label></td>
							<td>
							 <input readonly type="text" maxlength="45" size="45" tabindex="3" name="ModeloAeronave" value="<%=modeloAeronave %>">
							</td>
						</tr>
						
						
						<!-- quantidade de assento -->
						<tr>
							<td><label><%=idioma.QuantidadeAssentos %></label></td>
							
							<td>
							 <input readonly type="text" maxlength="11" size="11" tabindex="4" name="QuantidadeAssentos" value="<%=qtdAssento %>">
							</td>
							
						</tr>
						
						
						<!-- Quantidade de Fileiras -->
						<tr>
							<td><label><%=idioma.QuantidadeFileiras %></label></td>
					
							<td>
							 <input readonly type="text" maxlength="11" size="11" tabindex="5" name="QuantidadeFileiras" value="<%=qtdFileiras %>">
							</td>
						</tr>
						
					
					

					
					<!-- Executa operações jsp -->
					<tr>
						<td colspan="2">
							<button type="submit" name="operacao" value = "procurarAeronave" tabindex="13"><%=idioma.Buscar %></button>
							<button <%=disabled%> type="submit" name="operacao" value = "excluir" tabindex="14"><%=idioma.Excluir %></button>
							
							<!--<input type="submit" name="operacao" value="Procurar" tabindex="13">
							<input type="submit" name="operacao" value="Excluir" tabindex="14">
							<input type="submit" name="operacao" value="Limpar" tabindex="15">
							  -->
							
						</td>
					</tr>	
					
					<!-- Retorna para pagina daonde veio -->
					<tr>
						<td colspan="2">
							&nbsp;
							<button type="submit" name="operacao" value = "voltar" tabindex="15"><%=idioma.Voltar %></button>
							<!--<input type="button" name="voltar" tabindex="99" value="Voltar" 
							onClick="history.back()"/>  -->
							
						</td>
					</tr>
									
				</tbody>
			</table>
		</form>
		
		<!-- Limpa as variáveis da página -->
		<form action="excluirAeronave.jsp">
			<button type= "submit" name = "operacaoPagina" value = "limpar" tabindex="15"><%=idioma.Limpar %></button>
		</form>
	<!-- FIM -->
	</body>
</html>
