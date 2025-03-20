<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Lỗi - PRJ302 ASM</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Đã xảy ra lỗi</h2>
        <p class="error-message"><%= request.getParameter("message") %></p>
        <a href="login.jsp">Quay lại đăng nhập</a>
    </div>
</body>
</html>