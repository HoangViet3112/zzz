<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.prj302.servlet.ViewLeavesServlet.LeaveRequest" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch nghỉ của nhân viên - PRJ302 ASM</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Lịch nghỉ của nhân viên</h2>
        <table>
            <tr>
                <th>RequestID</th>
                <th>Username</th>
                <th>FromDate</th>
                <th>ToDate</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Processed By</th>
            </tr>
            <%
                List<LeaveRequest> allRequests = (List<LeaveRequest>) request.getAttribute("allRequests");
                if (allRequests != null) {
                    for (LeaveRequest req : allRequests) {
                        out.println("<tr>");
                        out.println("<td>" + req.getRequestID() + "</td>");
                        out.println("<td>" + req.getUsername() + "</td>");
                        out.println("<td>" + req.getFromDate() + "</td>");
                        out.println("<td>" + req.getToDate() + "</td>");
                        out.println("<td>" + req.getReason() + "</td>");
                        out.println("<td>" + req.getStatus() + "</td>");
                        out.println("<td>" + (req.getProcessedBy() != null ? req.getProcessedBy() : "Not processed") + "</td>");
                        out.println("</tr>");
                    }
                }
            %>
        </table>
        <a href="viewUsers.jsp">Xem danh sách nhân viên</a>
        <%
            String role = (String) session.getAttribute("role");
            if ("DirectManager".equals(role)) {
                out.println("<a href='AgendaServlet'>Duyệt đơn xin nghỉ</a>");
            }
        %>
        <a href="LogoutServlet">Đăng xuất</a>
    </div>
</body>
</html>