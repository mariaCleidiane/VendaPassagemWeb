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
	<title><%=idioma.ConsultarAeronave %></title>
	</head>
	


	<body>
	<!-- FUNÇÕES -->

	
		<%
		
			String codAeronave="", nomeAeronave = "" , modeloAeronave = "", qtdAssento = "", qtdFileiras = "";
		
			//Retorna a lista de aeronaves requisitada em "procurarAeronaveGenerica"		
			ArrayList<Aeronave> aeroList = (ArrayList<Aeronave>) request.getAttribute("aeronaveList");
			
			//Aeronave selecionada no combo box
			Aeronave aeronave = (Aeronave) request.getAttribute("aeronave");
			
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
			
			//Atribuição de valores para preencher tabela de detalhes.
			if(aeronave != null)
			{
				codAeronave = String.valueOf(aeronave.getCodAeronave());
				nomeAeronave = aeronave.getNomeAeronave();
				modeloAeronave = aeronave.getModeloAeronave();
				qtdAssento = String.valueOf(aeronave.getQtdAssento());
				qtdFileiras = String.valueOf(aeronave.getQtdFileiras());
					
			}
			
							
						
						
				if("limpar".equals(request.getParameter("operacaoPagina")))
				{
						codAeronave = "";
						nomeAeronave = "";
						modeloAeronave  = "";
						qtdAssento = "";
						qtdFileiras = "";
				}

				
		%>
	
<!-- Formulario -->

<h1><%=idioma.ConsultarAeronave %></h1>

		<form action="MainController" method="post">
			<input type="hidden" name= "categoria" value="aeronave">
			<table>
				<tbody>		
				
				
					<!-- codigo da aeronave -->
					<tr>
						<td><label><%=idioma.CodigoAeronave %></label></td>
						<td><input type="text" maxlength="11"
							size="11" tabindex="1" name="CodigoAeronave">
						</td>
					</tr>			
					
				<!-- Nome -->
				<tr>
					<td><label><%=idioma.NomeAeronave %></label></td>
					<td><input type="text" maxlength="45" 
							size="45" tabindex="2" name="NomeAeronave">
					</td>
				</tr>			
				
				
				<!-- Modelo -->
				<tr>
					<td><label><%=idioma.ModeloAeronave %></label></td>
					<td>
					 <input type="text" maxlength="45" size="45" tabindex="3" name="ModeloAeronave">
					</td>
				</tr>
				
				
				<!-- quantidade de assentos -->
				<tr>
					<td><label><%=idioma.QuantidadeAssentos %></label></td>
					
					<td>
					 <input type="text" maxlength="11" size="11" tabindex="4" name="QuantidaAssentos">
					</td>
					
				</tr>
				
				
				<!-- Quantidade de Fileiras -->
				<tr>
					<td><label><%=idioma.QuantidadeFileiras %></label></td>
			
					<td>
					 <input type="text" maxlength="11" size="11" tabindex="5" name="QuantidadeFileiras">
					</td>
				</tr>
					
					
					<!-- Limpa tabela e executa o jsp -->
					<tr>
						<td colspan="2">
							<button type="submit" name= "operacao" value = "procurarAeronaveGenerico" tabindex="13"><%=idioma.Consultar %></button>
							<button type="reset" name="operacao" value = "limpar" tabindex="14"><%=idioma.Limpar %></button>
						</td>
					</tr>
					
					<!-- Retorna para pagina daonde veio -->
					<tr>
						<td colspan="2">
							&nbsp;
							<button type="submit" name= "operacao" value = "voltar" tabindex="15"><%=idioma.Voltar %></button>
							<!--<input type="button" name="voltar" tabindex="15" value="Voltar" 
							onClick="location.href = 'principal.jsp'"/>  -->
							
						</td>
					</tr>
					
				</tbody>
			 </table>
		</form>
		
		<hr>
		
		<form action= "MainController" method="post">
			<input type = "hidden" name = "categoria" value = "aeronave">
				<input type = "hidden" name = "pagina" value = "consultar">
		
					<table>
					
						<tr>
							<td><label><%=idioma.ListaDeAeronave%></label></td>
							<td>
								<select name = "CodigoAeronave">
									<% try
										{
											for(Aeronave a : aeroList)
											{ %>
												<option value = "<%=a.getCodAeronave()%>"> <%=a %></option>
										  <%}
										}catch(Exception e){}%>
								</select>
							</td>
						</tr>
					
						 <tr>
							<td colspan="1">
								<button type= "submit" name= "operacao" value= "procurarAeronave" tabindex="13"><%= idioma.Detalhes %></button>
							</td>
						</tr>
					</table>
					
					<table border="1px" > 
					 
							<!-- Tabela Labels -->
							<tr align="center" >
								<td><label><%=idioma.CodigoAeronave %></label></td>
								<td><label><%=idioma.NomeAeronave %></label></td>
								<td><label><%=idioma.ModeloAeronave %></label></td>
								<td><label><%=idioma.QuantidadeAssentos %></label></td>
								<td><label><%=idioma.QuantidadeFileiras %></label></td>
							</tr>
							
							<!-- Tabela Dados -->
							<tr align="center">
								
								<td width="40px"><%=codAeronave %></td>
								<td width="200px"><%=nomeAeronave %></td>
								<td width="200px"><%=modeloAeronave %></td>
								<td width="40px"><%=qtdAssento %></td>
								<td width="40px"><%=qtdFileiras %></td>
							</tr>
						
					</table>
				</form>
		
		<form action="consultarAeronave.jsp">
			<button type= "submit" name= "operacaoPagina" value= "limpar" tabindex="14"><%= idioma.Limpar %></button>
		</form>
		
		<!-- FIM -->
	</body>
</html>
