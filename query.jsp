<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*,JavaBean.*"%>
<%
    String pattern = request.getParameter("pattern");
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
	Statement st = con.createStatement();
	JSONObject json = new JSONObject();
	if(pattern.equals("1")) {
	    String id = request.getParameter("id");
		String query = "select * from project where pid = "+id;
		ResultSet data = st.executeQuery(query);
		data.next();
		String descrpt = data.getString("descrpt");
		
		json.put("descrpt",Functions.toHtml(descrpt));
	}
	else if(pattern.equals("2")) {
	    String id = request.getParameter("id");
		String query = "select * from version where vid = "+id;
		ResultSet data = st.executeQuery(query);
		data.next();
		String descrpt = data.getString("descrpt");
		String vchange = data.getString("vchange");
		descrpt = Functions.toHtml(descrpt);
		vchange = Functions.toHtml(vchange);
		
		json.put("descrpt",descrpt);
		json.put("vchange",vchange);
	}
	else if(pattern.equals("3")) {
	    String id = request.getParameter("id");
		String query = "select * from page where pageid = "+id;
		ResultSet data = st.executeQuery(query);
		data.next();
		String descrpt = data.getString("descrpt");
		String vchange = data.getString("vchange");
		descrpt = Functions.toHtml(descrpt);
		vchange = Functions.toHtml(vchange);
		
		json.put("descrpt",descrpt);
		json.put("vchange",vchange);
	}
	else if(pattern.equals("4")) {
		String aid = request.getParameter("id");
		String query = "select * from ajax where aid = '"+aid+"'";
		ResultSet data = st.executeQuery(query);
		while(data.next()) {
			String name = data.getString("name");
			String url = data.getString("url");
			String action = data.getString("action");
			String mystructure = data.getString("structure");
			String myevent = data.getString("event");
			String myresponse = data.getString("response");
			String myrequest = data.getString("request");
			String descrpt = data.getString("descrpt");
			String vchange = data.getString("vchange");
			
			json.put("name",name);
			json.put("url",url);
			json.put("action",action);
			json.put("mystructure",mystructure);
			json.put("myevent",myevent);
			json.put("myrequest",myrequest);
			json.put("myresponse",myresponse);
			json.put("descrpt",descrpt);
			json.put("vchange",vchange);
		}
	}
	response.getWriter().write(json.toString());
%>