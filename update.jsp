<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*"%>
<%
    String pattern = request.getParameter("pattern");

	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
	Statement st = con.createStatement();
	
	if(pattern == "1") {
	    //String s = request.getParameter("project");
		//String query = "update project set name = '"+name+"' where pid = "+id;
		//st.execute(query);
	}
	else if(pattern == "2") {
	    //String s = request.getParameter("version");
		//String pid = request.getParameter("id");
		
		//String query = "update version set name = '"+name+"' where vid = "+id;
		//st.execute(query); 
	}
	else if(pattern == "3") {
	    //String s = request.getParameter("page");
		//String vid = request.getParameter("id");
		
		//String query = "update page set name = '"+name+"' where pageid = "+id;
		//st.execute(query);
	}
	else if(pattern.equals("4")) {
	    String name = request.getParameter("name");
		String myevent = request.getParameter("event");
		String url = request.getParameter("url");	
		String mystructure = request.getParameter("structure");
		String action = request.getParameter("action");
		String aid = request.getParameter("id");
		String myresponse = request.getParameter("response");
		String myrequest = request.getParameter("request");
		String descrpt = request.getParameter("descrpt");
		String vchange = request.getParameter("vchange");
		
		String query = "update ajax set vchange = '"+vchange+"',name = '"+name+"',event = '"+myevent+"',url = '"+url+"',structure = '"+mystructure+"',action = '"+action+"',response = '"+myresponse+"',request = '"+myrequest+"',descrpt = '"+descrpt+"' where aid = "+aid;
		//String query = "update ajax set descrpt = '"+descrpt+"' where aid = "+aid;
		st.execute(query);
	}
	JSONObject json = new JSONObject();
	json.put("status",true);
	response.getWriter().write(json.toString());
%>