package Controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.jdt.internal.compiler.ast.ThrowStatement;

import Model.Aeronave;
import Model.Assento;
import Model.Cartao;
import Model.Cheque;
import Model.Dinheiro;
import Model.Pagamento;
import Model.Passageiro;
import Model.Passagem;
import Model.Voo;
import Model.Aeroporto;
import Internacionalizacao.Internacionalizacao;

/**
 * Servlet implementation class PagamentoController
 */
@WebServlet("/ComprarPassagemController")
public class ComprarPassagemController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String origemVoo, destinoVoo, nomeAeronave, situacaoVoo, precoVoo, 
			diaVoo, mesVoo, anoVoo, horaVoo, minutoVoo, codVooEscolhido, mensagem; 

	String assentosDisponiveis;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComprarPassagemController() {
        super();
    	origemVoo = "";
    	destinoVoo = ""; nomeAeronave = ""; situacaoVoo = ""; precoVoo = ""; 
    			diaVoo = ""; mesVoo = ""; anoVoo = ""; horaVoo = ""; minutoVoo = ""; codVooEscolhido = ""; 
    		mensagem = "";

    	assentosDisponiveis = "";
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
		
		boolean redirecionarPagamento = false;
		
		if("transferirPassagem".equals(request.getParameter("pagina")))
		{
			
		}
		
	
		//---------------------------------------------------------------Voo----------------------------------------------------------
		
		if("ConsultarVoo".equals(request.getParameter("pagina")))
		{
				if( (request.getParameter("comprarPassagem")) != null && (request.getParameter("vooEscolhido") != null && request.getParameter("vooEscolhido") !=""))
				{
					
					Cookie codVooIda = new Cookie("codVooIda", request.getParameter("vooEscolhido"));
					response.addCookie(codVooIda);
					request.getRequestDispatcher("/addPassageiroComprarPassagem.jsp").forward(request, response);
				}
						
						
						//Consultar
						if("Consultar".equals(request.getParameter("operacaoCon")))
						{
							ArrayList<Voo> vooList = new ArrayList<Voo>();
						
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
								Voo voo = new Voo();
								
								vooList = voo.buscaGenericaVoo(codVoo, codOrigem, codDestino, hora, min, dia, mes, ano, codAeronave, situacao, preco);
								mensagem ="";
						
					}
					catch(Exception e)
					{
						
						mensagem = "Ocorreu um erro na Consulta!";
						
						
					}
							
					request.setAttribute("vooList", vooList);
					
					request.setAttribute("mensagem", mensagem);
					request.getServletContext().getRequestDispatcher("/consultarVooComprarPassagem.jsp").forward(request, response);
				}
						
						if("Detalhar".equals(request.getParameter("operacaoDel")))
						{
							try
							{
								Assento assento = new Assento();
								Voo voo = new Voo();
								voo = voo.buscarTodosCodigoObjt(Integer.parseInt(request.getParameter("listaVooEncontrado")));
								
								if(voo != null)
								{
									
									codVooEscolhido = Integer.toString(voo.getCodVoo());
									precoVoo = Double.toString(voo.getPrecoVoo());
									diaVoo = Integer.toString(voo.getDiaPartida());
									mesVoo = Integer.toString(voo.getMesPartida());
									anoVoo = Integer.toString(voo.getAnoPartida());
									horaVoo = Integer.toString(voo.getHoraPartida());
									minutoVoo = Integer.toString(voo.getMinutoPartida());
									nomeAeronave = voo.getAeronaveVoo().toString();
									situacaoVoo = voo.getSituacaoVoo();
									origemVoo = voo.getAeroportoOrigem().toString();
									destinoVoo = voo.getAeroportoDestino().toString();
									assentosDisponiveis = String.valueOf(assento.buscarQtdDisponivelVoo(voo.getAeronaveVoo().getCodAeronave(), voo.getCodVoo()));
									mensagem = "";
								}
							}
							catch (Exception e)
							{
	
								mensagem = "Ocorreu um erro na Detalhamento!";
	
							}
	
							request.setAttribute("codVooEscolhido", codVooEscolhido);
							request.setAttribute("precoVoo", precoVoo);
							request.setAttribute("diaVoo", diaVoo);
							request.setAttribute("mesVoo", mesVoo);
							request.setAttribute("anoVoo", anoVoo);
							request.setAttribute("horaVoo", horaVoo);
							request.setAttribute("minutoVoo", minutoVoo);
							request.setAttribute("nomeAeronave", nomeAeronave);
							request.setAttribute("situacaoVoo", situacaoVoo);
							request.setAttribute("origemVoo", origemVoo);
							request.setAttribute("destinoVoo", destinoVoo);
							request.setAttribute("assentosDisponiveis", assentosDisponiveis);
							
							request.setAttribute("mensagem", mensagem);
							
							request.getServletContext().getRequestDispatcher("/consultarVooComprarPassagem.jsp").forward(request, response);
						}
						
						if("Voltar".equals(request.getParameter("Voltar")))
						{
							request.getRequestDispatcher("/principal.jsp").forward(request, response);
						}
		}
		
		//---------------------------------------------------------------Passageiro----------------------------------------------------------
		
		else if("AddPassageiro".equals(request.getParameter("pagina")))
		{
			mensagem = "";
			if("Cadastrar".equals(request.getParameter("Cadastrar"))) 
			{
	
				try{
					Passageiro passageiro = new Passageiro();
					
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
					
					if (passageiro.buscarCodPassageiroCpfRg(passageiro.getCPF(), passageiro.getRG()) == -1)
					{
						try{
							passageiro.cadastrar(passageiro);
							mensagem = "Cadastro realizado com sucesso!";
						} catch(Exception e)
						{
							  e.printStackTrace();
							  mensagem = "Erro ao cadastrar!";
						}
					}
					
					Cookie cookie_temp = null;
					String valor_cookie = null;
					if (passageiro.getCPF() != null || passageiro.getCPF() !="")
					{
						valor_cookie = Integer.toString(passageiro.buscarCodPassageiroCpfRg(passageiro.getCPF(), null));

					}
					else if(passageiro.getRG() != null || passageiro.getCPF() !=""){ 
						valor_cookie = Integer.toString(passageiro.buscarCodPassageiroCpfRg(null, passageiro.getRG()));
					}
					
					if(valor_cookie != null)
					{
					 cookie_temp = new Cookie("passageiro",valor_cookie);
					 mensagem = mensagem + "\\nPassageiro encontrado; Prosseguindo para o pagamento";
						
					 response.addCookie(cookie_temp);
					 request.setAttribute("mensagem", mensagem);
					 redirecionarPagamento = true;
					 
					}
					else
					{
						mensagem = "Erro ao prosseguir!";
						request.setAttribute("mensagem", mensagem);
						request.getServletContext().getRequestDispatcher("/addPassageiroComprarPassagem.jsp").forward(request, response);
					}

				}catch(Exception e)
				{
						
					mensagem = "Erro ao cadastrar e processeguir!";
					request.setAttribute("mensagem", mensagem);
					request.getServletContext().getRequestDispatcher("/addPassageiroComprarPassagem.jsp").forward(request, response);
					
				}
				
			}
		
			if("Voltar".equals(request.getParameter("Voltar")))
			{
				request.getServletContext().getRequestDispatcher("/consultarVooComprarPassagem.jsp").forward(request, response);
			}

		}
		
		
		//---------------------------------------------------------------Pagamento----------------------------------------------------------
		
		
		if("Pagamento".equals(request.getParameter("pagina")) || redirecionarPagamento)
		{
			boolean pagamentoRealizado = false;
			
			Double numeroDeParcelas = 1.0;
			if(request.getParameter("valorParcela") != null)
			{
				numeroDeParcelas = Double.valueOf(request.getParameter("valorParcela"));
			}
			
			
			Cookie[] cookies = request.getCookies();
			int codVoo = -1;
			
			for(Cookie a : cookies)
			{
				if(a.getName().equals("codVooIda"))
				{
					codVoo = Integer.parseInt(a.getValue());
					break;
				}
			}
			
			Voo voo = new Voo();
			voo = voo.buscarTodosCodigoObjt(codVoo);
			
			//consulta voo --> add passageiro --> pagamento ---> cadastra passagem --> 
			//cadastra pagamento --> cadastra tipo de pagamento --> imprime cartão de embarque
			 
			if( request.getParameter("comprarPassagem") != null && request.getParameter("comprarPassagem") != "" )
			{
				mensagem = "";
				
				try{
					boolean erro = false;
					
					//Procurar os cookies "codVooIda" e "passageiro" 
					//----------------------------Montar algo mais sustentavel que cookies para conter ida/volta e mais de um passageiro----------------
					int codPass = -1 ;
					
					for(Cookie b : cookies)
					{
						if(b.getName().equals("passageiro"))
						{
							codPass = Integer.parseInt(b.getValue());
							break;
						}
					}
					//----------------------------------------------------------------------------------------
					
					//Encontrar os voos/passageiros respectivos
					//-----------------Montar lógica para ida/volta e mais de um passageiro-------------------
					int nPassageiros = 1;
					double taxEmbarque = 15.50;
					
					Passageiro passageiro = new Passageiro();
					
					passageiro = passageiro.buscarCodObj(codPass);	

					
					//----------------------------------------------------------------------------------------
					
					//--------------------------------Precisa aceitar mais de uma Passagem--------------------
					
					Passagem passagem = new Passagem();
					double rand = Math.random(), randomCode;
					randomCode = rand*codPass*codVoo*Calendar.getInstance().get(Calendar.MONTH+1)*Calendar.getInstance().get(Calendar.DAY_OF_MONTH)*Calendar.getInstance().get(Calendar.YEAR)*(900000000/rand);
					DecimalFormat df = new DecimalFormat("#.############");
					randomCode = Double.valueOf(df.format(randomCode));
					passagem.setTipoPassagem("Ida");
					passagem.setPassageiro(passageiro);
					passagem.setVoo(voo);
					passagem.setTaxaEmbarque(taxEmbarque);
					passagem.setTicketBagagem(Double.toString(randomCode));
					passagem.setValorPassagem(voo.getPrecoVoo());
					
					//----------------------------------------------------------------------------------------
					////-----------------------------------PAGAMENTO------------------------------------------
					//----------------------------------------------------------------------------------------
					Pagamento pagamento = new Pagamento();
					pagamento.setAnoPagamento(Calendar.getInstance().get(Calendar.YEAR));
					pagamento.setDiaPagamento(Calendar.getInstance().get(Calendar.DAY_OF_MONTH));
					//Mes começa como 0
					pagamento.setMesPagamento(Calendar.getInstance().get(Calendar.MONTH+1));
					
					pagamento.setPassageiroTitular(passageiro);
					
					double pagar = ((passagem.getTaxaEmbarque() + voo.getPrecoVoo())*nPassageiros);
					
					//(passagem.getTaxaEmbarque() + voo.getPrecoVoo())*nPassageiros
					//----------------------------------------------------------------------------------------
					
					//------------------------------CARTAO-----------------------------------
					if("cartao".equals(request.getParameter("tipoPagamento")))
					{
						try
						{
							
							Cartao cartao = new Cartao();
							
						 	//Passageiro Titular (necessário revisão)
							
							// NUMERO DO CARTÃO
							cartao.setNumeroCartao(request.getParameter("numeroCartao"));
							
							//BANDEIRA CARTÃO
							cartao.setBandeiraCartao(request.getParameter("BandeiraCartao"));
							
							//VALIDADE CARTÃO
							//Mês
							
							//	System.out.print(request.getParameter("mesValidadeCartao"));
							
							cartao.setMesValidade(Integer.parseInt(request.getParameter("mesValidadeCartao")));
							//Ano
							cartao.setAnoValidade(Integer.parseInt(request.getParameter("anoValidadeCartao")));
							
							//CÓDIGO DE SEGURANÇA
							cartao.setCodSeguranca(Integer.parseInt(request.getParameter("numeroSegurancaCartao")));
							
							//AGÊNCIA
							cartao.setAgenciaCartao(request.getParameter("agencia"));
							
							passagem.setNumeroPassagem(passagem.cadastrarPassagem());
							//seta o tipo de pagamento
							pagamento.setTipoPagamento("Cartão");
							
							if(passagem.getNumeroPassagem()!=0)
							{
								//poem a passagem com numero correto 
								pagamento.setNumeroPassagem(passagem);
								//insere no BD
								pagamento.setCodPagamento(pagamento.cadastrarPagamento());
								//
								if(pagamento.getCodPagamento()!=0)
								{	
									cartao.setCodPagamento(pagamento);
									
									cartao.cadastrarCartao();
									
									mensagem = "O pagamento foi feito por: "+ pagamento.getPassageiroTitular().getNomePassageiro() +
											"\\n\\nO numero das passagens e respectivos passageiros são:" +
											passagem.getNumeroPassagem() +" - " + passageiro.getNomePassageiro() + " " + passageiro.getSobrenomePassageiro();

									pagamentoRealizado = true;
								}
								else{erro = true;}
							}
							else{erro = true;}
					

						}catch(Exception e)
						{
							mensagem = "Ocorreu um erro no Cartao!";
							e.printStackTrace();
							erro = true;
						}
					}
					//------------------------------DINHEIRO-----------------------------------
					if("dinheiro".equals(request.getParameter("tipoPagamento")))
					{
						try
						{
							mensagem = "";
							
							double valorPago =  Double.parseDouble(request.getParameter("valorPagoDinheiro"));
							double troco = 0;
							if((valorPago - pagar)<0)
							{
								erro = true;
								
							}
							else
							{
								troco = valorPago - pagar;
								
								Dinheiro dinheiro = new Dinheiro();
								dinheiro.setValorPago(valorPago);
								dinheiro.setTroco(troco);
								
								//Agora tenho certeza de que não ocorrerá mais erro
								
								//Pega cria passagem e pega o numero dela
								passagem.setNumeroPassagem(passagem.cadastrarPassagem());
								//seta o tipo de pagamento
								pagamento.setTipoPagamento("Dinheiro");
								if(passagem.getNumeroPassagem()!=0)
								{
									//poem a passagem com numero correto 
									pagamento.setNumeroPassagem(passagem);
									//insere no BD
									pagamento.setCodPagamento(pagamento.cadastrarPagamento());
									//
									if(pagamento.getCodPagamento()!=0)
									{	
										dinheiro.setCodPagamento(pagamento);
										
										dinheiro.cadastrarDinheiro();
										
										mensagem = "O pagamento foi feito por: "+ pagamento.getPassageiroTitular().getNomePassageiro() +
												"\\nFoi pago: R$"+ valorPago +"\\nTroco: R$"+ troco +"\\n\\nO numero das passagens e respectivos passageiros são:" +
												passagem.getNumeroPassagem() +" - " + passageiro.getNomePassageiro() + " " + passageiro.getSobrenomePassageiro();
										
										pagamentoRealizado = true;
										
									}
									else{erro = true;}
								}
								else{erro = true;}
								
							
							}
						
						}catch(Exception e)
						{
							mensagem = "Ocorreu um erro no pagamento em Dinheiro!";
							e.printStackTrace();
							erro = true;
						}
					}
					
					//------------------------------CHEQUE-----------------------------------
					if("cheque".equals(request.getParameter("tipoPagamento")))
					{
						try
						{
							Cheque cheque = new Cheque();

							//NÚMERO CHEQUE
							cheque.setNumeroCheque(request.getParameter("numeroCheque"));
							
							//BANCO
							cheque.setBanco(request.getParameter("bancoCheque"));
							
							//AGENCIA
							cheque.setAgencia(request.getParameter("agenciaCheque"));
							
							//CONTA
							cheque.setConta(request.getParameter("contaCheque"));
							
							//Pega cria passagem e pega o numero dela
							passagem.setNumeroPassagem(passagem.cadastrarPassagem());
							//seta o tipo de pagamento
							pagamento.setTipoPagamento("Cheque");
							if(passagem.getNumeroPassagem()!=0)
							{
								//poem a passagem com numero correto 
								pagamento.setNumeroPassagem(passagem);
								//insere no BD
								pagamento.setCodPagamento(pagamento.cadastrarPagamento());
								//
								if(pagamento.getCodPagamento()!=0)
								{	
									cheque.setCodPagamento(pagamento);
									
									cheque.cadastrarCheque();
									 
									mensagem = "O pagamento foi feito por: "+ pagamento.getPassageiroTitular().getNomePassageiro() +
											"\\n\\nO numero das passagens e respectivos passageiros são:" +
											passagem.getNumeroPassagem() +" - " + passageiro.getNomePassageiro() + " " + passageiro.getSobrenomePassageiro();
									pagamentoRealizado = true;
								}
								else{erro = true;}
							}
							else{erro = true;}
						
						}catch(Exception e)
						{
							mensagem = "Ocorreu um erro no pagamento em cheque!";
							e.printStackTrace();
							erro = true;
						
						}
					}
					
					if(erro)
					{
						
						mensagem = mensagem + "\\nOcorreu um erro no pagamento!\\nNada foi comprometido";
						
					}
					
					
					
					request.setAttribute("mensagem", mensagem);
					request.setAttribute("voo", voo);
					request.setAttribute("numeroDeParcelas", numeroDeParcelas);
					request.setAttribute("pagamentoRealizado", String.valueOf(pagamentoRealizado));
					request.getServletContext().getRequestDispatcher("/pagamentoComprarPassagem.jsp").forward(request, response);
					
				}catch(Exception e)
				{
					e.printStackTrace();
					mensagem = "Ocorreu um erro no pagamento!";
					request.setAttribute("mensagem", mensagem);
					request.setAttribute("voo", voo);
					request.setAttribute("numeroDeParcelas", numeroDeParcelas);
					request.setAttribute("pagamentoRealizado", String.valueOf(pagamentoRealizado));
					request.getServletContext().getRequestDispatcher("/pagamentoComprarPassagem.jsp").forward(request, response);
				}
			}
			else
			{
				request.setAttribute("voo", voo);
				request.setAttribute("numeroDeParcelas", numeroDeParcelas);
				request.setAttribute("pagamentoRealizado", String.valueOf(pagamentoRealizado));
				request.getServletContext().getRequestDispatcher("/pagamentoComprarPassagem.jsp").forward(request, response);
			}
			
			if("Voltar".equals(request.getParameter("Voltar")))
			{
				request.getServletContext().getRequestDispatcher("/addPassageiroComprarPassagem.jsp").forward(request, response);
			}
			
		}	
	}
}
