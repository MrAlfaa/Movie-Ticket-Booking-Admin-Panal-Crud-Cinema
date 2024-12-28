<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <link rel="stylesheet" href="../css/styles.css">
</head>
<body>
    <div class="bookings-container">
        <h1>My Bookings</h1>
        <div class="bookings-list">
            <c:forEach items="${bookings}" var="booking">
                <div class="booking-item">
                    <h3>Booking ID: ${booking.bookingId}</h3>
                    <p>Movie: ${booking.movieTitle}</p>
                    <p>Show Time: ${booking.showTime}</p>
                    <p>Seats: ${booking.seats}</p>
                    <p>Status: ${booking.paymentStatus}</p>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
