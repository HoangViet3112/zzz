<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.prj302.dao.DBConnection" %>
<%@ page import="java.sql.*" %>
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
            if (role == null || (!role.equals("DirectManager") && !role.equals("DepartmentManager"))) {
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
                    String sql;
                    PreparedStatement ps;

                    if (role.equals("DirectManager")) {
                        // DirectManager can only see employees in their department
                        String username = (String) session.getAttribute("username");
                        String managerDepartment = null;
                        sql = "SELECT Department FROM Users WHERE Username = ?";
                        try (PreparedStatement deptPs = con.prepareStatement(sql)) {
                            deptPs.setString(1, username);
                            try (ResultSet rs = deptPs.executeQuery()) {
                                if (rs.next()) {
                                    managerDepartment = rs.getString("Department");
                                }
                            }
                        }

                        if (managerDepartment == null) {
                            out.println("<p class='error-message'>Lỗi: Không tìm thấy phòng ban của quản lý.</p>");
                            return;
                        }

                        sql = "SELECT UserID, Username, Password, Role, Department FROM Users WHERE Role = 'Employee' AND Department = ?";
                        ps = con.prepareStatement(sql);
                        ps.setString(1, managerDepartment);
                    } else {
                        // DepartmentManager can see all employees
                        sql = "SELECT UserID, Username, Password, Role, Department FROM Users WHERE Role = 'Employee'";
                        ps = con.prepareStatement(sql);
                    }

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
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='error-message'>Lỗi: " + e.getMessage() + "</p>");
                }
            %>
        </table>
        <a href="ViewLeavesServlet">Quay lại lịch nghỉ</a>
        <a href="LogoutServlet">Đăng xuất</a>
    </div>
</body>
</html>