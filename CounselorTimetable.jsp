<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="java.util.*, java.sql.*, java.text.SimpleDateFormat, java.text.DateFormat" %>
<%
Integer counselorId = (Integer) session.getAttribute("counselor_id");

if(counselorId == null){
    response.sendRedirect("CounselorLogin.jsp");
    return;
}
%>
<%
Set<String> savedSlots = new HashSet<String>();

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    Class.forName("org.apache.derby.jdbc.ClientDriver");
    con = DriverManager.getConnection("jdbc:derby://localhost:1527/ManSparsh","bns","bns");
    ps = con.prepareStatement("SELECT day, time_slot FROM counselor_timetable WHERE counselor_id=?");
    ps.setInt(1, counselorId);
    rs = ps.executeQuery();
    while(rs.next()){
        savedSlots.add(rs.getString("day") + "|" + rs.getString("time_slot"));
    }
} catch(Exception e) {
    e.printStackTrace();
} finally {
    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>

<%!
    class TimetableSlot {
        int id;
        String day;
        String time;
        String subject;
        String faculty;
        String room;
        String date;

        TimetableSlot(int id, String day,String time) {
            this.id = id;
            this.day = day;
            this.time = time;
            
        }
    }
%>
<%
   
    List<TimetableSlot> timetable = new ArrayList<TimetableSlot>();
    // Calendar logic from your dashboard (corrected startOffset)
    Calendar now = Calendar.getInstance();
    Calendar cal = (Calendar) now.clone();
    cal.set(Calendar.DAY_OF_MONTH, 1);
    
    int year = cal.get(Calendar.YEAR);
    int monthNum = cal.get(Calendar.MONTH) + 1;
    String monthName = cal.getDisplayName(Calendar.MONTH, Calendar.SHORT, java.util.Locale.getDefault());
    int daysInMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    
    int firstDayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    int startOffset = (firstDayOfWeek == Calendar.SUNDAY) ? 0 : firstDayOfWeek - 1;
    
    int todayDay = now.get(Calendar.DAY_OF_MONTH);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Timetable Management | ManSparsh</title>
<style>
body{
    margin:0;
    font-family:Arial, sans-serif;
    background:#f4f6fb;
}

.container{
    width:95%;
    max-width:1400px;
    margin:40px auto;
    background:white;
    padding:35px;
    border-radius:16px;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
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

.container { max-width: 1400px; margin: 0 auto; }
        h1 { text-align: center; color:#4a5568; margin-bottom: 20px; font-size: 2.5em; }

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

.main{ padding:40px; display:flex; gap:30px; min-height: calc(100vh - 100px); }

.left-panel{ flex:2; }

.timetable-section{ background:white; padding:25px; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.08); margin-bottom:25px; }

.timetable-section h3{ margin:0 0 20px 0; color:#2d3748; font-size:24px; }

#add-slot-form input, #add-slot-form select{ width:100%; padding:12px; margin-bottom:15px; border:1px solid #e2e8f0; border-radius:8px; box-sizing:border-box; }

#add-slot-btn{ background:linear-gradient(135deg, #6f63ff, #8b7eff); color:white; border:none; padding:12px 24px; border-radius:24px; font-weight:600; cursor:pointer; width:100%; }

#add-slot-btn:hover{ transform:translateY(-2px); box-shadow:0 8px 25px rgba(111,99,255,0.4); }

.timetable-table{ width:100%; border-collapse:collapse; margin-top:20px; }

.timetable-table th{ background:#6f63ff; color:white; padding:15px 12px; text-align:left; font-weight:600; }

.timetable-table td{ padding:12px; border-bottom:1px solid #f1f5f9; }

.timetable-table tr:hover{ background:#f8fafc; }

.delete-btn{ background:#ef4444; color:white; border:none; padding:6px 12px; border-radius:6px; cursor:pointer; font-size:12px; }

.delete-btn:hover{ background:#dc2626; }

.right-panel{ flex:1; }

.form-buttons {
    display: flex; gap: 15px; justify-content: center; margin-top: 35px;
}
.btn-primary {
    background: linear-gradient(135deg, #6f63ff, #8b7eff); color: white;
}
.btn {
    padding: 14px 32px; border: none; border-radius: 12px; font-size: 16px;
    font-weight: 600; cursor: pointer; transition: all 0.3s;
    text-decoration: none; display: inline-block; text-align: center;
}
.btn-primary:hover { transform: translateY(-2px); box-shadow: 0 15px 30px rgba(111,99,255,0.4); }
h3{
    text-align:center;
    margin-bottom:25px;
    color:#4f46e5;
}
.timetable-grid{
    width:100%;
    border-collapse:collapse;
    margin-top:20px;
}

.timetable-grid th{
    background:#6f63ff;
    color:white;
    padding:14px;
    text-align:center;
}

.timetable-grid td{
    border:1px solid #e5e7eb;
    padding:10px;
    text-align:center;
}

.time-col{
    font-weight:bold;
    background:#f1f5f9;
}

.slot-btn{
    width:100%;
    height:40px;
    border:1px solid #c7d2fe;
    background:#f8fafc;
    border-radius:6px;
    cursor:pointer;
    transition:0.2s;
}

.slot-btn:hover{
    background:#e0e7ff;
}

.slot-btn.selected{
    background:#2563eb;
    border-color:#2563eb;
}
.calendar{
display:grid;
grid-template-columns: 120px repeat(6, 1fr);
width:100%;
max-width:1200px;
margin:auto;
gap:4px;
background:#e5e7eb;
padding:5px;
border-radius:10px;
}

.cell{
background:white;
display:flex;
justify-content:center;
align-items:center;
height:80px;
font-size:14px;
border-radius:6px;
height:55px;
}

.header{
background:#6f63ff;
color:white;
font-weight:bold;
}

.time{
background:#eef2ff;
font-weight:bold;
}

.slot{
width:100%;
height:100%;
border:none;
background:#f9fafb;
cursor:pointer;
border-radius:6px;
transition:0.2s;
}

.slot:hover{
background:#c7d2fe;
transform:scale(1.05);
}

.slot.selected{
background:#6f63ff;
color:white;
}
</style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
    <div class="logo">ManSparsh</div>

    <div class="nav-right">
        <div class="nav-links">
          <a href="<%= request.getContextPath() %>/dashboard.jsp">Home</a>
            <a href="<%= request.getContextPath() %>/FacultyAboutUs.jsp">About Us</a>
            <a href="<%= request.getContextPath() %>/FacultyFeatures.jsp">Features</a>
            <a href="<%= request.getContextPath() %>/FacultyContactUs.jsp">Contact</a>
        </div>

     <div class="profile-section">
    <input type="checkbox" id="profileToggle" class="toggle-checkbox">
    <label for="profileToggle" class="student-mini">
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Profile">
        <span><%= session.getAttribute("userRole") != null ? session.getAttribute("userRole") : "Peer Counselor" %></span>
    </label>
    
    <!-- Dropdown appears on hover -->
    <div class="profile-dropdown" id="profileDropdown">
        <a href="<%= request.getContextPath() %>/CouncelorEditProfile.jsp"> Edit Profile</a>
        <a href="<%= request.getContextPath() %>/help.jsp">Help</a>
        <a href="<%= request.getContextPath() %>/feedback.jsp">Send Feedback</a>
        <a href="<%= request.getContextPath() %>/logout.jsp">Logout</a>
    </div>
</div>

    </div>
</div>
    <form id="timetableForm" method="post" action="CounselorSaveTimetable.jsp">
    <input type="hidden" name="slots" id="slotsInput">
</form>

    <div class="main">
        <!-- Left: Timetable Management -->
        <div class="container">
            <div class="timetable-section">
                <div id="message" style="text-align:center; color:green; font-weight:bold; margin-bottom:15px;"></div>

    <h3 style="font-size:28px;">Weekly Timetable</h3>

    <div class="calendar">

<div class="cell header">Time</div>

<%
String[] days={"Mon","Wed","Thu","Fri","Sat","Sun"};
for(String d:days){
%>
<div class="cell header"><%=d%></div>
<% } %>

<%
String[] times={
"9-10","10-11","11-12","12-1",
"1-2","2-3","3-4","4-5","5-6"
};

for(String t:times){
%>

<div class="cell time"><%=t%></div>

<% for(String d:days){ %>
<div class="cell">
<button
class="slot <%= savedSlots.contains(d+"|"+t) ? "selected":"" %>"
data-day="<%=d%>"
data-time="<%=t%>"
onclick="toggleSlot(this)">
</button>
</div>
<% } %>

<% } %>

</div>

    <div class="form-buttons">
        <button class="btn btn-primary" onclick="saveTimetable()">Save Timetable</button>
    </div>
        <script>
function toggleSlot(btn){
    btn.classList.toggle("selected");
}
</script>

</div>
        </div>

       
               
    </div>
                <br>
    <footer class="footer-desc">
        © 2026 ManSparsh Online Counseling & Therapy. All rights reserved.
    </footer>

    <script>
        document.getElementById('add-slot-form').onsubmit = function(e) {
            e.preventDefault();
            alert('Add slot functionality - Integrate with servlet/DB');
            // TODO: AJAX to servlet for Derby insert
        };
        function deleteSlot(id) {
            if(confirm('Delete slot?')) {
                alert('Delete ' + id + ' - Integrate with servlet');
                // TODO: AJAX delete
            }
        }
    </script>
    <script>
function toggleSlot(btn){
    btn.classList.toggle("selected");
}

function saveTimetable(){
    let slots = [];
    document.querySelectorAll(".slot.selected").forEach(btn=>{
        slots.push(btn.dataset.day + "|" + btn.dataset.time);
    });

    if(slots.length === 0){
        alert("Please select at least one slot");
        return;
    }

    // Send AJAX request
    fetch("CounselorSaveTimetable.jsp", {
        method: "POST",
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: "slots=" + encodeURIComponent(slots.join(","))
    })
    .then(response => response.text())
    .then(msg => {
        document.getElementById("message").innerText = msg;
    })
    .catch(err => alert("Error saving timetable"));
}


</script>


</body>
</html>
