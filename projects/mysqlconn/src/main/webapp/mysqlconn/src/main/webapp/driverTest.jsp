<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC 드라이버 테스트</title>
</head>
<body>
<h2>JDBC 드라이버 테스트</h2>
<%
	Connection conn=null;
	try{
        String dbURL = "jdbc:mysql://localhost:3306/BBS?useSSL=false";
        String dbID = "root";
        String dbPassword = "0000";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        out.println("제대로 연결되었습니다.");
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>