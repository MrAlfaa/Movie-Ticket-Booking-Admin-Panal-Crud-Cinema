<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cinema Admin Panel</title>
</head>
<body>
    <%
        response.sendRedirect(request.getContextPath() + "/admin/navigation?page=dashboard");
    %>
</body>
</html>
