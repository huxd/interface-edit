<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*,JavaBean.*"%>
<%
    String id = request.getParameter("id");

    Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
	Statement st = con.createStatement();
	
	String query = "select * from project where pid = "+id;
	Statement st2 = con.createStatement();
	ResultSet project = st2.executeQuery(query);
	project.next();
	String projecturl = "/Program Files (x86)/Apache Software Foundation/Tomcat 8.0/webapps/Web/";
	File path = new File(projecturl);
	if(!path.exists()) {
		path.mkdir();
	}
	
	String oldplace = "D:/Program Files (x86)/Apache Software Foundation/Tomcat 8.0/webapps/interface/my.css";
	String newplace = projecturl+"/my.css";
	FileInputStream input = new FileInputStream(oldplace);
	byte[] x = new byte[10000];
	input.read(x);
	input.close();
	FileOutputStream outmyput = new FileOutputStream(newplace);
	outmyput.write(x);
	outmyput.close();
	
	query = "select * from version where pid = "+id;
	Statement st1 = con.createStatement();
	Statement st3 = con.createStatement();
	ResultSet versions = st1.executeQuery(query);
	StringBuilder indexcontent = new StringBuilder();
	while(versions.next()) {
	    String versionurl = projecturl + "/" + versions.getString("name");
		indexcontent.append("<p><a href='"+versions.getString("name")+"/"+versions.getString("name")+".html'>"+versions.getString("name")+"</a></p>\n");
		path = new File(versionurl);
		if(!path.exists()) {
			path.mkdir();
		}
		query = "select * from page where vid = "+versions.getString("vid");
		ResultSet pages = st3.executeQuery(query);
		StringBuilder versioncontent = new StringBuilder();
		versioncontent.append("<div style='float:left;'><div><p id='fontstyle' style='font-size:15'>页面列表:</p>\n");
		while(pages.next()) {
		    String pageurl = versionurl+"/"+pages.getString("name");
			path = new File(pageurl);
			if(!path.exists()) {
				path.mkdir();
			}
			versioncontent.append("<p><a href='"+pages.getString("name")+"/"+pages.getString("name")+".html'>"+pages.getString("name")+"</a></p>\n");
			query = "select * from ajax where pageid = "+pages.getString("pageid");
	        ResultSet data = st.executeQuery(query);
	        StringBuilder output = new StringBuilder();
			output.append("<div styel='float:left;'>\n");
			output.append("<div id='viewdescrpt'><p id='descrptstyle' style='font-size:15;'>描述:<br />"+Functions.toHtml(pages.getString("descrpt"))+"</p></div>\n");
		    output.append("<div id='viewchange'><p id='tipstyle' style='font-size:15;'>版本修改:<br />"+Functions.toHtml(pages.getString("vchange"))+"</p></div></div>\n");
			while(data.next()) {
			    /*String ajaxurl = pageurl+"/"+pages.getString("name");
				path = new File(url);
				if(!path.exists()) {
					path.mkdir();
				}*/
			    String name = data.getString("name");
				String url = data.getString("url");
				String action = data.getString("action");
				String mystructure = data.getString("structure");
				String myevent = data.getString("event");
				String myresponse = data.getString("response");
				String myrequest = data.getString("request");
				String descrpt = data.getString("descrpt");
				String vchange = data.getString("vchange");
				descrpt = descrpt.replace(" ","&nbsp");
				descrpt = descrpt.replace("\n","<br />");
				vchange = vchange.replace(" ","&nbsp");
				vchange = vchange.replace("\n","<br />");
				myrequest = myrequest.replace(" ","&nbsp");
				myrequest = myrequest.replace("\n","<br />");
				myresponse = myresponse.replace(" ","&nbsp");
				myresponse = myresponse.replace("\n","<br />");
				
				String[] responses = myresponse.split("\\)\\*\\(");
				String[] requests = myrequest.split("\\)\\*\\(");
				output.append("<div id='divstyle'>\n");
				output.append("<p id='eventstyle'>触发事件:"+myevent+"</p>\n");
				output.append("<table id='tablestyle' cellpadding='3'><caption>"+name+"</caption>\n"+
							"<tr><td style='width:15%;'>请求路径</td><td>"+url+"</td></tr>\n"+
							"<tr><td>数据结构</td><td>"+mystructure+"</td></tr>\n"+
							"<tr><td>请求方式</td><td>"+action+"</td></tr>\n");
				for(int i = 0; i < responses.length; i++) {
					String[] myresponses = responses[i].split("\\(\\*\\)");
					if(i == 0) {
						if(myresponses.length < 2) {
							output.append("<tr><td>发送数据</td><td></td><td style='width:50%;'></td></tr>\n");
						}
						else {
							output.append("<tr><td>发送数据</td><td>"+myresponses[0]+"</td><td style='width:50%;'>"+myresponses[1]+"</td></tr>\n");
						}
					}
					else {
						if(myresponses.length >= 2) {
							output.append("<tr><td></td><td>"+myresponses[0]+"</td><td style='width:50%;'>"+myresponses[1]+"</td></tr>");
						}
					}
				}
				for(int i = 0; i < requests.length; i++) {
					String[] myrequests = requests[i].split("\\(\\*\\)");
					if(i == 0) {
						if(myrequests.length < 2) {
							output.append("<tr><td>接收数据</td><td></td><td style='width:50%;'></td></tr>\n");
						}
						else {
							output.append("<tr><td>接收数据</td><td>"+myrequests[0]+"</td><td style='width:50%;'>"+myrequests[1]+"</td></tr>\n");
						}
					}
					else {
						if(myrequests.length >= 2) {
							output.append("<tr><td></td><td>"+myrequests[0]+"</td><td style='width:50%;'>"+myrequests[1]+"</td></tr>\n");
						}
					}
				}
				output.append("</table>");
				if(descrpt != null)
					output.append("<p id='descrptstyle'>描述:<br />"+descrpt+"</p>\n");
				if(vchange != null)
		            output.append("<p id='tipstyle'>版本修改:<br />"+vchange+"</p>\n");
				output.append("</div>");
			}
			BufferedReader infile = new BufferedReader(new FileReader("D:/Program Files (x86)/Apache Software Foundation/Tomcat 8.0/webapps/interface/page.html"));
			String model = infile.readLine();
			String html = "";
			while(model != null) {
				html += model;
				model = infile.readLine();
			}
			infile.close();
			html = html.replaceFirst("\\$html",output.toString());
			html = html.replaceFirst("\\$cssurl","../../my.css");
			
			FileWriter outfile = new FileWriter(pageurl+"/"+pages.getString("name")+".html");
			outfile.write(html);
			outfile.close();
		}
		versioncontent.append("</div><div id='viewdescrpt'><p id='descrptstyle' style='font-size:15;'>描述:<br />"+Functions.toHtml(versions.getString("descrpt"))+"</p></div>\n");
		versioncontent.append("<div id='viewchange'><p id='tipstyle' style='font-size:15;'>版本修改:<br />"+Functions.toHtml(versions.getString("vchange"))+"</p></div></div>\n");
		BufferedReader infile = new BufferedReader(new FileReader("D:/Program Files (x86)/Apache Software Foundation/Tomcat 8.0/webapps/interface/page.html"));
		String model = infile.readLine();
		String html = "";
		while(model != null) {
			html += model;
			model = infile.readLine();
		}
		infile.close();
		html = html.replaceFirst("\\$html",versioncontent.toString());
		html = html.replaceFirst("\\$cssurl","../my.css");
		FileWriter output = new FileWriter(versionurl+"/"+versions.getString("name")+".html");
		output.write(html);
		output.close();
	}
    BufferedReader infile = new BufferedReader(new FileReader("D:/Program Files (x86)/Apache Software Foundation/Tomcat 8.0/webapps/interface/page1.html"));
	String model = infile.readLine();
	String html = "";
	while(model != null) {
		html += model;
	    model = infile.readLine();
	}
	infile.close();
	html = html.replaceFirst("\\$html",indexcontent.toString());
	html = html.replaceFirst("\\$cssurl","my.css");
	FileWriter indexhtml = new FileWriter(projecturl+"/index.html");
	indexhtml.write(html);
	indexhtml.close();
%>