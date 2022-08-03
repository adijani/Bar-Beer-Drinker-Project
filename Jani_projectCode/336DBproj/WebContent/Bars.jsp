<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<a href="index.jsp">Home Page</a> <br>

<form action="Bars.jsp">
<select name = "BarName" class="form-control" style="width: 250px;"> 
<option value="-1"></option>
<%

	String sql = "SELECT BarName FROM Bar";
	String url = "jdbc:mysql://localhost:3306/bdd?serverTimezone=UTC";
	String uname = "root";
	String pass= "student1";

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(url,uname,pass);
    Statement stm =con.createStatement();
    ResultSet rs = stm.executeQuery(sql);
    while(rs.next())
    {
        %>
    <option value="<%=rs.getString("BarName")%>"><%=rs.getString("BarName")%></option>
    <%
    }

} catch(Exception ex){
    ex.printStackTrace();
      out.println("Error " +ex.getMessage());
}


    %>

</select>
 <br>

<input type="submit" value="GO">
</form>


																			<%-- Bars part A --%>
<%
String BN = request.getParameter("BarName");
String sql2 = "Select DISTINCT Bills.drinker_name,Bills.total_price FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id WHERE bar_name = '"+BN+"' AND type = 'beer' ORDER BY Bills.total_price DESC limit 10;";
//System.out.println (sql2);
%>

<%

        try {

            //Get the database connection
   Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,uname,pass);
Statement statement = connection.createStatement();
ResultSet rs =  statement.executeQuery(sql2); 

out.println("<h3><center> Top 10 drinker's who are the largest spenders </center></h3>");

out.println("<center><table></center>");

//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//print out column header
out.print("<h4>Drinker Name</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Total Price</h4>");
out.print("</td>");

while (rs.next()){



out.println("<tr>");
out.print("<td>"+"<center>"+rs.getString("Bills.drinker_name")+ "</center>" + "</td>");
out.print("<td>"+"<center>" + "$" + rs.getString("Bills.total_price")+ "</center>" + "</td>");



out.println("</tr>");


}
} catch(Exception ex){
    ex.printStackTrace();
} 

out.println("</table>");

    %>
    
    																				<%-- Bars part B --%>
    
 <%
String BN2 = request.getParameter("BarName");
String sql3 = "Select SUM(Transactions.quantity), Transactions.item FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id WHERE bar_name = '"+BN2+"' and type = 'beer' GROUP BY Transactions.item  ORDER BY SUM(Transactions.quantity) DESC limit 10;";
//System.out.println (sql3);
%>

<%

        try {

            //Get the database connection
   Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,uname,pass);
Statement statement = connection.createStatement();
ResultSet rs =  statement.executeQuery(sql3); 

out.println("<h3><center> Top 10 most popular beers in selected bar </center> </h3>");

out.println("<table>");

//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//print out column header
out.print("<h4>Beer Name</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Total Sold</h4>");
out.print("</td>");

while (rs.next()){

out.println("<tr>");
out.print("<td>" + "<center>"+rs.getString("Transactions.item")+ "</center>" + "</td>");
out.print("<td>" + "<center>"+rs.getString("SUM(Transactions.quantity)")+"</center>"+ "</td>");


out.println("</tr>");


}
} catch(Exception ex){
    ex.printStackTrace();
} 

out.println("</table>");

    %>
    
    																		<%-- Bars part C --%>
    
 <%
String BN3 = request.getParameter("BarName");
String sql4 = "Select Distinct Beer.BeerManuf,Transactions.item ,SUM(Transactions.quantity) FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id INNER JOIN Beer ON Transactions.item = Beer.BeerName WHERE bar_name = '"+BN3+"' and type = 'beer' GROUP BY Transactions.item ORDER BY SUM(Transactions.quantity) DESC limit 5 ;";

%>

<%

        try {

            //Get the database connection
   Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,uname,pass);
Statement statement = connection.createStatement();
ResultSet rs =  statement.executeQuery(sql4); 

out.println("<h3><center> Top 5 manufactures who sell the most beers </center></h3>");

out.println("<table>");

//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//print out column header
out.print("<h4>Manufacturer</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Beer Name</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Number of Beer Sold</h4>");
out.print("</td>");

while (rs.next()){

out.println("<tr>");
out.print("<td>"+"<center>" +rs.getString("Beer.BeerManuf")+"</center>"+"</td>");
out.print("<td>"+"<center>" +rs.getString("Transactions.item")+ "</center>"+"</td>");
out.print("<td>"+"<center>" +rs.getString("SUM(Transactions.quantity)")+"</center>"+ "</td>");

out.println("</tr>");


}
} catch(Exception ex){
    ex.printStackTrace();
} 

out.println("</table>");

    %>
 
 
<form action = "BarsGraph.jsp">

<label style = "margin-right: 50px;"> Select time period: </label>
</select>
<br>

<% String bar_name = request.getParameter("BarName");%>

<input type = "hidden" name = "BarName" value = "<%=bar_name%>">
Choose your graph!
<select name = "graph" size =1>
<option value = "Busiest periods for the day" > Busiest periods for the day</option>
<option value = "Busiest periods for the week" > Busiest periods for the week</option>

</select>
<br>

<input type = "submit" value = "Show the graph">
</form>

</body>
</html>