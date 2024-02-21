<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mysqlconn.BoardDBBean" %>
<%@ page import="mysqlconn.BoardDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%!
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH:mm");
%>

<%
    String pageNum = request.getParameter("pageNum");

    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number = 0;
    
    List<BoardDataBean> articleList = null;

    BoardDBBean dbPro = BoardDBBean.getInstance();
    int totalCount = dbPro.getArticleCount("board");
    articleList = dbPro.getArticles(startRow, endRow, "board"); 


    number = totalCount - (currentPage - 1) * pageSize;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
</head>
<body>
<%
    String value_c = "gray";
%>
    <p>글목록(전체글:<%= count %>)</p>

    <table>
        <tr>
            <td align="right" bgcolor="<%= value_c %>">
                <a href="studyWriteForm.jsp">글쓰기</a>
            </td>
        </tr>
    </table>

    <% if (count == 0) { %>

    <table>
        <tr>
            <td align="center">
                게시판에 저장된 글이 없습니다.
            </td>
        </tr>
    </table>

    <% } else { %>
    <table>
        <tr height="30" bgcolor="<%= value_c %>">
            <td align="center" width="50">번호</td>
            <td align="center" width="250">제목</td>
            <td align="center" width="100">작성자</td>
            <td align="center" width="150">작성일</td>
            <td align="center" width="50">조회</td>
            <td align="center" width="100">IP</td>
        </tr>
        <% for (int i = 0; i < articleList.size(); i++) {
            BoardDataBean article = articleList.get(i);
        %>
        <tr height="30">
            <td width="50"><%= number-- %></td>
            <td width="250" align="left">
                <%
                    int wid = 0;
                    if (article.getRe_level() > 0) {
                        wid = 5 * (article.getRe_level());
                    }
                %>
                <a href="studyContent.jsp?num=<%= article.getNum() %>&pageNum=<%= currentPage %>"><%= article.getSubject() %></a>
            </td>
            <td width="100" align="left">
                <a href="mailto:<%= article.getEmail() %>"><%= article.getWriter() %></a>
            </td>
            <td width="150" align="left"><%= sdf.format(article.getReg_date()) %></td>
            <td width="50" align="center"><%= article.getReadcount() %></td>
            <td width="100" align="left"><%= article.getIp() %></td>
        </tr>
        <% } %>
    </table>
    <% } %>
<%
    if (count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        int startPage = 1;

        if (currentPage % 10 != 0) {
            startPage = (int) (currentPage / 10) * 10 + 1;
        } else {
            startPage = ((int) (currentPage / 10) - 1) * 10 + 1;
        }

        int pageBlock = 10;
        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) endPage = pageCount;

        if (startPage > 10) {
    %>
    <a href="studyList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
    <% }

        for (int i = startPage; i <= endPage; i++) {
    %>
    <a href="studyList.jsp?pageNum=<%= i %>">[<%= i %>]</a>
    <% }

        if (endPage < pageCount) { %>
    <a href="studyList.jpg?pageNum=<%= startPage + 10 %>">[다음]</a>
    <% }
    } %>
    <input type="button" value="뒤로가기" onclick="document.location.href='main.jsp'">
        <input type="button" value="로그아웃" onclick="document.location.href='home.jsp'">
</body>
</html>
