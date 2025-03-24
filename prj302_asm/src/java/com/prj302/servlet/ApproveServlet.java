import com.prj302.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ApproveServlet")
public class ApproveServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");
        String status = (action.equals("approve")) ? "Approved" : "Rejected";
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE Requests SET Status=?, ProcessedBy=(SELECT UserID FROM Users WHERE Username=?) WHERE RequestID=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setString(2, username);
                ps.setInt(3, requestId);
                ps.executeUpdate();
                response.sendRedirect("approveRequest.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }
}