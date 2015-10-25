<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="Include/verificaIdioma.jsp" %>
    <%@page import="DAO.VooDAO"%>
    <%@page import="Model.Voo"%>
    <%@page import = "DAO.AeroportoDAO" %>
	<%@page import = "Model.Aeroporto" %>
	<%@page import = "DAO.AeronaveDAO" %>
	<%@page import = "Model.Aeronave" %>
	<%@page import="java.util.ArrayList"%>
	   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.ConsultarVoo %></title>
</head>
<body>

<!-- FUNÇÕES -->
<%

String origemVoo = "", destinoVoo = "", nomeAeronave = "", situacaoVoo = "", precoVoo = "", 
diaVoo = "", mesVoo = "", anoVoo = "", horaVoo = "", minutoVoo = "", codVooEscolhido = ""; 


//Preeche a origem 
		//Objeto de DAO
		Aeroporto aeroporto = new Aeroporto();
		
		//ArrayList Origem e Destino
		 ArrayList<Aeroporto> origem = new ArrayList<Aeroporto>();
		 ArrayList<Aeroporto> destino = new ArrayList<Aeroporto>();
		 
		
		 //Lista com os aeroportos
		origem = aeroporto.buscarAeroporto();
		destino = aeroporto.buscarAeroporto();
		
		//Preeche Aeronaves 
			//Objeto de DAO
			Aeronave aeronave = new Aeronave();
			//ArrayList Aeronave
			 ArrayList<Aeronave> aero = new ArrayList<Aeronave>();
			//Lista com as aeronaves
			aero = aeronave.buscarTodos();
	
			
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
				
				
						
					Voo	vooDetalhes = (Voo) request.getAttribute("voo");
								
						if(vooDetalhes != null)
						{
							codVooEscolhido = Integer.toString(vooDetalhes.getCodVoo());
							precoVoo = Double.toString(vooDetalhes.getPrecoVoo());
							diaVoo = Integer.toString(vooDetalhes.getDiaPartida());
							mesVoo = Integer.toString(vooDetalhes.getMesPartida());
							anoVoo = Integer.toString(vooDetalhes.getAnoPartida());
							horaVoo = Integer.toString(vooDetalhes.getHoraPartida());
							minutoVoo = Integer.toString(vooDetalhes.getMinutoPartida());
							nomeAeronave = vooDetalhes.getAeronaveVoo().toString();
							situacaoVoo = vooDetalhes.getSituacaoVoo();
							origemVoo = vooDetalhes.getAeroportoOrigem().toString();
							destinoVoo = vooDetalhes.getAeroportoDestino().toString();
							
							
						}
						
						ArrayList<Voo> vooList = (ArrayList<Voo>) request.getAttribute("vooList");
				
				
						String operacaoPagina = request.getParameter("operacaoPagina");
						if("limpar".equals(request.getParameter("operacaoPagina")))
						{
							codVooEscolhido = "";
							precoVoo = "";
							diaVoo = "";
							mesVoo = "";
							anoVoo = "";
							horaVoo = "";
							minutoVoo = "";
							nomeAeronave = "";
							situacaoVoo = "";
							origemVoo = "";
							destinoVoo = "";
							
						}
		
%>

<!-- Javascript -->

<!-- DESABILITA o campo CÓDIGO VOO -->
<script type="text/javascript">
function bloqueiaCod()
{
	//Bloqueio
	var cod;
	cod  = document.getElementById("codVoo");
	cod.disabled = true;
	
	//Desbloqueio
	var origem, destino, dia, mes, ano, hora, min, aeronave, situacao, preco;
	origem = document.getElementById("listaAeroportoOrigem");
	origem.readOnly = false;
	
	destino = document.getElementById("listaAeroportoDestino");
	destino.disabled = false;
	
	dia = document.getElementById("diaVoo");
	dia.disabled = false;
	
	mes = document.getElementById("mesVoo");
	mes.disabled = false;
	
	ano = document.getElementById("anoVoo");
	ano.disabled = false;
	
	hora = document.getElementById("horaVoo");
	hora.disabled = false;
	
	min = document.getElementById("minVoo");
	min.disabled = false;
	
	aeronave = document.getElementById("listaAeronave");
	aeronave.disabled = false;
	
	situacao = document.getElementById("situacaoVoo");
	situacao.disabled = false;
	
	preco = document.getElementById("precoVoo");
	preco.disabled = false;
}
</script>

