<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.Date" %>
<%@ page session="false" %>

<%
Calendar now = Calendar.getInstance();
    Calendar cal = (Calendar) now.clone();
    cal.set(Calendar.DAY_OF_MONTH, 1);  // First day of month
    
    int year = cal.get(Calendar.YEAR);
    int monthNum = cal.get(Calendar.MONTH) + 1;  // 1-12
    String monthName = cal.getDisplayName(Calendar.MONTH, Calendar.SHORT, java.util.Locale.getDefault());

    int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    
    // Corrected startOffset: number of empty cells before day 1 (Sun=1 start)
    int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);  // 1=Sun, 2=Mon, ..., 7=Sat
    int startOffset = (firstDayOfWeek == Calendar.SUNDAY) ? 0 : firstDayOfWeek - 1;
    
    // today for comparison
    int todayDay = now.get(Calendar.DAY_OF_MONTH);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Faculty Dashboard | ManSparsh</title>

<style>
body{ margin:0; font-family:Arial, sans-serif; background:#f4f6fb; }

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

.main1{
    padding:40px;
    background-size:cover; background-position:center; min-height:100vh;
}

.welcome-title{
    text-align:center; font-size:34px; color:#2d3748;
    margin-bottom:35px; font-weight:600;
}

.cards{
    display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:25px;
}

.card{
    background:white; padding:25px; border-radius:14px;
    text-align:center; box-shadow:0 8px 20px rgba(0,0,0,0.08);
    transition:0.3s;
}

.card:hover{ transform:translateY(-8px) scale(1.02); }

.card button{
    margin-top:14px; padding:9px 22px; border:none;
    border-radius:20px; background:#6c63ff; color:white; cursor:pointer;
}

.footer{
    background:#2d3748; color:white; text-align:center;
    padding:20px; font-size:14px;
}

/* MAIN LAYOUT */
.main{
    padding:40px;
    display:flex;
    gap:30px;
    min-height: calc(100vh - 100px);
}


/* LEFT CONTENT */
.left-panel2{
    flex:3;
}

/* DASHBOARD BUTTONS */
.cards{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:25px;
}

.card{
    background:white;
    padding:25px;
    border-radius:12px;
    text-align:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
    cursor:pointer;
}

.card:hover{
    transform:translateY(-5px);
}

.card button,
.card .btn,
.card a[href] {
    all: unset;
    flex-shrink: 0;                 /* Never shrinks */
    width: 100%;
    height: 56px;                   /* LARGER + uniform */
    margin-top: auto;               /* Bottom aligned */
    border-radius: 24px;
    background: linear-gradient(135deg, #6f63ff, #8b7eff);
    color: white !important;
    font-size: 16px;                /* Slightly larger */
    font-weight: 600;
    line-height: 56px;
    text-align: center;
    cursor: pointer;
    text-decoration: none !important;
    box-shadow: 0 6px 20px rgba(111, 99, 255, 0.3);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* NOTES */
.notes{
    margin-top:40px;
    background:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
}

.notes textarea{
    width:100%;
    height:100px;
    padding:10px;
    margin-top:10px;
}

.notes button{
    margin-top:10px;
    padding:8px 18px;
    border:none;
    background:#6f63ff;
    color:white;
    border-radius:15px;
}



/* RIGHT PANEL */
.right-panel{
    flex:1;
}

/* CALENDAR */
.calendar{
    background:white;
    padding:20px;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
}

.calendar h3{
    margin-bottom:10px;
}

.calendar-header{
    display:grid;
    grid-template-columns:repeat(7,1fr);
    font-size:12px;
    text-align:center;
    color:#666;
}

.calendar-grid{
    display:grid;
    grid-template-columns:repeat(7,1fr);
    gap:6px;
    margin-top:10px;
}

.day{
    padding:8px;
    background:#f2f3f8;
    border-radius:6px;
    text-align:center;
    font-size:13px;
}

.session{
    background:#6f63ff;
    color:white;
    font-weight:bold;
}
.calendar {
    background: #ffffff;
    padding: 16px;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.06);
}

.calendar-header,
.calendar-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    text-align: center;
}

.calendar-header div {
    font-weight: 600;
    font-size: 13px;
    color: #666;
    padding-bottom: 6px;
}

.calendar-grid {
    gap: 8px;
    margin-top: 8px;
}

.day {
    background: #eef5ff;
    padding: 10px 0;
    border-radius: 10px;
    text-decoration: none;
    color: #333;
    font-size: 14px;
}

.day:hover {
    background: #cfe3ff;
}

.today {
    background: #bcdcff;
    font-weight: bold;
}

.empty {
    visibility: hidden;
}
.dashboard-bg {
    min-height: 100vh;
    background:
        
        url("https://images.unsplash.com/photo-1728931710303-b14d84dc1550?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
    background-size: cover;
    background-position: center;
}
/* Testimonials Section */

.testimonial-subtitle {
    color: #0d6efd;   /* strong blue */
    font-weight: 600;
    letter-spacing: 1.5px;
    font-size: 14px;
}

.testimonial-title {
    color: #1f2937;   /* dark gray */
    font-size: 36px;
    font-weight: 700;
    margin: 10px 0;
}

.testimonial-desc {
    color: #4b5563;   /* readable gray */
    max-width: 750px;
    margin: 0 auto;
    font-size: 16px;
    line-height: 1.7;
    text-align: center;
}

.testimonial-line {
    width: 80px;
    height: 3px;
    background: #0d6efd;
    margin: 25px auto 0;
}
.testimonials-section {
    width: 100%;
    padding: 50px 20px;
    text-align: center;

    /* VISIBILITY FIX */
    
    backdrop-filter: blur(4px);
    background: rgba(255, 255, 255, 0.88);
    border-top: 1px solid #e0e0e0;
}
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
 <div class="dashboard-bg">
    
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
       <span><%= session.getAttribute("facultyName") != null ? session.getAttribute("facultyName") : "Faculty" %></span>
    </label>
    <!-- Dropdown appears on hover -->
    <div class="profile-dropdown" id="profileDropdown">
        <a href="<%= request.getContextPath() %>/FacultyEditProfile.jsp"> Edit Profile</a>
        <a href="<%= request.getContextPath() %>/FacultyHelp.jsp">Help</a>
        <a href="<%= request.getContextPath() %>/feedback.jsp">Send Feedback</a>
        <a href="<%= request.getContextPath() %>/Home Page.jsp">Logout</a>
    </div>
</div>

    </div>
</div>


<div class="main">

    <!-- LEFT -->
    <div class="left-panel2">

        <div class="cards">
            <div class="card">
                <h3>Referred Cases</h3>
                <a href="<%= request.getContextPath() %>/FacultyReferredCases.jsp"
                   class="session-btn">
                <button>View Cases</button>
                </a>
            </div>

            <div class="card">
                <h3>Past Appointments</h3>
                <a href="<%= request.getContextPath() %>/FacultyAppointments.jsp"
       class="session-btn">
        <button>View</button>
    </a>            
            </div>
           
            <div class="card">
                <h3>Session Notes</h3>
                <a href="<%= request.getContextPath() %>/FacultySessionNotes.jsp"
                   class="session-btn">
                <button>View Notes</button>
                </a>
            </div>
                   
                    <div class="card">
                <h3>Workshops</h3>
                <a href="<%= request.getContextPath() %>/FacultyWorkshops.jsp"
                   class="session-btn">
                <button>View Workshop</button>
                </a>
            </div>
                       <div class="card">
                <h3>Manage Time- Table</h3>
                <a href="<%= request.getContextPath() %>/CounselorTimetable.jsp"
                   class="session-btn">
                <button>View cases</button>
                </a>
            </div>
                   </div>

    </div>

    <!-- RIGHT -->
    <div class="right-panel">

       <div class="right-panel">

    <!-- CALENDAR -->
    <div class="calendar">
        <h3>
           Appointment Schedule<br>
<small><%= monthName %> <%= year %></small>
</h3>

        </h3>

        <div class="calendar-header">
            <div>Sun</div><div>Mon</div><div>Tue</div>
            <div>Wed</div><div>Thu</div><div>Fri</div><div>Sat</div>
        </div>

        <div class="calendar-grid">

            <!-- Empty cells before first day -->
            <% for(int i = 0; i < startOffset; i++) { %>
                <div class="empty"></div>
            <% } %>

            <!-- Actual days -->
           <% for(int day = 1; day <= daysInMonth; day++) { %>
    <a href="<%= request.getContextPath() %>/appointments.jsp?day=<%= day %>"
       class="day <%= (day == todayDay) ? "today" : "" %>">
        <%= day %>
    </a>
<% } %>


        </div>

        <p style="margin-top:10px;font-size:12px;">
            <b>Today:</b> Therapy Session
        </p>
    </div>

</div>

    </div>

            </div>
            </div>
            
               <!-- TESTIMONIALS SECTION -->
<div class="testimonials-section">
    <p class="testimonial-subtitle">EMPOWERING COMMUNITY</p>
 <p class="testimonial-desc">
            "Healing doesn't mean the damage never existed. 
            It means the damage no longer controls your life."
        </p>
         <div class="testimonial-line"></div>
</div>
<script>
(function() {
    const toggle = document.getElementById('profileToggle');
    const section = document.querySelector('.profile-section');
    
    // CAPTURE PHASE (fires BEFORE bubbling)
    document.addEventListener('click', function(e) {
        if (!section.contains(e.target)) {
            toggle.checked = false;
        }
    }, true);  // true = capture phase [web:356]
})();
</script>
    <footer class="footer-desc">
             © 2026 ManSparsh Online Counseling &amp; Therapy. All rights reserved.
         </footer>

</body>
</html>