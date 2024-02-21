<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body style="text-align: center;">
	<h2>회원 탈퇴</h2>
	
	<form method="post" action="deleteAction.jsp">
		아이디: <input type="text" name ="userID" maxlength="50"> <br>
		비밀번호: <input type="password" name ="userPassword" maxlength="16"> <br>
		<input type="submit" value="입력완료"> <br>
		<a href="main.jsp">돌아가기</a>
	</form>
</body>
</html>