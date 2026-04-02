<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>User Management | ManSparsh</title>
<style>
body{margin:0;font-family:Segoe UI,Arial;background:#f4f7fb;}
.layout{display:flex;height:100vh;}
.sidebar{width:220px;background:#1e2a48;color:white;padding:20px;}
.sidebar h3{text-align:center;color:#9ecbff;margin-bottom:20px;}
.sidebar a{display:block;padding:12px;margin-bottom:10px;color:white;text-decoration:none;border-radius:8px;}
.sidebar a:hover{background:#3d5af1;}

.main{flex:1;padding:25px;}
.section{display:none;}
.section.active{display:block;}

.header{background:#1f3c88;color:white;padding:12px 20px;border-radius:10px 10px 0 0;font-size:20px;}
.box{background:white;padding:10px;border-radius:0 0 10px 10px;box-shadow:0 4px 10px rgba(0,0,0,0.1);}

table{width:100%;border-collapse:collapse;}
th,td{padding:12px;border-bottom:1px solid #eee;}
th{background:#eef2ff;color:#1f3c88;}

.status{padding:4px 10px;border-radius:12px;font-size:12px;color:white;}
.active{background:#4caf50;}
.inactive{background:#ff9800;}
.suspended{background:#f44336;}
</style>

<script>
function show(id){
    document.querySelectorAll('.section').forEach(s=>s.classList.remove('active'));
    document.getElementById(id).classList.add('active');
}
</script>
</head>

<body>
<div class="layout">

<div class="sidebar">
    <h3>User Types</h3>
    <a href="#" onclick="show('students')">Students</a>
    <a href="#" onclick="show('faculty')">Faculty</a>
    <a href="#" onclick="show('counselors')">Counselors</a>
</div>

<div class="main">

<!-- STUDENTS -->
<div id="students" class="section active">
<div class="header">Student Details</div>
<div class="box">
<table>
<tr><th>S.No</th><th>ID</th><th>Name</th><th>Email</th><th>Created Date</th></tr>
<tr><td>1</td><td>1</td><td>Aditi Sharma</td><td>aditi@banasthali.in</td><td>2026-01-05</td></tr>
<tr><td>2</td><td>2</td><td>Rahul Mehta</td><td>rahul@banasthali.in</td><td>2026-01-06</td></tr>
<tr><td>3</td><td>3</td><td>Neha Singh</td><td>neha@banasthali.in</td><td>2026-01-08</td></tr>
<tr><td>4</td><td>4</td><td>Pooja Verma</td><td>pooja@banasthali.in</td><td>2026-01-09</td></tr>
<tr><td>5</td><td>5</td><td>Ritika Jain</td><td>ritika@banasthali.in</td><td>2026-01-10</td></tr>
</table>
</div>
</div>

<!-- FACULTY -->
<div id="faculty" class="section">
<div class="header">Faculty Details</div>
<div class="box">
<table>
<tr><th>S.No</th><th>Faculty ID</th><th>Name</th><th>Email</th><th>Specialisation</th><th>Status</th><th>Created By</th><th>Created Date</th></tr>
<tr><td>1</td><td>1</td><td>Prof. Anjali</td><td>anjali@banasthali.in</td><td>Psychology</td><td><span class="status active">Active</span></td><td>Admin</td><td>2026-01-02</td></tr>
<tr><td>2</td><td>2</td><td>Dr. Verma</td><td>verma@banasthali.in</td><td>Wellness</td><td><span class="status inactive">Inactive</span></td><td>Admin</td><td>2026-01-03</td></tr>
<tr><td>3</td><td>3</td><td>Dr. Khanna</td><td>khanna@banasthali.in</td><td>Neuroscience</td><td><span class="status active">Active</span></td><td>Admin</td><td>2026-01-04</td></tr>
<tr><td>4</td><td>4</td><td>Prof. Iyer</td><td>iyer@banasthali.in</td><td>Clinical Psychology</td><td><span class="status inactive">Inactive</span></td><td>Admin</td><td>2026-01-05</td></tr>
<tr><td>5</td><td>5</td><td>Dr. Bose</td><td>bose@banasthali.in</td><td>Wellbeing</td><td><span class="status active">Active</span></td><td>Admin</td><td>2026-01-06</td></tr>
</table>
</div>
</div>

<!-- COUNSELORS -->
<div id="counselors" class="section">
<div class="header">Counselor Details</div>
<div class="box">
<table>
<tr><th>S.No</th><th>Counselor ID</th><th>Name</th><th>Email</th><th>Specialisation</th><th>Status</th><th>Created By</th><th>Created Date</th><th>Cases Handled</th></tr>
<tr><td>1</td><td>1</td><td>Dr. Meena</td><td>meena@banasthali.in</td><td>Stress Management</td><td><span class="status active">Active</span></td><td>Admin</td><td>2026-01-01</td><td>12</td></tr>
<tr><td>2</td><td>2</td><td>Ms. Kapoor</td><td>kapoor@banasthali.in</td><td>Career Guidance</td><td><span class="status inactive">Inactive</span></td><td>Admin</td><td>2026-01-04</td><td>5</td></tr>
<tr><td>3</td><td>3</td><td>Dr. Sen</td><td>sen@banasthali.in</td><td>Depression Therapy</td><td><span class="status active">Active</span></td><td>Admin</td><td>2026-01-06</td><td>18</td></tr>
<tr><td>4</td><td>4</td><td>Ms. Roy</td><td>roy@banasthali.in</td><td>Relationship Counseling</td><td><span class="status suspended">Suspended</span></td><td>Admin</td><td>2026-01-07</td><td>3</td></tr>
<tr><td>5</td><td>5</td><td>Dr. Arora</td><td>arora@banasthali.in</td><td>Mindfulness</td><td><span class="status active">Active</span></td><td>Admin</td><td>2026-01-08</td><td>9</td></tr>
</table>
</div>
</div>

</div>
</div>
</body>
</html>