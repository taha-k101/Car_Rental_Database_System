
//test above
let bookings = []; // Array to store booking details

function submitForm() {
    const carCategory = document.getElementById('carCategory').value;
    const pickupDate = document.getElementById('pickupDate').value;
    const returnDate = document.getElementById('returnDate').value;

    // Assuming you have some validation logic here

    const newBooking = {
        carCategory,
        pickupDate,
        returnDate
    }; 
    
    bookings.push(newBooking);
    displayBookingDetails();
}

function searchBookings() {
    const searchCategory = document.getElementById('searchCategory').value.toLowerCase();

    if (searchCategory) {
        const searchResults = bookings.filter(booking => booking.carCategory.toLowerCase().includes(searchCategory));
        displayBookingDetails(searchResults);
    } else {
        alert('Please provide a category for searching.');
    }
}

function deleteBooking(index) {
    bookings.splice(index, 1);
    displayBookingDetails();
}

function updateBooking(index) {
    const newPickupDate = prompt('Enter new Pickup Date:');
    const newReturnDate = prompt('Enter new Return Date:');

    if (newPickupDate && newReturnDate) {
        bookings[index].pickupDate = newPickupDate;
        bookings[index].returnDate = newReturnDate;
        displayBookingDetails();
    } else {
        alert('Invalid input. Please enter valid dates.');
    }
}

function displayBookingDetails(results) {
    const bookingDetailsContainer = document.getElementById('bookingDetails');
    bookingDetailsContainer.innerHTML = '';

    const bookingsToDisplay = results || bookings;

    bookingsToDisplay.forEach((booking, index) => {
        const bookingDiv = document.createElement('div');
        bookingDiv.innerHTML = `
            <p><strong>Car Category:</strong> ${booking.carCategory}</p>
            <p><strong>Pickup Date:</strong> ${booking.pickupDate}</p>
            <p><strong>Return Date:</strong> ${booking.returnDate}</p>
            <button onclick="deleteBooking(${index})">Delete</button>
            <button onclick="updateBooking(${index})">Update</button>
            <hr>
        `;
        bookingDetailsContainer.appendChild(bookingDiv);
    });
}

// public/script.js
document.addEventListener('DOMContentLoaded', () => {
    // Make an AJAX request to fetch data
    fetch('/getData')
        .then(response => response.json())
        .then(data => {
            // Update the HTML with the fetched data
            const dataList = document.getElementById('dataList');
            dataList.innerHTML = data.map(item => `<li>${item.id}: ${item.name}</li>`).join('');
        })
        .catch(error => console.error('Error fetching data:', error));
});

