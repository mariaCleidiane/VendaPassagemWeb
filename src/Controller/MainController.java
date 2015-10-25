package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MainController
 */
@WebServlet("/MainController")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainController() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		execute(request, response);
	}
	
	protected void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String categoria = request.getParameter("categoria");
		
		if(categoria.equals("aeronave"))
		{
			request.getRequestDispatcher("AeronaveController").forward(request, response);
		}
		else if(categoria.equals("passageiro"))
		{
			request.getRequestDispatcher("PassageiroController").forward(request, response);
		}
		else if(categoria.equals("voo"))
		{
			request.getRequestDispatcher("VooController").forward(request, response);
		}
		else if(categoria.equals("checkIn"))
		{
			request.getRequestDispatcher("CheckInController").forward(request, response);
		}
		else if(categoria.equals("ComprarPassagem"))
		{
			request.getRequestDispatcher("ComprarPassagemController").forward(request, response);
		}
		else if(categoria.equals("passagem"))
		{
			request.getRequestDispatcher("PassagemController").forward(request, response);
		}
		else
		{
			request.getRequestDispatcher("principal.jsp").forward(request, response);
		}
		
	}


}
