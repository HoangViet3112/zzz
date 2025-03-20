<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.prj302.dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Duyệt đơn xin nghỉ - PRJ302 ASM</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Duyệt đơn xin nghỉ</h2>
        <table>
            <tr>
                <th>RequestID</th>
                <th>FromDate</th>
                <th>ToDate</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                try (Connection con = DBConnection.getConnection()) {
                    String sql = "SELECT r.RequestID, r.FromDate, r.ToDate, r.Reason, r.Status " +
                                 "FROM Requests r JOIN Users u ON r.UserID = u.UserID " +
                                 "WHERE r.Status = 'Inprogress'";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        try (ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getInt("RequestID") + "</td>");
                                out.println("<td>" + rs.getDate("FromDate") + "</td>");
                                out.println("<td>" + rs.getDate("ToDate") + "</td>");
                                out.println("<td>" + rs.getString("Reason") + "</td>");
                                out.println("<td>" + rs.getString("Status") + "</td>");
                                out.println("<td>");
                                out.println("<a href='ApproveServlet?requestId=" + rs.getInt("RequestID") + "&action=approve'>Approve</a> | ");
                                out.println("<a href='ApproveServlet?requestId=" + rs.getInt("RequestID") + "&action=reject'>Reject</a>");
                                out.println("</td>");
                                out.println("</tr>");
                            }
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='error-message'>Lỗi: " + e.getMessage() + "</p>");
                }
            %>
        </table>
        <a href="LogoutServlet">Đăng xuất</a>
    </div>
</body>
</html>