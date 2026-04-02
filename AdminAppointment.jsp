<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Appointments | ManSparsh</title>

<style>
body{
    margin:0;
    font-family:Segoe UI, Arial, sans-serif;
    background:#f4f7fb;
}
.header{
    background:#1f3c88;
    color:white;
    padding:15px 30px;
    font-size:26px;
    font-weight:bold;
}
.sub-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:20px 30px 10px 30px;
}
.sub-header h2{
    margin:0;
    color:#1f3c88;
}
.controls{
    display:flex;
    gap:10px;
}
.controls input, .controls select{
    padding:7px 10px;
    border:1px solid #ccc;
    border-radius:6px;
}
.table-container{
    padding:20px 30px;
}
table{
    width:100%;
    border-collapse:collapse;
    background:white;
    border-radius:8px;
    box-shadow:0 2px 6px rgba(0,0,0,0.1);
}
th, td{
    padding:12px;
    border-bottom:1px solid #eaeaea;
    text-align:left;
    font-size:13px;
}
th{
    background:#e8ecf8;
    color:#1f3c88;
}
tr:hover{
    background:#f5f7ff;
}
.status{font-weight:600;}
.pending{color:orange;}
.completed{color:green;}

.btn{
    padding:6px 12px;
    border:none;
    border-radius:6px;
    font-size:12px;
    cursor:pointer;
}
.accept{background:#4caf50;color:white;}
.reject{background:#f44336;color:white;}
</style>
</head>

<body>

<div class="header">ManSparsh</div>

<div class="sub-header">
    <h2>Appointments</h2>
    <div class="controls">
        <input type="text" placeholder="Search student...">
        <select>
            <option>All Status</option>
            <option>Pending</option>
            <option>Completed</option>
        </select>
    </div>
</div>

<div class="table-container">
<table>
<tr>
    <th>S.No</th>
    <th>Name</th>
    <th>Smartcard ID</th>
    <th>Counselor</th>
    <th>Date</th>
    <th>Time</th>
    <th>Mode</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<tr>
    <td>1</td>
    <td>Aditi Sharma</td>
    <td>BTBTC20260</td>
    <td>Dr. Anuraj Singh</td>
    <td>2026-01-12</td>
    <td>10:00 AM</td>
    <td>In-person</td>
    <td class="status pending">Pending</td>
    <td><button class="btn accept">Accept</button></td>
</tr>

<tr>
    <td>2</td>
    <td>Riya Mehta</td>
    <td>BTBTI23875</td>
    <td>Ms. Lakshya Chaudhary</td>
    <td>2026-01-11</td>
    <td>02:00 PM</td>
    <td>Phone call</td>
    <td class="status completed">Completed</td>
    <td><button class="btn reject">Reject</button></td>
</tr>

<tr>
    <td>3</td>
    <td>Neha Singh</td>
    <td>BTBTS67899</td>
    <td>Ms. Kapoor</td>
    <td>2026-01-13</td>
    <td>11:30 AM</td>
    <td>Video call</td>
    <td class="status pending">Pending</td>
    <td><button class="btn accept">Accept</button></td>
</tr>

<tr>
    <td>4</td>
    <td>Pooja Verma</td>
    <td>BTBTC45245</td>
    <td>Dr. Meena</td>
    <td>2026-01-14</td>
    <td>01:00 PM</td>
    <td>Phone call</td>
    <td class="status completed">Completed</td>
    <td><button class="btn reject">Reject</button></td>
</tr>

<tr>
    <td>5</td>
    <td>Kritika Jain</td>
    <td>BTBTI26754</td>
    <td>Ms. Lakshya Chaudhary</td>
    <td>2026-01-15</td>
    <td>09:30 AM</td>
    <td>In-person</td>
    <td class="status pending">Pending</td>
    <td><button class="btn accept">Accept</button></td>
</tr>

</table>
</div>

</body>
</html>