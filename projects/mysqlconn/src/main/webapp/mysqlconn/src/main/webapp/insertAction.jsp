<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String userName = request.getParameter("userName");
    String userGender = request.getParameter("userGender");
    String userEmail = request.getParameter("userEmail");

    Connection conn = null;
    PreparedStatement pstmt = null;
    String str = "";

    try {
        String dbURL = "jdbc:mysql://localhost:3306/BBS?useSSL=false";
        String dbID = "root";
        String dbPassword = "0000";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

        String sql = "INSERT INTO user (userID, userPassword, userName, userGender, userEmail) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, userPassword);
        pstmt.setString(3, userName);
        pstmt.setString(4, userGender);
        pstmt.setString(5, userEmail);
        pstmt.executeUpdate();

        str = "회원가입을 축하합니다.";
    } catch (Exception e) {
        e.printStackTrace();
        str = "회원가입을 실패했습니다.";
    } finally {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
<body>
    <%=str %>
</body>
</html>
