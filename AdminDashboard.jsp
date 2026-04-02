<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>ManSparsh Admin</title>
<style>
html, body {
    height: 100%;
    margin: 0;
    font-family: 'Segoe UI', Arial, sans-serif;
}
body {
    background:
        linear-gradient(rgba(0,0,0,0.45), rgba(0,0,0,0.45)),
        url("https://images.unsplash.com/photo-1521791136064-7986c2920216?auto=format&fit=crop&w=1920&q=90")
        no-repeat center center fixed;
    background-size: cover;
}
.layout { display:flex; min-height:100vh; backdrop-filter:blur(2px); }
.sidebar { width:240px; background:rgba(30,42,72,0.95); color:white; padding:20px; }
.sidebar h2 { text-align:center; color:#9ecbff; margin-bottom:30px; }
.sidebar a { display:block; padding:12px; border-radius:8px; color:white; text-decoration:none; margin-bottom:10px; transition:0.3s; }
.sidebar a:hover { background:#3d5af1; }

.main { flex:1; padding:20px 30px; display:flex; flex-direction:column; }

.topbar {
    display:flex; justify-content:space-between; align-items:center;
    background:rgba(255,255,255,0.9); padding:12px 20px;
    border-radius:14px; margin-bottom:20px;
}
.search { width:50%; padding:10px 15px; border-radius:20px; border:1px solid #ccc; }

.profile { display:flex; align-items:center; cursor:pointer; position:relative; }
.profile img { width:40px; height:40px; border-radius:50%; margin-right:8px; }

.dropdown{
    position:fixed; top:70px; right:40px;
    background:white; box-shadow:0 4px 10px rgba(0,0,0,0.15);
    border-radius:8px; display:none; min-width:150px; z-index:1000;
}
.dropdown a{ display:block; padding:10px; text-decoration:none; color:#333; }
.dropdown a:hover{ background:#f0f0f0; }
.profile:hover .dropdown{ display:block; }

.cards { display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:18px; margin-bottom:20px; }
.card {
    background:rgba(255,255,255,0.92); padding:22px; border-radius:16px;
    box-shadow:0 6px 15px rgba(0,0,0,0.2); text-align:center;
    transition:0.3s ease;
}
.card:hover {
    transform: translateY(-6px) scale(1.02);
    box-shadow: 0 10px 22px rgba(0,0,0,0.3);
}
.card h2{ margin:0; font-size:32px; color:#3d5af1; }
.card p{ margin-top:6px; font-size:14px; color:#555; }

.section{ display:grid; grid-template-columns:2fr 1fr; gap:20px; flex:1; }
.box{
    background:rgba(255,255,255,0.92); padding:20px; border-radius:16px;
    box-shadow:0 4px 12px rgba(0,0,0,0.2);
}

table{ width:100%; border-collapse:collapse; }
th,td{ padding:10px; border-bottom:1px solid #ddd; }
th{ background:#eef2ff; }

.status{ padding:5px 10px; border-radius:10px; font-size:12px; color:white; }
.confirmed{ background:#4caf50; }
.pending{ background:#ff9800; }
.completed{ background:#2196f3; }

footer{ text-align:center; color:white; margin-top:20px; font-size:14px; }
</style>
</head>

<body>
<div class="layout">

<div class="sidebar">
    <h2>ManSparsh Admin</h2>
    <a href="AdminManageUser.jsp">User Management</a>
    <a href="AdminAppointment.jsp">Appointments</a>
    <a href="AdminManageHostel.jsp">Hostel Management</a>
    <a href="AdminManageResources.jsp">Resources</a>
    <a href="AdminFeedback.jsp">Feedback</a>
    <a href="AdminSettings.jsp">Settings</a>
    <a href="Home Page.jsp">Logout</a>
</div>

<div class="main">

<div class="topbar">
    <input class="search" placeholder="Search...">

    <div class="profile">
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Admin">
        <span>Admin</span>

        <div class="dropdown">
            <a href="#">Profile</a>
            <a href="#">Change Password</a>
            <a href="#">Logout</a>
        </div>
    </div>
</div>

<div class="cards">
    <div class="card"><h2>1200</h2><p>Total Students</p></div>
    <div class="card"><h2>35</h2><p>Total Counselors</p></div>
    <div class="card"><h2>28</h2><p>Today's Appointments</p></div>
    <div class="card"><h2>5</h2><p>Pending Approvals</p></div>
    <div class="card"><h2>120</h2><p>Feedback Received</p></div>
</div>

<div class="section">
<div class="box">
<h3>Recent Appointments</h3>
<table>
<tr><th>Student</th><th>Counselor</th><th>Date</th><th>Status</th></tr>
<tr><td>A. Sharma</td><td>Dr. Verma</td><td>Apr 23</td><td><span class="status confirmed">Confirmed</span></td></tr>
<tr><td>K. Patel</td><td>Ms. Kapoor</td><td>Apr 22</td><td><span class="status completed">Completed</span></td></tr>
<tr><td>M. Singh</td><td>Dr. Mehta</td><td>Apr 21</td><td><span class="status pending">Pending</span></td></tr>
</table>
</div>
</div>

<footer>© 2026 ManSparsh Online Counseling &amp;Therapy.All rights reserved.</footer>

</div>
</div>
</body>
</html>
