<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>  <!-- FIXED: Single clean import -->
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
Integer counselorId = (Integer) session.getAttribute("counselor_id");
if(counselorId == null){
    response.sendRedirect("CounselorLogin.jsp");
    return;
}
%>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    java.util.List<Appointment> appointmentsList = new java.util.ArrayList<Appointment>();

    try {
        // Load Derby driver (Network mode like your booking code)
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Connect to Derby DB (matching your booking: localhost:1527/ManSparsh)
        String dbURL = "jdbc:derby://localhost:1527/ManSparsh";
        conn = DriverManager.getConnection(dbURL, "bns", "bns");

        // SELECT from APPOINTMENT table (matching your schema)
        String selectSQL =
        "SELECT a.id, s.name AS client, s.smart_card_id, s.phone, " +
        "a.time_slot AS time, " +
        "a.preferred_mode AS mode, " +
        "a.appointment_date AS appointment_date, " +
        "a.meeting_link, " +
        "a.chief_concern, TRIM(a.status) AS status " +
        "FROM APPOINTMENT a " +
        "JOIN STUDENT s ON a.student_id = s.student_id " +
        "WHERE a.counselor_id = ? " +
        "ORDER BY a.appointment_date DESC, a.time_slot DESC";


        
        pstmt = conn.prepareStatement(selectSQL);
        pstmt.setInt(1, counselorId);
        rs = pstmt.executeQuery();

        // Dynamic table rows from APPOINTMENT table
        while (rs.next()) {
            Appointment appt = new Appointment();
            appt.setId(rs.getInt("id"));  // Optional ID
            appt.setClient(rs.getString("client"));
            appt.setSmartCard(rs.getString("smart_card_id"));
            appt.setTime(rs.getString("time"));
            appt.setMode(rs.getString("mode"));
            appt.setDate(rs.getString("appointment_date"));
            appt.setConcern(rs.getString("chief_concern"));
            appt.setStatus(rs.getString("status").trim());
            appt.setMeetingLink(rs.getString("meeting_link"));
            appt.setPhone(rs.getString("phone"));
            appointmentsList.add(appt);
        }

        // Store for JSTL
        pageContext.setAttribute("appointments", appointmentsList);

    } catch(Exception e) {
        out.println("<p style='color:red;'>DB Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
    %>
<html>
<head>
    <title>Counselor Case Details</title>
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

.student-mini{
    display:flex; align-items:center; gap:8px;
    background:rgba(255,255,255,0.2); padding:5px 12px;
    border-radius:20px; cursor:pointer; position:relative;
}

.student-mini img{ width:30px; height:30px; border-radius:50%; }
.navbar{
    background:#6f63ff; height:60px; display:flex;
    align-items:center; justify-content:space-between;
    padding:0 40px; color:white; position:relative;
}

.logo{ font-size:26px; font-weight:bold; }

/* RESPONSIVE */
@media (max-width: 768px) {
    .profile-dropdown {
        right: auto;
        left: 0;
        min-width: 200px;
    }
}

.footer-desc { 
    max-width: 100vw; 
    margin-top: 40px; 
    font-size: 16px; 
    line-height: 1.7; 
    text-align: center; 
    background: #6f63ff; 
    color: white; 
    padding: 20px; 
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
.equal-cols td:nth-child(1) { width: 14%; }   /* Client */

.equal-cols th:nth-child(2),
.equal-cols td:nth-child(2) { width: 12%; text-align:center; }  /* Smart Card */

.equal-cols th:nth-child(3),
.equal-cols td:nth-child(3) { width: 9%; text-align:center; }  /* Time */

.equal-cols th:nth-child(4),
.equal-cols td:nth-child(4) { width: 9%; text-align:center; }  /* Mode */

.equal-cols th:nth-child(5),
.equal-cols td:nth-child(5) { width: 12%; text-align:center; }  /* Date */

.equal-cols th:nth-child(6),
.equal-cols td:nth-child(6) { width: 20%; }  /* Concern */

.equal-cols th:nth-child(7),
.equal-cols td:nth-child(7) { width: 12%; text-align:center; }  /* Status */

.equal-cols th:nth-child(8),
.equal-cols td:nth-child(8) { width: 12%; text-align:center; }  /* Action */

        .concern { background: #fef3c7; color: #92400e; }
        .active { background: #dcfce7; color: #166534; }
        .new { background: #dbeafe; color: #1e40af; }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .navbar { padding: 0 20px; margin: 0 -20px 20px; }
            table { font-size: 14px; }
            th, td { padding: 12px 8px; }
        }
   /* NAV SEARCH BAR - RESPONSIVE */
.nav-search {
    margin-left: 40px;
    flex: 1;
    max-width: 320px;
    position: relative;
}

.nav-search input {
    width: 100%;
    padding: 8px 18px;
    border-radius: 20px;
    border: none;
    outline: none;
    font-size: 14px;
    background: rgba(255,255,255,0.2);
    color: #fff;
    transition: all 0.3s;
}

.nav-search input::placeholder {
    color: rgba(255,255,255,0.75);
}

.nav-search input:focus {
    background: rgba(255,255,255,0.3);
    transform: scale(1.02);
}

/* MOBILE RESPONSIVE - SHOW SEARCH AS ICON FIRST, EXPAND ON FOCUS */
.search-icon {
    display: none;
    font-size: 16px;
    cursor: pointer;
    padding: 8px;
    border-radius: 50%;
    background: rgba(255,255,255,0.2);
    transition: all 0.3s;
}

@media (max-width: 768px) {
    .navbar {
        padding: 0 20px;
        position: relative;
    }
    
    /* Hide full search input initially */
    .nav-search input {
        position: absolute;
        top: 100%;
        left: 0;
        right: 0;
        margin: 8px 20px 0;
        max-width: none;
        transform: scale(0);
        opacity: 0;
        visibility: hidden;
        z-index: 10;
    }
    
    /* Show search icon */
    .search-icon {
        display: block;
        margin-left: auto;
    }
    
    /* EXPAND ON FOCUS/CLICK */
    .nav-search:focus-within input {
        transform: scale(1);
        opacity: 1;
        visibility: visible;
    }
    
    .nav-search:focus-within .search-icon {
        background: rgba(255,255,255,0.3);
    }
    
    /* Hide other nav elements if space tight */
    .nav-right {
        gap: 10px;
    }
}
/* SEARCH BUTTON */
.search-input-group {
    display: flex;
    background: rgba(255,255,255,0.2);
    border-radius: 20px;
    overflow: hidden;
    transition: all 0.3s;
}

.search-input-group:focus-within {
    background: rgba(255,255,255,0.3);
    box-shadow: 0 4px 12px rgba(111,99,255,0.4);
}

.nav-search input {
    flex: 1;
    border: none;
    background: transparent;
    padding: 8px 16px;
    color: #fff;
    font-size: 14px;
}

.nav-search input::placeholder {
    color: rgba(255,255,255,0.75);
}

#searchBtn {
    border: none;
    background: rgba(255,255,255,0.25);
    color: #fff;
    width: 42px;
    height: 42px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s;
}

#searchBtn:hover {
    background: rgba(255,255,255,0.4);
    transform: scale(1.05);
}

#searchBtn:active {
    background: #5a4fd8;
}

/* MOBILE: Button stays visible */
@media (max-width: 768px) {
    .search-icon { display: none; }  /* Remove old icon */
    
    .nav-search input {
        position: absolute;
        top: 100%;
        left: 20px;
        right: 20px;
        margin: 8px 0 0;
        max-width: none;
        transform: scale(0);
        opacity: 0;
        visibility: hidden;
        z-index: 10;
        border-radius: 12px;
        padding: 12px 16px;
    }
    
    .nav-search:focus-within .search-input-group {
        transform: scale(1.02);
    }
    
    .nav-search:focus-within input {
        transform: scale(1);
        opacity: 1;
        visibility: visible;
    }
}
.filter-group select {
    border: none;
    background: white;
    padding: 6px 12px;
    border-radius: 999px;
    font-size: 14px;
    margin: 0 4px;
    min-width: 100px;
}

#monthFilter, #yearFilter {
    outline: none;
}
/* MONTH/YEAR FILTER - Purple Theme Match */
.filter-bar {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 16px;
    margin: 20px 0 10px;
    padding: 16px;
    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    border-radius: 16px;
    box-shadow: 0 4px 20px rgba(111,99,255,0.1);
}

.filter-group {
    display: flex;
    align-items: center;
    gap: 12px;
    background: rgba(255,255,255,0.9);
    padding: 12px 20px;
    border-radius: 25px;
    border: 1px solid rgba(111,99,255,0.2);
    backdrop-filter: blur(10px);
    transition: all 0.3s ease;
}

.filter-group:hover {
    background: white;
    box-shadow: 0 8px 25px rgba(111,99,255,0.15);
    border-color: rgba(111,99,255,0.3);
    transform: translateY(-1px);
}

.filter-group label {
    font-size: 14px;
    font-weight: 600;
    color: #6f63ff;
    white-space: nowrap;
}

/* CUSTOM SELECT DROPDOWNS */
#monthFilter, #yearFilter {
    border: none;
    background: linear-gradient(135deg, #f8fafc 0%, white 100%);
    padding: 10px 16px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 500;
    color: #475569;
    min-width: 110px;
    cursor: pointer;
    outline: none;
    box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
    transition: all 0.2s ease;
}

/* Dropdown Arrow */
#monthFilter, #yearFilter {
    background-repeat: no-repeat;
    background-position: right 12px center;
    background-size: 12px;
    padding-right: 36px;
}

