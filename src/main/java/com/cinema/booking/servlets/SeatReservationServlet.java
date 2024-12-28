package com.cinema.booking.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.cinema.booking.dao.ReservedSeatDAO;
import com.cinema.booking.model.ReservedSeat;
import com.cinema.booking.model.User;
import com.google.gson.Gson;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/user/seats/*")
public class SeatReservationServlet extends HttpServlet {
    private ReservedSeatDAO reservedSeatDAO;
    private Gson gson;

    @Override
    public void init() {
        reservedSeatDAO = new ReservedSeatDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String showTime = request.getParameter("showTime");
        java.sql.Date bookingDate = java.sql.Date.valueOf(request.getParameter("bookingDate"));

        try {
            List<String> reservedSeats = reservedSeatDAO.getReservedSeats(movieId, showTime, bookingDate);
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(reservedSeats));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson("Error fetching reserved seats"));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        response.setContentType("text/html");
        response.getWriter().write("<script>" +
                "sessionStorage.setItem('userId', '" + user.getUserId() + "');" +
                "sessionStorage.setItem('userEmail', '" + user.getEmail() + "');" +
                "</script>");

        try {
            String[] seatNumbers = request.getParameterValues("seats[]");
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            List<ReservedSeat> seats = new ArrayList<>();
            for (String seatNumber : seatNumbers) {
                ReservedSeat seat = new ReservedSeat();
                seat.setBookingId(bookingId);
                seat.setSeatNumber(seatNumber);
                seat.setStatus("RESERVED");
                seats.add(seat);
            }

            reservedSeatDAO.reserveSeats(seats);
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson("Seats reserved successfully"));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson("Error reserving seats"));
        }
    }
}
