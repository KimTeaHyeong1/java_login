<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mysqlconn.BoardDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="article" scope="page" class="mysqlconn.BoardDataBean">
    <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
    String pageNum = request.getParameter("pageNum");
    BoardDBBean dbPro = BoardDBBean.getInstance();
    int check = dbPro.updateArticle(article);
    
    if(check == 1) {
%>  
    <html>
    <head>
        <meta http-equiv="Refresh" content="0;url=studyList.jsp?pageNum=<%=pageNum%>">
    </head>
    <body>
    </body>
    </html>
<%  } else { %>
    <script type="text/javascript">
        alert("비밀번호가 맞지 않습니다");
        history.go(-1);
    </script>
<%
    }
%>