#monthFilter:hover, #yearFilter:hover,
#monthFilter:focus, #yearFilter:focus {
    background-color: white;
    box-shadow: 0 4px 12px rgba(111,99,255,0.2);
    transform: scale(1.02);
}

#monthFilter:focus, #yearFilter:focus {
    border: 2px solid #6f63ff;
}

/* SELECT OPTION STYLING (Limited but works) */
#monthFilter option, #yearFilter option {
    background: white;
    color: #475569;
    padding: 8px 12px;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .filter-bar {
        flex-direction: column;
        gap: 12px;
        padding: 20px;
    }
    
    .filter-group {
        width: 100%;
        justify-content: center;
    }
    
    #monthFilter, #yearFilter {
        flex: 1;
        min-width: 120px;
         appearance: none;
    }
}



 </style>
</head>
<body>
   <!-- NAVBAR -->
<div class="navbar">
    <div class="logo">ManSparsh</div>
<div class="nav-search">
    <div class="search-input-group">
        <input type="text" id="globalSearch" placeholder="Search students...">
        <button type="button" id="searchBtn" title="Search">
            <i>🔍</i>  <!-- or SVG/Font Awesome -->
        </button>
    </div>
</div>

    <div class="nav-right">
        
        <div class="nav-links">
            <a href="#">Home</a>
            <a href="#">About Us</a>
            <a href="#">Features</a>
            <a href="#">Contact</a>
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


   

    <div class="container">
  <div class="filter-bar">
    <div class="filter-group">
        <label>Filter Month/Year:</label>
        <select id="monthFilter">
            <option value="">All Months</option>
            <option value="01">January</option>
            <option value="02">February</option>
            <option value="03">March</option>
            <!-- ... Add all 12 months -->
            <option value="12">December</option>
        </select>
        <select id="yearFilter">
            <option value="">All Years</option>
            <option value="2025">2025</option>
            <option value="2026">2026</option>
            <option value="2027">2027</option>
        </select>
    </div>
