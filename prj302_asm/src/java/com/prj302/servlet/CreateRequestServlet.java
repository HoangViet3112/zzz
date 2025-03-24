import com.prj302.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/CreateRequestServlet")
public class CreateRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String reason = request.getParameter("reason");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO Requests (UserID, FromDate, ToDate, Reason) " +
                         "SELECT UserID, ?, ?, ? FROM Users WHERE Username=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, fromDate);
                ps.setString(2, toDate);
                ps.setString(3, reason);
                ps.setString(4, username);
                ps.executeUpdate();
                response.sendRedirect("createRequest.jsp?success=true");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }
}