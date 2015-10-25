package Controller;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.smartcardio.ATR;

//import org.apache.tomcat.util.bcel.classfile.Attribute;


import Model.Aeronave;
import Model.Assento;
import Model.Passageiro;
import Model.Passagem;
import Model.Voo;

/**
 * Servlet implementation class CheckInController
 */
@WebServlet("/CheckInController")
public class CheckInController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	String disabled = "disabled", nomePassageiro = "", cpfPassageiro = "", dataNascPassageiro = "", origemVoo = "", destinoVoo = "",
	dataPartida = "", precoPassagem ="", checkInVar  = "", mensagem = "";
    
	/**
     * @see HttpServlet#HttpServlet()
     */
    public CheckInController() {
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
		if("realizarCheckIn".equals(request.getParameter("pagina")) && !"CheckIn".equals(request.getParameter("CheckIn")) )
		{
			
			if("Voltar".equals(request.getParameter("Voltar")))
			{
				request.getRequestDispatcher("principal.jsp").forward(request, response);
			}
			
			if("BuscarPassagem".equals(request.getParameter("BuscarPassagem")))
			{
				try
				{
						
						Passagem pass = new Passagem();
						Passageiro passageiro = new Passageiro();
						Voo voo = new Voo();
						
						pass = pass.buscarPassagem(Integer.parseInt(request.getParameter("codPassagem")));
						
						if ( pass != null)
						{
							passageiro = pass.getPassageiro();
					
							nomePassageiro = passageiro.getNomePassageiro();
							cpfPassageiro = passageiro.getCPF();
							dataNascPassageiro = Integer.toString(passageiro.getDiaNascimento()) + "/"
									+ Integer.toString(passageiro.getMesNascimento()) + "/"
									+ Integer.toString(passageiro.getAnoNascimento());
							
							voo = pass.getVoo();
			
							origemVoo = voo.getAeroportoOrigem().toString();
							destinoVoo = voo.getAeroportoDestino().toString();
							precoPassagem = Double.toString(pass.getValorPassagem());
							dataPartida = voo.getDiaPartida() + "/" + voo.getMesPartida() + "/" + voo.getAnoPartida() + "   " + voo.getHoraPartida() + ":" + voo.getMinutoPartida();
							
							checkInVar = Boolean.toString(pass.isCheckIn());

							if(pass.isCheckIn())
								disabled = "disabled";
							else
								disabled = "";
							
			
							Cookie cookie_PassCheckIn = null;
							Cookie cookie_VooCheckIn = null;
			
						
							cookie_PassCheckIn = new Cookie("passCheckIn",  Integer.toString(pass.getNumeroPassagem()));
							response.addCookie(cookie_PassCheckIn);
							cookie_VooCheckIn = new Cookie("vooCheckIn",  Integer.toString(voo.getCodVoo()));
							response.addCookie(cookie_VooCheckIn);
						}

				
				request.setAttribute("disabled",disabled);
				request.setAttribute("nomePassageiro",nomePassageiro);
				request.setAttribute("cpfPassageiro",cpfPassageiro);
				request.setAttribute("dataNascPassageiro", dataNascPassageiro);
				request.setAttribute("origemVoo", origemVoo);
				request.setAttribute("destinoVoo", destinoVoo);
				request.setAttribute("dataPartida", dataPartida);
				request.setAttribute("precoPassagem", precoPassagem);
				request.setAttribute("checkInVar", checkInVar);
				
				
				request.getServletContext().getRequestDispatcher("/realizarCheckIn.jsp").forward(request, response);
				
				}
				catch (Exception e)
				{
					e.printStackTrace();
					mensagem ="Ocorreu um erro na Busca de passagem!";
					request.setAttribute("mensagem", mensagem);
					request.getRequestDispatcher("/realizarCheckIn.jsp").forward(request, response);
				}
			}
			
			if("Limpar".equals(request.getParameter("Limpar")))
			{
				disabled = "disabled";
				nomePassageiro = "";
				cpfPassageiro = ""; dataNascPassageiro = ""; origemVoo = ""; destinoVoo = "";
						dataPartida = ""; precoPassagem =""; checkInVar  = "";	
				request.setAttribute("disabled",disabled);
				request.setAttribute("nomePassageiro",nomePassageiro);
				request.setAttribute("cpfPassageiro",cpfPassageiro);
				request.setAttribute("dataNascPassageiro", dataNascPassageiro);
				request.setAttribute("origemVoo", origemVoo);
				request.setAttribute("destinoVoo", destinoVoo);
				request.setAttribute("dataPartida", dataPartida);
				request.setAttribute("precoPassagem", precoPassagem);
				request.setAttribute("checkInVar", checkInVar);
				request.setAttribute("mensagem", mensagem);
				
				request.getServletContext().getRequestDispatcher("/realizarCheckIn.jsp").forward(request, response);
			}
			

		}
		
		else if("EscolherAssento".equals(request.getParameter("pagina")) || "CheckIn".equals(request.getParameter("CheckIn")))
		{
			
				
			 mensagem = "";
			int codVoo = -1;
			int nPassagem = -1;
			
			Cookie[] cookies = request.getCookies();
			for(Cookie a : cookies)
			{
				if(a.getName().equals("passCheckIn"))
				{
					nPassagem = Integer.parseInt(a.getValue());
					break;
				}
			}
			
			for(Cookie a : cookies)
			{
				if(a.getName().equals("vooCheckIn"))
				{
					codVoo = Integer.parseInt(a.getValue());
					break;
				}
			}
			

			Passagem passagem = new Passagem();
			
			if("Voltar".equals(request.getParameter("Voltar")))
			{
				request.getRequestDispatcher("realizarCheckIn.jsp").forward(request, response);
			}
				else if("Salvar".equals(request.getParameter("Salvar")))
				{
	
					
					passagem = passagem.buscarPassagem(nPassagem);
					passagem.setAssentoPassagem(Integer.parseInt(request.getParameter("assento")));
					passagem.setCheckIn(true);
					
					passagem.checkIn();
					
					String mensagem = 	passagem.getNumeroPassagem() + "\\n" +
										"Passageiro:" + passagem.getPassageiro().toString() + "\\n" +
										"Voo:" + passagem.getVoo().toString() + "\\n" +
										"Assento escolhido:" + passagem.getAssentoPassagem();
					request.setAttribute("mensagem", mensagem);
					
					request.getServletContext().getRequestDispatcher("/realizarCheckIn.jsp").forward(request, response);
	
				}
				else{
				
				
					String nomeAeronave = "";
					Aeronave aeronave = new Aeronave();
					ArrayList<Assento> assentoList = new ArrayList<Assento>();
					
					
					if(codVoo != -1 && nPassagem != -1)
					{
						//VooDAO vooDAO = new VooDAO();
						Voo voo = new Voo().buscarTodosCodigoObjt(codVoo);
						passagem = passagem.buscarPassagem(nPassagem);
						
						aeronave = voo.getAeronaveVoo();
						
						nomeAeronave = aeronave.getNomeAeronave();
						
						Assento assento = new Assento();
						
						assentoList = assento.buscarTodosAssentosVoo(aeronave.getCodAeronave(), passagem.getVoo().getCodVoo());
						
						request.setAttribute("Aeronave", aeronave);
						request.setAttribute("AssentoList", assentoList);
						request.setAttribute("NomeAeronave", nomeAeronave);
						
	
						request.getRequestDispatcher("escolherAssentoCheckIn.jsp").forward(request, response);
					}
					else
					{
						request.getRequestDispatcher("realizarCheckIn.jsp").forward(request, response);
					}
					
					
					
					
				}
		}  
		
		
		
	}
}