</div>


    <h1>📋 Case Details</h1>
        <div class="table-container">
    <table class="equal-cols">
        <thead>
            <tr>
                <th>Student</th>
                <th>Smart Card</th>
                <th>Time</th>
                <th>Mode</th>
                <th>Date</th>
                <th>Concern</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody id="appointmentsTableBody">
            <c:if test="${empty appointments}">
                <tr>
                    <td colspan="8" style="text-align:center;padding:20px;color:#64748b;">
                        No appointments found
                    </td>
                </tr>
            </c:if>
            <c:forEach var="a" items="${appointments}">
                <tr>
                    <td>${a.client}</td>
                    <td>${a.smartCard}</td> 
                    <td>${a.time}</td>
                    <td>${a.mode}</td>
                    <td>${a.date}</td>
                    <td>${a.concern}</td>
                    <td>
                    <span class="status">${a.status}</span>
                    </td>
                    
                    <td>
                    <c:set var="mode" value="${fn:toUpperCase(a.mode)}"/>
                    <c:set var="status" value="${fn:toUpperCase(a.status)}"/>
                    <c:choose>

                    <c:when test="${a.status == 'SCHEDULED'}">

                        <c:choose>

                            <c:when test="${a.mode == 'VIDEO_CALL'}">
                                <a href="${a.meetingLink}" target="_blank"
                                   style="background:#16a34a;color:white;padding:6px 12px;border-radius:6px;text-decoration:none;font-size:13px;">
                                   &#128994; Start Session
                                </a>
                            </c:when>

                            <c:when test="${a.mode == 'PHONE_CALL'}">
                                <div style="color:#1e40af;font-weight:600;font-size:13px;">
                                    &#128222; Call Student: ${a.phone}
                                </div>
                            </c:when>

                            <c:when test="${a.mode == 'IN_PERSON'}">
                                <div style="color:#166534;font-weight:600;font-size:13px;">
                                    &#128205;  Student will meet you
                                </div>
                            </c:when>

                            <c:otherwise>
                                <span style="color:#64748b;">No action</span>
                            </c:otherwise>

                        </c:choose>

                    </c:when>

                    <c:when test="${a.status == 'COMPLETED'}">
                        <span style="color:#16a34a;font-weight:600;">Session Completed</span>
                    </c:when>

                    <c:when test="${a.status == 'CANCELLED_BY_STUDENT' || a.status == 'CANCELLED_BY_COUNSELOR'}">
                        <span style="color:#ef4444;">Appointment Cancelled</span>
                    </c:when>

                    <c:when test="${a.status == 'MISSED_BY_STUDENT' || a.status == 'MISSED_BY_COUNSELOR'}">
                        <span style="color:#f59e0b;">Session Missed</span>
                    </c:when>

                    <c:when test="${a.status == 'RESCHEDULED'}">
                        <span style="color:#2563eb;">Rescheduled</span>
                    </c:when>

                    <c:otherwise>
                        <span style="color:#64748b;">-</span>
                    </c:otherwise>

                    </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%!
