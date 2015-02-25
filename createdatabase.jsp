<%@page pageEncoding="utf-8" import="java.sql.*"%>
<%
    Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/interface?useUnicode=true&characterEncoding=utf8","root","root");
	Statement query = con.createStatement();
	//query.executeUpdate("create database interface default character set utf8");
	
	query.executeUpdate("create table project(vchange text,name varchar(20),time datetime,pid int not null auto_increment,primary key(pid),descrpt text)");
	query.executeUpdate("create table version(vchange text,name varchar(20),time datetime,vid int not null auto_increment,primary key(vid),descrpt text,pid int(11) not null)");
	query.executeUpdate("create table page(vchange text,cname varchar(20),name varchar(20),time datetime,pageid int not null auto_increment,primary key(pageid),descrpt text,vid int(11) not null)");
	query.executeUpdate("create table ajax(vchange text,name varchar(20),url text,action text,structure text,event text,response text,time datetime,aid int not null auto_increment,primary key(aid),descrpt text,pageid int(11) not null,request text)");
	
	
%>