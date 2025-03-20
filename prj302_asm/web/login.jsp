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
        <% 
            String error = request.getParameter("error");
            if (error != null) {
                if (error.equals("unauthorized")) {
                    out.println("<p class='error-message'>Bạn không có quyền truy cập trang này!</p>");
                } else {
                    out.println("<p class='error-message'>Tên đăng nhập hoặc mật khẩu không đúng!</p>");
                }
            }
        %>
        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label>Tên đăng nhập:</label>
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