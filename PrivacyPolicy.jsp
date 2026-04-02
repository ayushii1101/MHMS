<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Privacy Policy</title>

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

/* MAIN CONTENT CONTAINER */
.policy-container{
    max-width:900px;
    margin:40px auto;
    background:white;
    padding:30px;
    border-radius:16px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
}

/* TYPOGRAPHY */
.policy-container h2{
    color:#1e3a8a;
    margin-bottom:10px;
}

.policy-container h3{
    margin-top:20px;
    color:#374151;
}

.policy-container p{
    font-size:14px;
    color:#4b5563;
    line-height:1.6;
}

.policy-container ul{
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
<div class="policy-container">

    <h2><center>Privacy Policy</center></h2>

<p>Mansparsh is a mental health support platform designed for students of Banasthali Vidyapith. We are committed to protecting the privacy and confidentiality of our users, especially given the sensitive nature of mental health information.</p>

<h3>1. Information We Collect</h3>

<p><b>a) Personal Information:</b><br>
We collect basic user details including name, college email address, and phone number during account registration.</p>

<p><b>b) Account Security Information:</b><br>
User passwords are securely stored in hashed form and are not accessible in plain text.</p>

<p><b>c) Sensitive Information:</b><br>
Users may provide information related to their mental health, including symptoms and concerns. We also store appointment and session-related history. This data is considered sensitive and is handled with additional care.</p>

<h3>2. How We Use Information</h3>

<p>We use the collected information for the following purposes:</p>
<ul>
<li>To facilitate appointment booking and management</li>
<li>To share relevant information with assigned therapists</li>
<li>To send appointment-related email notifications</li>
<li>To improve platform functionality and user experience</li>
</ul>

<h3>3. Data Sharing</h3>

<p>We do not sell or distribute user data to third parties.</p>

<p>Information may be shared in the following cases:</p>
<ul>
<li>With assigned therapists, including user name, appointment details, and symptoms</li>
<li>When required by applicable law or legal processes</li>
<li>In situations involving potential risk to user safety or others</li>
</ul>

<h3>4. Confidentiality</h3>

<p>Mansparsh respects the confidentiality of all users. Information shared during sessions is treated as confidential. Therapists are expected to maintain professional confidentiality standards.</p>

<p>However, confidentiality may be limited in situations involving legal obligations or safety concerns.</p>

<h3>5. Data Storage and Security</h3>

<p>User data is stored in a secured database environment with restricted administrative access. Passwords are encrypted using hashing techniques, and session-based authentication is used to maintain secure access.</p>

<p>While we take reasonable measures to protect data, no system can guarantee absolute security.</p>

<h3>6. User Rights</h3>

<p>Users can update and manage their profile information within the platform. At present, account deletion or data removal requests are not supported but may be introduced in future updates.</p>

<h3>7. Cookies and Sessions</h3>

<p>Mansparsh uses session-based tracking to manage user authentication and login states. No unnecessary tracking or third-party analytics tools are used.</p>

<h3>8. Emergency and Safety</h3>

<p>This platform provides mental health support but does not replace emergency medical services. In critical situations, users are advised to contact appropriate emergency services.</p>

<p>Emergency contact support may be provided where applicable.</p>

<h3>9. Changes to This Policy</h3>

<p>We may update this Privacy Policy from time to time. Any changes will be reflected on this page.</p>

<h3>10. Contact Us</h3>

<p>For any questions or concerns regarding this Privacy Policy, please contact us at:<br>
mansparshhelp@gmail.com</p>

</div>

<!-- FOOTER -->
<div class="footer">
    © 2026 ManSparsh Online Counseling & Therapy. All rights reserved.
</div>

</body>
</html>