document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('bookingForm');
    const numTicketsInput = document.querySelector('input[name="numTickets"]');
    const totalAmountDisplay = document.getElementById('displayAmount');
    const totalAmountInput = document.getElementById('totalAmount');
    
    const TICKET_PRICE = 1000; // LKR
    
    function updateTotal() {
        const numTickets = parseInt(numTicketsInput.value) || 0;
        const total = numTickets * TICKET_PRICE;
        totalAmountDisplay.textContent = total.toFixed(2);
        totalAmountInput.value = total;
    }
    
    numTicketsInput.addEventListener('input', updateTotal);
    
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const date = new Date(form.bookingDate.value);
        const today = new Date();
        
        if (date < today) {
            alert('Please select a future date');
            return;
        }
        
        this.submit();
    });
});
