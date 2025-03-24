package com.prj302.servlet;

import com.prj302.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ApproveServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = (String) request.getSession().getAttribute("role");
        Integer userID = (Integer) request.getSession().getAttribute("userID");
        if (role == null || !role.equals("DirectManager")) { // Changed to DirectManager
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        if (userID == null) {
            response.sendRedirect("error.jsp?message=User ID not found in session");
            return;
        }

        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");

        String status = action.equals("approve") ? "Approved" : "Inprogress";
        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE Requests SET Status = ?, ProcessedBy = ? WHERE RequestID = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, userID); // Set ProcessedBy to directmanager1's UserID
                ps.setInt(3, requestId);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
            return;
        }
        response.sendRedirect("AgendaServlet");
    }
}