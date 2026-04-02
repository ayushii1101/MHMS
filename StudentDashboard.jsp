<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
Integer studentId = (Integer) session.getAttribute("studentId");

if(studentId == null){
    response.sendRedirect("StudentLogin.jsp");
    return;
}

String studentName = "";

try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection con = DriverManager.getConnection(
        "jdbc:derby://localhost:1527/ManSparsh","bns","bns"
    );

    PreparedStatement ps = con.prepareStatement(
        "SELECT name FROM student WHERE student_id=?"
    );
    ps.setInt(1, studentId);
    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        studentName = rs.getString("name");
    }

    con.close();
} catch(Exception e){
    e.printStackTrace();
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Dashboard</title>

<style>
body{margin:0;font-family:Arial,sans-serif;background:#f4f6fb;}
.navbar{background:#6f63ff;height:60px;display:flex;align-items:center;justify-content:space-between;padding:0 40px;color:white;}
.logo{font-size:26px;font-weight:bold;}
.nav-right{display:flex;align-items:center;gap:20px;}
.nav-links a{color:white;text-decoration:none;margin:0 12px;font-size:16px;}
.student-mini{display:flex;align-items:center;gap:8px;background:rgba(255,255,255,0.2);padding:5px 12px;border-radius:20px;cursor:pointer;position:relative;}
.student-mini img{width:30px;height:30px;border-radius:50%;}
.profile-dropdown{display:none;position:absolute;top:45px;right:0;background:white;min-width:180px;border-radius:12px;box-shadow:0 12px 25px rgba(0,0,0,0.25);overflow:hidden;z-index:999;}
.profile-dropdown a{display:block;padding:12px 16px;text-decoration:none;color:#333;font-size:14px;}
.profile-dropdown a:hover{background:#f1f5f9;}
.main{padding:40px;background-image:url("https://images.unsplash.com/photo-1526916027372-0c0852cef5d3?q=80&w=1025&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");background-size:cover;background-position:center;min-height:100vh;}
.welcome-title{text-align:center;font-size:34px;color:#2d3748;margin-bottom:35px;font-weight:600;}
.cards{
    display:grid;
    grid-template-columns: repeat(4, 260px);   /* fixed width cards */
    gap:30px;
    justify-content:center;                  /* center align grid */
    margin-bottom:40px;
}


.card{
    background:white;
    padding:20px;              /* reduced */
    border-radius:12px;        /* slightly smaller */
    text-align:center;
    box-shadow:0 6px 16px rgba(0,0,0,0.08);
    transition:0.3s;
}

.card:hover{transform:translateY(-8px) scale(1.02);box-shadow:0 12px 25px rgba(108,99,255,0.35);}
.card button{margin-top:14px;padding:9px 22px;border:none;border-radius:20px;background:#6c63ff;color:white;cursor:pointer;}
.chat{margin-top:50px;background:white;padding:25px;border-radius:14px;box-shadow:0 8px 20px rgba(0,0,0,0.08);}
.chat-box{height:140px;background:#f1f5f9;padding:10px;border-radius:8px;overflow-y:auto;margin-bottom:10px;}
.faculty{margin-top:60px;}
.faculty-grid{
    display:grid;
    grid-template-columns: repeat(4, 1fr);   /* exactly 4 per row */
    gap:40px;                               /* space between cards */
    max-width:1300px;                       /* keeps grid centered */
    margin:0 auto;                         /* equal left & right gap */
    justify-items:center;                  /* center cards */
}

.faculty-card{
    width:260px;                           /* perfect size */
    border-radius:14px;
    overflow:hidden;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    background:white;
    text-align:center;
}

.faculty-card img{
    width:100%;
    height:280px;
    object-fit:cover;         /* fills box nicely */
    background:#f8fafc;
}

.faculty-info{padding:15px; background:#f8fafc;
    font-size:15px;
    color:#334155;}
.quote-section{text-align:center;margin:80px 20px 40px;font-style:italic;font-size:30px;color:white;font-weight:500;}
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
      <a href="StudentDashboard.jsp">Home</a>
      <a href="StudentAboutUs.jsp">About Us</a>
      <a href="StudentFeatures.jsp">Features</a>
      <a href="StudentContactUs.jsp">Contact Us</a>
    </div>

    <div class="student-mini" onclick="toggleProfile()">
      <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png">
      <span><%= studentName %></span>
      <div class="profile-dropdown" id="profileDropdown">
        <a href="StudentEditProfile.jsp">Edit</a>
        <a href="StudentHelp.jsp">Help</a>
        <a href="feedback.jsp">Send Feedback</a>
        <a href="logout.jsp">Logout</a>
      </div>
    </div>
      
  </div>
</div>

<div class="main">
<h1 class="welcome-title">Welcome to ManSparsh</h1>

<div class="cards">

  <!-- Row 1 -->
  <div class="card">
    <h3>Book Appointment</h3>
    <a href="BookAppointment.jsp"><button>Book</button></a>
  </div>

  <div class="card">
    <h3>View Resources</h3>
    <a href="ViewResources.jsp"><button>View</button></a>
  </div>

  <div class="card">
    <h3>Upcoming Workshops</h3>
    <a href="workshop.jsp"><button>View</button></a>
  </div>

  <div class="card">
    <h3>Appointments</h3>
    <a href="StudentAppointments.jsp"><button>View</button></a>
  </div>

  <!-- Row 2 -->
  <div class="card">
    <h3>History</h3>
    <a href="StudentHistory.jsp"><button>View</button></a>
  </div>

  <div class="card">
    <h3>Emergency Help</h3>
    <a href="SOS.jsp"><button>SOS</button></a>
  </div>

  <!-- Empty placeholders to keep grid shape -->
  <div></div>
  <div></div>

</div>



<!-- Meet Our Team Section -->
<div class="faculty">
    <h2 style="text-align:center;font-size:36px;margin-bottom:10px;">
        Meet Our Team of Faculty & Counsellors
    </h2>
    <p style="text-align:center;color:#64748b;margin-bottom:40px;font-size:16px;">
        Every expert here is dedicated to listening, understanding, and supporting your mental well-being.
    </p>

    <div class="faculty-grid">

        <!-- Faculty -->
        <div class="faculty-card">
            <img src="images/anuraj.jpg">
            <div class="faculty-info">
                <b>Dr. Anu Raj Singh</b><br>
                Educational Psychologist
            </div>
        </div>

        <div class="faculty-card">
            <img src="images/ratnadixit.jpeg">
            <div class="faculty-info">
                <b>Dr. Ratna Dixit</b><br>
                Counseling & Educational Psychology Specialist
            </div>
        </div>

        <div class="faculty-card">
            <img src="images/RubiMam.jpg">
            <div class="faculty-info">
                <b>Dr. Rubi Singh</b><br>
                Counseling & Stress Management Specialist
            </div>
        </div>

        <!-- Counsellors -->
        <div class="faculty-card">
            <img src="images/lakshya.jpg">
            <div class="faculty-info">
                <b>Ms. Lakshyaa Chaturvedi</b><br>
                Counselling Psychologist
            </div>
        </div>

    </div>
</div>
<!-- End Meet Our Team -->

<div class="quote-section">
  “Out of your vulnerabilities will come your strength.” — <b>Sigmund Freud</b>
</div>

</div>

<footer class="footer-desc">
             © 2026 ManSparsh Online Counseling &amp; Therapy. All rights reserved.
         </footer>

<script>
function toggleProfile(){
  const d=document.getElementById("profileDropdown");
  d.style.display=(d.style.display==="block")?"none":"block";
}
document.addEventListener("click",function(e){
  const p=document.querySelector(".student-mini");
  const d=document.getElementById("profileDropdown");
  if(!p.contains(e.target)){ d.style.display="none"; }
});
function sendMsg(){
  var i=document.getElementById("msg"), c=document.getElementById("chatBox");
  if(i.value.trim()=="") return;
  c.innerHTML+="<p><b>You:</b> "+i.value+"</p><p><b>Saathi:</b> I’m listening.</p>";
  i.value=""; c.scrollTop=c.scrollHeight;
}
</script>
<script src="https://cdn.botpress.cloud/webchat/v3.6/inject.js"></script>
<script src="https://files.bpcontent.cloud/2026/02/22/17/20260222173255-JTXXGA7A.js" defer></script>
</body>
</html>
