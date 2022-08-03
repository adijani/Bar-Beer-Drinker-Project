<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<a href="index.jsp">Home Page</a> <br>



<form action="Drinkers.jsp">
<select name="DrinkerName" class="form-control" style="width: 250px;"> 
<option value="-1"></option>
<%

	String sql = "SELECT DrinkerName FROM Drinker";
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
    <option value="<%=rs.getString("DrinkerName")%>"><%=rs.getString("DrinkerName")%></option>
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

																<%-- Drinker part A --%>

<%
String DN = request.getParameter("DrinkerName");
String sql1 = "Select Bills.bill_id, Bills.bar_name,Bills.bill_date,Bills.bill_time ,Bills.drinker_name, Transactions.quantity, Transactions.item,Transactions.type,Bills.items_price, Transactions.price,Bills.tax_price, Bills.tip,Bills.total_price FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where drinker_name = '"+DN+"' ORDER BY bar_name , bill_time;";
//System.out.println (sql1);
%>

<%

        try {

            //Get the database connection
   Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url,uname,pass);
Statement statement = connection.createStatement();
ResultSet rs =  statement.executeQuery(sql1); 

out.println("<h3><center>Drinker's Transactions</center></h3>");

            //Make an HTML table to show the results in:
out.println("<center><table></center>");

//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//print out column header
out.print("<h4>Buyer's Name</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Bar's Name</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>(yyyy-mm-dd)</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Time</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Bills Identification Number</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Type of Item</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Name of Item</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Items Purchased</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Price</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Tax</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Tip</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Total</h4>");
out.print("</td>");
//make a column
out.print("<td>");
out.print("<h4>Cost for Transactions</h4>");
out.print("</td>");


while (rs.next()){



out.println("<tr>");
out.print("<td>"+"<center>" +rs.getString("Bills.drinker_name")+"</center>" + "</td>");
out.print("<td>"+"<center>" +rs.getString("Bills.bar_name")+"</center>"+ "</td>");
out.print("<td>"+"<center>" +rs.getString("Bills.bill_date")+"</center>"+ "</td>");
out.print("<td>"+"<center>" +rs.getString("Bills.bill_time")+"</center>"+ "</td>");
out.print("<td>"+"<center>" +rs.getString("Bills.bill_id")+"</center>"+ "</td>");
out.print("<td>"+"<center>" +rs.getString("Transactions.type")+"</center>"+ "</td>");
out.print("<td>"+"<center>" +rs.getString("Transactions.item")+"</center>"+ "</td>");
out.print("<td>"+"<center>" +rs.getString("Transactions.quantity")+"</center>"+ "</td>");
out.print("<td>"+"<center>" + "$" +rs.getString("Bills.items_price")+"</center>"+ "</td>");
out.print("<td>"+"<center>" + "$" +rs.getString("Bills.tax_price")+"</center>"+ "</td>");
out.print("<td>"+"<center>" + "$" +rs.getString("Bills.tip")+"</center>"+ "</td>");
out.print("<td>"+"<center>" + "$" +rs.getString("Bills.total_price")+"</center>"+ "</td>");
out.print("<td>"+"<center>" + "$" +rs.getString("Transactions.price")+"</center>"+ "</td>");

out.println("</tr>");


}
} catch(Exception ex){
    ex.printStackTrace();
} 

out.println("</table>");

%>

<a href="Drinkers.jsp">Drinkers Page</a> <br>
<form action = "DrinkersGraph.jsp">
<input type = "Hidden" name = "DrinkerName" value = "<%=DN%>">
<input type = "submit" value = "Show the graph">
</form>

</body>
</html>