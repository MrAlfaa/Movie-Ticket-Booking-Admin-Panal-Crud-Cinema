package com.cinema.booking.service;

import com.cinema.booking.dao.PaymentDAO;
import com.cinema.booking.dao.BookingDAO;
import com.cinema.booking.model.Payment;
import com.cinema.booking.constants.PaymentStatus;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class PaymentService {
    private PaymentDAO paymentDAO;
    private BookingDAO bookingDAO;

    public PaymentService() {
        this.paymentDAO = new PaymentDAO();
        this.bookingDAO = new BookingDAO();
    }

    public void processPayment(int bookingId, int userId, BigDecimal amount, String paymentIntentId)
            throws SQLException {
        try {
            System.out.println("Processing payment - BookingID: " + bookingId + ", UserID: " + userId +
                    ", Amount: " + amount + ", PaymentIntentID: " + paymentIntentId);

            // Validate input parameters
            if (bookingId <= 0 || userId <= 0 || amount == null || paymentIntentId == null) {
                throw new IllegalArgumentException("Invalid payment parameters");
            }

            paymentDAO.createPayment(bookingId, userId, amount, paymentIntentId);
            bookingDAO.updatePaymentStatus(bookingId, PaymentStatus.COMPLETED, paymentIntentId);

        } catch (SQLException e) {
            System.err.println("Database error during payment processing: " + e.getMessage());
            throw e;
        }
    }

    public void handleFailedPayment(int bookingId, String paymentIntentId) throws SQLException {
        bookingDAO.updatePaymentStatus(bookingId, PaymentStatus.FAILED, paymentIntentId);
    }

    public void handleRefund(String paymentIntentId) throws SQLException {
        paymentDAO.updatePaymentStatus(paymentIntentId, PaymentStatus.REFUNDED);
    }

    public Payment getPaymentByBookingId(int bookingId) throws SQLException {
        return paymentDAO.getPaymentByBookingId(bookingId);
    }

    public List<Payment> getUserPayments(int userId) throws SQLException {
        return paymentDAO.getUserPayments(userId);
    }

    public void updatePaymentStatus(String paymentIntentId, String status) throws SQLException {
        paymentDAO.updatePaymentStatus(paymentIntentId, status);
    }
}
