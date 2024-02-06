<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테이블 추가</title>
</head>
<body>
	<h2>회원가입</h2>
	
	<form method="post" action="insertTestPro.jsp">
		아이디: <input type="text" name="userID" maxlength="50"> <br>
		비밀번호: <input type="password" name="userPassword" maxlength="16"> <br>
		이름: <input type="text" name="userName" maxlength="10"> <br>
	        <div class="btn-group" data-toggle="buttons">
	            <label class="btn btn-primary">
	                <input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
	            </label>
	            <label class="btn btn-primary">
	                <input type="radio" name="userGender" autocomplete="off" value="여자">여자
	            </label> 							
	        </div> 
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
					</div>
		
		<input type="submit" value="입력완료">
	</form>
</body>
</html>