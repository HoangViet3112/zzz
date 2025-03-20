<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - PRJ302 ASM</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Đăng nhập</h2>
        <% if (request.getParameter("error") != null) { %>
            <p class="error-message">Tên người dùng hoặc mật khẩu không đúng!</p>
        <% } %>
        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label>Tên người dùng:</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Mật khẩu:</label>
                <input type="password" name="password" required>
            </div>
            <input type="submit" value="Đăng nhập">
        </form>
    </div>
</body>
</html>