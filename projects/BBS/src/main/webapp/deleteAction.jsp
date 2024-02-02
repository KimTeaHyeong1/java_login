<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css"><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP 김민형 사이트</title>
</head>
<body>
<%
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String userName = request.getParameter("userName");

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/BBS?useSSL=false", "root", "0000")) {
        String selectSQL = "SELECT userID, userPassword FROM user WHERE userID=?";
        try (PreparedStatement selectStmt = conn.prepareStatement(selectSQL)) {
            selectStmt.setString(1, userID);
            try (ResultSet rs = selectStmt.executeQuery()) {
                if (rs.next()) {
                    String rUserID = rs.getString("userID");
                    String rUserPassword = rs.getString("userPassword");
                    if (userID.equals(rUserID) && userPassword.equals(rUserPassword)) {
                        String updateSQL = "DELETE user SET userName=? WHERE userID=?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                            updateStmt.setString(1, userName);
                            updateStmt.setString(2, userID);
                            updateStmt.executeUpdate();
                        }
                    }
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<p>개인 정보를 수정했습니다.</p>
<a href="login.jsp">로그인 페이지로 돌아가기</a>
</body>
</html>

<title>JSP 김민형 사이트</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		location.href = 'delete.jsp';
	</script>
</body>
</html>