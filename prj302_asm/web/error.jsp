<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>An Error Occurred</h2>
        <p style="color:red"><%= request.getParameter("message") %></p>
        <a href="login.jsp">Back to Login</a>
    </div>
</body>
</html>