<!-- DESABILITA os DEMAIS campos -->
<script type="text/javascript">
function bloqueiaDados()
{
	//Desbloqueio
	var cod;
	cod  = document.getElementById("codVoo");
	cod.readOnly = true;
	
	
	//Bloqueio
	var origem, destino, dia, mes, ano, hora, min, aeronave, situacao, preco;
	origem = document.getElementById("listaAeroportoOrigem");
	origem.disabled = true;
	
	destino = document.getElementById("listaAeroportoDestino");
	destino.disabled = true;
	
	dia = document.getElementById("diaVoo");
	dia.disabled = true;
	
	mes = document.getElementById("mesVoo");
	mes.disabled = true;
	
	ano = document.getElementById("anoVoo");
	ano.disabled = true;
	
	hora = document.getElementById("horaVoo");
	hora.disabled = true;
	
	min = document.getElementById("minVoo");
	min.disabled = true;
	
	aeronave = document.getElementById("listaAeronave");
	aeronave.disabled = true;
	
	situacao = document.getElementById("situacaoVoo");
	situacao.disabled = true;
	
	preco = document.getElementById("precoVoo");
	preco.disabled = true;
}
</script>

<!-- Formulario -->

<h1><%=idioma.ConsultarVoo %></h1>

		<form action="MainController" method="post">
			<input type="hidden" name = "categoria" value="voo">
				
					<table>
						<tbody>		
						
						
														
						<!-- CÓDIGO -->
							<tr>
								<td><label><%=idioma.CodigoVoo %></label></td>
								<td><input type = "text" name = "codVoo" id = "codVoo" size = 10 tabindex = "1" > 
								</td>
							</tr>			
							
						
							<!-- ORIGEM -->
							<tr>
								<td><label><%=idioma.Origem %></label></td>
								<td><select name = "listaAeroportoOrigem" id = "listaAeroportoOrigem"   >
									<option value = "-1"></option>
									<% try{for(Aeroporto a : origem)
									{ %>
									<option value = "<%=a.getCodAeroporto()%>"> <%=a %></option>
									<%}}catch(Exception e){} %>
									</select>
								</td>
							</tr>	
							
							<!-- DESTINO -->
							<tr>
								<td><label><%=idioma.Destino %></label></td>
								<td><select name = "listaAeroportoDestino" id = "listaAeroportoDestino" >
									<option value = "-1"></option>
									<% try{for(Aeroporto a : destino)
									{ %>
									<option value = "<%=a.getCodAeroporto() %>"> <%=a %></option>
									<%}}catch(Exception e){} %>
									</select>
								</td>
							</tr>			
									
							<!-- DATA -->
							<tr>
								<td><label><%=idioma.Data %></label></td>
								<td><input type = "text" name = "diaVoo" size = 2 tabindex = "1" id = "diaVoo"  > /
								    <input type = "text" name = "mesVoo" size = 2 tabindex = "2" id = "mesVoo"  > / 
								    <input type = "text" name = "anoVoo" size = 4 tabindex = "3" id = "anoVoo"  >						
								</td>
							</tr>			
							
							
							<!-- HORA -->
							<tr>
								<td><label><%=idioma.Hora %></label></td>
								<td><input type = "text" name = "horaVoo" size = 2 tabindex = "4" id = "horaVoo"  > :
								    <input type = "text" name = "minVoo" size = 2 tabindex = "5" id = "minVoo"  > 
								</td>
							</tr>			
				
							
							<!-- AERONAVES -->
							<tr>
								<td><label><%=idioma.Aeronave %></label></td>
								<td><select name = "listaAeronave" id = "listaAeronave"  >
									<option value = "-1"></option>
									<% try{for(Aeronave a : aero)
									{ %>
									<option value="<%=a.getCodAeronave() %>"> <%=a.getNomeAeronave() %></option>
									<%}}catch(Exception e){} %>
									</select>
								</td>
							</tr>
							
							<!-- PREÇO -->
							<tr>
								<td><label><%=idioma.Preco %></label></td>
								<td><input type = "text" name = "precoVoo" size = "10" tabindex = "8" id = "precoVoo"  >
								</td>
							</tr>
							
							<!-- SITUAÇÃO -->
							<tr>
								<td><label><%=idioma.Situacao %></label></td>
								<td><select name = "situacaoVoo" id = "situacaoVoo"  >
								  	<option value = "null"></option>
								  	<option value = "EmEspera"><%=idioma.EmEspera %> </option>
								  	<option value = "Confirmado"><%=idioma.Confirmado %> </option>
								  	<option value = "Encerrado"><%=idioma.Encerrado %> </option>
								  </select>
		
								</td>
							</tr>			
										
							
							
							<!-- Limpa tabela e executa o jsp -->
							<tr>
								<td colspan="2">
									<button type="submit" name= "operacao" value = "buscarVooGenerico" tabindex="13"><%=idioma.Consultar %></button>
									<button type="reset" name="limpar" tabindex="14"><%=idioma.Limpar %></button>
								</td>
							</tr>
							
							<!-- Retorna para pagina daonde veio -->
							<tr>
								<td colspan="2">
									&nbsp;
									<button type="submit" name="operacao" value = "voltar" tabindex="15"><%=idioma.Voltar %></button>
		
								</td>
							</tr>
							
						</tbody>
					 </table>
				</form>
				
				<hr>
				
		
		
		<!-- FORMULÁRIO DE DETALHES -->
		<form action="MainController" method="post">
			<input type = "hidden" name = "categoria" value = "voo">
				<input type = "hidden" name = "pagina" value = "consultar">

					<table>
					
						<tr>
							<td><label><%=idioma.Voos%></label></td>
							<td>
								<select name = "codigoVoo">
									<% try{for(Voo a : vooList)
									{ %>
									<option value = "<%=a.getCodVoo()%>"> <%=a %></option>
									<%}}catch(Exception e){} %>
								</select>
							</td>
						</tr>
					
						 <tr>
							<td colspan="1">
								<button type="submit" name="operacao" value="buscarVoo" tabindex="13"><%= idioma.Detalhes %></button>
							</td>
						</tr>
					</table>
					
					<table border="1px" > 
					 
							<!-- Tabela Labels -->
							<tr align="center" >
								<td><label><%=idioma.CodigoVoo %></label></td>
								<td><label><%=idioma.Origem %></label></td>
								<td><label><%=idioma.Destino %></label></td>
								<td><label><%=idioma.Dia %></label></td>
								<td><label><%=idioma.Hora %></label></td>
								<td><label><%=idioma.Aeronave %></label></td>
								<td><label><%=idioma.Preco %></label></td>
								<td><label><%=idioma.Situacao %></label></td>
							</tr>
							
							<!-- Tabela Dados -->
							<tr align="center">
								
								<td width="40px"><%=codVooEscolhido %></td>
								<td width="200px"><%=origemVoo %></td>
								<td width="200px"><%=destinoVoo %></td>
								<td width="40px"><%=diaVoo %>/<%=mesVoo %>/<%=anoVoo %></td>
								<td width="40px"><%=horaVoo %>:<%=minutoVoo %></td>
								<td width="100px"><%=nomeAeronave %></td>
								<td width="40px">R$&nbsp;<%=precoVoo %></td>
								<td width="40px"><%=situacaoVoo %></td>
							</tr>
						
					</table>
				</form>
		
		<form action="consultarVoo.jsp">
			<button type="submit" name="operacaoPagina" value="limpar" tabindex="14"><%= idioma.Limpar %></button>
	
		</form>
		
		
		</body>
</html>