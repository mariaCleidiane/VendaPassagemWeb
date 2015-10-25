<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.ArrayList"%>
    <%@page import = "DAO.VooDAO" %>
    <%@page import = "Model.Voo"  %>
    <%@page import = "Model.Aeronave" %>
    <%@page import = "DAO.AeronaveDAO" %>
    <%@page import = "Model.Aeroporto" %>
    <%@page import = "DAO.AeroportoDAO" %>
    <%@ include file="Include/verificaIdioma.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.AlterarVoo %></title>
</head>
<body>


<!-- FUNÇÕES -->
<%
	String origemVoo = "", destinoVoo = "", nomeAeronave = "", situacao = "", codVooEscolhido = "";
	double preco = 0; 
	int dia = 0, mes = 0, ano = 0, hora = 0, minuto = 0; 
	
	//Objeto de Voo
	Voo vooDetalhes = new Voo();
	Voo voo = new Voo();
	//Objeto de Aeronave
	Aeronave aeronave = new Aeronave();
	//Objeto de DAO
	AeronaveDAO aeronaveDAO = new AeronaveDAO();
	//Objeto de Aeroporto
	Aeroporto aeroporto = new Aeroporto();
	
	

	//ArrayList Aeronave
	 ArrayList<Aeronave> aeronaveList = new ArrayList<Aeronave>();
	//ArrayList Aeroporto
	ArrayList<Aeroporto> aeroportoList = new ArrayList<Aeroporto>();
	
	 //Lista com as aeronaves
	 aeronaveList = aeronave.buscarTodos();
	 //Lista com aeroportos
	 aeroportoList = aeroporto.buscarAeroporto();
	
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
	 
	
			
		//Detalhes do Voo
		vooDetalhes = (Voo) request.getAttribute("voo");
		if(vooDetalhes != null)
		{
			codVooEscolhido = Integer.toString(vooDetalhes.getCodVoo());
			preco = vooDetalhes.getPrecoVoo();
			dia = vooDetalhes.getDiaPartida();
			mes = vooDetalhes.getMesPartida();
			ano = vooDetalhes.getAnoPartida();
			hora = vooDetalhes.getHoraPartida();
			minuto = vooDetalhes.getMinutoPartida();
			nomeAeronave = vooDetalhes.getAeronaveVoo().toString();
			situacao = vooDetalhes.getSituacaoVoo();
				
		}
		
			
		
	%>


<!-- FORMULÁRIO -->
<form action = "MainController" method = "post">
	<input type = "hidden" name = "categoria" value = "voo">
		<input type = "hidden" name = "pagina" value = "alterar">

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
									<% try{for(Voo v : vooList)
									{%>
									<option value = "<%=v.getCodVoo()%>"> <%=v %> </option>
									<%}}catch(Exception e){} %>
									</select>
									<button type="submit" name = "operacao" value = "buscarVoo" tabindex="15"><%=idioma.Buscar %></button>
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
						<td><label><%=idioma.Origem %></label></td>
						<td><select name = "listaAeroportoOrigem">
							<% 
							/*ArrayList<Aeroporto> aeroportoOrigem = new ArrayList<Aeroporto>();
							aeroportoOrigem = aeroportoDAO.buscarAeroporto();*/
							try{for(Aeroporto a : aeroportoList)
							{ %>
							<option value = "<%=a.getCodAeroporto()%>"> <%=a %></option>
							<%}}catch(Exception e){} %>
							</select>
						</td>
					</tr>			
					
					
					<!-- Destino -->
					<tr>
						<td><label><%=idioma.Destino %></label></td>
						<td>
						 <select name = "listaAeroportoDestino">
							<% 
							/*ArrayList<Aeroporto> aeroportoDestino = new ArrayList<Aeroporto>();
							aeroportoDestino = aeroportoDAO.buscarAeroporto();*/
							
							try{for(Aeroporto a : aeroportoList)
							{ %>
							<option value = "<%=a.getCodAeroporto()%>"> <%=a %></option>
							<%}}catch(Exception e){} %>
							</select>
						</td>
					</tr>
					
					
					<!-- Data Voo -->
					<tr>
						<td><label><%=idioma.Data %></label></td>
						
						<td>
						 <input type="text" maxlength="2" size="2" tabindex="4" name="DiaVoo" value="<%=dia %>" >/
						 <input type="text" maxlength="2" size="2" tabindex="5" name="MesVoo" value="<%=mes %>" >/
						 <input type="text" maxlength="4" size="4" tabindex="6" name="AnoVoo" value="<%=ano %>" >
						</td>
						
					</tr>
					
					
					<!-- Hora Voo -->
					<tr>
						<td><label><%=idioma.Hora %></label></td>
				
						<td>
						 <input type="text" maxlength="2" size="2" tabindex="7" name="HoraVoo" value="<%=hora %>"  >:
						 <input type="text" maxlength="2" size="2" tabindex="8" name="MinVoo" value="<%=minuto %>"  >
						 
						</td>
					</tr>		
						
				
				<!-- Nome aeronave -->
					<tr>
						<td><label><%=idioma.Aeronave %></label></td>
				
						<td>
						 <select name = "listaAeronave">
							<% 
							/*ArrayList<Aeronave> aero = new ArrayList<Aeronave>();
							aero = aeronaveDAO.buscarTodos();*/
							
							try{for(Aeronave a : aeronaveList)
							{ %>
							<option value="<%=a.getCodAeronave() %>"> <%=a.getNomeAeronave() %></option>
							<%}}catch(Exception e){} %>
							</select>
						</td>
					</tr>		
						
				<!-- Preço -->
					<tr>
						<td><label><%=idioma.Preco %></label></td>
				
						<td>
						 <input type="text" maxlength="11" size="11" tabindex="7" name="Preco" value="<%=preco %>"  >
						</td>
					</tr>		
					
				<!-- SITUAÇÃO -->
						<tr>
							<td><label><%=idioma.Situacao %></label></td>
							<td><select name = "situacaoVoo">
							  	<option value = "EmEspera"><%=idioma.EmEspera %> </option>
							  	<option value = "Confirmado"><%=idioma.Confirmado %> </option>
							  	<option value = "Encerrado"><%=idioma.Encerrado %> </option>
							  </select>
	
							</td>
						</tr>			
			
						<!-- Retorna para pagina da onde veio -->
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
							
								<button type="submit" name="operacao" value = "alterarVoo" tabindex="15"><%=idioma.Alterar %></button>
								<button type="reset" name="operacao" value = "limpar" tabindex="15"><%=idioma.Limpar %></button>
							<!--<input type="submit" name="operacao" value="Alterar" tabindex="14">
								<input type="submit" name="operacao" value="Limpar" tabindex="15">
								  -->
								
							</td>
						</tr>
	
					</tbody>
				</table>
	
		
	</form>
	
	
	</body>
</html>