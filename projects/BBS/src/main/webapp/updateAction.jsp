<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 김민형 사이트</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	String userPassword = null;
	if(session.getAttribute("userPassword") != null) {
		userPassword = (String) session.getAttribute("userPassword");
	}
	
	String userName = null;
	if(session.getAttribute("userName") != null) {
		userName = (String) session.getAttribute("userName");
	}
	
	String userGender = null;
	if(session.getAttribute("userGender") != null) {
		userGender = (String) session.getAttribute("userGender");
	}
	
	String userEmail = null;
	if(session.getAttribute("userEmail") != null) {
		userEmail = (String) session.getAttribute("userEmail");
	}
	
	if (user.getUserID() == null || user.getUserPassword() == null ||
		user.getUserName() == null || user.getUserGender() == null ||
		user.getUserEmail() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.update(userID, userPassword, userName, userGender, userEmail);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} 
	}
	%>
	<a href=home.html>돌아가기(미구현)</a>
</body>
</html>
