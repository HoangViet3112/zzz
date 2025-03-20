<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Tạo đơn xin nghỉ - PRJ302 ASM</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Tạo đơn xin nghỉ</h2>
        <% if (request.getParameter("success") != null) { %>
            <p style="color: green; margin-bottom: 15px;">Đơn xin nghỉ đã được gửi thành công!</p>
        <% } %>
        <form action="CreateRequestServlet" method="post">
            <div class="form-group">
                <label>Từ ngày:</label>
                <input type="date" name="fromDate" required>
            </div>
            <div class="form-group">
                <label>Đến ngày:</label>
                <input type="date" name="toDate" required>
            </div>
            <div class="form-group">
                <label>Lý do:</label>
                <input type="text" name="reason" required>
            </div>
            <input type="submit" value="Gửi">
        </form>
        <a href="LogoutServlet">Đăng xuất</a>
    </div>
</body>
</html>