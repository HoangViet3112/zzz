package com.prj302.servlet;

import com.prj302.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ViewLeavesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        String username = (String) request.getSession().getAttribute("username");
        if (role == null || (!role.equals("DirectManager") && !role.equals("DepartmentManager"))) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        List<LeaveRequest> allRequests = new ArrayList<>();
        try (Connection con = DBConnection.getConnection()) {
            String sql;
            PreparedStatement ps;

            if (role.equals("DirectManager")) {
                // DirectManager can only see requests from their own department
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
                    response.sendRedirect("error.jsp?message=Manager department not found");
                    return;
                }

                sql = "SELECT r.RequestID, r.UserID, r.FromDate, r.ToDate, r.Reason, r.Status, r.ProcessedBy, u.Username " +
                      "FROM Requests r " +
                      "JOIN Users u ON r.UserID = u.UserID " +
                      "WHERE u.Department = ? AND u.Role = 'Employee'";
                ps = con.prepareStatement(sql);
                ps.setString(1, managerDepartment);
            } else {
                // DepartmentManager can see requests from all departments
                sql = "SELECT r.RequestID, r.UserID, r.FromDate, r.ToDate, r.Reason, r.Status, r.ProcessedBy, u.Username " +
                      "FROM Requests r " +
                      "JOIN Users u ON r.UserID = u.UserID " +
                      "WHERE u.Role = 'Employee'";
                ps = con.prepareStatement(sql);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LeaveRequest req = new LeaveRequest();
                    req.setRequestID(rs.getInt("RequestID"));
                    req.setUserID(rs.getInt("UserID"));
                    req.setFromDate(rs.getDate("FromDate"));
                    req.setToDate(rs.getDate("ToDate"));
                    req.setReason(rs.getString("Reason"));
                    req.setStatus(rs.getString("Status"));
                    req.setProcessedBy(rs.getInt("ProcessedBy"));
                    req.setUsername(rs.getString("Username"));
                    allRequests.add(req);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
            return;
        }

        request.setAttribute("allRequests", allRequests);
        request.getRequestDispatcher("viewAgenda.jsp").forward(request, response);
    }

    public static class LeaveRequest {
        private int requestID;
        private int userID;
        private java.sql.Date fromDate;
        private java.sql.Date toDate;
        private String reason;
        private String status;
        private Integer processedBy;
        private String username;

        public int getRequestID() { return requestID; }
        public void setRequestID(int requestID) { this.requestID = requestID; }
        public int getUserID() { return userID; }
        public void setUserID(int userID) { this.userID = userID; }
        public java.sql.Date getFromDate() { return fromDate; }
        public void setFromDate(java.sql.Date fromDate) { this.fromDate = fromDate; }
        public java.sql.Date getToDate() { return toDate; }
        public void setToDate(java.sql.Date toDate) { this.toDate = toDate; }
        public String getReason() { return reason; }
        public void setReason(String reason) { this.reason = reason; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public Integer getProcessedBy() { return processedBy; }
        public void setProcessedBy(Integer processedBy) { this.processedBy = processedBy; }
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
    }
}