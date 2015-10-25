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
		Aeroporto aeroportoDAO = new Aeroporto();
		Voo vooDAO = new Voo();
		
		//ArrayList Origem e Destino
		 ArrayList<Aeroporto> origem = new ArrayList<Aeroporto>();
		 ArrayList<Aeroporto> destino = new ArrayList<Aeroporto>();
		 
		
		 //Lista com os aeroportos
		origem = aeroportoDAO.buscarAeroporto();
		destino = aeroportoDAO.buscarAeroporto();
		
		//Preeche Aeronaves 
			//Objeto de DAO
			AeronaveDAO aeronaveDAO = new AeronaveDAO();
			//ArrayList Aeronave
			 ArrayList<Aeronave> aero = new ArrayList<Aeronave>();
			//Lista com as aeronaves
			aero = aeronaveDAO.buscarTodos();
	
			//Lista de voos
			ArrayList<Voo> vooList = new ArrayList<Voo>();
			
				
				//Consultar
				if("Consultar".equals(request.getParameter("operacaoCon")))
				{
					try
					{
						
						int codVoo = -1, hora = -1, min = -1, dia = -1, mes = -1, ano = -1, codAeronave = -1,
								codOrigem = -1, codDestino = -1;
						double preco = -1;
						String situacao = "";
						
						//Código do Voo
						if(request.getParameter("codVoo") == "" || request.getParameter("codVoo") == null)
							codVoo = -1;
						else
							codVoo = Integer.parseInt(request.getParameter("codVoo"));
						
						//Hora 
						if(request.getParameter("horaVoo") == "" || request.getParameter("horaVoo") == null)
							hora = -1;
						else
							hora = Integer.parseInt(request.getParameter("horaVoo"));
						
						//Minuto
						if(request.getParameter("minVoo") == "" || request.getParameter("minVoo") == null)
							min = -1;
						else
							min = Integer.parseInt(request.getParameter("minVoo"));
						
						//Dia
						if(request.getParameter("diaVoo") == "" || request.getParameter("diaVoo") == null)
							dia = -1;
						else
							dia = Integer.parseInt(request.getParameter("diaVoo"));
						
						//Mes
						if(request.getParameter("mesVoo") == "" || request.getParameter("mesVoo") == null)
							mes = -1;
						else
							mes = Integer.parseInt(request.getParameter("mesVoo"));
						
						//Ano
						if(request.getParameter("anoVoo") == "" || request.getParameter("anoVoo") == null)
							ano = -1;
						else
							ano = Integer.parseInt(request.getParameter("anoVoo"));
						
						//Origem
						if(Integer.parseInt(request.getParameter("listaAeroportoOrigem")) == -1)
							codOrigem = -1;
						else
							codOrigem = Integer.parseInt(request.getParameter("listaAeroportoOrigem"));
						
						//Destino
						if(Integer.parseInt(request.getParameter("listaAeroportoDestino")) == -1)
							codDestino = -1;
						else
							codDestino = Integer.parseInt(request.getParameter("listaAeroportoDestino"));
						
						//Aeronave
						if(Integer.parseInt(request.getParameter("listaAeronave")) == -1)
							codAeronave = -1;
						else
							codAeronave = Integer.parseInt(request.getParameter("listaAeronave"));
						
						//Sitação
						if(!request.getParameter("situacaoVoo").equals("null"))
						{
							if(request.getParameter("situacaoVoo").equals("EmEspera"))
								situacao = "Em espera";
							else if(request.getParameter("situacaoVoo").equals("Confirmado"))
								situacao = "Confirmado";
							else
								situacao = "Encerrado";
						}
						else
							situacao = "";
							
						//Preço
						if(request.getParameter("precoVoo") == null || request.getParameter("precoVoo") == "" )
							preco = -1;
						else
							preco = Double.parseDouble(request.getParameter("precoVoo"));
						
						vooList = vooDAO.buscaGenericaVoo(codVoo, codOrigem, codDestino, hora, min, dia, mes, ano, codAeronave, situacao, preco);
					
				
			}
			catch(Exception e)
			{
				%><script type="text/javascript">
				alert("Ocorreu um erro na Consulta!");
				</script>
				<%	
			}
		}
				
				if("Detalhar".equals(request.getParameter("operacaoDel")))
				{
					try
					{
						Voo vooDetalhes = new Voo();
						VooDAO vDAO = new VooDAO();
						
						vooDetalhes = vDAO.buscarTodosCodigoObjt(Integer.parseInt(request.getParameter("listaVooEncontrado")));
						
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
					}
					catch (Exception e)
					{
						%><script type="text/javascript">
						alert("Ocorreu um erro na Detalhamento!");
						</script>
						<%	
					}
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
	origem.disabled = false;
	
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
	cod.disabled = false;
	
	
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

		<form action="consultaVoo.jsp" method="post">
			<input type="hidden" name="operacaoCon" value="Consultar">
			<table>
				<tbody>		
				
				
				<!-- TIPO DE PESQUISA -->
					<tr>
						<td><strong><label><%=idioma.TipoPesquisa %></label></strong></td>
						<td><label><%=idioma.SomenteCodigo %></label><input type = "radio" name = "pesquisa" value = "codOnly" onclick = "bloqueiaDados()" >
													<label><%=idioma.DadosVoo %></label><input type = "radio" name = "pesquisa" value = "dadosVoo" onclick = "bloqueiaCod()">
						</td>
					</tr>			
				
								
				<!-- CÓDIGO -->
					<tr>
						<td><label><%=idioma.CodigoVoo %></label></td>
						<td><input type = "text" name = "codVoo" id = "codVoo" size = 10 tabindex = "1" disabled> 
						</td>
					</tr>			
					
				
					<!-- ORIGEM -->
					<tr>
						<td><label><%=idioma.Origem %></label></td>
						<td><select name = "listaAeroportoOrigem" id = "listaAeroportoOrigem" disabled >
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
						<td><select name = "listaAeroportoDestino" id = "listaAeroportoDestino" disabled>
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
						<td><input type = "text" name = "diaVoo" size = 2 tabindex = "1" id = "diaVoo" disabled> /
						    <input type = "text" name = "mesVoo" size = 2 tabindex = "2" id = "mesVoo" disabled> / 
						    <input type = "text" name = "anoVoo" size = 4 tabindex = "3" id = "anoVoo" disabled>						
						</td>
					</tr>			
					
					
					<!-- HORA -->
					<tr>
						<td><label><%=idioma.Hora %></label></td>
						<td><input type = "text" name = "horaVoo" size = 2 tabindex = "4" id = "horaVoo" disabled> :
						    <input type = "text" name = "minVoo" size = 2 tabindex = "5" id = "minVoo" disabled> 
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
						<td><select name = "listaAeronave" id = "listaAeronave" disabled>
							<option value = "-1"></option>
							<% for(Aeronave a : aero)
							{ %>
							<option value="<%=a.getCodAeronave() %>"> <%=a.getNomeAeronave() %></option>
							<%} %>
							</select>
						</td>
					</tr>
					
					<!-- PREÇO -->
					<tr>
						<td><label><%=idioma.Preco %></label></td>
						<td><input type = "text" name = "precoVoo" size = "10" tabindex = "8" id = "precoVoo" disabled>
						</td>
					</tr>
					
					<!-- SITUAÇÃO -->
					<tr>
						<td><label><%=idioma.Situacao %></label></td>
						<td><select name = "situacaoVoo" id = "situacaoVoo" disabled>
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
							<button type="submit" name="Consultar" tabindex="13"><%=idioma.Consultar %></button>
							<button type="reset" name="limpar" tabindex="14"><%=idioma.Limpar %></button>
						</td>
					</tr>
					
					<!-- Retorna para pagina daonde veio -->
					<tr>
						<td colspan="2">
							&nbsp;
							<input type="button" name="voltar" tabindex="15" value="Voltar" 
							onClick="location.href = 'principal.jsp'"/>
						</td>
					</tr>
					
				</tbody>
			 </table>
		</form>
		
		<hr>
		
		
		
		<!-- FORMULÁRIO DE DETALHES -->
		<form action="consultaVoo.jsp" method="post">

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



</body>
</html>