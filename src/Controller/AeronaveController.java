package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.AeronaveDAO;
import Model.Aeronave;

/**
 * Servlet implementation class AeronaveController
 */
@WebServlet("/AeronaveController")
public class AeronaveController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    //Objetos
	Aeronave aeronave;
	String mensagem = "";
	
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AeronaveController() 
    {
        super();
        // TODO Auto-generated constructor stub
        //array = new double [2]
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
	
	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String operacao = request.getParameter("operacao");
		String pagina = request.getParameter("pagina");
		
		if(operacao == null || operacao.equals("voltar"))
		{
			request.getRequestDispatcher("principal.jsp").forward(request, response);
		}
		else if(operacao.equals("cadastrar"))
		{
			try
			{
				aeronave = new Aeronave();
	
				aeronave.setNomeAeronave(request.getParameter("NomeAeronave"));		
				aeronave.setModeloAeronave(request.getParameter("ModeloAeronave"));
				aeronave.setQtdColunas(Integer.parseInt(request.getParameter("QuantidadeColunas")));
				aeronave.setQtdFileiras(Integer.parseInt(request.getParameter("QuantidadeFileiras")));
			
		   		/*O que deve ser cadastrado
				nomeAeronave = "";
				modeloAeronave = "";
				qtdColunas = X;
				qtdFileiras = X;
				*/
				aeronave.cadastrar(aeronave);
	
				//Envia mensagem ao usuário
				mensagem = "Aeronave cadastrada com sucesso!";
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("cadastrarAeronave.jsp").forward(request, response);
				
			}catch(Exception e)
			{
				mensagem = "Não foi possível cadastrar aeronave";
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("cadastrarAeronave.jsp").forward(request, response);
				
			}
			
		}
		else if(operacao.equals("excluir"))
		{
			aeronave = new Aeronave();
			
			try
			{
				aeronave.excluir(Integer.parseInt(request.getParameter("CodigoAeronave")));
				
				
				mensagem = "Aeronave excluída com sucesso!";
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("excluirAeronave.jsp").forward(request, response);
				
			}
			catch(Exception e)
			{
				mensagem = "Não foi possível excluir aeronave.";
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("excluirAeronave.jsp").forward(request, response);
				
			}
			
		}
		else if (operacao.equals("procurarAeronave"))
		{
			try{
				aeronave = new Aeronave();
				aeronave = aeronave.buscarCodObj(Integer.parseInt(request.getParameter("CodigoAeronave")));
				
				request.setAttribute("aeronave", aeronave);
				
				if(pagina.equals("excluir"))
					request.getRequestDispatcher("excluirAeronave.jsp").forward(request, response);
				else if (pagina.equals("alterar"))
					request.getRequestDispatcher("alterarAeronave.jsp").forward(request, response);
				else if (pagina.equals("consultar"))
					request.getRequestDispatcher("consultarAeronave.jsp").forward(request, response);
				
				
			}catch(Exception e)
			{
				mensagem = "Não foi possível buscar aeronave.";
				request.setAttribute("mensagemRetorno", mensagem);
				
				if(pagina.equals("excluir"))
					request.getRequestDispatcher("excluirAeronave.jsp").forward(request, response);
				else if (pagina.equals("alterar"))
					request.getRequestDispatcher("alterarAeronave.jsp").forward(request, response);
				else if (pagina.equals("consultar"))
					request.getRequestDispatcher("consultarAeronave.jsp").forward(request, response);
				
				
			}
	
		}
		else if (operacao.equals("procurarAeronaveGenerico"))
		{
			
			ArrayList<Aeronave> aeroList = new ArrayList<Aeronave>();
					
				try
				{
					int cod, assento, fileira;
					String nome, modelo;
					AeronaveDAO aeroDAO = new AeronaveDAO();
					
					if(request.getParameter("CodigoAeronave") == null || request.getParameter("CodigoAeronave") == "")
					 	cod = -1;
					else
						cod = Integer.parseInt(request.getParameter("CodigoAeronave"));
					
						nome = request.getParameter("NomeAeronave");
						
						modelo = request.getParameter("ModeloAeronave");

						if(request.getParameter("QuantidaAssentos") == null || request.getParameter("QuantidaAssentos") == "")
							assento = -1;
						else
							assento = Integer.parseInt(request.getParameter("QuantidaAssentos"));
						
						if(request.getParameter("QuantidadeFileiras") == null || request.getParameter("QuantidadeFileiras") == "")
							fileira = -1;
						else
							fileira = Integer.parseInt(request.getParameter("QuantidadeFileiras"));
						
						aeroList = aeroDAO.buscarGenerico(cod, nome, modelo, assento, fileira);
						
						request.setAttribute("aeronaveList", aeroList);
						request.getRequestDispatcher("consultarAeronave.jsp").forward(request, response);
						
						
					}catch(Exception e)
					{
						mensagem = "Aeronave não encontrada.";
						request.setAttribute("mensagemRetorno", mensagem);
						request.getRequestDispatcher("consultarAeronave.jsp").forward(request, response);
						
						
					}
			

		}
		else if(operacao.equals("alterar"))
		{
			aeronave = new Aeronave();
			
			try
			{
				aeronave.setCodAeronave(Integer.parseInt(request.getParameter("CodigoAeronave")));
				aeronave.setNomeAeronave(request.getParameter("NomeAeronave"));
				aeronave.setModeloAeronave(request.getParameter("ModeloAeronave"));
				aeronave.setQtdColunas(Integer.parseInt(request.getParameter("QuantidaDeColunas")));
				aeronave.setQtdFileiras(Integer.parseInt(request.getParameter("QuantidaDeFileiras")));	
				
				aeronave.alterar(aeronave);
				
				mensagem = "Aeronave alterada com sucesso!";
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("alterarAeronave.jsp").forward(request, response);
			}catch(Exception e)
			{
				mensagem = "Não foi possível alterar aeronave.";
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("alterarAeronave.jsp").forward(request, response);
				
			}
			
			
		}
	}
}
