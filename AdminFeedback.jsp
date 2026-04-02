<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Feedback | ManSparsh</title>

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
    padding:20px 30px;
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
.container{
    padding:20px 30px;
    display:grid;
    grid-template-columns:repeat(auto-fill, minmax(280px, 1fr));
    gap:20px;
}
.card{
    background:white;
    padding:18px;
    border-radius:10px;
    box-shadow:0 4px 8px rgba(0,0,0,0.08);
}
.card h4{
    margin:0;
    color:#1f3c88;
}
.role{
    font-size:12px;
    font-weight:600;
    color:#666;
    margin-top:4px;
}
.meta{
    font-size:12px;
    color:#888;
    margin-top:4px;
}
.comment{
    margin:12px 0;
    font-size:14px;
    color:#333;
}
.actions{
    display:flex;
    gap:10px;
}
.btn{
    padding:6px 12px;
    border:none;
    border-radius:6px;
    font-size:12px;
    cursor:pointer;
}
.view{background:#1f3c88;color:white;}
.flag{background:orange;color:white;}
.delete{background:red;color:white;}
</style>
</head>

<body>

<div class="header">ManSparsh</div>

<div class="sub-header">
    <h2>Platform Feedback</h2>

    <div class="controls">
        <input type="text" placeholder="Search feedback...">
        <select>
            <option>All Roles</option>
            <option>Student</option>
            <option>Faculty</option>
            <option>Counselor</option>
            <option>Visitor</option>
        </select>
    </div>
</div>

<div class="container">

<div class="card">
    <h4>Aditi Sharma</h4>
    <div class="role">Student</div>
    <div class="meta">2026-01-05</div>
    <div class="comment">Very helpful platform for mental health support.</div>
    <div class="actions">
        <button class="btn view">View</button>
        <button class="btn flag">Flag</button>
        <button class="btn delete">Delete</button>
    </div>
</div>

<div class="card">
    <h4>Dr. Meena</h4>
    <div class="role">Counselor</div>
    <div class="meta">2026-01-04</div>
    <div class="comment">Scheduling system is smooth but could improve notifications.</div>
    <div class="actions">
        <button class="btn view">View</button>
        <button class="btn flag">Flag</button>
        <button class="btn delete">Delete</button>
    </div>
</div>

<div class="card">
    <h4>Prof. Anjali Verma</h4>
    <div class="role">Faculty</div>
    <div class="meta">2026-01-03</div>
    <div class="comment">Very organized and student-friendly interface.</div>
    <div class="actions">
        <button class="btn view">View</button>
        <button class="btn flag">Flag</button>
        <button class="btn delete">Delete</button>
    </div>
</div>

<div class="card">
    <h4>Anonymous</h4>
    <div class="role">Visitor</div>
    <div class="meta">2026-01-02</div>
    <div class="comment">Looks nice but I was confused at first.</div>
    <div class="actions">
        <button class="btn view">View</button>
        <button class="btn flag">Flag</button>
        <button class="btn delete">Delete</button>
    </div>
</div>

</div>

</body>
</html>