<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.ArrayList"%>
    <%@page import = "DAO.VooDAO" %>
    <%@page import = "Model.Voo"  %>
    <%@ include file="Include/verificaIdioma.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.ExcluirVoo %></title>
</head>
<body>

<h1><%=idioma.ExcluirVoo %></h1>

<!-- FUNÇÕES -->
<%
	String origemVoo = "", destinoVoo = "", preco = "", data = "", hora = "", nomeAeronave = "", situacao = "", codVooEscolhido = "";
	Voo voo = new Voo();
	
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
	
		Voo vooDetalhes = (Voo) request.getAttribute("voo");
	
			if(vooDetalhes != null)
			{
				//Detalhes do Voo
				codVooEscolhido = Integer.toString(vooDetalhes.getCodVoo());
				origemVoo = vooDetalhes.getAeroportoOrigem().toString();
				destinoVoo = vooDetalhes.getAeroportoDestino().toString();
				preco = Double.toString(vooDetalhes.getPrecoVoo());
				data = vooDetalhes.getDiaPartida()+"/"+vooDetalhes.getMesPartida()+"/"+vooDetalhes.getAnoPartida();
				hora = vooDetalhes.getHoraPartida()+":"+vooDetalhes.getMinutoPartida();
				nomeAeronave = vooDetalhes.getAeronaveVoo().toString();
				situacao = vooDetalhes.getSituacaoVoo();
				
				if(situacao.equals("Confirmado"))
				{
					situacao = idioma.Confirmado;
				}
				if(situacao.equals("Em Espera"))
				{
					situacao = idioma.EmEspera;
				}
				if(situacao.equals("Encerrado"))
				{
					situacao = idioma.Encerrado;
				}
				
			}
		
		
	%>

		


<!-- FORMULÁRIO -->
<form action = "MainController" method = "post">
	<input type = "hidden" name = "categoria" value = "voo">
		<input type = "hidden" name = "pagina" value = "excluir">

				<table>
						<tbody>		
						
						
							<!-- Código do Voo -->
							<tr>
								<td><label><%=idioma.Voos %></label></td>
								<td>
								<%		//Lista com os voos
										ArrayList<Voo> vooList = new ArrayList<Voo>();
										vooList = voo.buscarTodos();
										
										// Percorre a lista e adiciona no combo
										%>
										<select name = "codigoVoo">
										<% try{ for(Voo v : vooList)
										{%>
										<option value = "<%=v.getCodVoo()%>"> <%=v %> </option>
										<%}}catch(Exception e){}%>
										</select>
								
								<button type="submit" name = "operacao" value = "buscarVoo" tabindex="13"><%=idioma.Buscar %></button>
								<!--<input type="submit" name="operacao" value="Procurar" tabindex="13">  -->
								
								</td>
							</tr>			
						
						<!-- Código -->
						<tr>
							<td><label><%=idioma.CodigoVoo %>:</label></td>
							<td><input type="text" maxlength="5" 
									size="5" tabindex="2" name="codigoVooEscolhido" value="<%=codVooEscolhido %>" readonly = "true">
							</td>
						</tr>
							
						<!-- Origem -->
						<tr>
							<td><label><%=idioma.Origem %>:</label></td>
							<td><input type="text" maxlength="70" 
									size="70" tabindex="2" name="origemVoo" value="<%=origemVoo %>" readonly = "true">
							</td>
						</tr>			
						
						
						<!-- Destino -->
						<tr>
							<td><label><%=idioma.Destino %></label></td>
							<td>
							 <input type="text" maxlength="70" size="70" tabindex="3" name="DestinoVoo" value="<%=destinoVoo %>" readonly = "true">
							</td>
						</tr>
						
						
						<!-- Data Voo -->
						<tr>
							<td><label><%=idioma.DataPartida %></label></td>
							
							<td>
							 <input type="text" maxlength="11" size="11" tabindex="4" name="DataVoo" value="<%=data %>" readOnly = "true">
							</td>
							
						</tr>
						
						
						<!-- Hora Voo -->
						<tr>
							<td><label><%=idioma.HoraPartida %></label></td>
					
							<td>
							 <input type="text" maxlength="11" size="11" tabindex="5" name="HoraVoo" value="<%=hora %>" readOnly = "true">
							</td>
						</tr>		
							
					
					<!-- Nome aeronave -->
						<tr>
							<td><label><%=idioma.NomeAeronave %></label></td>
					
							<td>
							 <input type="text" maxlength="11" size="11" tabindex="6" name="NomeAeronave" value="<%=nomeAeronave %>" readOnly = "true">
							</td>
						</tr>		
							
					<!-- Preço -->
						<tr>
							<td><label><%=idioma.Preco %></label></td>
					
							<td>
							 <input type="text" maxlength="11" size="11" tabindex="7" name="Preco" value="<%=preco %>" readOnly = "true">
							</td>
						</tr>		
						
					<!-- Situação -->
						<tr>
							<td><label><%=idioma.Situacao %></label></td>
					
							<td>
							 <input type="text" maxlength="11" size="11" tabindex="8" name="Situacao" value="<%=situacao %>" readOnly = "true">
							</td>
						</tr>		
							
							<!-- BOTÃO VOLTAR -->
							<tr>
								<td colspan="2">
									&nbsp;
									
									<button type="submit" name = "operacao" value = "voltar" tabindex="15"><%=idioma.Voltar %></button>
									<!--<input type="button" name="voltar" tabindex="15" value="Voltar" 
									onClick="history.back()"/>  -->
									
								</td>
							</tr>
							
							
							<!-- Limpa tabela e executa o jsp -->
							<tr>
								<td colspan="3">
									<button type="submit" name="operacao" value = "excluirVoo" tabindex="15"><%=idioma.Excluir %></button>
									<button type="reset" name="operacao" value = "Limpar" tabindex="15"><%=idioma.Limpar %></button>
								
								<!--<input type="submit" name="operacao" value="Excluir" tabindex="14">
									<input type="submit" name="operacao" value="Limpar" tabindex="15">
									  -->
									
								</td>
							</tr>
		
						</tbody>
					</table>
		
			
		</form>
				
			
		
		
		</body>
</html>