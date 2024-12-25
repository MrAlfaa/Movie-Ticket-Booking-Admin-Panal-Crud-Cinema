<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Movie Tickets</title>
    <link href="../css/booking.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-white">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6">
                <h2>${movie.title}</h2>
                <img src="${movie.posterUrl}" class="img-fluid movie-poster" alt="${movie.title}">
            </div>
            <div class="col-md-6">
                <form id="bookingForm" action="${pageContext.request.contextPath}/user/booking" method="post">
                    <input type="hidden" name="movieId" value="${movie.movieId}">
                    <input type="hidden" name="totalAmount" id="totalAmount">
                    
                    <div class="mb-3">
                        <label>Show Date:</label>
                        <input type="date" name="bookingDate" class="form-control" required>
                    </div>
                    
                    <div class="mb-3">
                        <label>Show Time:</label>
                        <select name="showTime" class="form-control" required>
                            <option value="8:30 AM-10:30 AM">8:30 AM - 10:30 AM</option>
                            <option value="12:30 PM-2:30 PM">12:30 PM - 2:30 PM</option>
                            <option value="4:30 PM-6:30 PM">4:30 PM - 6:30 PM</option>
                            <option value="8:30 PM-10:30 PM">8:30 PM - 10:30 PM</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label>Number of Tickets:</label>
                        <input type="number" name="numTickets" min="1" max="10" class="form-control" required>
                    </div>
                    
                    <div class="mb-3">
                        <h4>Total Amount: <span id="displayAmount">0.00</span> LKR</h4>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Continue to Seat Selection</button>
                </form>
            </div>
        </div>
    </div>
    <script src="../js/booking.js"></script>
</body>
</html>
