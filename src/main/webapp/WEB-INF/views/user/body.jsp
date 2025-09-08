<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shop Collections</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --electric-blue: #00f5d4;
        --hot-pink: #ff006e;
        --deep-purple: #8338ec;
        --neon-yellow: #ffbe0b;
        --dark-bg: #1a1a2e;
    }
    
    body {
        font-family: 'Poppins', sans-serif;
        background-color: var(--dark-bg);
        color: white;
        overflow-x: hidden;
    }
    
    .section {
        padding: 5rem 0;
        perspective: 1000px;
    }
    
    .collection-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 2rem;
        transform-style: preserve-3d;
    }
    
    .shop {
        position: relative;
        height: 400px;
        border-radius: 20px;
        overflow: hidden;
        transform-style: preserve-3d;
        transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        box-shadow: 0 0 30px rgba(0, 0, 0, 0.3);
    }
    
    .shop:nth-child(1) { border: 3px solid var(--electric-blue); }
    .shop:nth-child(2) { border: 3px solid var(--hot-pink); }
    .shop:nth-child(3) { border: 3px solid var(--neon-yellow); }
    
    .shop:hover {
        transform: translateY(-20px) rotateX(5deg);
        box-shadow: 0 30px 50px rgba(0, 0, 0, 0.5);
    }
    
    .shop-img {
        position: absolute;
        width: 100%;
        height: 100%;
        filter: brightness(0.7);
        transition: all 0.5s ease;
    }
    
    .shop:hover .shop-img {
        filter: brightness(1);
        transform: scale(1.1);
    }
    
    .shop-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .shop-body {
        position: absolute;
        bottom: 0;
        width: 100%;
        padding: 2rem;
        background: linear-gradient(to top, rgba(0,0,0,0.9), transparent);
        transform: translateZ(30px);
    }
    
    .shop-body h3 {
        font-size: 2.5rem;
        font-weight: 800;
        margin-bottom: 1rem;
        text-transform: uppercase;
        letter-spacing: 2px;
        background: linear-gradient(90deg, 
            var(--electric-blue), 
            var(--hot-pink), 
            var(--neon-yellow));
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent;
        text-shadow: 0 0 10px rgba(255,255,255,0.3);
    }
    
    .cta-btn {
        display: inline-flex;
        align-items: center;
        padding: 12px 30px;
        background: transparent;
        color: white;
        border: 2px solid white;
        border-radius: 50px;
        font-weight: 600;
        text-decoration: none;
        overflow: hidden;
        position: relative;
        transition: all 0.5s ease;
    }
    
    .cta-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: all 0.5s ease;
    }
    
    .cta-btn:hover {
        background: white;
        color: var(--dark-bg);
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.3);
    }
    
    .cta-btn:hover::before {
        left: 100%;
    }
    
    .cta-btn i {
        margin-left: 10px;
        transition: all 0.3s ease;
    }
    
    .cta-btn:hover i {
        transform: translateX(5px) rotate(90deg);
    }
    
    /* Glitch effect on hover */
    .shop:hover h3::before {
        content: attr(data-text);
        position: absolute;
        left: -2px;
        text-shadow: 2px 0 var(--electric-blue);
        clip: rect(0, 900px, 0, 0);
        animation: glitch-effect 3s infinite linear alternate-reverse;
    }
    
    @keyframes glitch-effect {
        0% { clip: rect(30px, 9999px, 50px, 0) }
        20% { clip: rect(10px, 9999px, 30px, 0) }
        40% { clip: rect(50px, 9999px, 30px, 0) }
        60% { clip: rect(20px, 9999px, 60px, 0) }
        80% { clip: rect(40px, 9999px, 20px, 0) }
        100% { clip: rect(70px, 9999px, 40px, 0) }
    }
    
    /* Responsive design */
    @media (max-width: 992px) {
        .collection-grid {
            grid-template-columns: 1fr;
        }
        
        .shop {
            height: 300px;
        }
        
        .shop-body h3 {
            font-size: 2rem;
        }
    }
</style>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
</head>
<body>
    
    <div class="section">
        <div class="container">
            <div class="collection-grid">
                <div class="shop">
                    <div class="shop-img">
                        <img src="${cp}/asset/img/shop01.png" alt="Laptop Collection">
                    </div>
                    <div class="shop-body">
                        <h3 data-text="Laptop Collection">Computers Collection</h3>
                        <a href="${cp}/user/product/allproducts/${user.id}" class="cta-btn">
                            Explore <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
                
                <div class="shop">
                    <div class="shop-img">
                        <img src="${cp}/asset/img/shop03.png" alt="Accessories Collection">
                    </div>
                    <div class="shop-body">
                        <h3 data-text="Accessories Collection">Electronics Collection</h3>
                        <a href="${cp}/user/product/allproducts/${user.id}" class="cta-btn">
                            Explore <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
                
                <div class="shop">
                    <div class="shop-img">
                        <img src="${cp}/asset/img/shop02.png" alt="Cameras Collection">
                    </div>
                    <div class="shop-body">
                        <h3 data-text="Cameras Collection">Cameras Collection</h3>
                        <a href="${cp}/user/product/allproducts/${user.id}" class="cta-btn">
                            Explore <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Add parallax effect on mouse move
        document.addEventListener('mousemove', function(e) {
            const shops = document.querySelectorAll('.shop');
            shops.forEach(shop => {
                const speed = shop.getAttribute('data-speed') || 10;
                const x = (window.innerWidth - e.pageX * speed) / 100;
                const y = (window.innerHeight - e.pageY * speed) / 100;
                shop.style.transform = `translateY(-20px) rotateX(${y}deg) rotateY(${x}deg)`;
            });
        });
    </script>
</body>
</html>