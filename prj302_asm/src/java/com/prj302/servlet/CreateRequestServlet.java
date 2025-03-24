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

public class CreateRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userID = (int) request.getSession().getAttribute("userID");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String reason = request.getParameter("reason");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO Requests (UserID, FromDate, ToDate, Reason, Status) VALUES (?, ?, ?, ?, 'Inprogress')";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, userID);
                ps.setString(2, fromDate);
                ps.setString(3, toDate);
                ps.setString(4, reason);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
            return;
        }
        response.sendRedirect("createRequest.jsp?success=true");
    }
}