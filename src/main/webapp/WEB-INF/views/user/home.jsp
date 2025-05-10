<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Second Hand Bazar</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${cp}/asset/css/vendor.css">
    <link rel="stylesheet" type="text/css" href="${cp}/asset/style.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lora:wght@700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    
</head>
<%@ include file="../userhome.jsp" %>

<style>

    /* General Styles for the Hero Section */
    .hero-section {
        font-family: 'Poppins', sans-serif;
        text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
    }

    /* Styling for the Heading */
    .custom-heading {
        font-family: 'Lora', serif;
        color: #fff; /* White text for visibility */
        text-transform: uppercase; /* Make the title bold and capitalized */
        font-size: 3.5rem; /* Larger font size for emphasis */
        letter-spacing: 2px; /* Add spacing between letters for an elegant effect */
        text-shadow: 3px 3px 6px rgba(0, 0, 0, 0.5); /* Subtle text shadow */
    }

    /* Styling for the Paragraph */
    .custom-paragraph {
        font-family: 'Poppins', sans-serif;
        color: #f0f0f0; /* Light gray text */
        font-size: 1.2rem;
        font-weight: 300; /* Lighter weight for a clean look */
        line-height: 1.6;
    }

    /* Button Styling */
    .btn-custom {
        background-color: #FF6F61; /* Soft Coral color for the button */
        color: #fff; /* White text */
        font-family: 'Poppins', sans-serif;
        font-weight: 600;
        padding: 12px 25px;
        font-size: 1.1rem;
        border-radius: 30px; /* Rounded corners for a modern touch */
        text-transform: uppercase;
        transition: background-color 0.3s ease, transform 0.3s ease;
    }

    .btn-custom:hover {
        background-color: #ff4d3f; /* Slightly darker coral on hover */
        transform: scale(1.05); /* Slight grow effect on hover */
    }
</style>


<body>




<section class="hero-section text-light text-center py-5" style="background-image: url('${cp}/asset/images/Screenshot 2024-12-25 141839.png'); background-size: cover; background-position: center; height: 80vh;">
    <div class="container">
        <h2 class="display-4 custom-heading"><strong>Second Hand Bazar</strong></h2>
        <p class="lead custom-paragraph">All kinds of products available for selling and buying.</p>
        <a href="${cp}/user/product/add" class="btn btn-custom mt-3">Add Products</a>
    </div>
</section>





<footer class="bg-dark text-light py-4">
    <div class="container-lg">
        <div class="row">
            <div class="col-md-4">
                <h4>Second Hand Bazar</h4>
                <p>&copy; 2024 All rights reserved.</p>
            </div>
            <div class="col-md-4">
                <h4>Quick Links</h4>
               
            </div>
            <div class="col-md-4">
                <h4>Follow Us</h4>
               
            </div>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize Swiper
    new Swiper('.category-carousel', { navigation: { nextEl: '.swiper-next', prevEl: '.swiper-prev' } });
    new Swiper('.products-carousel', { navigation: { nextEl: '.swiper-next', prevEl: '.swiper-prev' } });
</script>
</body>
</html>
