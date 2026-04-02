<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Privacy & Security</title>

<style>
body{
    margin:0;
    font-family: "Segoe UI", Arial, sans-serif;
    background: linear-gradient(135deg, #ede9fe, #e0ecff, #f5f3ff);
}

/* NAVBAR */
.navbar{
    background:#6f63ff;
    height:60px;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 40px;
    color:white;
}

.logo{
    font-size:26px;
    font-weight:bold;
}

.nav-right{
    display:flex;
    align-items:center;
    gap:20px;
}

.nav-links a{
    color:white;
    text-decoration:none;
    margin:0 12px;
    font-size:16px;
}

/* CONTENT */
.container{
    max-width:900px;
    margin:40px auto;
    background:white;
    padding:30px;
    border-radius:16px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

.container h2{
    color:#1e3a8a;
}

.container h3{
    margin-top:20px;
    color:#374151;
}

.container p, .container li{
    font-size:14px;
    color:#4b5563;
    line-height:1.6;
}

/* FOOTER */
.footer{
    background:#6f63ff;
    color:white;
    text-align:center;
    padding:20px;
    font-size:14px;
    margin-top:40px;
}
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">ManSparsh</div>

    <div class="nav-right">
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/dashboard.jsp">Home</a>
            <a href="<%= request.getContextPath() %>/FacultyAboutUs.jsp">About Us</a>
            <a href="<%= request.getContextPath() %>/FacultyFeatures.jsp">Features</a>
            <a href="<%= request.getContextPath() %>/FacultyContactUs.jsp">Contact</a>
        </div>
    </div>
</div>

<!-- CONTENT -->
<div class="container">

    <h2><center>Privacy & Security</center></h2>

<p>Your privacy and data security are important to us. Mansparsh follows responsible practices to protect user information, especially given the sensitive nature of mental health data.</p>

<h3>Account Security</h3>
<ul>
<li>Passwords are securely stored using hashing techniques and are not readable in plain text</li>
<li>Users can update their passwords at any time</li>
<li>The system limits incorrect login attempts to prevent unauthorized access</li>
<li>Users are advised not to share their login credentials with others</li>
</ul>

<h3>Data Privacy & Access Control</h3>
<ul>
<li>Students can access only their own data</li>
<li>Faculty can access data of assigned students only</li>
<li>Senior faculty can access cases referred by counselors</li>
<li>Student symptoms are visible only to assigned therapists</li>
<li>Therapist notes are private and not visible to students</li>
</ul>

<h3>System Security Measures</h3>
<ul>
<li>User data is stored in a secure MySQL database</li>
<li>Access to data is restricted to authorized administrative personnel</li>
<li>Password hashing is implemented for secure authentication</li>
<li>Standard security practices are followed to protect system integrity</li>
</ul>

<h3>Communication Security</h3>
<ul>
<li>Emails are sent only for appointment-related updates</li>
<li>No sensitive personal or mental health information is shared through email</li>
</ul>

<h3>Session & Platform Safety</h3>
<ul>
<li>The platform uses session-based authentication for secure login handling</li>
<li>Users should log out after using shared or public devices</li>
</ul>

<h3>User Responsibilities</h3>
<ul>
<li>Use strong and secure passwords</li>
<li>Avoid sharing account details with others</li>
<li>Access the platform only from trusted devices</li>
<li>Log out after each session, especially on shared systems</li>
</ul>

<h3>Your Control Over Data</h3>
<ul>
<li>Users can update and manage their personal information</li>
<li>Account deletion or data removal is not currently available but may be added in future updates</li>
</ul>

<h3>Transparency & Limitations</h3>
<p>While Mansparsh implements reasonable security measures to protect user data, no system can guarantee complete security. Users are encouraged to follow safe practices while using the platform.</p>

</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 ManSparsh Online Counseling & Therapy. All rights reserved.
</div>

</body>
</html>