<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*"%>
<%
    String pattern = request.getParameter("pattern");
	//pattern = "2";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
	Statement st = con.createStatement();
	//处理创建项目的请求
	if(pattern.equals("1")) {
		String s = request.getParameter("project");
		String descrpt = request.getParameter("descrpt");
		/*
		String url = "/Hi/"+s;
		File path = new File(url);
		if(!path.exists()) {
			path.mkdir();
		}
		*/
		String query = "insert into project (name,time,descrpt) values('"+s+"',now(),'"+descrpt+"')";
		st.execute(query);
	}
	
	//处理创建某个项目下新版本的请求
	else if(pattern.equals("2")) {
		String s = request.getParameter("version");
		String pid = request.getParameter("id");
		String descrpt = request.getParameter("descrpt");
		String vchange = request.getParameter("vchange");
		
		String query = "insert into version (pid,name,time,descrpt,vchange) values("+pid+",'"+s+"',now(),'"+descrpt+"','"+vchange+"')";
		st.execute(query);    
	}
	else if(pattern.equals("3")) {
	    String s = request.getParameter("page");
		String vid = request.getParameter("id");
		String descrpt = request.getParameter("descrpt");
		String vchange = request.getParameter("vchange");
		String controller = request.getParameter("controller");
		
		String query = "insert into page (vid,name,time,descrpt,vchange,cname) values("+vid+",'"+s+"',now(),'"+descrpt+"','"+vchange+"','"+controller+"')";
		st.execute(query);
	}
	else if(pattern.equals("4")) {
	    String name = request.getParameter("name");
		String myevent = request.getParameter("event");
		String url = request.getParameter("url");
		String mystructure = request.getParameter("structure");
		String action = request.getParameter("action");
		String pageid = request.getParameter("id");
		String myresponse = request.getParameter("response");
		String myrequest = request.getParameter("request");
		String descrpt = request.getParameter("descrpt");
		String vchange = request.getParameter("vchange");
		/*name = "123";
		myevent = "123";
		url = "123";
		mystructure = "123";
		action = "123";
		pageid = "2";
		myresponse = "123";
		myrequest = "123";*/
		
		String query = "insert into ajax (vchange,descrpt,pageid,event,time,name,url,structure,action,response,request) values('"+vchange+"','"+descrpt+"',"+pageid+",'"+myevent+"',now(),'"+name+"','"+url+"','"+mystructure+"','"+action+"','"+myresponse+"','"+myrequest+"')";
		st.execute(query);    
	}
	JSONObject json = new JSONObject();
	json.put("status",true);
	response.getWriter().write(json.toString());
%>