<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

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
    transition: all 0.3s;
}
.student-mini:hover {
    background: rgba(255,255,255,0.3);
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

.cards{
    display:grid;
    grid-template-columns:repeat(8,1fr);
    gap:50px;
}
.card{
    background:white;
    padding:25px;
    border-radius:12px;
    text-align:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
    cursor:pointer;
}
.card button{
    margin-top:12px;
    padding:5px 5px;
    border:none;
    border-radius:20px;
    background:#6f63ff;
    color:white;
    cursor:pointer;
}
/* MAIN CONTENT */
        .container { max-width: 1400px; margin: 0 auto; }
        h1 { text-align: center; color: #4a5568; margin-bottom: 30px; font-size: 2.2em; }

        /* RESPONSIVE TABLE */
        .table-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }
        th {
            background: linear-gradient(135deg, #6f63ff, #8b7eff);
            color: white;
            padding: 18px 16px;
            text-align: left;
            font-weight: 600;
            position: sticky; top: 0;
        }
        td { 
            padding: 16px; 
            border-bottom: 1px solid #f1f5f9;
            color: #475569;
        }
        tr:hover { background: #f8fafc; transform: scale(1.01); transition: all 0.2s; }
        tr:last-child td { border-bottom: none; }

        /* STATUS BADGES */
        .status { 
            padding: 6px 14px; 
            border-radius: 20px; 
            font-size: 13px; 
            font-weight: 600;
            display: inline-block;
        }
        /* EQUAL COLUMNS FOR BOTH TABLES */
.equal-cols {
    table-layout: fixed !important;  /* FIXED: Forces exact widths */
    width: 100%;
}

.equal-cols th:nth-child(1),
.equal-cols td:nth-child(1) { width: 8%; text-align: center; }      /* Serial */
.equal-cols th:nth-child(2),
.equal-cols td:nth-child(2) { width: 22%; }                          /* Name */
.equal-cols th:nth-child(3),
.equal-cols td:nth-child(3) { width: 8%; text-align: center; }       /* Age */
.equal-cols th:nth-child(4),
.equal-cols td:nth-child(4) { width: 10%; text-align: center; }      /* Gender */
.equal-cols th:nth-child(5),
.equal-cols td:nth-child(5) { 
    width: 32%; 
    word-break: break-word; 
}   /* Concern - Largest */
.equal-cols th:nth-child(6),
.equal-cols td:nth-child(6) { width: 20%; text-align: center; }      /* Date */

        
/* RESPONSIVE */
        @media (max-width: 768px) {
            .navbar { padding: 0 20px; margin: 0 -20px 20px; }
            table { font-size: 14px; }
            th, td { padding: 12px 8px; }
}
 html, body {
  height: 100%;
  margin: 0;
}

.page-wrapper {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}
main {
  flex: 1;
}
.footer-desc { 
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
<body >
 <!-- NAVBAR -->
<div class="navbar">
    <div class="logo">ManSparsh</div>

    <div class="nav-right">
        <div class="nav-links">
          <a href="<%= request.getContextPath() %>/dashboard.jsp">Home</a>
            <a href="<%= request.getContextPath() %>/FacultyAboutUs.jsp">About Us</a>
            <a href="<%= request.getContextPath() %>/FacultyFeatures.jsp">Features</a>
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
        <a href="<%= request.getContextPath() %>/logout.jsp">Logout</a>
    </div>
</div>

    </div>
</div>


  <div class="container">
                <h1>Appointments 🗓️</h1>
                <div class="page-wrapper">
<div class="table-container">
            <table class="equal-cols">
    <tr>
       
                        
                        <th>Name</th>
                        <th>SmartID</th>
                        
                        <th>Date</th>
                        <th>Time</th>
                       <th>Mode</th>
                       <th>Action(join)</th>
    </tr>
    
</table>
</div>
</div>
</div>

    
 <div class="cards">
                <a href="<%= request.getContextPath() %>/FacultyDashboard.jsp"  class="card button"><button>Back</button></a></div>
                  <footer class="footer-desc">
             © 2026 ManSparsh Online Counseling &amp; Therapy. All rights reserved.
         </footer>
</body>
</html>