public static class Appointment {
    private int id;
    private String client, time, mode, date, concern, status, smartCard;
    private String meetingLink;
    private String phone;
    
    // Getters/Setters matching new fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getClient() { return client; }
    public void setClient(String client) { this.client = client; }
    
    public String getSmartCard() { return smartCard; }
    public void setSmartCard(String smartCard) { this.smartCard = smartCard; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }
    
    public String getMode() { return mode; }
    public void setMode(String mode) { this.mode = mode; }
    
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
    
    public String getConcern() { return concern; }
    public void setConcern(String concern) { this.concern = concern; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getMeetingLink() { return meetingLink; }
    public void setMeetingLink(String meetingLink) { this.meetingLink = meetingLink; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}
%>

        </div>
      <script>
          function confirmStart(id){
    if(confirm("Are you sure you want to start the session?")){
        window.location.href = "StartSession.jsp?appointmentId=" + id;
    }
}
let timeoutId = null;  // For debouncing

function filterTable() {
    const monthFilter = document.getElementById('monthFilter')?.value;
    const yearFilter = document.getElementById('yearFilter')?.value;
    const searchInput = document.getElementById('globalSearch')?.value.toLowerCase().trim();
    
    const tableBodies = ['appointmentsTableBody'];

    tableBodies.forEach(tableId => {
        const tableBody = document.getElementById(tableId);
        if (!tableBody) return;
        
        const rows = tableBody.getElementsByTagName('tr');
        
        for (let row of rows) {
            const cells = row.getElementsByTagName('td');
            if (cells.length < 5) continue;
            const dateCell = cells[4].innerText.trim();   // Date column

            const rowText = Array.from(cells).map(cell => cell.innerText.toLowerCase()).join(' ');
            
            // Extract month/year from "YYYY-MM-DD"
            const dateMatch = dateCell.match(/(\d{4})-(\d{2})-\d{2}/);
            const rowYear = dateMatch ? dateMatch[1] : '';
            const rowMonth = dateMatch ? dateMatch[2] : '';
            
            const matchesSearch = !searchInput || rowText.includes(searchInput);
            const matchesMonth = !monthFilter || rowMonth === monthFilter;
            const matchesYear = !yearFilter || rowYear === yearFilter;
            
            row.style.display = (matchesSearch && matchesMonth && matchesYear) ? '' : 'none';
        }
    });
}

// Event listeners
document.addEventListener('DOMContentLoaded', () => {
    document.getElementById('monthFilter')?.addEventListener('change', filterTable);
    document.getElementById('yearFilter')?.addEventListener('change', filterTable);
    document.getElementById('globalSearch')?.addEventListener('input', () => {
        clearTimeout(timeoutId);
        timeoutId = setTimeout(filterTable, 300);
    });
    document.getElementById('searchBtn')?.addEventListener('click', filterTable);
});

// Add after event listeners
const searchBtn = document.getElementById('searchBtn');
if (searchBtn) {
    searchBtn.addEventListener('click', () => {
        clearTimeout(timeoutId);
        filterTable();  // Immediate search on button click [web:5][web:63]
    });
}
// Close dropdown when clicking outside
document.addEventListener('click', function(e) {
    const profileSection = document.querySelector('.profile-section');
    const toggle = document.getElementById('profileToggle');
    
    // If click is OUTSIDE profile-section → Close
    if (!profileSection.contains(e.target)) {
        toggle.checked = false;
    }
});

</script>
</body>
</html>