package com.cinema.booking.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import com.stripe.model.Refund;
import com.cinema.booking.service.StripeService;
import com.cinema.booking.webhooks.StripeWebhookHandler;

@WebServlet("/stripe/*")
public class StripePaymentServlet extends HttpServlet {
    private StripeService stripeService;
    private StripeWebhookHandler webhookHandler;

    @Override
    public void init() {
        stripeService = new StripeService();
        webhookHandler = new StripeWebhookHandler();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        try {
            switch (action) {
                case "/create-payment-intent":
                    createPaymentIntent(request, response);
                    break;
                case "/webhook":
                    handleWebhook(request, response);
                    break;
                case "/refund":
                    handleRefund(request, response);
                    break;
            }
        } catch (StripeException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(new JSONObject().put("error", e.getMessage()).toString());
        }
    }

    private void createPaymentIntent(HttpServletRequest request, HttpServletResponse response)
            throws IOException, StripeException {
        Long amount = Long.parseLong(request.getParameter("amount"));
        PaymentIntent intent = stripeService.createPaymentIntent(amount, "lkr");

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("clientSecret", intent.getClientSecret());

        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }

    private void handleWebhook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String payload = request.getReader().lines()
                .reduce("", (accumulator, actual) -> accumulator + actual);
        String sigHeader = request.getHeader("Stripe-Signature");

        try {
            webhookHandler.handleWebhookEvent(payload, sigHeader);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write(new JSONObject().put("error", e.getMessage()).toString());
        }
    }

    private void handleRefund(HttpServletRequest request, HttpServletResponse response)
            throws IOException, StripeException {
        String paymentIntentId = request.getParameter("paymentIntentId");
        Refund refund = stripeService.createRefund(paymentIntentId);

        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("refundId", refund.getId());
        jsonResponse.put("status", refund.getStatus());

        response.setContentType("application/json");
        response.getWriter().write(jsonResponse.toString());
    }
}
