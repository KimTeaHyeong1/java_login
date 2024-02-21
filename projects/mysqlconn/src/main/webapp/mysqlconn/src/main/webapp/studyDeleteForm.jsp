<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num =Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script type="text/javascript">
<!-- function deleteSave(){ if(!document.delForm.password.value){ alert("비밀번호를 입력하세요."); 
docount.delForm.password.focus(); return false; } } -->
</script>
</head>
<body>
<%
    String value_c = "white";
%>
	<form method="POST" name="delForm" action="studyDeletePro.jsp?pageNum=<%=pageNum%>" onsubmit="return deleteSave()">
		<table>
			<tr height="30">
				<td align = center bgcolor ="<%=value_c%>">
				<b>비밀번호를 입력해 주세요</b></td>
			</tr>
			<tr height="30">
				<td align = center> 비밀번호 : 
				<input type = "password" name="password" size="8" maxlength="12">
				<input type = "hidden" name= "num" value="<%=num%>"> </td>
			</tr>
			<tr height="30">
				<td align = center bgcolor ="<%=value_c%>">
				<input type = "submit" value="글삭제">
				<input type = "button" value="글목록" onclick="document.location.href='studyList.jsp?pageNum=<%=pageNum%>>'">
				</td>
			</tr>		
		</table>
	</form>
</body>
</html>