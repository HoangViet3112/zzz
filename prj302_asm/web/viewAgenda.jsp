<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.prj302.dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Leave Agenda</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Leave Agenda</h2>
        <table>
            <tr>
                <th>RequestID</th>
                <th>Username</th>
                <th>FromDate</th>
                <th>ToDate</th>
                <th>Reason</th>
                <th>Status</th>
            </tr>
            <%
                try (Connection con = DBConnection.getConnection()) {
                    String sql = "SELECT r.RequestID, u.Username, r.FromDate, r.ToDate, r.Reason, r.Status " +
                                 "FROM Requests r JOIN Users u ON r.UserID = u.UserID";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        try (ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getInt("RequestID") + "</td>");
                                out.println("<td>" + rs.getString("Username") + "</td>");
                                out.println("<td>" + rs.getDate("FromDate") + "</td>");
                                out.println("<td>" + rs.getDate("ToDate") + "</td>");
                                out.println("<td>" + rs.getString("Reason") + "</td>");
                                out.println("<td>" + rs.getString("Status") + "</td>");
                                out.println("</tr>");
                            }
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
                }
            %>
        </table>
        <a href="viewUsers.jsp">View Employees</a> | <a href="LogoutServlet">Logout</a>
    </div>
</body>
</html>