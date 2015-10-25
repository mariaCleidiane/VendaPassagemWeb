<%@page import="javax.xml.stream.events.Comment"%>
<%@page import="DAO.AssentoDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="Include/verificaIdioma.jsp" %>
    <%@ page import = "DAO.VooDAO, DAO.AeroportoDAO, DAO.AeronaveDAO, Model.Aeronave, Model.Voo, Model.Aeroporto"  %>
    <%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.ComprarPassagem %></title>
</head>
<body>
<!-- FUNÇÕES -->
<%

String origemVoo = "", destinoVoo = "", nomeAeronave = "", situacaoVoo = "", precoVoo = "", 
diaVoo = "", mesVoo = "", anoVoo = "", horaVoo = "", minutoVoo = "", codVooEscolhido = "", assentosDisponiveis = "";


//comprar passagem




			//Exibe mensagem para o usuário.
			String msg = (String) request.getAttribute("mensagem");
			if(msg != null && msg != "")
			{
				%>
				<script type="text/javascript">
					alert('<%=msg%>');
				</script>
				<%
			}
			
			
			if(request.getAttribute("codVooEscolhido") != null)
			{
				
				codVooEscolhido = (String) request.getAttribute("codVooEscolhido");
				precoVoo = (String) request.getAttribute("precoVoo");
				diaVoo = (String) request.getAttribute("diaVoo");
				mesVoo = (String) request.getAttribute("mesVoo");
				anoVoo = (String) request.getAttribute("anoVoo");
				horaVoo = (String) request.getAttribute("horaVoo");
				minutoVoo = (String) request.getAttribute("minutoVoo");
				nomeAeronave = (String) request.getAttribute("nomeAeronave");
				situacaoVoo = (String) request.getAttribute("situacaoVoo");
				origemVoo = (String) request.getAttribute("origemVoo");
				destinoVoo = (String) request.getAttribute("destinoVoo");
				assentosDisponiveis = (String) request.getAttribute("assentosDisponiveis");
				
			}	
			
			//Preeche a origem 
			//Objeto de DAO
			Aeroporto aeroporto = new Aeroporto();
			Voo voo = new Voo();
			
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
				 ArrayList<Aeronave> aeroList = new ArrayList<Aeronave>();
				//Lista com as aeronaves
				 aeroList = aeronave.buscarTodos();
		
				//Lista de voos
				ArrayList<Voo> vooList = new ArrayList<Voo>();
			
				if(request.getAttribute("vooList") != null)
				{
					vooList = (ArrayList<Voo>) request.getAttribute("vooList");
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
		<input type="hidden" name="categoria" value="ComprarPassagem">
			<input type="hidden" name="pagina" value="ConsultarVoo">
			<table>
				<tbody>		
				
				
				<!-- IDA OU IDA E VOLTA -->
					<tr>
						<td><label><%=idioma.SomenteIda %></label>
						<input type = "radio" id = "ida" name = "tipoVoo" value = "somenteIda" >
						</td>
						
						<td><label><%=idioma.IdaVolta %></label>
						<input type = "radio" id = "ida" name = "tipoVoo" value = "idaVolta" >
						</td>
						
					</tr>							
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
							<% for(Aeroporto a : origem)
							{ %>
							<option value = "<%=a.getCodAeroporto()%>"> <%=a %></option>
							<%} %>
							</select>
						</td>
					</tr>	
					
					<!-- DESTINO -->
					<tr>
						<td><label><%=idioma.Destino %></label></td>
						<td><select name = "listaAeroportoDestino" id = "listaAeroportoDestino" >
							<option value = "-1"></option>
							<% for(Aeroporto a : destino)
							{ %>
							<option value = "<%=a.getCodAeroporto() %>"> <%=a %></option>
							<%} %>
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
					
					<!-- ESCALAS -->
					<tr>
						<td><label><%=idioma.Escalas %></label></td>
						<td><input name = "incluirEscalas" type = "button" onClick = "window.open ('adicionarEscala.jsp')" value = "Adicionar Escalas" tabindex = "6">
		 					<input name = "excluirEscalas" type = "button" onClick = "window.open ('excluirEscala.jsp')" value = "Excluir Escalas" tabindex = "7">
		  
						</td>
					</tr>
					
					
					<!-- AERONAVES -->
					<tr>
						<td><label><%=idioma.Aeronave %></label></td>
						<td><select name = "listaAeronave" id = "listaAeronave"  >
							<option value = "-1"></option>
							<% for(Aeronave a : aeroList)
							{ %>
							<option value="<%=a.getCodAeronave() %>"> <%=a.getNomeAeronave() %></option>
							<%} %>
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
								
					<!-- PASSAGEIROS  -->
					<tr>
						<td><label><%=idioma.QuantidadePassageiros %></label></td>
						<td><input type = "text" name = "qtdPassageiros" size = "2" tabindex = "4" id = "qtdPassageiros"  >
						    
						</td>
					</tr>			
					
					
					<!-- Limpa tabela e executa o jsp -->
					<tr>
						<td colspan="2">
							<button type="submit" name="operacaoCon" value="Consultar" tabindex="13"><%=idioma.Consultar %></button>
							<button type="reset" name="operacaoCon" value="limpar" tabindex="14"><%=idioma.Limpar %></button>
						</td>
					</tr>
					
					<!-- Retorna para pagina daonde veio -->
					<tr>
						<td colspan="2">
							&nbsp;
							<button type="submit" name="Voltar" value = "Voltar" tabindex="15"><%=idioma.Voltar %></button>

						</td>
					</tr>
					
				</tbody>
			 </table>
		</form>
		
		<hr>
		
		
		
		<!-- FORMULÁRIO DE DETALHES -->
		<form action="MainController" method="post">
		<input type="hidden" name="categoria" value="ComprarPassagem">
					<input type="hidden" name="pagina" value="ConsultarVoo">
			<table>
			
				<tr>
					<td><label><%=idioma.Voos%></label></td>
					<td>
						<select name = "listaVooEncontrado">
							<% for(Voo a : vooList)
							{ %>
							<option value = "<%=a.getCodVoo()%>"> <%=a %></option>
							<%} %>
						</select>
					</td>
				</tr>
			
				 <tr>
					<td colspan="2">
						<button type="submit" name="operacaoDel" value="Detalhar" tabindex="13"><%= idioma.Detalhes %></button>
						<button type="submit" name="operacaoDel" value="Limpar" tabindex="14"><%= idioma.Limpar %></button>
					</td>
				</tr>
			</table>
			
			<table border="1px" > 
			 
					<!-- Tabela Labels -->
					<tr align="center" >
						<td width="40px"><label><%=idioma.CodigoVoo %></label></td>
						<td width="200px"><label><%=idioma.Origem %></label></td>
						<td width="200px"><label><%=idioma.Destino %></label></td>
						<td width="40px"><label><%=idioma.Data %></label></td>
						<td width="40px"><label><%=idioma.Hora %></label></td>
						<td width="100px"><label><%=idioma.Aeronave %></label></td>
						<td width="40px"><label><%=idioma.Preco %></label></td>
						<td width="40px"><label><%=idioma.Situacao %></label></td>
						<td width="40px"><label><%=idioma.AssentosDisponiveis %></label></td>
						<td width = "40px"><label><%=idioma.Comprar %></label></td>
						
					</tr>
					
					<!-- Tabela Dados -->
					<tr align="center">
						
						<td width="40px"><input type="hidden" readonly name="vooEscolhido"  value="<%=codVooEscolhido%>"><%=codVooEscolhido%></td>
						<td width="200px"><%=origemVoo %></td>
						<td width="200px"><%=destinoVoo %></td>
						<td width="40px"><%=diaVoo %>/<%=mesVoo %>/<%=anoVoo %></td>
						<td width="40px"><%=horaVoo %>:<%=minutoVoo %></td>
						<td width="100px"><%=nomeAeronave %></td>
						<td width="40px">R$&nbsp;<%=precoVoo %></td>
						<td width="40px"><%=situacaoVoo %></td>
						<td width="40px"><%=assentosDisponiveis %></td>
						<td width="40px"><input type ="submit" name = "comprarPassagem" value = "<%=idioma.Comprar %>"></td>
					</tr>
				
			</table>
		</form>

		<hr>

</body>
</html>