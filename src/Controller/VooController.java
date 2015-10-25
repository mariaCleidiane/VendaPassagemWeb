package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Aeronave;
import Model.Aeroporto;
import Model.Voo;

/**
 * Servlet implementation class VooController
 */
@WebServlet("/VooController")
public class VooController extends HttpServlet
{
	private static final long serialVersionUID = 1L;
    private Voo voo;
    private String mensagemRetorno = "";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VooController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		execute(request, response);
	}
	
	protected void execute (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String operacao = request.getParameter("operacao");
		String pagina = request.getParameter("pagina");
		
		if(operacao == null || operacao.equals("voltar"))
		{
			request.getRequestDispatcher("principal.jsp").forward(request, response);
		}
		else if(operacao.equals("cadastrarVoo"))
		{
			try
			{
				 voo = new Voo();
				
				voo.setPrecoVoo(Double.parseDouble(request.getParameter("precoVoo")));
				
				if(request.getParameter("situacaoVoo").equals("EmEspera"))
					voo.setSituacaoVoo("Em Espera");
				else
					voo.setSituacaoVoo(request.getParameter("situacaoVoo"));
				
				voo.setHoraPartida(Integer.parseInt(request.getParameter("horaVoo")));
				voo.setMinutoPartida(Integer.parseInt(request.getParameter("minVoo")));
				
				
				voo.setDiaPartida(Integer.parseInt(request.getParameter("diaVoo")));
				voo.setMesPartida(Integer.parseInt(request.getParameter("mesVoo")));
				voo.setAnoPartida(Integer.parseInt(request.getParameter("anoVoo")));
				
				Aeroporto aeroportoOrigem = new Aeroporto();
				aeroportoOrigem.setCodAeroporto(Integer.parseInt(request.getParameter("listaAeroportoOrigem")));
				voo.setAeroportoOrigem(aeroportoOrigem);
				
				Aeroporto aeroportoDestino = new Aeroporto();
				aeroportoDestino.setCodAeroporto(Integer.parseInt(request.getParameter("listaAeroportoDestino")));
				voo.setAeroportoDestino(aeroportoDestino);
				
				Aeronave aeronave = new Aeronave();
				aeronave.setCodAeronave(Integer.parseInt(request.getParameter("listaAeronave")));
				voo.setAeronaveVoo(aeronave);
				
			
				voo.cadastrarVoo(voo);
				
				//Mensagem retorno
				mensagemRetorno = "Voo cadastrado com sucesso.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("cadastrarVoo.jsp").forward(request, response);
				
							
		
			}catch(Exception e)
			{
				//Mensagem retorno
				mensagemRetorno = "Não foi possível cadastrar o voo.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("cadastrarVoo.jsp").forward(request, response);
				
			
			}
		
		}
		else if(operacao.equals("excluirVoo"))
		{
			try
			{
				voo = new Voo();
				voo.excluir(Integer.parseInt(request.getParameter("codigoVooEscolhido")));
				
				//Mensagem retorno
				mensagemRetorno = "Voo excluído com sucesso.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("excluirVoo.jsp").forward(request, response);
				
				
			}
			catch(Exception e)
			{
				//Mensagem retorno
				mensagemRetorno = "Não foi possível excluir voo.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("excluirVoo.jsp").forward(request, response);
				
			}
		}
		else if(operacao.equals("alterarVoo"))
		{
			try
			{
				voo = new Voo();
				voo = voo.buscarTodosCodigoObjt(Integer.parseInt(request.getParameter("codigoVooEscolhido")));
				
				
				//Aeroporto Origem e destino
				//Origem
				Aeroporto aeroportoOrigem = new Aeroporto();
				aeroportoOrigem = aeroportoOrigem.buscarPorCodigoAeroporto(Integer.parseInt(request.getParameter("listaAeroportoOrigem")));
				voo.setAeroportoOrigem(aeroportoOrigem);
				
				//Destino
				Aeroporto aeroportoDestino = new Aeroporto();
				aeroportoDestino = aeroportoDestino.buscarPorCodigoAeroporto(Integer.parseInt(request.getParameter("listaAeroportoDestino")));
				voo.setAeroportoDestino(aeroportoDestino);
				
				//Preço
				voo.setPrecoVoo(Double.parseDouble(request.getParameter("Preco")));
				
				//Hora
				voo.setHoraPartida(Integer.parseInt(request.getParameter("HoraVoo")));
				
				//Minuto
				voo.setMinutoPartida(Integer.parseInt(request.getParameter("MinVoo")));
			
				//Data
				//Dia
				voo.setDiaPartida(Integer.parseInt(request.getParameter("DiaVoo")));
				//Mes
				voo.setMesPartida(Integer.parseInt(request.getParameter("MesVoo")));
				//Ano
				voo.setAnoPartida(Integer.parseInt(request.getParameter("AnoVoo")));
				
				//Aeronave
				Aeronave aeronaveSelecionada = new Aeronave();
				aeronaveSelecionada = aeronaveSelecionada.buscarCodObj(Integer.parseInt((request.getParameter("listaAeronave"))));
				voo.setAeronaveVoo(aeronaveSelecionada);
				
				//Situação
				if(request.getParameter("situacaoVoo").equals("EmEspera"))
							voo.setSituacaoVoo("Em Espera");
						else
							voo.setSituacaoVoo(request.getParameter("situacaoVoo"));
						
				voo.alterar(voo);
				
				//Mensagem retorno
				mensagemRetorno = "Voo alterado com sucesso.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("alterarVoo.jsp").forward(request, response);
				
			
			}
			catch(Exception e)
			{
				//Mensagem retorno
				mensagemRetorno = "Não foi possível alterar voo.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("alterarVoo.jsp").forward(request, response);
				
			}
		}
		else if(operacao.equals("buscarVoo"))
		{
			try
			{
				voo = new Voo();
				voo = voo.buscarTodosCodigoObjt(Integer.parseInt(request.getParameter("codigoVoo")));
				
				request.setAttribute("voo", voo);
				
				if(pagina.equals("excluir"))
					request.getRequestDispatcher("excluirVoo.jsp").forward(request, response);
				else if(pagina.equals("alterar"))
					request.getRequestDispatcher("alterarVoo.jsp").forward(request, response);
				else if(pagina.equals("consultar"))
					request.getRequestDispatcher("consultarVoo.jsp").forward(request, response);
			}
			catch(Exception e)
			{
				//Mensagem retorno
				mensagemRetorno = "Não foi possível encontrar voo.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
		
				if(pagina.equals("excluir"))
					request.getRequestDispatcher("excluirVoo.jsp").forward(request, response);
				else if(pagina.equals("alterar"))
					request.getRequestDispatcher("alterarVoo.jsp").forward(request, response);
				else if(pagina.equals("consultar"))
					request.getRequestDispatcher("consultarVoo.jsp").forward(request, response);
		
			}
		}
		else if(operacao.equals("buscarVooGenerico"))
		{
			ArrayList<Voo> vooList = new ArrayList<Voo>();
			voo = new Voo();
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
				if(request.getParameter("listaAeroportoOrigem") == null || request.getParameter("listaAeroportoOrigem") == "" )
					codOrigem = -1;
				else
					codOrigem = Integer.parseInt(request.getParameter("listaAeroportoOrigem"));
				
				//Destino
				if(request.getParameter("listaAeroportoDestino") == null || request.getParameter("listaAeroportoOrigem") == "")
					codDestino = -1;
				else
					codDestino = Integer.parseInt(request.getParameter("listaAeroportoDestino"));
				
				//Aeronave
				if(request.getParameter("listaAeronave") == null || request.getParameter("listaAeronave") == "")
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
				
				//Busca os Voos
				vooList = voo.buscaGenericaVoo(codVoo, codOrigem, codDestino, hora, min, dia, mes, ano, codAeronave, situacao, preco);
	
				request.setAttribute("vooList", vooList);
				request.getRequestDispatcher("consultarVoo.jsp").forward(request, response);
		}
		catch(Exception e)
		{
			//Mensagem retorno
			mensagemRetorno = "Não foi possível encontrar voo.";
			request.setAttribute("mensagemRetorno", mensagemRetorno);
			request.getRequestDispatcher("consultarVoo.jsp").forward(request, response);
		}
		

		}
			
	}
}
