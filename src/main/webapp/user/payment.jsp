<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://js.stripe.com/v3/"></script>
</head>
<body class="bg-dark text-white">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2>Complete Payment</h2>
                <div class="card bg-secondary">
                    <div class="card-body">
                        <form id="payment-form">
                            <div id="payment-element">
                                <!-- Stripe Elements will be inserted here -->
                            </div>
                            <button id="submit" class="btn btn-primary w-100 mt-4">Pay Now</button>
                            <div id="error-message"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/payment.js"></script>
</body>
</html>
