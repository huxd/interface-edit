<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*,JavaBean.*"%>
<jsp:useBean id="db" scope="application" class="JavaBean.ConnectDb" />
<html>
    <head>
	    <script src="jquery-1.11.1.min.js"></script>
		<link rel="stylesheet" href="page.css">
		<script>
		    function create() {
			    var version = $("#version").val();
				var pattern = 2;
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
			    $.post("create.jsp",{version:version,pattern:pattern,id:id,descrpt:descrpt,vchange:vchange},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("创建成功!");
						self.location = self.location;
					}
				});
			}
			function initate() {
			    var pattern = 1;
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
				});
			}
			function output() {
			    var url = location.search;
				var id;
				if(url == '') {
				    self.location = "../index.jsp";
				}
				else {
				    id = url.split('=')[1];
				}
			    $.post("export.jsp",{id:id},function(data) {
				    alert("导出成功");
				});
			}
			function toremove(id) {
			    var pattern = 2;
			    $.post("delete.jsp",{pattern:pattern,id:id},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("删除成功!");
						self.location = self.location;
					}
				});
			}
			function change() {
			    $("#change").show();
				$("#versio").hide();
				var pattern = 2;
				
			}
			$(function() {
			    $("#change").hide();
			    initate();
			});
		</script>
    </head>
    <body>
	    <div id='change'>
	    <form id="formstyle" method="post" style="width:300px">
			<fieldset id="fieldstyle">
			    <p id="textstyle" style="color:blue;">
				    项目名:<input type="text" name="project" id="project"/>
				</p>
				<p id="textstyle" style="color:blue;font-family:Microsoft YaHei; ">
				    描述:<textarea cols="31	" rows="4" id="pdescrpt"></textarea>
				</p>
				<button id="sub" type="button" onclick="">确定修改</button>
			</fieldset>
		</form>
		</div>
	    <div id='versio' style="float:left;">
		    <div>
		    <p id="fontstyle" style="font-size:15">版本列表：</p>
	    <%
			String pid = request.getParameter("projectid");
			
			Connection con = db.getConnection();
			if(con == null) {
			    out.println("数据库连接失败!");
				return;
			}
			
			Statement st = con.createStatement();
			String query = "select * from version where pid = "+pid;
			ResultSet data = st.executeQuery(query);
			out.println("<table>");
			while(data.next()) {
				String name = data.getString("name");
				int id = data.getInt("vid");
				out.println("<tr><td><a href='version.jsp?versionid="+id+"'>"+name+"</a></td><td><button id='sub' onclick='toremove("+id+")'>delete</button></td></tr>");
			}
			out.println("</table>");
        %>
		    </div>
		    <div id="viewdescrpt">
		        <p id="fontstyle" style="font-size:15;">描述:</p>
		    </div>
			<button id="sub" onclick="output()">导出该项目</button>
		</div>
		<div id='versio'>
			<form id="formstyle" method="post" style="width:300px">
				<fieldset id="fieldstyle">
					<p id="textstyle" style="color:blue;">
						版本名称:<input type="text" name="version" id="version"/>
					</p>
					<p id="textstyle" style="color:blue;font-family:Microsoft YaHei; ">
						描述:<textarea cols="31	" rows="4" id="descrpt"></textarea>
					</p>
					<p id="textstyle" style="color:blue;font-family:Microsoft YaHei; ">
						版本修改:<textarea cols="31	" rows="4" id="vchange"></textarea>
					</p>
					<button id='sub' type="button" onclick="create()">创建新版本</button>
				</fieldset>
			</form>
		</div>
	</body>
</html>