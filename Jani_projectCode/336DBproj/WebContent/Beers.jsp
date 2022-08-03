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

<form action="Beers.jsp">
<select name = "BeerName" class="form-control" style="width: 250px;"> 
<option value="-1"></option>
<%

	String sql = "SELECT BeerName FROM Beer";
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
    <option value="<%=rs.getString("BeerName")%>"><%=rs.getString("BeerName")%></option>
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

																			<%-- Beers part A --%>
<%
String BeerN = request.getParameter("BeerName");
String sql31 = "Select Bills.bar_name,SUM(Transactions.quantity)FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where item = '"+BeerN+"' group by Bills.bar_name ORDER BY SUM(Transactions.quantity) desc Limit 5;";
%>

<%

        try {

            //Get the database connection
   Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,uname,pass);
Statement statement = connection.createStatement();
ResultSet rs =  statement.executeQuery(sql31); 

out.println("<h3><center>The Top 5 bars Where This Beer Sells the Most</center></h3>");

out.println("<center><table></center>");

//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//print out column header
out.print("<h4>Bar Name</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Number of Transactions</h4>");
out.print("</td>");

while (rs.next()){

out.println("<tr>");
out.print("<td>"+"<center>" +rs.getString("Bills.bar_name")+ "</center>"+"</td>");
out.print("<td>"+"<center>"+ rs.getString("SUM(Transactions.quantity)")+"</center>"+ "</td>");

out.println("</tr>");


}
} catch(Exception ex){
    ex.printStackTrace();
} 

out.println("</table>");

    %>

																			<%-- Beers part B --%>
<%
String BeerN2 = request.getParameter("BeerName");
String sql32 = "SELECT Bills.drinker_name,Sum(Transactions.quantity) FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where item = '"+BeerN2+"' Group By drinker_name ORDER BY Sum(Transactions.quantity) Desc Limit 10;";
%>

<%
        try {
            //Get the database connection
   Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,uname,pass);
Statement statement = connection.createStatement();
ResultSet rs =  statement.executeQuery(sql32); 

out.println("<h3><center>Drinkers Who are the Biggest Consumers of Beer</center></h3>");

out.println("<center><table></center>");

//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//print out column header
out.print("<h4>Drinker's Name</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Number of Transactions</h4>");
out.print("</td>");

while (rs.next()){

out.println("<tr>");
out.print("<td>"+"<center>"+ rs.getString("Bills.drinker_name")+"</center>"+ "</td>");
out.print("<td>"+"<center>"+ rs.getString("Sum(Transactions.quantity)")+"</center>"+ "</td>");

out.println("</tr>");


}
} catch(Exception ex){
    ex.printStackTrace();
} 

out.println("</table>");

    %>

<form action = "BeersGraph.jsp">

<label style = "margin-right: 50px;"> Select time period: </label>
</select>
<br>

<% String Bar = request.getParameter("bar_name");%>

<input type = "hidden" name = "BeerName" value = "<%=BeerN%>">
Choose your graph!
<select name = "graph" size =1>
<option value = "Most sales per day" > Most sales per day</option>
<option value = "Most sales per time of day" > Most sales per time day</option>
<option value = "Most sales per month" > Most sales per month</option>
</select>
<br>
Input the DATE for 'Most sales per time of day' graph ONLY (format: yyyy-mm-dd):
<input type="text" name="date">
<br>
Input the MONTH for 'Most sales per day' graph ONLY (format: 1-12):
<input type="text" name="month">
<br>

<input type = "submit" value = "Show the graph">
</form>

</body>
</html>