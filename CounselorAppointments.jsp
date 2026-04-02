<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %> 

<%
Integer counselorId = (Integer) session.getAttribute("counselor_id");
if(counselorId == null){
    response.sendRedirect("CounselorLogin.jsp");
    return;
}
%>

<%
Class.forName("org.apache.derby.jdbc.ClientDriver");
Connection con = DriverManager.getConnection(
    "jdbc:derby://localhost:1527/ManSparsh","bns","bns");

PreparedStatement ps = con.prepareStatement(
"SELECT a.id, s.name, s.smart_card_id, a.appointment_date, a.time_slot, " +
"a.preferred_mode, a.chief_concern ,a.status " +
"FROM APPOINTMENT a " +
"JOIN STUDENT s ON a.student_id = s.student_id " +
"WHERE a.status IN ('COMPLETED','MISSED_BY_STUDENT','MISSED_BY_COUNSELOR','CANCELLED_BY_STUDENT','CANCELLED_BY_COUNSELOR') AND a.counselor_id=? " +
"ORDER BY a.appointment_date DESC, a.time_slot DESC");

ps.setInt(1, counselorId);
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Counselor Appointments</title>
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
    table-layout: fixed;  /* FIXED: Forces exact widths */
    width: 100%;
}

.equal-cols th:nth-child(1),
.equal-cols td:nth-child(1) { width: 14%; }   /* Student */

.equal-cols th:nth-child(2),
.equal-cols td:nth-child(2) { width: 12%; }   /* Smart Card */

.equal-cols th:nth-child(3),
.equal-cols td:nth-child(3) { width: 10%; }   /* Date */

.equal-cols th:nth-child(4),
.equal-cols td:nth-child(4) { width: 8%; }    /* Time */

.equal-cols th:nth-child(5),
.equal-cols td:nth-child(5) { width: 10%; }   /* Mode */

.equal-cols th:nth-child(6),
.equal-cols td:nth-child(6) { width: 26%; }   /* Concern */

.equal-cols th:nth-child(7),
.equal-cols td:nth-child(7) { width: 10%; text-align:center; } /* Start */

.equal-cols th:nth-child(8),
.equal-cols td:nth-child(8) { width: 10%; text-align:center; } /* Refer */
        
/* RESPONSIVE */
        @media (max-width: 768px) {
            .navbar { padding: 0 20px; margin: 0 -20px 20px; }
            table { font-size: 14px; }
            th, td { padding: 12px 8px; }
        }

        .refer-btn { 
            background: #10b981; color: white; 
            border: none; padding: 8px 16px; 
            border-radius: 6px; cursor: pointer; 
            font-weight: bold;
        }
        .refer-btn:hover { background: #059669; }

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
<body >
 <!-- NAVBAR -->
<div class="navbar">
    <div class="logo">ManSparsh</div>

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
        <a href="<%= request.getContextPath() %>/homepage.jsp">Logout</a>
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
    <h1>Appointments 🗓️</h1>
                
<div class="table-container">
    <table class="equal-cols">
        <tr>
            <th>Student</th>
            <th>Smart Card</th>
            <th>Date</th>
            <th>Time</th>
            <th>Mode</th>
            <th>Concern</th>
            <th>Session</th>
            <th>Refer</th>
        </tr>

        <%
        while(rs.next()){
            String status = rs.getString("status");
        %>
        
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("smart_card_id") %></td>
            <td><%= rs.getDate("appointment_date") %></td>
            <td><%= rs.getString("time_slot") %></td>
            <td><%= rs.getString("preferred_mode") %></td>
            <td><%= rs.getString("chief_concern") %></td>

            <!-- Start Session -->
            <td>

                <% if("COMPLETED".equals(status)) { %>
                <span class="badge bg-success">Completed</span>

                <% } else if("MISSED_BY_STUDENT".equals(status)) { %>
                <span class="text-danger">Missed by Student</span>

                <% } else if("MISSED_BY_COUNSELOR".equals(status)) { %>
                <span class="text-danger">Missed by Counselor</span>

                <% } else if("CANCELLED_BY_STUDENT".equals(status)) { %>
                <span class="text-secondary">Cancelled by Student</span>

                <% } else if("CANCELLED_BY_COUNSELOR".equals(status)) { %>
                <span class="text-secondary">Cancelled by Counselor</span>

                <% } %>

            </td>

            <!-- Refer Case -->
            <td>
                <% if("COMPLETED".equals(status)) { %>
                    <form action="CounselorReferAppointment.jsp" method="post" onsubmit="return confirm('Are you sure you want to refer this case to the faculty?');">
                        <input type="hidden" name="appointmentId" value="<%= rs.getInt("id") %>">
                        <button class="refer-btn">Refer Case</button>
                    </form>
                <% } else { %>
                    <span style="color:#94a3b8;">Not Available</span>
                <% } %>
            </td>

        </tr>

        
        <%
        }
        con.close();
        %>
    </table>

</div>
</div>
 
     <script>
        let timeoutId = null;  // For debouncing

        function filterTable() {
            const monthFilter = document.getElementById('monthFilter')?.value;
            const yearFilter = document.getElementById('yearFilter')?.value;
            const searchInput = document.getElementById('globalSearch')?.value.toLowerCase().trim();

            const tableBodies = ['studentTableBody', 'inactiveTableBody'];  // Both tables

            tableBodies.forEach(tableId => {
                const tableBody = document.getElementById(tableId);
                if (!tableBody) return;

                const rows = tableBody.getElementsByTagName('tr');

                for (let row of rows) {
                    const cells = row.getElementsByTagName('td');
                    if (cells.length < 5) continue;

                    const dateCell = cells[4].innerText.trim();  // "2026-01-01"
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
        function confirmRefer(client, time) {
            if (confirm(`Refer case for ${client} at ${time}?\n\nThis will notify the referral team.`)) {
                alert(`Case referred successfully for ${client} at ${time}!`);
                // Here you can add AJAX call to servlet
                // referCase(client, time);
            }
        }
</script>
</body>
</html>