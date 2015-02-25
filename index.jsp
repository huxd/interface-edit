<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*,JavaBean.ConnectDb"%>
<jsp:useBean id="db" scope="application" class="JavaBean.ConnectDb" />
<html>
    <head>
		<script src="jquery-1.11.1.min.js"></script>
		<link rel="stylesheet" href="page.css">
		<script>
		    function create() {
			    var project = $("#project").val();
				var descrpt = $("#descrpt").val();
				var pattern = 1;
			    $.post("create.jsp",{project:project,descrpt:descrpt,pattern:pattern},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("创建成功!");
						self.location = self.location;
					}
				});
			}
			function toremove(id) {
			    var pattern = 1;
			    $.post("delete.jsp",{pattern:pattern,id:id},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("删除成功!");
						self.location = self.location;
					}
				});
			}
		</script>
    </head>
    <body>
	    <div style="float:left;">
		    <p id="fontstyle" style="font-size:15">项目列表：</p>
	    <%
		    Connection con = db.getConnection();
			if(con == null) {
			    out.println("数据库连接失败!");
				return;
			}
			
			Statement st = con.createStatement();
			String query = "select * from project";
			ResultSet data = st.executeQuery(query);
			out.println("<table>");
			while(data.next()) {
				String project = data.getString("name");
				int id = data.getInt("pid");
				out.println("<tr><td><a href='project.jsp?projectid="+id+"'>"+project+"</a></td><td><button id='sub' onclick='toremove("+id+")'>delete</button></td></tr>");
			}
			out.println("</table>");
        %>
		</div>
		<form id="formstyle" method="post" style="width:300px">
			<fieldset id="fieldstyle">
			    <p id="textstyle" style="color:blue;">
				项目名:<input type="text" name="project" id="project"/>
				</p>
				<p id="textstyle" style="color:blue;font-family:Microsoft YaHei; ">
				    描述:<textarea cols="31	" rows="4" id="descrpt"></textarea>
				</p>
				<button id="sub" type="button" onclick="create()">创建项目</button>
			</fieldset>
		</form>
		<div id="viewproject">
		</div>
	</body>
</html>