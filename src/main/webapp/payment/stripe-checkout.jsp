<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <script src="https://js.stripe.com/v3/"></script>
</head>
<body>
    <form id="payment-form">
        <div id="payment-element"></div>
        <button id="submit">Pay now</button>
    </form>

    <script>
        const stripe = Stripe('${stripePublicKey}');
        const elements = stripe.elements();
        const paymentElement = elements.create('payment');
        paymentElement.mount('#payment-element');

        const form = document.getElementById('payment-form');
        form.addEventListener('submit', async (event) => {
            event.preventDefault();
            
            const {error} = await stripe.confirmPayment({
                elements,
                confirmParams: {
                    return_url: '${pageContext.request.contextPath}/payment/success',
                }
            });

            if (error) {
                console.error(error);
            }
        });
    </script>
</body>
</html>
