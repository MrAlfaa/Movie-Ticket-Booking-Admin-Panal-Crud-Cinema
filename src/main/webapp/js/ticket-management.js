let contextPath = '';

document.addEventListener('DOMContentLoaded', function() {
    contextPath = document.querySelector('meta[name="contextPath"]').getAttribute('content');
    
    // Initialize modal close handlers
    initializeModalHandlers();
    
    // Initialize form validation
    initializeFormValidation();
});

function showAddModal() {
    document.getElementById('addModal').style.display = 'block';
}

function editTicket(ticketId, price, quantity, status) {
    document.getElementById('editTicketId').value = ticketId;
    document.getElementById('editPrice').value = price;
    document.getElementById('editQuantity').value = quantity;
    document.getElementById('editStatus').value = status;
    document.getElementById('editModal').style.display = 'block';
}

function confirmDelete(ticketId) {
    if (confirm('Are you sure you want to delete this ticket?')) {
        const deleteForm = document.getElementById('deleteForm');
        deleteForm.action = contextPath + '/admin/tickets';
        document.getElementById('deleteTicketId').value = ticketId;
        deleteForm.submit();
    }
}

function validateTicketForm(formId) {
    const form = document.getElementById(formId);
    const price = parseFloat(form.querySelector('[name="price"]').value);
    const quantity = parseInt(form.querySelector('[name="quantity"]').value);
    
    if (isNaN(price) || price <= 0) {
        alert('Price must be greater than 0');
        return false;
    }
    
    if (isNaN(quantity) || quantity <= 0) {
        alert('Quantity must be greater than 0');
        return false;
    }
    
    return true;
}

function initializeModalHandlers() {
    // Close modal when clicking outside
    window.onclick = function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    }

    // Close buttons in modals
    document.querySelectorAll('.close').forEach(button => {
        button.onclick = function() {
            this.closest('.modal').style.display = 'none';
        }
    });
}

function initializeFormValidation() {
    // Add ticket form validation
    const addForm = document.getElementById('addTicketForm');
    if (addForm) {
        addForm.addEventListener('submit', function(e) {
            if (!validateTicketForm('addTicketForm')) {
                e.preventDefault();
            }
        });
    }

    // Edit ticket form validation
    const editForm = document.getElementById('editTicketForm');
    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            if (!validateTicketForm('editTicketForm')) {
                e.preventDefault();
            }
        });
    }
}

// Utility functions
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(amount);
}

function formatDate(dateString) {
    return new Date(dateString).toLocaleString();
}
