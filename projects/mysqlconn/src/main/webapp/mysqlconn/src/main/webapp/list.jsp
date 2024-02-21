<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mysqlconn.BoardDBBean" %>
<%@ page import="mysqlconn.BoardDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%!
    int pageSize1 = 10;
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd-HH:mm");
%>

<%
    String list = "게시판1"; 
    String pageNum1 = request.getParameter("pageNum1");

    if (pageNum1 == null) {
        pageNum1 = "1";
    }

    int currentPage1 = Integer.parseInt(pageNum1);
    int startRow1 = (currentPage1 - 1) * pageSize1 + 1;
    int endRow1 = currentPage1 * pageSize1;
    int count1 = 0;
    int number1 = 0;
    
    List<BoardDataBean> articleList1 = null;

    BoardDBBean dbPro1 = BoardDBBean.getInstance();
    int totalCount1 = dbPro1.getArticleCount("list");
    if (totalCount1 > 0) {
    	articleList1 = dbPro1.getArticles(startRow1, endRow1);

        count1 = totalCount1;
    }

    number1 = totalCount1 - (currentPage1 - 1) * pageSize1;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 1</title>
</head>
<body>
<%
    String value_c1 = "gray";
%>
    <p>게시판 1의 글목록(전체글:<%= count1 %>)</p>

    <table>
        <tr>
            <td align="right" bgcolor="<%= value_c1 %>">
                <a href="writeForm.jsp">글쓰기</a>
            </td>
        </tr>
    </table>

    <% if (count1 == 0) { %>

    <table>
        <tr>
            <td align="center">
                게시판에 저장된 글이 없습니다.
            </td>
        </tr>
    </table>

    <% } else { %>
    <table>
        <tr height="30" bgcolor="<%= value_c1 %>">
            <td align="center" width="50">번호</td>
            <td align="center" width="250">제목</td>
            <td align="center" width="100">작성자</td>
            <td align="center" width="150">작성일</td>
            <td align="center" width="50">조회</td>
            <td align="center" width="100">IP</td>
        </tr>
        <% for (int i = 0; i < articleList1.size(); i++) {
            BoardDataBean article1 = articleList1.get(i);
        %>
        <tr height="30">
            <td width="50"><%= number1-- %></td>
            <td width="250" align="left">
                <%
                    int wid1 = 0;
                    if (article1.getRe_level() > 0) {
                        wid1 = 5 * (article1.getRe_level());
                    }
                %>
                <a href="content.jsp?num=<%= article1.getNum() %>&pageNum1=<%= currentPage1 %>"><%= article1.getSubject() %></a>
            </td>
            <td width="100" align="left">
                <a href="mailto:<%= article1.getEmail() %>"><%= article1.getWriter() %></a>
            </td>
            <td width="150" align="left"><%= sdf1.format(article1.getReg_date()) %></td>
            <td width="50" align="center"><%= article1.getReadcount() %></td>
            <td width="100" align="left"><%= article1.getIp() %></td>
        </tr>
        <% } %>
    </table>
    <% } %>
<%
    if (count1 > 0) {
        int pageCount1 = count1 / pageSize1 + (count1 % pageSize1 == 0 ? 0 : 1);
        int startPage1 = 1;

        if (currentPage1 % 10 != 0) {
            startPage1 = (int) (currentPage1 / 10) * 10 + 1;
        } else {
            startPage1 = ((int) (currentPage1 / 10) - 1) * 10 + 1;
        }

        int pageBlock1 = 10;
        int endPage1 = startPage1 + pageBlock1 - 1;
        if (endPage1 > pageCount1) endPage1 = pageCount1;

        if (startPage1 > 10) {
    %>
    <a href="list.jsp?pageNum1=<%= startPage1 - 10 %>">[이전]</a>
    <% }

        for (int i = startPage1; i <= endPage1; i++) {
    %>
    <a href="list.jsp?pageNum1=<%= i %>">[<%= i %>]</a>
    <% }

        if (endPage1 < pageCount1) { %>
    <a href="list.jsp?pageNum1=<%= startPage1 + 10 %>">[다음]</a>
    <% }
    } %>
    <input type="button" value="뒤로가기" onclick="document.location.href='main.jsp'">
        <input type="button" value="로그아웃" onclick="document.location.href='home.jsp'">
</body>
</html>
