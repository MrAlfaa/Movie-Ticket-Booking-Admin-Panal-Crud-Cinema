<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="../css/auth-styles.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <h2>User Registration</h2>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/user/auth" method="post">
                <input type="hidden" name="action" value="register">
                
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" required>
                </div>
                
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" name="phoneNumber" required>
                </div>
                
                <div class="form-group">
                    <label>NIC</label>
                    <input type="text" name="nic" required>
                </div>
                
                <div class="form-group">
                    <label>Gender</label>
                    <select name="gender" required>
                        <option value="MALE">Male</option>
                        <option value="FEMALE">Female</option>
                        <option value="OTHER">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                
                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" required>
                </div>
                
                <button type="submit">Register</button>
            </form>
            <p>Already have an account? <a href="${pageContext.request.contextPath}/user/login.jsp">Login here</a></p>
        </div>
    </div>
</body>
</html>
