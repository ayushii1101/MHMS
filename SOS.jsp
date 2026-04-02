<%@ page contentType="text/html; charset=UTF-8" %>
<%
String studentEmail = (String) session.getAttribute("studentEmail");
if(studentEmail == null){
    response.sendRedirect("StudentLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Emergency Support | ManSparsh</title>

<style>
body{
    margin:0;
    font-family:"Segoe UI", Arial, sans-serif;
    background:linear-gradient(135deg,#eef2ff,#f8f9ff);
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
}

.box{
    background:white;
    max-width:600px;
    width:90%;
    padding:40px;
    border-radius:20px;
    box-shadow:0 15px 35px rgba(0,0,0,0.2);
    text-align:center;
}

h1{
    color:#dc2626;
    margin-bottom:10px;
}

p{
    color:#444;
    margin-bottom:30px;
    font-size:16px;
}

.contact-card{
    background:#f1f5ff;
    padding:25px;
    border-radius:16px;
    margin-bottom:25px;
    box-shadow:0 8px 20px rgba(0,0,0,0.1);
}

.name{
    font-size:20px;
    font-weight:bold;
    color:#4c51bf;
}

.role{
    font-size:14px;
    color:#555;
    margin-bottom:12px;
}

.call-btn{
    display:inline-block;
    background:#16a34a;
    color:white;
    padding:14px 28px;
    border-radius:30px;
    text-decoration:none;
    font-size:18px;
    font-weight:bold;
    transition:0.3s;
}

.call-btn:hover{
    background:#15803d;
}
</style>
</head>

<body>

<div class="box">
    <h1> Emergency Support</h1>
    <p>If you are feeling unsafe, anxious, or overwhelmed, please call one campus support contacts below immediately.</p>

    <!-- Faculty Psychologist -->
    <div class="contact-card">
        <div class="name">Dr. Anu Raj Singh</div>
        <div class="role">Faculty Psychologist</div>
        <a class="call-btn" href="tel:9887374811"> Call 9887374811</a>
    </div>

</div>

</body>
</html>
