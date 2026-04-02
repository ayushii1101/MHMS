<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Help & Support</title>

<style>
body {
    font-family: "Segoe UI", Arial, sans-serif;
    background: linear-gradient(to right, #e0ecff, #f7faff);
}

.container {
    max-width: 900px;
    margin: 50px auto;
    padding: 0 20px;
}

.header {
    background: white;
    padding: 28px;
    border-radius: 18px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    margin-bottom: 25px;
    text-align: center;
}

.header h2 {
    margin: 0 0 10px;
    color: #1e3a8a;
}

.header p {
    color: #6b7280;
    font-size: 14px;
}

.search input {
    width: 100%;
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #d1d5db;
    margin-top: 15px;
    font-size: 14px;
}

.grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}

.card {
    background: white;
    padding: 22px;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.06);
    transition: 0.2s;
}

.card:hover {
    transform: translateY(-3px);
}

.card h3 {
    margin: 0 0 8px;
    color: #1f2937;
}

.card p {
    font-size: 14px;
    color: #6b7280;
}

.faq {
    margin-top: 30px;
    background: white;
    padding: 22px;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.06);
}

.faq h3 {
    margin-bottom: 12px;
    color: #1e3a8a;
}

.faq-item {
    padding: 10px 0;
    border-bottom: 1px solid #e5e7eb;
    font-size: 14px;
}

.faq-item:last-child {
    border-bottom: none;
}

.contact {
    margin-top: 30px;
    background: #2563eb;
    color: white;
    padding: 24px;
    border-radius: 16px;
    text-align: center;
}

.contact a {
    color: white;
    font-weight: bold;
    text-decoration: underline;
}
</style>
</head>

<body>

<div class="container">

<div class="header">
<h2>Help & Support</h2>

</div>

<div class="grid">
<div class="card">
<h3>Account Help</h3>
<p>Manage login, password, and profile settings.</p>
</div>

<div class="card">
<h3>Appointments</h3>
<p>Booking, rescheduling, and cancellation support.</p>
</div>

<div class="card">
<h3>Notifications</h3>
<p>Learn how to manage alerts and reminders.</p>
</div>

<div class="card">
<h3>Privacy & Security</h3>
<p>Understand how your data is protected.</p>
</div>
</div>

<div class="faq">
<h3>Frequently Asked Questions</h3>

<div class="faq-item">
<b>How do I reset my password?</b><br>
Go to Account → Settings → Change Password.
</div>

<div class="faq-item">
<b>Why am I not receiving notifications?</b><br>
Check notification settings and ensure they are enabled.
</div>

<div class="faq-item">
<b>How can I contact support?</b><br>
Use the contact section below.
</div>

</div>

<div class="contact">
<h3>Need more help?</h3>
<p>Email us at <a href="mansparshhelp@gmail.com">mansparshhelp@gmail.com</a></p>
</div>

</div>

</body>
</html>
