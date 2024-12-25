package com.cinema.booking.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.cinema.booking.model.*;
import com.cinema.booking.dao.*;
import java.math.BigDecimal;
import java.sql.Date;

@WebServlet("/user/booking/*")
public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private MovieDAO movieDAO;
    private TicketDAO ticketDAO;

    @Override
    public void init() {
        bookingDAO = new BookingDAO();
        movieDAO = new MovieDAO();
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        Movie movie = movieDAO.getMovieById(movieId);
        BigDecimal ticketPrice = ticketDAO.getMoviePrice(movieId);

        request.setAttribute("movie", movie);
        request.setAttribute("ticketPrice", ticketPrice);
        request.getRequestDispatcher("/user/booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        Booking booking = new Booking();
        booking.setUserId(user.getUserId());
        booking.setMovieId(Integer.parseInt(request.getParameter("movieId")));
        booking.setShowTime(request.getParameter("showTime"));
        booking.setBookingDate(Date.valueOf(request.getParameter("bookingDate")));
        booking.setNumTickets(Integer.parseInt(request.getParameter("numTickets")));
        booking.setTotalAmount(new BigDecimal(request.getParameter("totalAmount")));
        booking.setPaymentStatus("PENDING");

        try {
            int bookingId = bookingDAO.createBooking(booking);
            session.setAttribute("currentBookingId", bookingId);
            session.setAttribute("ticketPrice", ticketDAO.getMoviePrice(booking.getMovieId()));
            session.setAttribute("ticketCount", booking.getNumTickets());
            response.sendRedirect(request.getContextPath() + "/user/seat-selection.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "Booking failed: " + e.getMessage());
            request.getRequestDispatcher("/user/booking.jsp").forward(request, response);
        }
    }
}
