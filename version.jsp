<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*"%>
<html>
    <head>
		<script src="jquery-1.11.1.min.js"></script>
		<link rel="stylesheet" href="page.css">
		<script>
		    function create() {
			    var page = $("#page").val();
				var pattern = 3;
				var url = location.search;
				var id;
				if(url == '') {
				    self.location = "../index.jsp";
				}
				else {
				    id = url.split('=')[1];
				}
				var descrpt = $("#descrpt").val();
				var vchange = $("#vchange").val();
				var controller = $("#controller").val();
			    $.post("create.jsp",{page:page,pattern:pattern,id:id,descrpt:descrpt,vchange:vchange,controller:controller},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("创建成功!");
						self.location = self.location;
					}
				});
			}
			function initate() {
			    var pattern = 2;
				var id;
				var url = location.search;
				if(url == '') {
					self.location = "../index.jsp";
				}
				else {
					id = url.split('=')[1];
				}
			    $.post("query.jsp",{pattern:pattern,id:id},function(data) {
				    var data = eval('('+data+')');
					$("#viewdescrpt").append("<p id='descrptstyle'>"+data.descrpt+"</p>");
					var vchange = data.vchange;
					if(!vchange.trim())
					    vchange = "无";
					$("#viewchange").append("<p id='tipstyle'>"+vchange+"</p>");
				});
			}
			function toremove(id) {
			    var pattern = 3;
			    $.post("delete.jsp",{pattern:pattern,id:id},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("删除成功!");
						self.location = self.location;
					}
				});
			}
			function input() {
			    var id;
				var url = location.search;
				if(url == '') {
					self.location = "../index.jsp";
				}
				else {
					id = url.split('=')[1];
				}
			    var vid = $("#version").val();
				$.post("input.jsp",{vid:vid,id:id},function(data) {
				    alert("导入成功");
					self.location = self.location;
				});
			}
			$(function() {
			    initate();
			});
			function change() {
			    
			}
		</script>
    </head>
    <body>
	    <div style="float:left;">
		    <div>
		    <p id="fontstyle" style="font-size:15">页面列表：</p>
	    <%
			String vid = request.getParameter("versionid");
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
			
			Statement st = con.createStatement();
			String query = "select * from page where vid = "+vid;
			ResultSet data = st.executeQuery(query);
			out.println("<table>");
			while(data.next()) {
				String name = data.getString("name");
				int id = data.getInt("pageid");
				out.println("<tr><td><a href='page.jsp?pageid="+id+"'>"+name+"</a></td><td><button id='sub' onclick='toremove("+id+")'>delete</button></td></tr>");
			}
			out.println("</table>");
        %>
		    </div>
			<div id="viewdescrpt" style="width:400px">
		        <p id="fontstyle" style="font-size:15;">描述:</p>
		    </div>
			<div id="viewchange">
		        <p id="fontstyle" style="font-size:15;">版本修改:</p>
		    </div>
			<div style="margin-top:10px;">
				<select id="version">
				<%
					query = "select * from version where vid = "+vid;
					data = st.executeQuery(query);
					data.next();
				    String pid = data.getString("pid");
					query = "select * from version where pid = "+pid;
					data = st.executeQuery(query);
					while(data.next()) {
					    String name = data.getString("name");
						String id = data.getString("vid");
						out.println("<option value='"+id+"'>"+name+"</option>");
					}
				%>
				</select>
				<button id="sub" onclick="input()">导入此版本</button>
			</div>
		</div>
		<form id="formstyle" method="post" style="width:300px">
			<fieldset id="fieldstyle">
			    <p id="textstyle" style="color:blue;">
				    页面名称:<input type="text" name="page" id="page"/>
				</p>
				<p id="textstyle" style="color:blue;">
				    控制器名称:<input type="text" id="controller"/>
				</p>
				<p id="textstyle" style="color:blue;font-family:Microsoft YaHei; ">
				    描述:<textarea cols="31	" rows="4" id="descrpt"></textarea>
				</p>
				<p id="textstyle" style="color:blue;font-family:Microsoft YaHei; ">
				    版本修改:<textarea cols="31	" rows="4" id="vchange"></textarea>
				</p>
				<button id="sub" type="button" onclick="create()">创建新页面</button>
			</fieldset>
		</form>
		<div id="viewversion">
		</div>
	</body>
</html>