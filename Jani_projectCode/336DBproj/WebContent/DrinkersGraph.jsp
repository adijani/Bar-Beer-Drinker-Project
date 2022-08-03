<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
    <% String DN = request.getParameter("DrinkerName");%>
	

<%

String url = "jdbc:mysql://localhost:3306/bdd?serverTimezone=UTC";
String uname = "root";
String pass= "student1";



	StringBuilder myData=new StringBuilder();
	String strData ="";
	String chartTitle="";
	String legend="";
	try{
	
	ArrayList <Map<String,Integer>> list = new ArrayList();
		Map<String,Integer> map = null;
		//Get the database connection
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con =DriverManager.getConnection(url,uname,pass);

		//Create a SQL statement
		Statement stmt = con.createStatement();
		  
		//Make a query
		String query = "Select Transactions.item,Sum(Transactions.quantity) FROM Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id WHERE drinker_name = '"+DN+"' and type='beer'  GROUP BY Transactions.item ORDER BY Sum(Transactions.quantity) DESC;" ;
		//System.out.println(query);
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(query);
		//Process the result
		while (result.next()) { 
			map = new HashMap<String,Integer>();
	   			map.put(result.getString("Transactions.item"),result.getInt("Sum(Transactions.quantity)"));
			list.add(map);
	    } 
	    result.close();
	    
	    //Create a String of graph data of the following form: ["Caravan", 3],["Cabana",2],...
    for(Map<String,Integer> hashmap : list){
    		Iterator it = hashmap.entrySet().iterator();
        	while (it.hasNext()) { 
       		Map.Entry pair = (Map.Entry)it.next();
       		String key = pair.getKey().toString().replaceAll("'", "");
       		myData.append("['"+ key +"',"+ pair.getValue() +"],");
       	}
    }
    strData = myData.substring(0, myData.length()-1); //remove the last comma
    
    //Create the chart title according to what the user selected
      chartTitle = ""+DN+" ordered these beers the most";
      legend = "beers";
}catch(SQLException e){
		out.println(e);
}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Graphs</title>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data = [<%=strData%>]; //contains the data of the graph in the form: [ ["Caravan", 3],["Cabana",2],...]
			var title = '<%=chartTitle%>'; 
			var legend = '<%=legend%>'
			//this is an example of other kind of data
			//var data = [["01/22/2016",108],["01/24/2016",45],["01/25/2016",261],["01/26/2016",224],["01/27/2016",307],["01/28/2016",64]];
			var cat = [];
			data.forEach(function(item) {
			  cat.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart = Highcharts.chart('graphContainer', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			            //load: requestData
			        }
			    },
			    title: {
			        text: title
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend,
			        data: data
			    }]
			});
			});
		
		</script>
	</head>


<body>
<a href="index.jsp">Home Page</a> <br>
<div id="graphContainer" style="width: 500px; height: 400px; margin: 0 auto"></div>


<form action="DrinkersGraph2.jsp">
<label style = "margin-right: 50px;"> Select Bars: </label>
<select name = "Bar" class="form-control" style="width: 138px;"> 
<option value="-1"></option>

<%

String sql15 = "Select Distinct bar_name From Bills WHERE drinker_name = '"+DN+"';";
//System.out.println(DN);
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(url,uname,pass);
    Statement stm =con.createStatement();
    ResultSet rs = stm.executeQuery(sql15);
    while(rs.next())
    {
        %>
    <option value="<%=rs.getString("bar_name")%>"><%=rs.getString("bar_name")%></option>
    <%
    }
} catch(Exception ex){
    ex.printStackTrace();
      out.println("Error " +ex.getMessage());
}
%>
</select>
<br>

<% String Bar = request.getParameter("bar_name");%>

<input type = "hidden" name = "DrinkerName" value = "<%=DN%>">
<input type = "hidden" name = "bar_name" value = "<%=Bar%>">
Choose your graph!
<select name = "graph" size =1>
<option value = "Daily Spendings" > Daily Spendings</option>
<option value = "Monthly Spendings" > Monthly Spendings</option>
</select>
<br>
<input type="submit" value="Graph">


</form>

</body>
</html>