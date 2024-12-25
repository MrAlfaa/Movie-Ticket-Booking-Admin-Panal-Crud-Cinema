document.addEventListener('DOMContentLoaded', function() {
    const stripe = Stripe('your_publishable_key');
    const elements = stripe.elements();
    const paymentElement = elements.create('payment');
    paymentElement.mount('#payment-element');

    const form = document.getElementById('payment-form');
    const errorDiv = document.getElementById('error-message');
    
    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const {error} = await stripe.confirmPayment({
            elements,
            confirmParams: {
                return_url: `${window.location.origin}/booking-confirmation.jsp`,
            },
        });
        
        if (error) {
            errorDiv.textContent = error.message;
        }
    });
});
