<%@page import="com.sun.media.sound.DataPusher"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="Include/verificaIdioma.jsp" %>
    <%@page import = "Model.Passagem" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=idioma.TransferirPassagem %></title>
</head>
<body>

<!-- FUNÇÕES -->
<%
	String nomePassageiro = "", cpfPassageiro = "", dataNasc = "", origemVoo = "", destinoVoo = "", dataVoo = "", valorVoo = "", checkInView = "";
	boolean checkIn = false;
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
		
		Passagem passagem = (Passagem) request.getAttribute("passagem");
		
		if(passagem != null)
		{
			//Informações de passageiro.
			nomePassageiro = passagem.getPassageiro().getNomePassageiro();
			cpfPassageiro = passagem.getPassageiro().getCPF();
			dataNasc = passagem.getPassageiro().getDiaNascimento()+"/"+passagem.getPassageiro().getMesNascimento()+"/"+passagem.getPassageiro().getAnoNascimento();
			
			//Informações do voo
			origemVoo = passagem.getVoo().getAeroportoOrigem().toString();
			destinoVoo = passagem.getVoo().getAeroportoDestino().toString();
			dataVoo = passagem.getVoo().getDiaPartida()+"/"+passagem.getVoo().getMesPartida()+"/"+passagem.getVoo().getAnoPartida();
			valorVoo = Double.toString(passagem.getVoo().getPrecoVoo());
			
			checkIn = passagem.isCheckIn();
			if(checkIn)
				checkInView = idioma.Sim;
			else 
				checkInView = idioma.Nao;
			
		}
%>
<!-- Formulario -->

<h1><%=idioma.TransferirPassagem %></h1>

		<form action= "MainController" method="post">
			<input type="hidden" name="categoria" value="passagem">
				<input type = "hidden" name = "pagina" value = "transferir">
			<table>
				<tbody>		
				
				
					<!-- CÓDIGO PASSAGEM -->
					<tr>
						<td><label><%=idioma.CodigoPassagem %></label></td>
						<td><input type="text" maxlength="20" size="20" tabindex="1" name="codPassagem">
						<button type = "submit" name = "operacao" value = "buscarPassagem" ><%=idioma.Buscar %></button>
						</td>
					</tr>			
				
					<!-- NOME PASSAGEIRO -->
					<tr>
						<td><label><%=idioma.Nome %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="nomePassageiro" value = "<%=nomePassageiro %>" readonly = "true">
						</td>
					</tr>			
					
					<!-- CPF -->
					<tr>
						<td><label><%=idioma.CPF %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="cpfPassageiro" value = "<%=cpfPassageiro %>" readonly = "true">
						</td>
					</tr>			
					
					<!-- DATA NASCIMENTO -->
					<tr>
						<td><label><%=idioma.DataDeNascimento %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="dataNascPassageiro" value = "<%=dataNasc %>" readonly = "true">
						</td>
					</tr>			
					
					<!-- INFO PASSAGEM  -->
					<tr>
						<td><hr></td>
						
					</tr>			
				
					<!-- ORIGEM -->
					<tr>
						<td><label><%=idioma.Origem %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="origemVoo" value = "<%=origemVoo %>" readonly = "true">
						</td>
					</tr>
					
					<!-- DESTINO -->
					<tr>
						<td><label><%=idioma.Destino %></label></td>
						<td><input type="text" maxlength="40" size="40" tabindex="1" name="destinoVoo" value = "<%=destinoVoo %>" readonly = "true">
						</td>
					</tr>			
							
					<!-- DATA -->
					<tr>
						<td><label><%=idioma.DataPartida %></label></td>
						<td><input type="text" maxlength="10" size="10" tabindex="1" name="dataPartida" value = "<%=dataVoo %>" readonly = "true">
						</td>
					</tr>			
					
					<!-- VALOR -->
					<tr>
						<td><label><%=idioma.Preco %></label></td>
						<td><input type="text" maxlength="15" size="15" tabindex="1" name="precoPassagem" value = "<%=valorVoo %>" readonly = "true">
						</td>
					</tr>			
					
					 <!-- CHECK-IN -->
					 <tr>
						<td><label><%=idioma.CheckIn %></label></td>
						<td><input type="text" maxlength="4" size="4" tabindex="1" name="checkIn" value = "<%=checkInView %>" readonly = "true">
						</td>
					</tr>			
					
					<!-- BOTÕES -->
					<tr>
						<td colspan="2"><button type = "submit" name = "operacao" value = "voltar"><%=idioma.Voltar %></button>
						<button type = "reset" name = "operacaoPagina" value = "limpar"><%=idioma.Limpar %></button>
						</td>
					</tr>			
					
					<!-- TRANSFERIR -->
					<tr>
						<td colspan="2"><center><button type = "submit" name = "operacao" value = "transferirPassagem"><%=idioma.TransferirPassagem %></button></center>
						</td>
					</tr>
					
					
				</tbody>
			</table>
		</form>


</body>
</html>