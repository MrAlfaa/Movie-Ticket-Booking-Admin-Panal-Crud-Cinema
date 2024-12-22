<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="../css/auth-styles.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <h2>User Login</h2>
            <form action="${pageContext.request.contextPath}/user/auth" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                
                <button type="submit">Login</button>
            </form>
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/user/register.jsp">Register here</a></p>
            <p>Are you an admin? <a href="${pageContext.request.contextPath}/admin/login.jsp">Admin Login</a></p>
        </div>
    </div>
</body>
</html>
