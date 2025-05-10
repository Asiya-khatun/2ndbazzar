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
</head>
<style>
/* Importing Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@600&family=Roboto:wght@500&family=Open+Sans:wght@400;600&display=swap');

/* Body Styling */
body {
    font-family: 'Open Sans', sans-serif;
    background-color: #f4f4f9;  /* Light background color for the body */
    margin: 0;
    padding: 0;
}

/* Styling the header container */
header {
    background-color: #ffffff;  /* White background for header */
    padding: 1.5rem 0;  /* Padding for top and bottom */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);  /* Subtle shadow for modern look */
    position: sticky;
    top: 0;
    z-index: 1000;
}

/* Styling the logo */
header .logo a {
    font-family: 'Poppins', sans-serif;
    font-size: 2.5rem;
    font-weight: 700;
    color: transparent;
    background-image: linear-gradient(to right, #f05a28, #ee3f7f);
    -webkit-background-clip: text;
    background-clip: text;
    text-decoration: none;
    letter-spacing: 2px;
    transition: all 0.4s ease;
}

/* Hover effect for the logo */
header .logo a:hover {
    transform: scale(1.1);
    color: #333;
    background-image: none;
}

/* Styling navigation links */
header nav {
    font-family: 'Roboto', sans-serif;
    font-size: 1.1rem;
    display: flex;
    gap: 20px;
}

header nav .nav-link {
    color: #333;
    text-decoration: none;
    padding: 0.5rem 1rem;
    border-radius: 5px;
    transition: all 0.3s ease;
}

header nav .nav-link:hover {
    background-color: #f05a28;
    color: #fff;
    transform: translateY(-2px);
}

/* Hero Section Styling */
.hero-section {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 4rem 1rem;
    background-image: url('${cp}/asset/images/Screenshot 2024-12-25 141839.png');
    background-size: cover;
    background-position: center;
    height: 80vh;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);  /* Adds depth to the text */
}

.hero-section h2 {
    font-size: 3.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    letter-spacing: 1px;
}

.hero-section p {
    font-size: 1.2rem;
    font-weight: 400;
    max-width: 600px;
    margin: 0 auto;
}

/* Footer Styling */
footer {
    background-color: #333;
    color: #fff;
    padding: 3rem 0;
    text-align: center;
}

footer h4 {
    font-family: 'Poppins', sans-serif;
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 1.5rem;
}

footer p {
    font-family: 'Open Sans', sans-serif;
    font-size: 1rem;
}

footer .container-lg {
    display: flex;
    justify-content: space-around;
    align-items: center;
    gap: 20px;
}

footer .col-md-4 {
    flex: 1;
    padding: 1rem;
}

/* Quick Links Section */
footer .col-md-4 h4 {
    font-family: 'Poppins', sans-serif;
    font-size: 1.2rem;
    font-weight: 600;
}

/* Styling Social Media Icons */
footer .social-icons {
    display: flex;
    justify-content: center;
    gap: 20px;
    font-size: 1.5rem;
}

footer .social-icons a {
    color: #fff;
    text-decoration: none;
    transition: all 0.3s ease;
}

footer .social-icons a:hover {
    color: #f05a28;
}

/* Responsive Design */
@media (max-width: 768px) {
    header .container-lg {
        flex-direction: column;
        align-items: flex-start;
    }

    header nav {
        margin-top: 1rem;
    }

    .hero-section h2 {
        font-size: 2.5rem;
    }

    .hero-section p {
        font-size: 1rem;
    }
}
</style>

<body>
<header class="bg-light py-3 shadow-sm">
    <div class="container-lg d-flex justify-content-between align-items-center">
        <h1 class="logo mb-0">
            <a href="index.html" class="text-logo">Second Hand Bazar</a>
        </h1>
        <nav class="d-flex gap-3" aria-label="Main Navigation">
            <a href="${cp }/index" class="nav-link">Home</a>
            <a href="${cp}/login" class="nav-link">Login</a>
           
        </nav>
    </div>
</header>




<section class="hero-section text-light text-center py-5" style="background-image: url('${cp}/asset/images/Screenshot 2024-12-25 141839.png'); background-size: cover; background-position: center; height: 80vh;">
    <div class="container">
        <h2 class="display-4"><strong>Second Hand Bazar</strong></h2>
        <p class="lead">All kinds of products available for selling and buying.</p>
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
