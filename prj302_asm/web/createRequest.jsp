<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Leave Request</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Create Leave Request</h2>
        <% if (request.getParameter("success") != null) { %>
            <p style="color:green">Leave request submitted successfully!</p>
        <% } %>
        <form action="CreateRequestServlet" method="post">
            <div class="form-group">
                <label>From Date:</label>
                <input type="date" name="fromDate" required>
            </div>
            <div class="form-group">
                <label>To Date:</label>
                <input type="date" name="toDate" required>
            </div>
            <div class="form-group">
                <label>Reason:</label>
                <input type="text" name="reason" required>
            </div>
            <input type="submit" value="Submit">
        </form>
        <a href="LogoutServlet">Logout</a>
    </div>
</body>
</html>