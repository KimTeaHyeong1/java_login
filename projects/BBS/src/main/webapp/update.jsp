<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 김민형 사이트</title>
</head>
<body>
	<h2>정보 수정</h2>
	<form method="post"action="updateAction.jsp">
	아이디: <input type="text" name="userID" maxlength="50"> <br>
	패스워드: <input type="password" name="userPassword" maxlength="16"> <br>
	이름 : <input type="text" name="userName" maxlength="10"> <br>
	<input type="submit"value="입력완료">
	</form>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>