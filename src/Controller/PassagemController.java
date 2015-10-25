package Controller;

import java.io.IOException;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Passageiro;
import Model.Passagem;
import Model.Reembolso;

/**
 * Servlet implementation class PassagemController
 */
@WebServlet("/PassagemController")
public class PassagemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Passagem passagem;
    private Passageiro passageiro;
    private Reembolso reembolso;
    private String mensagem = "";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PassagemController() {
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
	
	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String operacao = request.getParameter("operacao");
		String pagina = request.getParameter("pagina");
		
		if(pagina.equals("cancelarPassagem"))
		{
			
		}
		
		if(operacao.equals("transferirPassagem"))
		{
			
		}
		else if(operacao.equals("bucarPassagem"))
		{
			passagem = new Passagem();
			
			try
			{
				passagem = passagem.buscarPassagem(Integer.parseInt(request.getParameter("codPassagem")));
				request.setAttribute("passagem", passagem);
				
				if(pagina.equals("transferir"))
					request.getRequestDispatcher("passagem").forward(request, response);
				
			}
			catch(Exception e)
			{
				mensagem = "Passagem não encontrada.";
				request.setAttribute("mensagemRetorno", mensagem);
				
				if(pagina.equals("transferir"))
					request.getRequestDispatcher("mensagemRetorno").forward(request, response);
			}
			
		}
		else if(operacao.equals("buscarPassagemReembolso"))
		{
			try
			{
				long horaMilissegundo = 0, minMilissegundo = 0, tempoPassagemMilissegundo = 0, nowMilissegundo = 0, diferencaMilissegundo = 0;
				double valorDevolvido = 0.0;
				
				passagem = passagem.buscarPassagem(Integer.parseInt(request.getParameter("codBilhete")));
				
				horaMilissegundo = (passagem.getVoo().getHoraPartida())*3600000;
				minMilissegundo = (passagem.getVoo().getMinutoPartida())*60000;
				
				tempoPassagemMilissegundo = horaMilissegundo + minMilissegundo;
				
				GregorianCalendar now = new GregorianCalendar();
				nowMilissegundo = now.getTimeInMillis();
				
				diferencaMilissegundo = nowMilissegundo - tempoPassagemMilissegundo;
				
				
				//86400000 ms == 24 horas
				//43200000 ms == 12 horas
				//21600000 ms == 6 horas
				
				if(diferencaMilissegundo <= 21599999)
					valorDevolvido = 0;
				else if(diferencaMilissegundo >= 21600000 && diferencaMilissegundo <= 43199999)
					valorDevolvido = passagem.getValorPassagem() * 0.25;
				else if (diferencaMilissegundo >= 43200000 && diferencaMilissegundo <= 86399999)
					valorDevolvido = passagem.getValorPassagem() * 0.5;
				else
					valorDevolvido = passagem.getValorPassagem();
				
				request.setAttribute("valorDevolucao", valorDevolvido);
				
				request.getRequestDispatcher("cancelarPassagem.jsp").forward(request, response);
				
			}
			catch(Exception e)
			{
				mensagem = "Passagem não encontrada.";
				e.printStackTrace();
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("cancelarPassagem.jsp");
				
			}
		}
		else if (operacao.equals("cancelarPassagem"))
		{
			try
			{
				double valDevolvido = Double.parseDouble(request.getParameter("valorDevolvido"));
				
				if(valDevolvido > 0 )
				{
					reembolso.setBancoReembolso(request.getParameter("banco"));
					reembolso.setAgenciaReembolso(request.getParameter("agencia"));
					reembolso.setContaReembolso(request.getParameter("numeroDaConta"));
					//reembolso.setCodPassageiroTitular(passageiroTitular);
					//reembolso.setCodPassagem(pass);
					
					reembolso.inserirReembolso(reembolso);
						
				}
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
				mensagem = "Não foi possível cancelar a passagem.";
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("cancelarPassagem.jsp");
						
			}
		}
		else if(operacao.equals("buscarPassageiro"))
		{
			try
			{
				passageiro = new Passageiro();
				
				passageiro = passageiro.buscarCodObj(passageiro.buscarCodPassageiroCpfRg(request.getParameter("cpfTitular"), ""));
				
				request.setAttribute("passageiroEncontrado", passageiro);
				request.getRequestDispatcher("cancelarPassagem.jsp").forward(request, response);
				
			}
			catch (Exception e)
			{
				e.printStackTrace();
				mensagem = "Passageiro não encontrado.";
				
				request.setAttribute("mensagemRetorno", mensagem);
				request.getRequestDispatcher("cancelarPassagem.jsp");
						
			}
		}
	}

		
		
}
