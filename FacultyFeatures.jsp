<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Features</title>

<style>
body{ margin:0; font-family:Arial, sans-serif; background: linear-gradient(to right, #6f63ff, #9b8cff); color: white;}
.banner{
    width: 100%;
    height: 280px;          /* thin & stylish */
    background-image: url("images/about_banner1.png");  /* apni image ka path */
    background-size: cover;
    background-position: top center;
    background-repeat: no-repeat;
}
.navbar{
    background:#6f63ff; height:60px; display:flex;
    align-items:center; justify-content:space-between;
    padding:0 40px; color:white; position:relative;
}

.logo{ font-size:26px; font-weight:bold; }
.nav-right{ display:flex; align-items:center; gap:20px; }

.nav-links a{
    color:white; text-decoration:none; margin:0 12px; font-size:16px;
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

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">ManSparsh</div>

    <div class="nav-right">
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/FacultyDashboard.jsp">Home</a>
            <a href="<%= request.getContextPath() %>/FacultyAboutUs.jsp">About Us</a>
            <a href="<%= request.getContextPath() %>/FacultyFeatures.jsp">Features</a>
            <a href="<%= request.getContextPath() %>/FacultyContactUs.jsp">Contact</a>
        </div>

   <div class="profile-section">
    <input type="checkbox" id="profileToggle" class="toggle-checkbox">
    <label for="profileToggle" class="student-mini">
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
       <span><%= session.getAttribute("userRole") != null ? session.getAttribute("userRole") : "Faculty" %></span>
    </label>
    <!-- Dropdown appears on hover -->
    <div class="profile-dropdown" id="profileDropdown">
        <a href="<%= request.getContextPath() %>/FacultyEditProfile.jsp"> Edit Profile</a>
        <a href="<%= request.getContextPath() %>/help.jsp">Help</a>
        <a href="<%= request.getContextPath() %>/feedback.jsp">Send Feedback</a>
        <a href="<%= request.getContextPath() %>/Home Page.jsp">Logout</a>
    </div>
</div>

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
