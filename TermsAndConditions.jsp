<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Terms & Conditions</title>

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

/* MAIN CONTENT */
.terms-container{
    max-width:900px;
    margin:40px auto;
    background:white;
    padding:30px;
    border-radius:16px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

/* TEXT STYLING */
.terms-container h2{
    color:#1e3a8a;
}

.terms-container h3{
    margin-top:20px;
    color:#374151;
}

.terms-container p{
    font-size:14px;
    color:#4b5563;
    line-height:1.6;
}

.terms-container ul{
    margin-left:18px;
    color:#4b5563;
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
<div class="terms-container">

    <h2><center>Terms & Conditions</center></h2>

<p>Welcome to Mansparsh. By accessing or using this platform, you agree to comply with and be bound by the following Terms and Conditions. Mansparsh is a mental health support system designed exclusively for students of Banasthali Vidyapith.</p>

<h3>1. Eligibility</h3>
<p>This platform is intended only for students of Banasthali Vidyapith. Users must register using a valid college email address and provide accurate information. Providing false information may lead to account suspension.</p>

<h3>2. User Responsibilities</h3>
<ul>
<li>Users must provide accurate and truthful information</li>
<li>Users must not engage in abusive, harmful, or inappropriate behavior</li>
<li>Users are expected to maintain respectful communication with therapists</li>
</ul>

<h3>3. Account Rules</h3>
<p>User accounts are personal and must not be shared with others. Mansparsh reserves the right to suspend or restrict accounts in case of misuse or violation of these terms.</p>

<h3>4. Appointment and Booking Rules</h3>
<ul>
<li>Users can book, cancel, or reschedule appointments</li>
<li>Appointments cannot be scheduled within 1 hour of the desired time</li>
<li>In case of a missed session (no-show), the system may automatically reschedule and notify the user via email with available options</li>
</ul>

<h3>5. Therapist and Service Disclaimer</h3>
<p>All therapists available on the platform are university-approved professionals. Mansparsh provides mental health support and guidance but does not offer medical diagnosis or treatment.</p>

<h3>6. Emergency Disclaimer</h3>
<p>This platform is not intended for emergency situations. In case of a mental health crisis or emergency, users are advised to contact appropriate emergency services immediately.</p>

<h3>7. Limitation of Liability</h3>
<p>Mansparsh is not responsible for any outcomes resulting from therapy sessions or user decisions. The platform does not assume liability for emotional, psychological, or personal outcomes experienced by users.</p>

<h3>8. Privacy Policy</h3>
<p>Use of this platform is also governed by our Privacy Policy. Users are encouraged to review it to understand how their data is handled.</p>

<h3>9. Intellectual Property</h3>
<p>All content, design, and branding of Mansparsh are the property of the platform and may not be copied, reproduced, or reused without permission.</p>

<h3>10. Changes to Terms</h3>
<p>Mansparsh reserves the right to update or modify these Terms and Conditions at any time. Continued use of the platform after changes implies acceptance of the updated terms.</p>

<h3>11. Contact</h3>
<p>For any questions or concerns regarding these Terms and Conditions, please contact:<br>
mansparshhelp@gmail.com</p>

</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 ManSparsh Online Counseling & Therapy. All rights reserved.
</div>

</body>
</html>
