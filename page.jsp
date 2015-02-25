<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*"%>
<html>
    <head>
		<script src="jquery-1.11.1.min.js"></script>
		<link rel="stylesheet" href="page.css">
		<script>
		    var myresnum = [],
		        myreqnum = [];
			myresnum[0] = 1;
			myreqnum[0] = 1;
		    function create() {
			    var name = $("#name").val();
				var event = $("#event").val();
				var pattern = 4;
				var url = location.search;
				var id;
				if(url == '') {
				    self.location = "../index.jsp";
				}
				else {
				    id = url.split('=')[1];
				}
				var request = '';
				for(var i = 0; i < myreqnum.length; i++) {
				    request += $("#requestkey"+myreqnum[i]).val() + "(*)" +$("#requestvalue"+myreqnum[i]).val() + ")*(";
				}
				var responsenum = Number($("#responsenum").val());
				var response = '';
				for(var i = 0; i < myresnum.length; i++) {
				    response += $("#responsekey"+myresnum[i]).val() + "(*)" +$("#responsevalue"+myresnum[i]).val() + ")*(";
				}
				url = $("#url").val();
				var structure = $("#structure").val();
				var action = $("#action").val();
				var descrpt = $("#descrpt").val();
				var vchange = $("vchange").val();
			    $.post("create.jsp",{
					name:name,
					event:event,
					descrpt:descrpt,
					pattern:pattern,
					id:id,
					url:url,
					structure:structure,
					action:action,
					request:request,
					vchange:vchange,
					response:response
				},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("创建成功!");
						self.location = self.location;
					}
				});
			}
		    function addresponse() {
			    //var number = Number($("#responsenum").val());
				var number = myresnum[myresnum.length - 1];
			    var num = number + 1;
			    $("#response"+number).after("<tr id='response"+num+"'><td></td><td><p id='textstyle'><input type='text' id='responsekey"+num+"'/></p></td><td><p id='textstyle'><textarea id='responsevalue"+num+"'></textarea></p></td><td><button id='sub' class='sub"+num+"' onclick='removeresponse("+num+")'>-</button></td></tr>");
				$("#responsenum").val(num);
				myresnum[myresnum.length] = num;
			}
			function addrequest() {
			    //var number = Number($("#requestnum").val());
				var number = myreqnum[myreqnum.length - 1];
			    var num = number + 1;
			    $("#request"+number).after("<tr id='request"+num+"'><td></td><td><p id='textstyle'><input type='text' id='requestkey"+num+"'/></p></td><td><p id='textstyle'><textarea id='requestvalue"+num+"'></textarea></p></td><td><button id='sub' class='sub"+num+"' onclick='removerequest("+num+")'>-</button></td></tr>");
				$("#requestnum").val(num);
				myreqnum[myreqnum.length] = num;
			}
			function removeresponse(number) {
			    $("#response"+number).remove();
				//var num = Number($("#responsenum").val());
				var num = myresnum[myresnum.length - 1];
				for(i in myresnum) {
				    if(myresnum[i] == number) {
					    myresnum.splice(i,1);
					}
				}
				//$("#responsenum").val(num - 1);
			}
			function removerequest(number) {
			    $("#request"+number).remove();
				//var num = Number($("#requestnum").val());
				var num = myreqnum[myreqnum.length - 1];
				for(i in myreqnum) {
				    if(myreqnum[i] == number) {
					    myreqnum.splice(i,1);
					}
				}
				//$("#requestnum").val(num - 1);
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
			
			//remove不能作为函数名
			function toremove(id) {
			    var pattern = 4;
			    $.post("delete.jsp",{id:id,pattern:pattern},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("删除成功!");
						self.location = self.location;
					}
				});
			}
			function initate() {
			    var pattern = 3;
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
			$(function() {
			    initate();
				$("#structure").val("JSON");
				$("#action").val("POST");
			});
		</script>
    </head>
    <body>
	    <div style="float:left;">
		    <div>
		    <p id="fontstyle" style="font-size:15">Ajax请求列表:</p>
	    <%
			String pageid = request.getParameter("pageid");
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
			Statement st = con.createStatement();
			String query = "select * from ajax where pageid = "+pageid;
			ResultSet data = st.executeQuery(query);
			out.println("<table>");
			while(data.next()) {
				String name = data.getString("name");
				int id = data.getInt("aid");
				out.println("<tr><td><a style='margin:5px;' href='ajax.jsp?ajaxid="+id+"'>"+name+"</a></td><td><button id = 'sub' onclick='toremove("+id+")'>delete</button></td></tr>");
			}
			out.println("</table>");
        %>
		    </div>
			<div id="viewdescrpt">
		        <p id="fontstyle" style="font-size:15;">描述:</p>
		    </div>
			<div id="viewchange">
		        <p id="fontstyle" style="font-size:15;">版本修改:</p>
		    </div>
		</div>
		<div>
			<form id="formstyle" method="post">
				<fieldset id="fieldstyle">
					<table id="tablesytle" border="0">
						<tr>
							<td id="fontstyle">名字：</td>
							<td><p id="textstyle"><input type="text" id="name" /></p></td>
						</tr>
						<tr>
							<td id="fontstyle">事件：</td>
							<td><p id="textstyle"><input type="text" id="event" /></p></td>
						</tr>
						<tr>
							<td id="fontstyle">请求路径:</td>
							<td><p id="textstyle"><input type="text" id="url" /></p></td>
						</tr>
						<tr>
							<td id="fontstyle">数据格式:</td>
							<td><p id="textstyle"><input type="text" id="structure" /></p></td>
						</tr>
						<tr>
							<td id="fontstyle">请求方式:</td>
							<td><p id="textstyle"><input type="text" id="action" /></p></td>
						</tr>
						<tr id="response1">
							<td id="fontstyle">发送数据:</td>
							<td><p id="textstyle"><input type="text" id="responsekey1" /></p></td>
							<td><p id="textstyle"><textarea id="responsevalue1"></textarea></p></td>
							<td><button id="sub" type="button" onclick="addresponse()">+</button></td>
						</tr>
						<tr id="request1">
							<td id="fontstyle">接收数据:</td>
							<td><p id="textstyle"><input type="text" id="requestkey1" /></p></td>
							<td><p id="textstyle"><textarea id="requestvalue1"></textarea></p></td>
							<td><button id="sub" type="button" onclick="addrequest()">+</button></td>
						</tr>
					</table>
			        <p id="textstyle" style="color:blue;font-family:Microsoft YaHei; ">
				    描述:<textarea cols="100" rows="4" id="descrpt"></textarea>
				    </p>
					<p id="textstyle" style="color:blue;font-family:Microsoft YaHei; ">
				    版本修改:<textarea cols="100" rows="4" id="vchange"></textarea>
				    </p>
					<button type="button" id="sub" onclick="create()">创建Ajax请求</button>
				</fieldset>
			</form>
		</div>
	</body>
</html>