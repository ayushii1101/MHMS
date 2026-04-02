<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Counselor Contact Us</title>
<style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #000;

            min-height: 100vh;          /* full screen height */
            display: flex;
            flex-direction: column;
        }


        .navbar {
    background-color: #6f63ff;
    height: 60px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 40px;
    box-sizing: border-box;
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
        .nav-right{
    display:flex;
    align-items:center;
    gap:30px;
}
.nav-links{
    display:flex;
    align-items:center;
}

        .nav-links a:hover {
            text-decoration: underline;
        }
.student-mini span {
    color: white;
}
        .student-mini{
            display:flex; align-items:center; gap:8px;
            background:rgba(255,255,255,0.2); padding:5px 12px;
            border-radius:20px; cursor:pointer; position:relative;
        }

        .student-mini img{ width:30px; height:30px; border-radius:50%; }

        .profile-dropdown{
            display:none; position:absolute; top:45px; right:0;
            background:white; min-width:200px; border-radius:12px;
            box-shadow:0 12px 30px rgba(0,0,0,0.25); overflow:hidden; z-index:1000;
        }

        .profile-dropdown a{
            display:block; padding:12px 18px; text-decoration:none;
            color:#333; font-size:15px;
        }

        .profile-dropdown a:hover{ background:#f1f5f9; }
        /* PURE CSS DROPDOWN - No JavaScript */
        .profile-section {
            position: relative;
            cursor: pointer;
        }

        .faculty-mini {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.2);
            padding: 8px 16px;
            border-radius: 25px;
            transition: all 0.3s;
        }

        .faculty-mini:hover {
            background: rgba(255,255,255,0.3);
        }

        /* CSS-ONLY CHECKBOX HACK */
        .profile-dropdown {
            display: none;
            position: absolute;
            top: 100%; right: 0;
            margin-top: 8px;
            min-width: 220px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 16px 40px rgba(0,0,0,0.2);
            border: 1px solid #f1f5f9;
            overflow: hidden;
            z-index: 1000;
            opacity: 0;
            transform: translateY(-8px);
            transition: all 0.25s ease-out;
        }

        /* SHOW ON HOVER */


        /* HOVER OUT DELAY (Smooth) */
        .profile-section {
            --close-delay: 0.2s;
        }

        .profile-dropdown a {
            display: block;
            padding: 16px 20px;
            color: #475569;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            border-bottom: 1px solid #f8fafc;
            transition: all 0.2s;
        }

        .profile-dropdown a:last-child { border-bottom: none; }

        .profile-dropdown a:hover {
            background: linear-gradient(90deg, #f8fafc, #f1f5f9);
            color: #6f63ff;
            padding-left: 28px;
        }
        /* MAGIC: SHOW WHEN CHECKBOX CHECKED */
        .profile-section #profileToggle:checked ~ .profile-dropdown {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }
        .toggle-checkbox {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .profile-dropdown {
                right: auto;
                left: 0;
                min-width: 200px;
            }
        }

.page-content{
    flex:1;
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

    <div class="nav-right">
        <div class="nav-links">
            <a href="CounselorDashboard.jsp">Home</a>
            <a href="CounselorAboutUs.jsp">About Us</a>
            <a href="CounselorFeatures.jsp#">Features</a>
            <a href="CounselorContactUs.jsp">Contact</a>
        </div>

    <div class="profile-section">
        <input type="checkbox" id="profileToggle" class="toggle-checkbox">
        <label for="profileToggle" class="student-mini">
            <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
            <span><%= session.getAttribute("counselorName") != null ? session.getAttribute("counselorName") : "Peer Counselor" %></span>
        </label>
        <div class="profile-dropdown" id="profileDropdown">
            <a href="<%= request.getContextPath() %>/CounselorEditProfile.jsp">Edit Profile</a>
            <a href="<%= request.getContextPath() %>/help.jsp">Help</a>
            <a href="<%= request.getContextPath() %>/feedback.jsp">Send Feedback</a>
            <a href="<%= request.getContextPath() %>/homepage.jsp">Logout</a>
        </div>
    </div>


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