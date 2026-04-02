<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<html>
<head>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counselor Referred Cases</title>
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

        /* MAIN CONTENT */
        .main-content { padding: 40px; max-width: 1400px; margin: 0 auto; }
        
        /* HEADER CARD */
        .header-card { background: white; padding: 30px; border-radius: 12px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.08); margin-bottom: 30px; }
        .header-card h3 { color: #333; font-size: 28px; margin-bottom: 20px; }
        .header-card button { background: #6f63ff; color: white; border: none; padding: 12px 30px; border-radius: 25px; font-size: 16px; cursor: pointer; font-weight: 500; }
        
        /* CASES TABLE */
        .cases-section { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .section-title { font-size: 24px; color: #333; margin-bottom: 25px; text-align: center; }
        
        /* 3-COLUMN GRID */
        .cases-grid { display: grid; grid-template-columns: 2fr 2fr 1fr 3fr; gap: 20px; margin-bottom: 20px; font-size: 14px; }
        .grid-header { background: #6f63ff; color: white; padding: 15px; border-radius: 8px 0 0 8px; font-weight: bold; text-align: center; }
        .grid-header:last-child { border-radius: 0 8px 0 0; }
        .grid-cell { background: #f8f9ff; padding: 15px; border-radius: 0 0 8px 8px; text-align: center; border: 1px solid #e1e5ff; }
        
        /* STATUS */
        .status { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .status.active { background: #d4edda; color: #155724; }
        .status.pending { background: #fff3cd; color: #856404; }
        .status.completed { background: #d1ecf1; color: #0c5460; }
        
        @media (max-width: 768px) { .cases-grid { grid-template-columns: 1fr; } 
        .main-content { padding: 20px; } }
        
        .footer-desc { max-width: 100vw; margin-top: 40px; font-size: 16px; line-height: 1.7; text-align: center; background: #6f63ff; color: white; padding: 20px; }
   
    .container { max-width: 1400px; margin: 0 auto; }
        h1 { text-align: center; color:#4a5568; margin-bottom: 20px; font-size: 2.5em; }

        /* URGENT TABLE */
        .table-section {
            background: white;
            border-radius: 16px;
            
            overflow: hidden;
            margin-bottom: 30px;
        }
        .section-header {
            background: linear-gradient(135deg, #6f63ff, #8b7eff);
            color: white;
            padding: 24px;
            font-size: 1.5em;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .priority-badge { 
            background: #fef2f2; color: #dc2626; 
            padding: 6px 12px; border-radius: 16px; 
            font-size: 13px; font-weight: 700;
        }

        /* FIXED TABLE LAYOUT */
        table.equal-cols { 
            width: 100%; 
            table-layout: fixed; 
            font-size: 15px; 
            border-collapse: collapse;
        }
        th, td {
            padding: 18px 16px;
            text-align: left;
            border-bottom: 1px solid #fee2e2;
        }
        th {
            background: rgba(239, 68, 68, 0.1);
            color: #475569;
            font-weight: 700;
            position: sticky; top: 0;
        }

       /* UPDATED COLUMN WIDTHS with Serial No */
.equal-cols th:nth-child(1), .equal-cols td:nth-child(1) { width: 6%; text-align: center; }   /* Serial # */
.equal-cols th:nth-child(2), .equal-cols td:nth-child(2) { width: 22%; }                     /* Name */
.equal-cols th:nth-child(3), .equal-cols td:nth-child(3) { width: 16%; }                     /* Status */
.equal-cols th:nth-child(4), .equal-cols td:nth-child(4) { width: 24%; }                     /* Concern */
.equal-cols th:nth-child(5), .equal-cols td:nth-child(5) { width: 32%; word-break: break-word; } /* Treatments */
        tr:hover { background: #f8fafc }
        tr.critical { border-left: 5px solid #dc2626; background: #fef2f2; }

        /* STATUS & PRIORITY BADGES */
        .status, .priority { 
            padding: 6px 14px; 
            border-radius: 20px; 
            font-size: 13px; 
            font-weight: 700;
        }
        .critical { background: #fecaca; color: #dc2626; }
        .high { background: #fed7d7; color: #b91c1c; }
        .pending { background: #fef3c7; color: #d97706; }
        .treatment { background: #dbeafe; color: #1e40af; }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .navbar { padding: 0 20px; flex-direction: column; height: auto; gap: 10px; padding: 20px; }
            table.equal-cols { font-size: 14px; }
            th, td { padding: 12px 8px; }
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
   <div class="container">
        <h1>🚨 Priority Urgent Cases</h1>
        
        <div class="table-section">
            <div class="section-header">
                ⚡ High Priority Alerts 
            </div>
            <table class="equal-cols">
    <thead>
        <tr>
            <th>#</th>   
            <th>Student</th>
            <th>Smart Card</th>
            <th>Mode</th>
            <th>Concern</th>
        </tr>
    </thead>
    <tbody>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/ManSparsh", "bns", "bns"
            );

            // SELECT only the columns you need for referred cases
            String selectSQL =
            "SELECT a.id, s.name AS student_name, a.smart_card_id, a.preferred_mode, a.chief_concern " +
            "FROM APPOINTMENT a " +
            "JOIN STUDENT s ON a.student_id = s.student_id " +
            "WHERE a.status = 'REFERRED' " +
            "ORDER BY a.created_at DESC";


            pstmt = conn.prepareStatement(selectSQL);
            rs = pstmt.executeQuery();

            int count = 1; // serial number

            while (rs.next()) {
                int id = rs.getInt("id");
                String studentName = rs.getString("student_name");
                String smartCard = rs.getString("smart_card_id");    // was smart_card
                String mode = rs.getString("preferred_mode");        // was mode
                String concern = rs.getString("chief_concern");     // was concern
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= studentName %></td>
                    <td><%= smartCard != null ? smartCard : "-" %></td>
                    <td><%= mode != null ? mode : "-" %></td>
                    <td><%= concern != null ? concern : "-" %></td>
                </tr>
                <%
            }  // end while
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<tr><td colspan='5' class='concern'>Error: " + e.getMessage() + "</td></tr>");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    </tbody>
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
</script>
   </div>
</body>
</html>