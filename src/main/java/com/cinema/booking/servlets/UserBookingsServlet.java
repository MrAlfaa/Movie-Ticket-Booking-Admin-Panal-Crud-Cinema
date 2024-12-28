package com.cinema.booking.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cinema.booking.model.Booking;
import com.cinema.booking.service.BookingService;

@WebServlet("/user/bookings")
public class UserBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookingService bookingService;

    @Override
    public void init() {
        bookingService = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Booking> bookings = bookingService.getUserBookings(userId);
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/user/bookings.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to retrieve bookings");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
