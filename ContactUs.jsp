<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Contact Us – ManSparsh</title>
<style>
/* Reset & body */
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    color: #000;

    min-height: 100vh;          /* full screen height */
    display: flex;
    flex-direction: column;
}


/* NAVBAR */
.navbar {
    background-color: #6f63ff;
    height: 60px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    box-sizing: border-box;
    box-shadow: 0 2px 6px rgba(0,0,0,0.2);
}

/* LOGO */
.logo {
    color: white;
    font-size: 26px;
    font-weight: bold;
}

/* LINKS */
.nav-links a {
    color: white;
    text-decoration: none;
    margin: 0 15px;
    font-size: 16px;
}
.nav-links a:hover {
    text-decoration: underline;
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
.main{
    background-image:url("https://images.pexels.com/photos/7709189/pexels-photo-7709189.jpeg");background-size:cover;background-position:center;min-height:100vh;}

/* Contact Header */
.contact-header {
    text-align: center;
    padding: 60px 20px 20px 20px;
    color: #ffffff;   /* plain black text */
    text-shadow: 0 1px 2px rgba(0,0,0,0.8);
}
.contact-header h1 {
    font-size: 42px;
    margin-bottom: 15px;
    color: #ffffff;   /* plain black text */
    text-shadow: 0 1px 2px rgba(0,0,0,0.8);
}
.contact-header h2 {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #ffffff;   /* plain black text */
    text-shadow: 0 1px 2px rgba(0,0,0,0.8);
}
.contact-header p {
    max-width: 700px;
    margin: 10px auto;
    font-size: 18px;
    line-height: 1.6;
    color: #ffffff;   /* plain black text */
    text-shadow: 0 1px 2px rgba(0,0,0,0.8);
}

/* Contact Card */
.contact-container {
     background: rgba(255, 255, 255, 0.15);  /* Your purple #6f63ff, 15% opacity */
    //backdrop-filter: blur(10px);  
    max-width: 800px;
    margin: 40px auto;
    padding: 30px 40px;
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.3);
}

/* Contact Items */
.contact-item {
    display: flex;
    align-items: center;
    margin-bottom: 18px;
    font-size: 18px;
}
.contact-item span {
    font-weight: bold;
    color: #ffffff;
    margin-left: 10px;
}
.contact-item:hover {
    transform: translateY(-8px) scale(1.02);
    background: rgba(111, 99, 255, 0.25);
    box-shadow:
        0 20px 40px rgba(111, 99, 255, 0.4),
        0 0 20px rgba(111, 99, 255, 0.3);
    border-color: rgba(111, 99, 255, 0.7);
}
/* Privacy Line */
.privacy-line {
    text-align: center;
    margin-top: 25px;
    font-size: 16px;
    font-style: italic;
    color: #ddd;
    text-shadow: 0 1px 2px rgba(0,0,0,0.8);
}

/* Icons */
.icon {
    font-size: 22px;
    width: 30px;
}

/* Responsive */
@media(max-width:600px){
    .contact-header h1 { font-size: 32px; }
    .contact-header h2 { font-size: 18px; }
    .contact-header p { font-size: 16px; }
    .contact-container { margin: 20px; padding: 20px; }
    .contact-item { font-size: 16px; }
}
.footer-desc {
    margin-top: auto;
    width: 100%;
    text-align: center;
    background: #6f63ff;
    color: white;

    font-size: 16px;        /* smaller text */
    line-height: 0.9;      /* thinner vertical height */
    padding: 8px 0;        /* less padding = thinner bar */
}
/* EMAIL LINK HOVER */
.contact-item a {
    color: #ffffff;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.3s ease;
}

.contact-item:hover a {
    color: #6f63ff;
    text-shadow: 0 0 15px rgba(111, 99, 255, 0.8);
    transform: translateX(5px);
}

</style>

<!-- Font Awesome CDN for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

</head>
<body>

<!-- NAVBAR -->
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

<!-- CONTACT HEADER -->
<div class="main">
<div class="contact-header">
    <h1>Contact Us</h1>
    <h2>We’re here to help - reach out to ManSparsh anytime.</h2>
   
    <div class="intro-text">
        <p>Whether you have a question, need guidance, or want to know more about our support services, we’re just one message away.</p>
    </div>
</div>

<!-- CONTACT DETAILS -->
<div class="contact-container">
   
    <div class="contact-item">
        <i class="fas fa-envelope icon"></i>
        <span>Email Us:</span>
        <a href="https://mail.google.com/mail/?view=cm&fs=1&to=mansparshhelp@gmail.com"
   target="_blank"
   style="color:#fff; text-decoration:none;">mansparshhelp@gmail.com</a>
    </div>
   
    <div class="privacy-line">
        Your privacy matters. All conversations and queries are kept strictly confidential.
    </div>
</div>
</div>
<footer class="footer-desc">
             © 2026 ManSparsh Online Counseling &amp; Therapy. All rights reserved.
         </footer>
</body>
</html>