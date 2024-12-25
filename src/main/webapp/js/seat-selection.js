document.addEventListener('DOMContentLoaded', function() {
    const seatMap = document.getElementById('seatMap');
    const selectedSeatsText = document.getElementById('selectedSeatsText');
    const totalAmountSpan = document.getElementById('totalAmount');
    const proceedButton = document.getElementById('proceedToPayment');
    
    const SEAT_PRICE = 1000;
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
        
        seat.classList.toggle('selected');
        const seatNumber = seat.dataset.seatNumber;
        
        if (seat.classList.contains('selected')) {
            selectedSeats.push(seatNumber);
        } else {
            selectedSeats = selectedSeats.filter(s => s !== seatNumber);
        }
        
        updateBookingSummary();
    }
    
    function updateBookingSummary() {
        selectedSeatsText.textContent = selectedSeats.join(', ') || 'None';
        totalAmountSpan.textContent = (selectedSeats.length * SEAT_PRICE).toFixed(2);
    }
    
    proceedButton.addEventListener('click', function() {
        if (selectedSeats.length === 0) {
            alert('Please select at least one seat');
            return;
        }
        
        // Store selected seats in session storage
        sessionStorage.setItem('selectedSeats', JSON.stringify(selectedSeats));
        window.location.href = 'payment.jsp';
    });
    
    createSeatMap();
    loadReservedSeats();
});

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
