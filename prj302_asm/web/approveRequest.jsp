<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.prj302.servlet.AgendaServlet.LeaveRequest" %>
<%@ page import="java.util.List" %>
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
                <th>Username</th>
                <th>FromDate</th>
                <th>ToDate</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Processed By</th>
                <th>Action</th>
            </tr>
            <%
                List<LeaveRequest> pendingRequests = (List<LeaveRequest>) request.getAttribute("pendingRequests");
                if (pendingRequests != null) {
                    for (LeaveRequest req : pendingRequests) {
                        out.println("<tr>");
                        out.println("<td>" + req.getRequestID() + "</td>");
                        out.println("<td>" + req.getUsername() + "</td>");
                        out.println("<td>" + req.getFromDate() + "</td>");
                        out.println("<td>" + req.getToDate() + "</td>");
                        out.println("<td>" + req.getReason() + "</td>");
                        out.println("<td>" + req.getStatus() + "</td>");
                        out.println("<td>" + (req.getProcessedBy() != null ? req.getProcessedBy() : "Not processed") + "</td>");
                        out.println("<td>");
                        out.println("<a href='ApproveServlet?requestId=" + req.getRequestID() + "&action=approve'>Approve</a> | ");
                        out.println("<a href='ApproveServlet?requestId=" + req.getRequestID() + "&action=keep'>Keep Inprogress</a>");
                        out.println("</td>");
                        out.println("</tr>");
                    }
                }
            %>
        </table>
        <a href="ViewLeavesServlet">Quay lại lịch nghỉ</a>
        <a href="LogoutServlet">Đăng xuất</a>
    </div>
</body>
</html>