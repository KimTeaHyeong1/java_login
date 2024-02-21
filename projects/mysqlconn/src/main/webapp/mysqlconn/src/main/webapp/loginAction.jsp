<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        String dbURL = "jdbc:mysql://localhost:3306/BBS?useSSL=false";
        String dbID = "root";
        String dbPassword = "0000";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        
        String sql = "SELECT userPassword FROM USER WHERE userID = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            String rPassword = rs.getString("userPassword");
            if (userPassword.equals(rPassword)) {
                response.sendRedirect("main.jsp");
            } else {
                out.println("비밀번호가 틀렸습니다.");
            }
        } else {
            out.println("아이디가 틀렸습니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null)
            try { rs.close(); } catch (SQLException sqle) {}
        if (pstmt != null)
            try { pstmt.close(); } catch (SQLException sqle) {}
        if (conn != null)
            try { conn.close(); } catch (SQLException sqle) {}
    }
%>
