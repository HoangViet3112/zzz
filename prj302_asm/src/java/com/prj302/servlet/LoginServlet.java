package com.prj302.servlet;

import com.prj302.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT UserID, Role FROM Users WHERE Username = ? AND Password = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("userID", rs.getInt("UserID"));
                        session.setAttribute("role", rs.getString("Role"));
                        session.setAttribute("username", username);
                        if ("DirectManager".equals(rs.getString("Role")) || "DepartmentManager".equals(rs.getString("Role"))) {
                            response.sendRedirect("ViewLeavesServlet");
                        } else {
                            response.sendRedirect("createRequest.jsp");
                        }
                    } else {
                        response.sendRedirect("login.jsp?error=invalid");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }
}