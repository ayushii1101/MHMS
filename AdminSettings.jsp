<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Settings | ManSparsh</title>

<style>
body{
    margin:0;
    font-family:"Segoe UI", Arial, sans-serif;
    background:#f4f6fb;
}

/* NAVBAR */
.navbar{
    height:60px;
    background:#1f3c88;
    color:white;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 30px;
}
.navbar span{ font-size:22px; font-weight:bold; }

/* MAIN */
.main{ padding:30px; }

/* CARD */
.card{
    background:white;
    padding:25px;
    border-radius:14px;
    box-shadow:0 8px 25px rgba(0,0,0,0.08);
    margin-bottom:25px;
}

.card h2{
    margin-top:0;
    font-size:20px;
    color:#1e293b;
    border-bottom:1px solid #e5e7eb;
    padding-bottom:8px;
}

/* ROW */
.setting-row{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:12px 0;
    border-bottom:1px solid #f1f5f9;
    font-size:15px;
}
.setting-row:last-child{ border-bottom:none; }

/* TOGGLE */
.switch{
    position:relative;
    width:44px;
    height:22px;
}
.switch input{ display:none; }

.slider{
    position:absolute;
    cursor:pointer;
    background:#cbd5e1;
    border-radius:22px;
    top:0; left:0; right:0; bottom:0;
    transition:.3s;
}
.slider:before{
    content:"";
    position:absolute;
    height:18px;
    width:18px;
    left:2px;
    bottom:2px;
    background:white;
    border-radius:50%;
    transition:.3s;
}
.switch input:checked + .slider{
    background:#22c55e;
}
.switch input:checked + .slider:before{
    transform:translateX(22px);
}

button{
    padding:6px 14px;
    border:none;
    border-radius:6px;
    background:#6366f1;
    color:white;
    cursor:pointer;
}
button:hover{ background:#4f46e5; }

</style>
</head>

<body>

<div class="navbar">
    <span>ManSparsh Admin</span>
    <span>Settings</span>
</div>

<div class="main">

<!-- SYSTEM SETTINGS -->
<div class="card">
    <h2>System Settings</h2>
    <div class="setting-row">
        <span>Maintenance Mode</span>
        <label class="switch">
            <input type="checkbox">
            <span class="slider"></span>
        </label>
    </div>
    <div class="setting-row">
        <span>Dark Mode</span>
        <label class="switch">
            <input type="checkbox">
            <span class="slider"></span>
        </label>
    </div>
</div>

<!-- USER SETTINGS -->
<div class="card">
    <h2>User & Role Management</h2>
    <div class="setting-row">
        <span>Allow New Registrations</span>
        <label class="switch">
            <input type="checkbox" checked>
            <span class="slider"></span>
        </label>
    </div>
    <div class="setting-row">
        <span>Auto Approve Counselors</span>
        <label class="switch">
            <input type="checkbox">
            <span class="slider"></span>
        </label>
    </div>
</div>

<!-- SECURITY -->
<div class="card">
    <h2>Security</h2>
    <div class="setting-row">
        <span>Enable Two Factor Authentication</span>
        <label class="switch">
            <input type="checkbox">
            <span class="slider"></span>
        </label>
    </div>
    <div class="setting-row">
        <span>Limit Login Attempts</span>
        <label class="switch">
            <input type="checkbox" checked>
            <span class="slider"></span>
        </label>
    </div>
</div>

<!-- FEATURES -->
<div class="card">
    <h2>Feature Control</h2>
    <div class="setting-row">
        <span>Enable SOS Alerts</span>
        <label class="switch">
            <input type="checkbox" checked>
            <span class="slider"></span>
        </label>
    </div>
    <div class="setting-row">
        <span>Enable Feedback Module</span>
        <label class="switch">
            <input type="checkbox" checked>
            <span class="slider"></span>
        </label>
    </div>
</div>

<!-- DATA -->
<div class="card">
    <h2>Data & Backup</h2>
    <div class="setting-row">
        <span>Automatic Backups</span>
        <label class="switch">
            <input type="checkbox" checked>
            <span class="slider"></span>
        </label>
    </div>
    <div class="setting-row">
        <span>Export Data</span>
        <button>Export</button>
    </div>
</div>

</div>

</body>
</html>