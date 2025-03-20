<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.prj302.dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách nhân viên - PRJ302 ASM</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Danh sách nhân viên</h2>
        <%
            String role = (String) session.getAttribute("role");
            if (role == null || !role.equals("DepartmentManager")) {
                response.sendRedirect("login.jsp?error=unauthorized");
                return;
            }
        %>
        <table>
            <tr>
                <th>UserID</th>
                <th>Tên đăng nhập</th>
                <th>Mật khẩu</th>
                <th>Vai trò</th>
                <th>Phòng ban</th>
            </tr>
            <%
                try (Connection con = DBConnection.getConnection()) {
                    String sql = "SELECT UserID, Username, Password, Role, Department FROM Users WHERE Role = 'Employee'";
                    try (PreparedStatement ps = con.prepareStatement(sql)) {
                        try (ResultSet rs = ps.executeQuery()) {
                            while (rs.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rs.getInt("UserID") + "</td>");
                                out.println("<td>" + rs.getString("Username") + "</td>");
                                out.println("<td>" + rs.getString("Password") + "</td>");
                                out.println("<td>" + rs.getString("Role") + "</td>");
                                out.println("<td>" + rs.getString("Department") + "</td>");
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
        <a href="viewAgenda.jsp">Quay lại lịch nghỉ</a>
        <a href="LogoutServlet">Đăng xuất</a>
    </div>
</body>
</html>