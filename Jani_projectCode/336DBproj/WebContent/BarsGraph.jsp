<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
	
	
	
	<%
	StringBuilder myData=new StringBuilder();
	String strData ="";
    String chartTitle="";
    String legend="";
    

		String bar_name = request.getParameter("BarName");
		
		//System.out.println(DN);
		//System.out.println(Bar);
		//String Bar2 = request.getParameter("Bar");
		//System.out.println(Bar2);
		// String bar_name = request.getParameter("bar_name");
		// String bar_name2 = request.getParameter("bar_name");
		//System.out.println(bar_name);
		//System.out.println(bar_name2);
		String url = "jdbc:mysql://localhost:3306/bdd?serverTimezone=UTC";
		String uname = "root";
		String pass= "student1";
//String DN = request.getParameter("DN");



	
	try{
		//this list will hold the x-axis and y-axis data as a pair
		ArrayList<Map<String,Integer>> list = new ArrayList();
   		Map<String,Integer> map = null;
   		//Get the database connection
   		Class.forName("com.mysql.jdbc.Driver").newInstance();
   		Connection con =DriverManager.getConnection(url,uname,pass);		

   		//Create a SQL statement
   		Statement stmt = con.createStatement();
   		
   		String graphType = request.getParameter("graph");   
   		//Make a query
   		String query = "" ;
   		if(graphType.equalsIgnoreCase("Busiest periods for the day")){
   	   		query = "SELECT QW.TI, SUM(QW.ID) FROM (SELECT time_format(bill_time,'%I:%p') as TI, Count(Transactions.bill_id) as ID From Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id WHERE bar_name='"+bar_name+"' Group by bill_time Order by bill_time) as QW Group by QW.TI;";
   		}else{
   	   		query = "SELECT DF.BD, SUM(DF.BI) FROM(SELECT DAYNAME(Bills.bill_date) as BD, Count(Transactions.bill_id) as BI  From Bills INNER JOIN Transactions ON Bills.bill_id=Transactions.bill_id where bar_name='"+bar_name+"' Group by bill_date Order by bill_date) AS DF Group By DF.BD;";
   		}
   		
   		//Run the query against the database.
   		ResultSet result = stmt.executeQuery(query);
   		//Process the result
   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   			if(graphType.equalsIgnoreCase("Busiest periods for the day")){
   	   			map.put(result.getString("QW.TI"),result.getInt("SUM(QW.ID)"));
   	   		}else{
   	   			map.put(result.getString("DF.BD"),result.getInt("SUM(DF.BI)"));
   	   		}
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
        if(graphType.equalsIgnoreCase("Busiest periods for the day")){
          chartTitle = "Busiest periods for the day";
          legend = "Number of transactions";
        }else{
            chartTitle = "Busiest periods for the week";
            legend="Number of transactions";
        }
	}catch(Exception e){
    		out.println(e);
    }
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	<a href="Bars.jsp">Bar page</a> <br>

	<div id="graphContainer" style="width: 500px; height: 400px; margin: 0 auto"></div>

</body>
</html>
