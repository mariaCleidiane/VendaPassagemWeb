<%@page import = "Internacionalizacao.Internacionalizacao" %>

<%
Internacionalizacao idioma = new Internacionalizacao();
	String meu_cookie = "";

	Cookie[] cookies = request.getCookies();

	if(cookies == null || cookies.length <= 0)
	{
		response.sendRedirect("principal.jsp");
	}
	else
	{
		for(Cookie c : cookies)
		{
			if(c.getName().equals("idioma"))
			{
				meu_cookie = c.getValue();
				if(meu_cookie.equals("en"))
				{
					idioma.toEnglish();
				}
				else if(meu_cookie.equals("sp"))
				{
					idioma.toSpanish();
				}
				else
				{
					idioma.toPortuguese();
				}
						
				break;
			}
		}
	
		if(meu_cookie.equals(""))
		{
			response.sendRedirect("principal.jsp");
		}
	}
%>