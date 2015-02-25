<%@page pageEncoding="utf-8" import="java.io.*,java.util.*,org.json.JSONObject,java.sql.*,JavaBean.*"%>
<html>
    <head>
		<script src="jquery-1.11.1.min.js"></script>
		<script>
		var myresnum = [],
		    myreqnum = [];
		$(function() {
		    $("#change").hide();
		});
		function change() {
		    $(".change").css("display","none");
		    $("#divstyle").hide();
		    $("#change").show();
			var id;
			var url = location.search;
			if(url == '') {
				self.location = "../index.jsp";
			}
			else {
				id = url.split('=')[1];
			}
			var pattern = 4;
			$.post("query.jsp",{id:id,pattern:pattern},function(data) {
			    $("td").css("border","none");
			    var data = eval("("+data+")");
				$("#name").val(data.name);
				$("#event").val(data.myevent);
				$("#url").val(data.url);
				$("#structure").val(data.mystructure);
				$("#action").val(data.action);
				$("#vchange").val(data.vchange);
				var myresponse = data.myresponse;
				var myrequest = data.myrequest;
				//document.write(myresponse);
				
				var responses = myresponse.split(")*(");
		        var requests = myrequest.split(")*(");
				var myresponses = [];
				for(var i = 1; i < responses.length - 1; i++) {
				    myresponses = responses[i - 1].split("(*)");
					$("#responsekey"+i).val(myresponses[0]);
					$("#responsevalue"+i).val(myresponses[1]);
					myresnum[i - 1] = i;
					addresponse();
				}
				myresponses = responses[responses.length - 2].split("(*)");
				$("#responsekey"+(responses.length - 1)).val(myresponses[0]);
				$("#responsevalue"+(responses.length - 1)).val(myresponses[1]);
				myresnum[responses.length - 2] = responses.length - 1;
                
				var myrequests = [];
				for(var i = 1; i < requests.length - 1; i++) {
					myrequests = requests[i - 1].split("(*)");
					$("#requestkey"+i).val(myrequests[0]);
					$("#requestvalue"+i).val(myrequests[1]);
					myreqnum[i - 1] = i;
					addrequest();
				}
				myrequests = requests[requests.length - 2].split("(*)");
				$("#requestkey"+(requests.length - 1)).val(myrequests[0]);
				$("#requestvalue"+(requests.length - 1)).val(myrequests[1]);
				myreqnum[requests.length - 2] = requests.length - 1;
				
				$("#descrpt").val(data.descrpt);
			});
		}
		function update() {
		    $("#change").hide();
			$("#divstyle").show();
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
				var response = '';
				for(var i = 0; i < myresnum.length; i++) {
				    response += $("#responsekey"+myresnum[i]).val() + "(*)" +$("#responsevalue"+myresnum[i]).val() + ")*(";
				}
				url = $("#url").val();
				var structure = $("#structure").val();
				var action = $("#action").val();
				var descrpt = $("#descrpt").val();

				var vchange = $("#vchange").val();
			    $.post("update.jsp",{
					name:name,
					event:event,
					descrpt:descrpt,
					pattern:pattern,
					id:id,
					vchange:vchange,
					url:url,
					structure:structure,
					action:action,
					request:request,
					response:response
				},function(data) {
				    var data = eval('('+data+')');
					if(data.status == true) {
					    alert("修改成功!");
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
				$("td").css("border","none");
			}
			function addrequest() {
			    //var number = Number($("#requestnum").val());
				var number = myreqnum[myreqnum.length - 1];
			    var num = number + 1;
			    $("#request"+number).after("<tr id='request"+num+"'><td></td><td><p id='textstyle'><input type='text' id='requestkey"+num+"'/></p></td><td><p id='textstyle'><textarea id='requestvalue"+num+"'></textarea></p></td><td><button id='sub' class='sub"+num+"' onclick='removerequest("+num+")'>-</button></td></tr>");
				$("#requestnum").val(num);
				myreqnum[myreqnum.length] = num;
				$("td").css("border","none");
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
		</script>
		<link rel="stylesheet" href="my.css">
    </head>
    <body>
	<div style="float:left;">
	    <button onclick="change()" id="sub" class="change">修改ajax请求</button>
	</div>
	<div id="change">
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
					<button type="button" id="sub" onclick="update()">确认修改</button>
				</fieldset>
			</form>
	</div>
<%
	String ajaxid = request.getParameter("ajaxid");
	
    Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface","root","root");
	Statement st = con.createStatement();
	String query = "select * from ajax where aid = "+ajaxid;
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
		descrpt = descrpt.replace(" ","&nbsp");
		descrpt = descrpt.replace("\n","<br />");
		//vchange = vchange.replace(" ","&nbsp");
		//vchange = vchange.replace("\n","<br />");
		vchange = Functions.toHtml(vchange);
		myrequest = myrequest.replace(" ","&nbsp");
		myrequest = myrequest.replace("\n","<br />");
		myresponse = myresponse.replace(" ","&nbsp");
		myresponse = myresponse.replace("\n","<br />");
		
		String[] responses = myresponse.split("\\)\\*\\(");
		String[] requests = myrequest.split("\\)\\*\\(");
		out.println("<div id='divstyle'>");
		out.println("<p id='eventstyle'>触发事件:"+myevent+"</p>");
		out.println("<table id='tablestyle' cellpadding='3' style='table-layout:fixed;'><caption>"+name+"</caption>"+
		            "<tr><td id='td1'>请求路径</td><td id='td2'>"+url+"</td></tr>"+
					"<tr><td>数据结构</td><td>"+mystructure+"</td></tr>"+
					"<tr><td>请求方式</td><td>"+action+"</td></tr>");
        for(int i = 0; i < responses.length; i++) {
		    String[] myresponses = responses[i].split("\\(\\*\\)");
		    if(i == 0) {
			    if(myresponses.length < 2) {
			        out.println("<tr><td>发送数据</td><td></td></tr>");
				}
				else {
				    out.println("<tr><td>发送数据</td><td>"+myresponses[0]+"</td><td>"+myresponses[1]+"</td></tr>");
				}
			}
			else {
			    if(myresponses.length >= 2) {
			        out.println("<tr><td></td><td>"+myresponses[0]+"</td><td>"+myresponses[1]+"</td></tr>");
				}
			}
		}
		for(int i = 0; i < requests.length; i++) {
		    String[] myrequests = requests[i].split("\\(\\*\\)");
		    if(i == 0) {
			    if(myrequests.length < 2) {
			        out.println("<tr><td>接收数据</td><td></td></tr>");
				}
				else {
				    out.println("<tr><td id='x1'>接收数据</td><td>"+myrequests[0]+"</td><td style='width:50%;'>"+myrequests[1]+"</td></tr>");
				}
			}
			else {
			    if(myrequests.length >= 2) {
			        out.println("<tr><td></td><td id='td2'>"+myrequests[0]+"</td><td id='td3'>"+myrequests[1]+"</td></tr>");
				}
			}
		}
		out.println("</table>");
		if(descrpt != null)
		    out.println("<p id='descrptstyle'>描述:<br />"+descrpt+"</p>");
		if(vchange != null)
		    out.println("<p id='tipstyle'>版本修改:<br />"+vchange+"</p>");
		out.println("</div>");
	}
%>   
    <script>
	</script>
	</body>
</html>