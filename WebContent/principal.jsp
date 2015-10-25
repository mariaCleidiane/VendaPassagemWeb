
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import = "Internacionalizacao.Internacionalizacao" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%
	Internacionalizacao idioma = new Internacionalizacao();

String lang = request.getParameter("idioma");
System.out.print(lang);
if(lang != null)
{
	Cookie[] cookies = request.getCookies();

	Cookie meu_cookie = null;
	
	/* Se não existir cookie algum..*/
	
	if(cookies == null || cookies.length <= 0)
	{
		// construtor do cookie = Cookie(nome do cookie, valor do cookie)
		meu_cookie = new Cookie("idioma", lang);
	}
	else
	{
		//Verifica a existencia do nosso cookie idioma
		for(Cookie c : cookies)
		{
			if(c.getName().equals("idioma"))
			{
				meu_cookie = c;
				meu_cookie.setValue(lang);
				
				break;
			}
		}
	}

	// Se nao encontrou o nosso cookie...
	if(meu_cookie == null)
	{
		meu_cookie = new Cookie("idioma", lang);
	}
	
	response.addCookie(meu_cookie);
	
	if(meu_cookie.getValue().equals("en"))
	{
		idioma.toEnglish();
	}
	else if(meu_cookie.getValue().equals("sp"))
	{
		idioma.toSpanish();
	}
	else
	{
		idioma.toPortuguese();
	}
	response.sendRedirect("principal.jsp");
}	
else
{
	Cookie meu_cookie = null;
	Cookie[] cookies = request.getCookies();
	if(cookies != null )
	{
		for(Cookie c : cookies)
		{
			if(c.getName().equals("idioma"))
			{
				meu_cookie = c;
				
				break;
			}
		}
		if (meu_cookie != null )
		{		
			if(meu_cookie.getValue().equals("en"))
			{
				idioma.toEnglish();
			}
			else if(meu_cookie.getValue().equals("sp"))
			{
				idioma.toSpanish();
			}
			else
			{
				idioma.toPortuguese();
			}
		}
		else
		{
			meu_cookie = new Cookie("idioma", "pt");
			response.addCookie(meu_cookie);
			idioma.toPortuguese();
		}
	}
	else
	{
		meu_cookie = new Cookie("idioma", "pt");
		response.addCookie(meu_cookie);
		idioma.toPortuguese();
	}
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=idioma.SistemaAeroporto %></title>
<style type="text/css">
body
{
   background-color: #FFFFFF;
   color: #000000;
}
</style>
<style type="text/css">
a
{
   color: #0000FF;
   text-decoration: underline;
}
a:visited
{
   color: #800080;
}
a:active
{
   color: #FF0000;
}
a:hover
{
   color: #0000FF;
   text-decoration: underline;
}
</style>
<link rel="stylesheet" href="cupertino/jquery.ui.all.css" type="text/css">
<style type="text/css">
#MenuPrincipal
{
   float: left;
   list-style: none;
   margin: 0;
   padding: 0;
   width: 100%;
   font-family: Arial;
   font-size: 17px;
}
#MenuPrincipal li
{
   float: left;
   margin: 0;
   padding: 0;
   position: relative;
}
#MenuPrincipal li a
{
   float: left;
}
#MenuPrincipal li .submenu
{
   display: none;
   float: left;
   left: 0;
   padding: 15px 15px 15px 15px;
   position: absolute;
   top: 0;
}
#MenuPrincipal li .row
{
   clear: both;
   float: left;
   margin-bottom: 10px;
   width: 100%;
}
#MenuPrincipal li .submenu ul
{
   float: left;
   list-style: none;
   margin: 0;
   padding: 0;
   width: 150px;
}
#MenuPrincipal .submenu ul li
{
   width: 100%;
}
#MenuPrincipal .submenu ul li h2
{
   font-family: Arial;
   font-size: 17px;
   font-weight: bold;
   font-style: normal;
   margin: 0;
   padding: 0;
   text-decoration: none;
}
#MenuPrincipal .submenu ul li h2 a
{
   background-image: none;
   background-color: transparent;
   border-width: 0;
   font-weight: bold;
   font-style: normal;
   padding: 5px 0;
   text-decoration: none;
}
#MenuPrincipal .submenu ul li h2 a:hover
{
   padding: 5px 0;
}
#MenuPrincipal .submenu ul li a
{
   display: block;
   float: none;
   font-weight: normal;
   font-style: normal;
   height: auto;
   padding: 7px 5px 7px 15px;
   text-decoration: none;
   text-indent: 0;
}
#MenuPrincipal .submenu ul li a:hover
{
   padding: 6px 4px 6px 14px;
}
#MenuPrincipal .submenu ul li a .ui-icon
{
   left: 0;
   margin-top: -8px;
   position: absolute;
   top: 50%;
}
#MenuPrincipal .button
{
   cursor: pointer;
   font-weight: normal;
   font-style: normal;
   margin: 0 1px 0 0;
   outline: 0;
   padding: 4px 20px 4px 8px;
   position: relative;
   text-align: center;
   text-decoration: none !important;
   color: #2779AA;
}
#MenuPrincipal .button:hover
{
   color: #0070A3;
}
#MenuPrincipal .button:active
{
   color: #FFFFFF;
}
#MenuPrincipal .button .ui-icon
{
   left: auto;
   margin-top: -8px;
   margin-left: 0;
   position: absolute;
   right: 4px;
   top: 50%;
}
#fundo
{
   background-color: transparent;
   background-image: url(images/index_fundo_bkgrnd.png);
   background-repeat: repeat-x;
   background-position: left top;
   -moz-box-shadow: -2px 1px 9px #000000;
   -webkit-box-shadow: -2px 1px 9px #000000;
   box-shadow: -2px 1px 9px #000000;
}
#Combobox1
{
   border: 1px #0000FF double;
   background-color: #FFFFFF;
   color: #000000;
   font-family: Arial;
   font-size: 13px;
}
</style>
<script type="text/javascript" src="jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="jquery.effects.core.min.js"></script>
<script type="text/javascript" src="jquery.effects.blind.min.js"></script>
<script type="text/javascript" src="jquery.effects.bounce.min.js"></script>
<script type="text/javascript" src="jquery.effects.clip.min.js"></script>
<script type="text/javascript" src="jquery.effects.drop.min.js"></script>
<script type="text/javascript" src="jquery.effects.fold.min.js"></script>
<script type="text/javascript" src="jquery.effects.scale.min.js"></script>
<script type="text/javascript" src="jquery.effects.slide.min.js"></script>
<script type="text/javascript" src="wb.slideshow.min.js"></script>
<script type="text/javascript">
$(document).ready(function()
{
   $("#SlideShow1").slideshow(
   {
      interval: 8000,
      type: 'random',
      effect: 'fade',
      direction: '',
      effectlength: 3000
   });
   $('#MenuPrincipal .submenu ul li h2 a').addClass('ui-widget-header');
   $('#MenuPrincipal .submenu ul li a').hover(function()
   {
      $(this).addClass('ui-state-default');
   }, function()
   {
      $(this).removeClass('ui-state-default');
   });
   $('.ui-state-default').hover(function()
   {
      $(this).addClass('ui-state-hover');
   }, function()
   {
      $(this).removeClass('ui-state-hover');
   });
   $('#MenuPrincipal li').hover(function()
   {
      var top = $(this).find('.button').outerHeight();
      $(this).find('.submenu').css( {'top': top });
      $(this).find('.submenu').stop().fadeTo('fast', 1).show();
      if ($(this).find('.row').length > 0 )
      {
         var maxRowWidth = 0;
         $(this).find('.row').each(function()
         {
            var width = 0;
            $(this).find('ul').each(function()
            {
               width += $(this).width();
            });
            if (width > maxRowWidth)
            {
               maxRowWidth = width;
            }
         });
         $(this).find('.submenu').css({'width' : maxRowWidth});
         $(this).find('.row:last').css({'margin': '0'});
      }
      else
      {
         var width = 0;
         $(this).find('ul').each(function()
         {
            width += $(this).width();
         });
         $(this).find('.submenu').css({'width' : width});
      }
      $(this).find('.submenu').slideDown();
   }, function()
   {
      $(this).find('.submenu').stop().fadeTo('fast', 0, function()
      {
         $(this).hide();
      });
   })
   $('#MenuPrincipal li .submenu').hide();
});

function mudaLinguagem()
{
	var idioma = document.getElementById("Combobox1").value;
	location.href("principal.jsp?idioma=" + idioma);

}

</script>
</head>
<body>

<div id="fundo" style="position:absolute;text-align:left;left:3%;top:3%;width:859px;height:394px;z-index:8;" title="">
<div id="SlideShow1" style="position:absolute;left:0px;top:42px;width:858px;height:310px;z-index:0;">
<img style="border-width:0;left:0px;top:0px;width:858px;height:310px;" src="images/tam-aviao.jpg" alt="" title="">
<img style="border-width:0;left:0px;top:0px;width:858px;height:310px;display:none;" src="images/tam_oferece_check_in_pelo_celular_em_todo_o_pais_logo1.jpg" alt="" title="">
<img style="border-width:0;left:0px;top:0px;width:858px;height:310px;display:none;" src="images/WALLPAPER%20TAM.jpg" alt="" title="">
</div>

<!-- MENU -->
<div id="wb_MenuPrincipal" style="position:absolute;left:35px;top:5px;width:550px;height:47px;z-index:1;">
   <ul class="ui-widget" id="MenuPrincipal">
     
     <!-- PASSAGEM -->
      <li>
      <a href="principal.jsp" class="button ui-state-default"><span class="ui-icon ui-icon-triangle-1-s"></span><%=idioma.Passagem %></a>
      <div class="submenu ui-widget-content">
         <ul style="width:213px">
            <li><h2><a href="principal.jsp"><%=idioma.Passagem %></a></h2></li>
            <li><a href="consultarVooComprarPassagem.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.ComprarPassagem %></a></li>
            <li><a href="transferirPassagem.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.TransferirPassagem %></a></li>
            <li><a href="cancelarPassagem.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.CancelarPassagem %></a></li>
         </ul>
       </div>
      </li>
     
     <!-- CHECK-IN --> 
      <li>
      <a href="principal.jsp" class="button ui-state-default"><span class="ui-icon ui-icon-triangle-1-s"></span>Check-In</a>
      <div class="submenu ui-widget-content">
      <div class="row">
         <ul style="width:157px">
            <li><h2><a href="principal.jsp">Check-In</a></h2></li>
            <li><a href="realizarCheckIn.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.RealizarCheckIn %></a></li>
         </ul>
      </div>
      </div>
      </li>
      
      <!-- AERONAVE -->
      <li>
      <a href="principal.jsp" class="button ui-state-default"><span class="ui-icon ui-icon-triangle-1-s"></span><%=idioma.Aeronave %></a>
      <div class="submenu ui-widget-content">
      <div class="row">
         <ul style="width:172px">
            <li><h2><a href="principal.jsp"><%=idioma.Aeronave %></a></h2></li>
            <li><a href="cadastrarAeronave.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.CadastrarAeronave %></a></li>
            <li><a href="consultarAeronave.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.ConsultarAeronave %></a></li>
            <li><a href="alterarAeronave.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.AlterarAeronave %></a></li>
            <li><a href="excluirAeronave.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.ExcluirAeronave %></a></li>
         </ul>
      </div>
      </div>
      </li>
      
      <!-- VOO -->
      <li>
      <a href="principal.jsp" class="button ui-state-default"><span class="ui-icon ui-icon-triangle-1-s"></span><%=idioma.Voo %></a>
      <div class="submenu ui-widget-content">
      <div class="row">
         <ul style="width:132px">
            <li><h2><a href="principal.jsp"><%=idioma.Voo %></a></h2></li>
            <li><a href="cadastrarVoo.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.CadastrarVoo %></a></li>
            <li><a href="alterarVoo.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.AlterarVoo %></a></li>
            <li><a href="consultarVoo.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.ConsultarVoo %></a></li>
            <li><a href="excluirVoo.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.ExcluirVoo %></a></li>
         </ul>
      </div>
      </div>
      </li>
      
      <!-- PASSAGEIRO -->
      <li>
      <a href="principal.jsp" class="button ui-state-default"><span class="ui-icon ui-icon-triangle-1-s"></span><%=idioma.Passageiro %></a>
      <div class="submenu ui-widget-content">
        <div class = "row">
         <ul style="width:185px">
            <li><h2><a href="principal.jsp"><%=idioma.Passageiro %></a></h2></li>
            <li><a href="cadastrarPassageiro.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.CadastrarPassageiro %></a></li>
            <li><a href="alterarPassageiro.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.AlterarPassageiro %></a></li>
            <li><a href="consultarPassageiro.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.ConsultarPassageiro %></a></li>
            <li><a href="excluirPassageiro.jsp"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.ExcluirPassageiro %></a></li>
         </ul>
      </div>
      </div>
      </li>
   

      
      <!-- AJUDA -->
      <li>
      <a href="principal.jsp" class="button ui-state-default"><span class="ui-icon ui-icon-triangle-1-s"></span><%=idioma.Ajuda %></a>
      <div class="submenu ui-widget-content">
          <div class = "row">
            <ul style="width:100px">
            <li><h2><a href="principal.jsp"><%=idioma.Ajuda %></a></h2></li>
            <li><a href="emConstrucao.html"><span class="ui-icon ui-icon-triangle-1-e"></span><%=idioma.Sobre %></a></li>
         </ul>
      </div>
</div>
      </li>
      
	</ul>

</div>



<!-- Combo de idioma -->
<select onchange="mudaLinguagem()" name="cbxIdiomas" size="1" id="Combobox1"  style="position:absolute;left:690px;top:9px;width:159px;height:23px;z-index:2;">
	<option value="pt" <% if(idioma.lang.equals("pt")) out.print("selected");  %> >Português</option>
	<option value="en" <% if(idioma.lang.equals("en")) out.print("selected"); %> >English</option>
	<option value="sp" <% if(idioma.lang.equals("sp")) out.print("selected"); %> >Español</option>
	</select>

<!-- BOTOES -->
<button id="btnPassagemAerea" type="button" name="" value="" style="position:absolute;left:160px;top:355px;width:138px;height:34px;z-index:3;"><div style="text-align:center"><span style="color:#000000;font-family:Arial;font-size:13px"><%=idioma.PassagemAerea %></span></div></button>
<button id="btnCheckIn" type="button" name="" value="" style="position:absolute;left:302px;top:355px;width:138px;height:34px;z-index:4;"><div style="text-align:center"><span style="color:#000000;font-family:Arial;font-size:13px">Check-In</span></div></button>
<button id="btnAeronave" type="button" name="" value="" style="position:absolute;left:445px;top:356px;width:150px;height:34px;z-index:5;"><div style="text-align:center"><span style="color:#000000;font-family:Arial;font-size:13px"><%=idioma.Aeronave %></span></div></button>
<button id="btnVoo" type="button" name="" value="" style="position:absolute;left:598px;top:356px;width:138px;height:34px;z-index:6;"><div style="text-align:center"><span style="color:#000000;font-family:Arial;font-size:13px"><%=idioma.Voo %></span></div></button>
</div>
</body>
</html>