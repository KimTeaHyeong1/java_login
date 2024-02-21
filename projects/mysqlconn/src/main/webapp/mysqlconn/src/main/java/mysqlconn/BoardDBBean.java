package mysqlconn;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDBBean {

    private static BoardDBBean instance = new BoardDBBean();

    public static BoardDBBean getInstance() {
        return instance;
    }

    private BoardDBBean() {
    }

    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/basicjsp");
        return ds.getConnection();
    }



    public void insertArticle(BoardDataBean article, String boardName) throws Exception {
        try (Connection conn = getConnection();
             PreparedStatement pstmtSelect = conn.prepareStatement("select max(num) from " + boardName);
             ResultSet rs = pstmtSelect.executeQuery()) {

            int num = article.getNum();
            int ref = article.getRef();
            int re_step = article.getRe_step();
            int re_level = article.getRe_level();
            int number = 0;
            String sql = "";

            if (rs.next())
                number = rs.getInt(1) + 1;
            else
                number = 1;

            if (num != 0) {
                sql = "update " + boardName + " set re_step=re_step+1 where ref= ? and re_step> ?";
                try (PreparedStatement pstmtUpdate = conn.prepareStatement(sql)) {
                    pstmtUpdate.setInt(1, ref);
                    pstmtUpdate.setInt(2, re_step);
                    pstmtUpdate.executeUpdate();
                    re_step = re_step + 1;
                    re_level = re_level + 1;
                }
            } else {
                ref = number;
                re_step = 0;
                re_level = 0;
            }

            sql = "insert into " + boardName + "(writer,email,subject,password,reg_date, ref,re_step,re_level,content,ip) values(?,?,?,?,?,?,?,?,?,?)";

            try (PreparedStatement pstmtInsert = conn.prepareStatement(sql)) {
                pstmtInsert.setString(1, article.getWriter());
                pstmtInsert.setString(2, article.getEmail());
                pstmtInsert.setString(3, article.getSubject());
                pstmtInsert.setString(4, article.getPassword());
                pstmtInsert.setTimestamp(5, article.getReg_date());
                pstmtInsert.setInt(6, ref);
                pstmtInsert.setInt(7, re_step);
                pstmtInsert.setInt(8, re_level);
                pstmtInsert.setString(9, article.getContent());
                pstmtInsert.setString(10, article.getIp());

                pstmtInsert.executeUpdate();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    public List<BoardDataBean> getArticlesByBoard(int start, int end, String boardName) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BoardDataBean> articleList = null;

        int pageSize = 10; 

        try {
            conn = getConnection();
            String sql = "SELECT * FROM " + boardName + " ORDER BY num DESC LIMIT ?, ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start - 1);
            pstmt.setInt(2, end - start + 1);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                articleList = new ArrayList<>(pageSize);
                do {
                    BoardDataBean article = new BoardDataBean();
                    article.setNum(rs.getInt("num"));
                    articleList.add(article);
                } while (rs.next());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return articleList;
    }



    public int getArticleCount(String board) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int x = 0;

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement("select count(*) from board");
            rs = pstmt.executeQuery();

            if (rs.next()) {
                x = rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
            if (conn != null) try { conn.close(); } catch (SQLException ex) { }
        }
        return x;
    }


    public List<BoardDataBean> getArticles(int start, int end, String board) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BoardDataBean> articleList = null;
        
        // 페이지 크기를 지정합니다.
        int pageSize = 10; // 예시로 10으로 설정하였습니다.

        try {
            conn = getConnection();
            String sql = "SELECT * FROM " + board + " ORDER BY num DESC LIMIT ?, ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start - 1);
            pstmt.setInt(2, end - start + 1);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                articleList = new ArrayList<BoardDataBean>(pageSize);
                do {
                    BoardDataBean article = new BoardDataBean();
                    article.setNum(rs.getInt("num"));
                    // 나머지 필드 설정
                    articleList.add(article);
                } while (rs.next());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
        return articleList;
    }



    public List<BoardDataBean> getArticles(int start, int end) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BoardDataBean> articleList = null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select * from board order by ref desc, re_step asc limit ?,?");
            pstmt.setInt(1, start - 1);
            pstmt.setInt(2, end);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                articleList = new ArrayList<BoardDataBean>(end);
                do {
                    BoardDataBean article = new BoardDataBean();
                    article.setNum(rs.getInt("num"));
                    article.setWriter(rs.getString("writer"));
                    article.setEmail(rs.getString("email"));
                    article.setSubject(rs.getString("subject"));
                    article.setPassword(rs.getString("password"));
                    article.setReg_date(rs.getTimestamp("reg_date"));
                    article.setReadcount(rs.getInt("readcount"));
                    article.setRef(rs.getInt("ref"));
                    article.setRe_step(rs.getInt("re_step"));
                    article.setRe_level(rs.getInt("re_level"));
                    article.setContent(rs.getString("content"));
                    article.setIp(rs.getString("ip"));

                    articleList.add(article);
                } while (rs.next());
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
            if (conn != null) try { conn.close(); } catch (SQLException ex) { }
        }
        return articleList;
    }


    public BoardDataBean getArticle(int num) throws Exception {
        try (Connection conn = getConnection();
             PreparedStatement pstmtUpdateReadCount = conn.prepareStatement("update board set readcount=readcount+1 where num=?");
             PreparedStatement pstmtSelectArticle = conn.prepareStatement("select * from board where num =?")) {


            pstmtUpdateReadCount.setInt(1, num);
            pstmtUpdateReadCount.executeUpdate();

            pstmtSelectArticle.setInt(1, num);
            try (ResultSet rs = pstmtSelectArticle.executeQuery()) {
                if (rs.next()) {

                    BoardDataBean article = new BoardDataBean();
                    article.setNum(rs.getInt("num"));
                    article.setWriter(rs.getString("writer"));
                    article.setEmail(rs.getString("email"));
                    article.setSubject(rs.getString("subject"));
                    article.setPassword(rs.getString("password"));
                    article.setReg_date(rs.getTimestamp("reg_date"));
                    article.setReadcount(rs.getInt("readcount"));
                    article.setRef(rs.getInt("ref"));
                    article.setRe_step(rs.getInt("re_step"));
                    article.setRe_level(rs.getInt("re_level"));
                    article.setContent(rs.getString("content"));
                    article.setIp(rs.getString("ip"));
                    return article;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return null;
    }

    public BoardDataBean updateGetArticle(int num)
            throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDataBean article = null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select * from board where num = ?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new BoardDataBean();
                article.setNum(rs.getInt("num"));
                article.setWriter(rs.getString("writer"));
                article.setEmail(rs.getString("email"));
                article.setSubject(rs.getString("subject"));
                article.setPassword(rs.getString("password"));
                article.setReg_date(rs.getTimestamp("reg_date"));
                article.setReadcount(rs.getInt("readcount"));
                article.setRef(rs.getInt("ref"));
                article.setRe_step(rs.getInt("re_step"));
                article.setRe_level(rs.getInt("re_level"));
                article.setContent(rs.getString("content"));
                article.setIp(rs.getString("ip"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try {
                rs.close();
            } catch (SQLException ex) {
            }
            if (pstmt != null) try {
                pstmt.close();
            } catch (SQLException ex) {
            }
            if (conn != null) try {
                conn.close();
            } catch (SQLException ex) {
            }
        }
        return article;
    }

    public int updateArticle(BoardDataBean article) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String dbpassword = "";
        int x = -1;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement("select password from board where num =?");
            pstmt.setInt(1, article.getNum());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dbpassword = rs.getString("password");
                if (dbpassword.equals(article.getPassword())) {
                    pstmt.close(); 
                    pstmt = conn.prepareStatement("update board set writer=?, email=?, subject=?, password=?, content=? where num=?");
                    pstmt.setString(1, article.getWriter());
                    pstmt.setString(2, article.getEmail());
                    pstmt.setString(3, article.getSubject());
                    pstmt.setString(4, article.getPassword());
                    pstmt.setString(5, article.getContent());
                    pstmt.setInt(6, article.getNum());
                    pstmt.executeUpdate();
                    x = 1;
                } else {
                    x = 0;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
            if (conn != null) try { conn.close(); } catch (SQLException ex) { }
        }
        return x;
    }

    public int deleteArticle(int num, String password) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String dbpassword = "";
        int x = -1;
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(
                    "select password from board where num =?");
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dbpassword = rs.getString("password");
                if (dbpassword.equals(password)) {
                    pstmt.close(); 
                    
                    pstmt = conn.prepareStatement(
                            "delete from board where num=?");
                    pstmt.setInt(1, num);
                    pstmt.executeUpdate();
                    x = 1;
                } else
                    x = 0;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
            if (conn != null) try { conn.close(); } catch (SQLException ex) { }
        }
        return x;
    }
}
