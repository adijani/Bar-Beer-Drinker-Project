<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>
<% 
String html = "<a href=\"index.jsp\">Home Page</a> <br>";
String sql = request.getParameter("satisfy");
String url = "jdbc:mysql://localhost:3306/bdd?serverTimezone=UTC";
String uname = "root";
String pass= "student1";

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(url,uname,pass);
    Statement stm =con.createStatement();
    stm.executeUpdate(sql);
    
    PrintWriter XD = response.getWriter();
    out.println("Task Completed Successfully");
    out.println(html);
    
} catch(SQLException ex){
    ex.printStackTrace();
      out.println("Error " +ex.getMessage());
      out.println(html);
}
%>

</body>
</html>