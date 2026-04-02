<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Features</title>

<style>
body{
    margin:0;
    font-family: Arial, sans-serif;
    background: linear-gradient(to right, #6f63ff, #9b8cff);
    color: white;
}

.banner{
    width: 100%;
    height: 280px;          /* thin & stylish */
    background-image: url("images/about_banner1.png");  /* apni image ka path */
    background-size: cover;
    background-position: top center;
    background-repeat: no-repeat;
}

/* NAVBAR */
.navbar {
    background-color: #6f63ff;   /* same purple as home */
    height: 60px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    box-sizing: border-box;
}


.logo {
    color: white;
    font-size: 26px;
    font-weight: bold;
}

.nav-links a {
    color: white;
    text-decoration: none;
    margin: 0 15px;
    font-size: 16px;
}

/* LOGIN DROPDOWN */
.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown > a {
    cursor: pointer;
}

/* Hidden menu */
.dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 180px;
    top: 100%;       /* instead of 45px */
    right: 0;
    border-radius: 6px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    z-index: 9999;
}


/* Links inside dropdown */
.dropdown-content a {
    color: #333;
    padding: 12px 16px;
    display: block;
    text-decoration: none;
    font-size: 14px;
}

.dropdown-content a:hover {
    background-color: #f1f1f1;
}

/* Show dropdown on hover */
.dropdown:hover .dropdown-content {
    display: block;
}
.dropdown > a {
    cursor: pointer;
    padding: 20px 15px;   /* hover area bada ho jayega */
    display: inline-block;
}

/* MAIN */
.container{
    padding:60px 10%;
    text-align:center;
}

.container h1{
    font-size:48px;
    margin-bottom:10px;
}

.tagline{
    font-size:20px;
    margin-bottom:50px;
    opacity:0.9;
}

/* CARD GRID */
.cards{
    display:grid;
    grid-template-columns: repeat(auto-fit, minmax(250px,1fr));
    gap:30px;
}

.card{
    background:white;
    color:#333;
    padding:30px;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(0,0,0,0.2);
    transition:0.3s;
}

.card:hover{
    transform: translateY(-10px);
}

.card h3{
    color:#6f63ff;
    margin-bottom:10px;
}

/* FOOTER */
.footer-desc{
            max-width: 100vw;
            margin: 0 auto;
            font-size: 16px;
            line-height: 1.7;
            text-align: center;
            background: #6f63ff;
            color: white;
            display: flex;
            justify-content: center;   /* Horizontal centering of flex items */
        }
</style>

</head>
<body>

<div class="navbar">
    <div class="logo">ManSparsh</div>
    <div class="nav-links">
        <a href="Home Page.jsp">Home</a>
        <a href="AboutUs.jsp">About Us</a>
        <a href="Features.jsp">Features</a>
        <div class="dropdown">
        <a>Login</a>
        <div class="dropdown-content">
            <a href="StudentLogin.jsp">Student</a>
            <a href="CounselorLogin.jsp">Counselor</a>
            <a href="FacultyLogin.jsp">Faculty</a>
        </div>
        </div>
        <a href="ContactUs.jsp">Contact Us</a>
    </div>
</div>
<div class="banner"></div>  
<div class="container">
    <h1>Features</h1>
    <p class="tagline">A safe digital space for your mind, emotions, and well-being </p>
    <div class="cards">

        <div class="card">
            <h3>Safe Space</h3>
            <p>ManSparsh provides a safe space where students can seek help without hesitation.</p>
        </div>

        <div class="card">
            <h3>Self-Assessment</h3>
            <p>Chat-based tools help identify early signs of stress, anxiety, or depression.</p>
        </div>

        <div class="card">
            <h3>Professional Help</h3>
            <p>Connect with counselors through text, video, call, or in-person consultancy.</p>
        </div>

        <div class="card">
            <h3>Resource Library</h3>
            <p>Access articles, coping strategies, and motivational content designed for students.</p>
        </div>

        <div class="card">
            <h3>Workshops & Events</h3>
            <p>Get notified about mental wellness workshops, therapy camps, and stress-management programs.</p>
        </div>
        
        <div class="card">
            <h3>Privacy & Trust</h3>
            <p>We ensure complete confidentiality and data privacy for every user.</p>
        </div>

        <div class="card">
            <h3>Our Mission</h3>
            <p>To prevent students from falling into depression by creating a supportive digital ecosystem.</p>
        </div>

    </div>
</div>

<footer class="footer-desc">
             © 2026 ManSparsh Online Counseling &amp; Therapy. All rights reserved.
         </footer>

</body>
</html>