<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*"%>
<%
    String vid = request.getParameter("vid");
	String id = request.getParameter("id");
	
    Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
	Statement st = con.createStatement();
	
	/*
	String query = "delete from version where vid = " + vid;
	st.executeUpdate(query);
	query = "update version set vid = "+vid+" where vid = " + id;
	st.executeUpdate(query);
	*/
	
	String query = "select * from page where vid = " + vid;
	ResultSet data = st.executeQuery(query);
	while(data.next()) {
	    String pageid = data.getString("pageid");
		Statement st1 = con.createStatement();
		query = "insert into page (vid,name,time,descrpt,vchange,cname) values"+
		"("+id+",'"+data.getString("name")+"',now(),'"+data.getString("descrpt")+
		"','"+data.getString("vchange")+"','"+data.getString("cname")+"')";
		st1.execute(query);
		query = "select * from page where name = '" + data.getString("name") + "' and vid = " + id;
		ResultSet data2 = st1.executeQuery(query);
		data2.next();
		
		Statement st2 = con.createStatement();
		query = "select * from ajax where pageid = " + pageid;
		ResultSet data1 = st2.executeQuery(query);
		while(data1.next()) {
		    String aid = data1.getString("aid");
			
			query = "insert into ajax (vchange,descrpt,pageid,event,time,name,url,structure,"+
			"action,response,request) values('"+data1.getString("vchange")+"','"+data1.getString("descrpt")+"',"+data2.getString("pageid")+
			",'"+data1.getString("event")+"',now(),'"+data1.getString("name")+"','"+data1.getString("url")+
			"','"+data1.getString("structure")+"','"+data1.getString("action")+"','"+data1.getString("response")+"','"+data1.getString("request")+"')";
			Statement st3 = con.createStatement();
			st3.execute(query);
		}
	}
%>