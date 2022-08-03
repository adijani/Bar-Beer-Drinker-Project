package com.project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AJ
 */
@WebServlet("/AJ")
public class AJ extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AJ() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String c = request.getParameter("Page2");
		if (c.equals("Drinker")){
			response.sendRedirect("Drinkers.jsp"); 
		}
		else if (c.equals("Bar")){
			response.sendRedirect("Bars.jsp"); 
		}
		else if (c.equals("Beer")){
			response.sendRedirect("Beers.jsp"); 
		}
		else{
			response.sendRedirect("Modifications.jsp");
		}
		
	}

}
