package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Passageiro;

/**
 * Servlet implementation class PassageiroController
 */
@WebServlet("/PassageiroController")
public class PassageiroController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Passageiro passageiro;
    //Envia mensagens para o usuário.
    private String mensagemRetorno;
    
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PassageiroController() {
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
		
		if(operacao == null || operacao.equals("voltar"))
		{
			request.getRequestDispatcher("principal.jsp").forward(request, response);
		}
		else if(operacao.equals("buscarPassageiro"))
		{
			try
			{
				passageiro = new Passageiro();
				passageiro = passageiro.buscarCodObj(Integer.parseInt(request.getParameter("CodigoPassageiro")));
				
				//Insere o passageiro encontrado.
				request.setAttribute("passageiro", passageiro);
				
				//Redireciona para a página específica
				if(pagina.equals("excluir"))
					request.getRequestDispatcher("excluirPassageiro.jsp").forward(request, response);
				else if(pagina.equals("alterar"))
					request.getRequestDispatcher("alterarPassageiro.jsp").forward(request, response);
				else if(pagina.equals("consultar"))
					request.getRequestDispatcher("consultarPassageiro.jsp").forward(request, response);
				
			}
			catch(Exception e)
			{
				mensagemRetorno = "Não foi possível encontrar passageiro solicitado";
				
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				
				if(pagina.equals("excluir"))
					request.getRequestDispatcher("excluirPassageiro.jsp").forward(request, response);
				else if(pagina.equals("alterar"))
					request.getRequestDispatcher("alterarPassageiro.jsp").forward(request, response);
				else if(pagina.equals("consultar"))
					request.getRequestDispatcher("consultarPassageiro.jsp").forward(request, response);
				
			}
				
				

		}
		else if(operacao.equals("excluirPassageiro"))
		{
			try{
				passageiro = new Passageiro();
				passageiro.excluir(Integer.parseInt(request.getParameter("CodigoPassageiro")));
				
				mensagemRetorno = "Passageiro excluído com sucesso";
				
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("excluirPassageiro.jsp").forward(request, response);
				
				}
				catch(Exception e)
				{
					mensagemRetorno = "Erro na exclusão do passageiro";
					request.setAttribute("mensagemRetorno", mensagemRetorno);
					request.getRequestDispatcher("excluirPassageiro.jsp").forward(request, response);
					
				}
		}
		else if(operacao.equals("cadastrarPassageiro"))
		{
			try
			{
					passageiro = new Passageiro();
				
					passageiro.setNomePassageiro(request.getParameter("NomePassageiro"));		
					passageiro.setSobrenomePassageiro(request.getParameter("SobrenomePassageiro"));
					passageiro.setGeneroPassageiro(request.getParameter("Genero"));
					passageiro.setRG(request.getParameter("RGPassageiro"));
					passageiro.setCPF(request.getParameter("CPFPassageiro"));
					passageiro.setTratamentoPassageiro(request.getParameter("TratamentoPassageiro"));
					passageiro.setDiaNascimento(Integer.parseInt(request.getParameter("DiaNascimento")));
					passageiro.setMesNascimento(Integer.parseInt(request.getParameter("MesNascimento")));
					passageiro.setAnoNascimento(Integer.parseInt(request.getParameter("AnoNascimento")));
					passageiro.setCelularPassageiro(request.getParameter("CelularPassageiro"));
					passageiro.setEmailPassageiro(request.getParameter("EmailPassageiro"));

				
					passageiro.cadastrar(passageiro);
				
					//Envia mensagem ao jsp
					mensagemRetorno = "Cadastro realizado com sucesso!";
					request.setAttribute("mensagemRetorno", mensagemRetorno);
					request.getRequestDispatcher("cadastrarPassageiro.jsp").forward(request, response);
			}
			catch (Exception e)
			{
				//Envia mensagem ao jsp
				mensagemRetorno = "Não foi possível cadastrar passageiro.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("cadastrarPassageiro.jsp").forward(request, response);
			}
				

		}
		else if(operacao.equals("alterarPassageiro"))
		{
			try
			{
				passageiro = new Passageiro();
				
				passageiro.setCodPassageiro(Integer.parseInt(request.getParameter("CodigoPassageiro")));
				
				passageiro.setNomePassageiro(request.getParameter("NomePassageiro"));		
				passageiro.setSobrenomePassageiro(request.getParameter("SobrenomePassageiro"));
				passageiro.setGeneroPassageiro(request.getParameter("Genero"));
				passageiro.setRG(request.getParameter("RGPassageiro"));
				passageiro.setCPF(request.getParameter("CPFPassageiro"));
				passageiro.setTratamentoPassageiro(request.getParameter("TratamentoPassageiro"));
				passageiro.setDiaNascimento(Integer.parseInt(request.getParameter("DiaNascimento")));
				passageiro.setMesNascimento(Integer.parseInt(request.getParameter("MesNascimento")));
				passageiro.setAnoNascimento(Integer.parseInt(request.getParameter("AnoNascimento")));
				passageiro.setCelularPassageiro(request.getParameter("CelularPassageiro"));
				passageiro.setEmailPassageiro(request.getParameter("EmailPassageiro"));	
			
				passageiro.alterar(passageiro);
				
				//Envia mensagem ao jsp
				mensagemRetorno = "Informações do passageiro alteradas com sucesso.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("alterarPassageiro.jsp").forward(request, response);
			
			}
			catch(Exception e)
			{
				//Envia mensagem ao jsp
				mensagemRetorno = "Não foi possível alterar informações do passageiro.";
				request.setAttribute("mensagemRetorno", mensagemRetorno);
				request.getRequestDispatcher("alterarPassageiro.jsp").forward(request, response);
			}
		}
		else if(operacao.equals("buscarPassageiroGenerico"))
		{
			try
			{

				 int cod;
				 String nome;
				 String sobrenome;
				 String genero;
				 String cpf;
				 String rg;
				 int dia;
				 int mes;
				 int ano;
				 String tratamento;
				 String celular;
				 String email;
				 //Lista de passageiros encontrados
				 ArrayList<Passageiro> passList = new ArrayList<Passageiro>();

			passageiro = new Passageiro();
			
			if(request.getParameter("CodigoPassageiro") == null || request.getParameter("CodigoPassageiro") == "")
			 	cod = -1;
			else
				cod = Integer.parseInt(request.getParameter("CodigoPassageiro"));
			
				nome = request.getParameter("NomePassageiro");
				
				sobrenome = request.getParameter("SobrenomePassageiro");
				
				genero = request.getParameter("Genero");
				
				rg = request.getParameter("RGPassageiro");
				
				cpf = request.getParameter("CPFPassageiro");
				
				
				if(request.getParameter("DiaNascimento") == null || request.getParameter("DiaNascimento") == "")
				 	dia = -1;
				else
					dia = Integer.parseInt(request.getParameter("CodigoPassageiro"));
				
				if(request.getParameter("MesNascimento") == null || request.getParameter("MesNascimento") == "")
				 	mes = -1;
				else
					mes = Integer.parseInt(request.getParameter("CodigoPassageiro"));
				
				if(request.getParameter("AnoNascimento") == null || request.getParameter("AnoNascimento") == "")
				 	ano = -1;
				else
					ano = Integer.parseInt(request.getParameter("CodigoPassageiro"));
				
				tratamento = request.getParameter("TratamentoPassageiro");

				celular = request.getParameter("CelularPassageiro");
				
				email = request.getParameter("EmailPassageiro");
				
				passList = passageiro.buscarGenerico(cod, nome, sobrenome, genero, rg, cpf,
						tratamento, dia, mes, ano, email, celular);
				
				//Envia a lista de usuários para a jsp
				request.setAttribute("passList", passList);
				request.getRequestDispatcher("consultarPassageiro.jsp").forward(request, response);
				

		}
		catch(Exception e)
		{
			mensagemRetorno = "Não foi possível encontrar passageiro solicitado";
			
			request.setAttribute("mensagemRetorno", mensagemRetorno);
			request.getRequestDispatcher("consultarPassageiro.jsp").forward(request, response);
		}
			
	}

 }
	
}
