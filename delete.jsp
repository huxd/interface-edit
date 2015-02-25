<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*"%>
<%
    String pattern = request.getParameter("pattern");
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
	Statement st = con.createStatement();
	String query;
	//处理创建项目的请求
	if(pattern.equals("1")) {
		String id = request.getParameter("id");
		/*String url = "/Hi/"+s;
		File path = new File(url);
		if(!path.exists()) {
			path.mkdir();
		}*/
		query = "select * from project where pid = "+id;
		ResultSet project = st.executeQuery(query);
		Statement st3 = con.createStatement();
		while(project.next()) {
		    query = "select * from version where pid = "+id;
			ResultSet version = st3.executeQuery(query);
			Statement st2 = con.createStatement();
			while(version.next()) {
			    query = "select * from page where vid = "+version.getString("vid");
			    ResultSet pages = st2.executeQuery(query);
				Statement st1 = con.createStatement();
				while(pages.next()) {
					query = "delete from ajax where pageid = "+pages.getString("pageid");
					st1.execute(query);
				}
				query = "delete from page where vid = "+version.getString("vid");
				st2.execute(query);
			}
			query = "delete from version where pid = "+project.getString("pid");
			st3.execute(query);
		}
		query = "delete from project where pid = "+id;
		st.execute(query);
	}
	
	else if(pattern.equals("2")) {
		String id = request.getParameter("id");
		query = "select * from version where vid = "+id;
		ResultSet version = st.executeQuery(query);
		Statement st2 = con.createStatement();
        while(version.next()) {
		    query = "select * from page where vid = "+version.getString("vid");
			ResultSet pages = st2.executeQuery(query);
			Statement st1 = con.createStatement();
			while(pages.next()) {
			    query = "delete from ajax where pageid = "+pages.getString("pageid");
			    st1.execute(query);
			}
			//query = "delete from page where vid = "+version.getString("vid");
			query = "delete from page where vid = "+id;
			st2.execute(query);
        }
        query = "delete from version where vid = "+id;
        st.execute(query);
	}
	else if(pattern.equals("3")) {
		String id = request.getParameter("id");
		query = "select * from page where pageid = "+id;
		ResultSet pages = st.executeQuery(query);
		Statement st1 = con.createStatement();
		while(pages.next()) {
		    query = "delete from ajax where pageid = "+pages.getString("pageid");
			st1.execute(query);
		}
		query = "delete from page where pageid = "+id;
		st.execute(query);
	}
	else if(pattern.equals("4")) {
	    String id = request.getParameter("id");
		query = "delete from ajax where aid = "+id;
		st.execute(query);
	}
	JSONObject json = new JSONObject();
	json.put("status",true);
	response.getWriter().write(json.toString());
%>