<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보</title>
</head>
<body>
    <h2>회원정보 표시</h2>
    <table border="1">
        <tr>
            <td width="100">아이디</td>
            <td width="100">패스워드</td>
            <td width="100">이름</td>
            <td width="100">성별</td>
            <td width="100">이메일</td>
        </tr>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                String dbURL = "jdbc:mysql://localhost:3306/BBS?useSSL=false";
                String dbID = "root";
                String dbPassword = "0000";
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

                String sql = "SELECT * FROM user";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String userPassword = rs.getString("userPassword");
                    String userName = rs.getString("userName");
                    String userGender = rs.getString("userGender");
                    String userEmail = rs.getString("userEmail");
        %>

        <tr>
            <td width="100"><%=userID %></td>
            <td width="100"><%=userPassword %></td>
            <td width="100"><%=userName %></td>
            <td width="100"><%=userGender %></td>
            <td width="100"><%=userEmail %></td>
        </tr>

        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException sqle) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException sqle) {}
                if (conn != null) try { conn.close(); } catch (SQLException sqle) {}
            }
        %>
    </table>
</body>
</html>
