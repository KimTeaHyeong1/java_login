<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "mysqlconn.BoardDBBean" %>
<%@ page import="mysqlconn.BoardDataBean" %>
<%@ page import = "java.sql.Timestamp" %>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="article" scope="page" class="mysqlconn.BoardDataBean">
    <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
	article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	article.setIp(request.getRemoteAddr());
	
	BoardDBBean dbPro = BoardDBBean.getInstance();
	dbPro.insertArticle(article);
	
	response.sendRedirect("list.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>