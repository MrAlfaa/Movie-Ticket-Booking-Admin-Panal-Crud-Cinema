document.addEventListener('DOMContentLoaded', function() {
    const seatMap = document.getElementById('seatMap');
    const selectedSeatsText = document.getElementById('selectedSeatsText');
    const totalAmountSpan = document.getElementById('totalAmount');
    const proceedButton = document.getElementById('proceedToPayment');
    
    let selectedSeats = [];
    
    function createSeatMap() {
        for (let i = 0; i < 64; i++) {
            const seat = document.createElement('div');
            seat.className = 'seat available';
            seat.dataset.seatNumber = `${String.fromCharCode(65 + Math.floor(i/8))}${i%8 + 1}`;
            seat.textContent = seat.dataset.seatNumber;
            
            seat.addEventListener('click', () => toggleSeat(seat));
            seatMap.appendChild(seat);
        }
    }
    
    function toggleSeat(seat) {
        if (seat.classList.contains('occupied')) return;
        
        if (!seat.classList.contains('selected') && selectedSeats.length >= TICKET_COUNT) {
            showAlert(`You can only select ${TICKET_COUNT} seats`);
            return;
        }
        
        seat.classList.toggle('selected');
        const seatNumber = seat.dataset.seatNumber;
        
        if (seat.classList.contains('selected')) {
            selectedSeats.push(seatNumber);
        } else {
            selectedSeats = selectedSeats.filter(s => s !== seatNumber);
        }
        
        updateBookingSummary();
        updateProceedButton();
    }
    
    function updateBookingSummary() {
        selectedSeatsText.textContent = selectedSeats.join(', ') || 'None';
        totalAmountSpan.textContent = (selectedSeats.length * SEAT_PRICE).toFixed(2);
    }
    
    function updateProceedButton() {
        const isValidSelection = selectedSeats.length === TICKET_COUNT;
        proceedButton.disabled = !isValidSelection;
        
        if (!isValidSelection) {
            proceedButton.title = `Please select exactly ${TICKET_COUNT} seats`;
        } else {
            proceedButton.title = 'Proceed to payment';
        }
    }
    
    function showAlert(message) {
        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert alert-warning alert-dismissible fade show';
        alertDiv.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        document.querySelector('.container').insertBefore(alertDiv, document.querySelector('.screen-container'));
        
        setTimeout(() => alertDiv.remove(), 3000);
    }
    
    function loadReservedSeats() {
        const urlParams = new URLSearchParams(window.location.search);
        const movieId = urlParams.get('movieId');
        const showTime = urlParams.get('showTime');
        const bookingDate = urlParams.get('bookingDate');
        
        fetch(`/user/seats?movieId=${movieId}&showTime=${showTime}&bookingDate=${bookingDate}`)
            .then(response => response.json())
            .then(reservedSeats => {
                reservedSeats.forEach(seatNumber => {
                    const seat = document.querySelector(`[data-seat-number="${seatNumber}"]`);
                    if (seat) {
                        seat.classList.remove('available');
                        seat.classList.add('occupied');
                    }
                });
            })
            .catch(error => console.error('Error loading reserved seats:', error));
    }
    
    proceedButton.addEventListener('click', function() {
        if (selectedSeats.length !== TICKET_COUNT) {
            showAlert(`Please select exactly ${TICKET_COUNT} seats`);
            return;
        }
        
        sessionStorage.setItem('selectedSeats', JSON.stringify(selectedSeats));
        window.location.href = 'payment.jsp';
    });
    
    createSeatMap();
    loadReservedSeats();
    updateProceedButton();
});
